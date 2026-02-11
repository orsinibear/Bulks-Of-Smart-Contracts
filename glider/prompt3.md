from glider import *

def query():
    """
    @title: Token Accounting Mismatch - Transfer to Token Contract with Increment Burnable
    @description: Detects functions that transfer tokens to the token contract itself (address(token)) via transferFrom, then increment a burnable/should-be-burned tracking variable in a different contract. This creates an accounting mismatch where the tracking variable increases but the contract's balance doesn't, leading to unnecessary POL liquidation and eventual exhaustion.
    @severity: High
    @author: orsinibear
    @tags: accounting-mismatch, burnable-tokens, transferFrom, protocol-owned-liquidity, pol
    @references: https://cwe.mitre.org/data/definitions/682.html, CWE-840
    """
    
    results = []
    
    # Find functions that call transferFrom or safeTransferFrom
    functions = Functions().with_callee_names(["transferFrom", "safeTransferFrom"]).exec()
    
    for fn in functions:
        # Filter for main contracts only
        if not fn.get_contract().is_main():
            continue
        
        # Get function source code
        try:
            source = fn.source_code()
            source_lower = source.lower()
        except:
            continue
        
        # =============================================
        # DETECT VULNERABLE PATTERN
        # =============================================
        
        # Pattern 1: Transfer to token contract itself
        # Look for: tokenVariable.transferFrom(..., address(tokenVariable), ...)
        transfers_to_token_contract = False
        
        # Check all transferFrom calls
        callee_values = fn.callee_values()
        for call in callee_values:
            if call.name in ["transferFrom", "safeTransferFrom"]:
                try:
                    # Get arguments: transferFrom(from, to, amount)
                    args = call.get_args()
                    if len(args) >= 2:
                        # Second argument is the recipient
                        recipient_expr = str(args[1].expression).lower()
                        
                        # Check if recipient is address(tokenVariable)
                        if "address(" in recipient_expr:
                            # Get the call expression to find token variable
                            call_expr = str(call.expression).lower()
                            if "." in call_expr:
                                # Extract token variable name (before the dot)
                                token_var = call_expr.split(".")[0].strip()
                                # Check if recipient references same variable
                                if token_var in recipient_expr:
                                    transfers_to_token_contract = True
                                    break
                            
                            # Also check for common patterns
                            if "address(token" in recipient_expr or \
                               "address(usds" in recipient_expr or \
                               "address(this" in recipient_expr:
                                transfers_to_token_contract = True
                                break
                except:
                    pass
        
        # Fallback: Check source code for pattern
        # Simple heuristic: if transferFrom and address( exist together, likely the pattern
        if not transfers_to_token_contract:
            if ("transferfrom" in source_lower or "safetransferfrom" in source_lower) and \
               "address(" in source_lower:
                # Additional validation: check if it's likely transferring to token contract
                # Look for common token variable names near address()
                if any(token_name in source_lower for token_name in ["usds", "token"]):
                    transfers_to_token_contract = True
        
        # Pattern 2: Increment burnable tracking variable
        # Look for increment/increase functions with burnable patterns
        increment_patterns = [
            "incrementburnable", "increment_burnable", "incrementburnableusds",
            "increaseburnable", "increase_burnable", "addburnable", "add_burnable",
            "shouldbeburned", "should_be_burned", "burnableusds", "burnable_usds",
            "usdsthatshouldbeburned", "usds_that_should_be_burned"
        ]
        
        increments_burnable = False
        
        # Check callee names
        callee_names = [call.name for call in fn.callee_values()]
        for callee_name in callee_names:
            callee_lower = callee_name.lower().replace("_", "").replace("-", "")
            if any(pattern in callee_lower for pattern in increment_patterns):
                increments_burnable = True
                break
        
        # Check source code (normalize by removing underscores and hyphens)
        source_normalized = source_lower.replace("_", "").replace("-", "")
        for pattern in increment_patterns:
            pattern_normalized = pattern.replace("_", "").replace("-", "")
            if pattern_normalized in source_normalized:
                increments_burnable = True
                break
        
        # Check for variable increments: usdsThatShouldBeBurned +=
        if "thatshouldbeburned" in source_normalized or "shouldbeburned" in source_normalized:
            if "+=" in source_lower or "= " in source_lower:
                increments_burnable = True
        
        # =============================================
        # EXCLUDE SECURE PATTERNS (False Positives)
        # =============================================
        
        is_secure = False
        
        # Secure Pattern: If there are multiple transfers and one is to address(this)
        # This might indicate proper accounting
        if increments_burnable and transfers_to_token_contract:
            transfer_count = source_lower.count("transferfrom") + source_lower.count("safetransferfrom")
            if transfer_count > 1 and "address(this)" in source_lower:
                # Might be secure if tokens are also sent to the tracking contract
                is_secure = True
        
        if is_secure:
            continue
        
        # Only flag if we found both patterns
        if transfers_to_token_contract and increments_burnable:
            results.append(fn)
    
    return results
