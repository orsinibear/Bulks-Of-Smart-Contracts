from glider import *

def query():
    """
    @title: Unauthorized Token Transfers - Missing Caller Verification in Payment Functions
    @description: Detects public/external functions that call transferFrom without verifying msg.sender is authorized to initiate transfers on behalf of the from address. This allows attackers to steal tokens from any user who has approved the contract.
    @severity: High
    @author: orsinibear
    @tags: access-control, unauthorized-transfer, erc20, payment-functions, transferFrom
    @references: https://cwe.mitre.org/data/definitions/284.html, CWE-306, CWE-639
    """
    
    results = []
    
    # Find functions that call transferFrom
    functions = Functions().with_callee_names(["transferFrom"]).exec()
    
    for fn in functions:
        # Filter for main contracts only
        if not fn.get_contract().is_main():
            continue
        
        # Must be public or external (accessible by anyone)
        if not (fn.is_public() or fn.is_external()):
            continue
        
        # Must actually call transferFrom
        callee_names = [call.name for call in fn.callee_values()]
        if "transferFrom" not in callee_names:
            continue
        
        # =============================================
        # EXCLUDE SECURE PATTERNS (False Positives)
        # =============================================
        
        is_secure = False
        
        # Get function source code for pattern checking
        try:
            source = fn.source_code().lower()
        except:
            continue
        
        # Secure Pattern 1: Check for msg.sender verification
        # Look for: msg.sender == fromAddress, require(msg.sender == ...), etc.
        if "msg.sender" in source or "_msgsender" in source:
            # Check if msg.sender is being compared/verified (not just used)
            # Patterns: msg.sender ==, require(msg.sender ==, if (msg.sender ==, etc.
            if ("==" in source and "msg.sender" in source) or \
               ("require" in source and "msg.sender" in source) or \
               ("if" in source and "msg.sender" in source and "==" in source):
                is_secure = True
        
        # Secure Pattern 2: Access control modifiers
        # Check for modifiers like onlyOwner, onlyRole, etc.
        modifiers = fn.modifiers().exec()
        if len(modifiers) > 0:
            # Check modifier names for access control patterns
            for mod in modifiers:
                mod_name = mod.name.lower()
                if any(pattern in mod_name for pattern in ["only", "owner", "role", "admin", "authorized"]):
                    is_secure = True
                    break
        
        # Secure Pattern 3: Check if transferFrom uses msg.sender as the from parameter
        # If transferFrom(from=msg.sender, ...), it's secure
        # Also check if function parameter "from" is compared to msg.sender
        callee_values = fn.callee_values()
        for call in callee_values:
            if call.name == "transferFrom":
                try:
                    # Get arguments passed to transferFrom
                    args = call.get_args()
                    if len(args) >= 1:
                        # First argument is typically the "from" address
                        from_arg_expr = str(args[0].expression).lower()
                        # Check if it's msg.sender or _msgSender()
                        if "msg.sender" in from_arg_expr or "_msgsender" in from_arg_expr:
                            is_secure = True
                            break
                        
                        # Check if the from argument is a function parameter that's verified
                        # Look for patterns where function has a "from" parameter and it's checked
                        from_arg_str = str(args[0].expression)
                        # If source contains comparison of this parameter with msg.sender
                        if from_arg_str in source:
                            # Check if there's a comparison pattern
                            if f"{from_arg_str} == msg.sender" in source or \
                               f"msg.sender == {from_arg_str}" in source or \
                               f"require({from_arg_str} == msg.sender" in source or \
                               f"require(msg.sender == {from_arg_str}" in source:
                                is_secure = True
                                break
                except:
                    pass
        
        # Secure Pattern 4: Internal/private functions are safe (already filtered, but double-check)
        if fn.is_internal() or fn.is_private():
            is_secure = True
        
        if is_secure:
            continue
        
        # Only flag if we found transferFrom without proper authorization
        results.append(fn)
    
    return results
