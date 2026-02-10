from glider import *

def query():
    """
    @title: Unauthorized Token Transfers - Missing Caller Verification in Payment Functions
    @description: This vulnerability occurs when public/external payment functions transfer ERC-20 tokens using transferFrom without verifying that msg.sender is authorized to initiate transfers on behalf of the from address. This allows attackers to steal tokens from any user who has approved the contract.
    @tags: access-control, unauthorized-transfer, erc20, payment-functions
    @author: orsinibear
    @references: https://cwe.mitre.org/data/definitions/284.html, CWE-306, CWE-639
    """
    
    # Find payment-related functions
    payment_patterns = ["payWithERC20", "payWithToken", "payWith", "payERC20", "payToken"]
    
    # Get all public/external functions
    targets = (
        Functions()
        .with_one_property([MethodProp.PUBLIC, MethodProp.EXTERNAL])
        .exec(500)
    )
    
    results = []
    
    for func in targets:
        # Check if function name matches payment patterns
        func_name_lower = func.name.lower()  # Changed from func.name() to func.name
        is_payment_function = any(pattern.lower() in func_name_lower for pattern in payment_patterns)
        
        # Check if function calls transferFrom
        source = func.source_code()
        source_lower = source.lower()
        calls_transferFrom = "transferfrom" in source_lower
        
        # Skip if not relevant
        if not is_payment_function and not calls_transferFrom:
            continue
        
        # Check for access control patterns
        has_msg_sender_check = False
        
        # Look for msg.sender verification patterns
        if "msg.sender" in source_lower or "_msgsender" in source_lower:
            # Check if it's being compared/verified
            if ("==" in source_lower or "require" in source_lower) and "msg.sender" in source_lower:
                has_msg_sender_check = True
        
        # Check for modifiers (onlyOwner, etc.)
        if "onlyowner" in source_lower or "onlyrole" in source_lower or "modifier" in source_lower:
            has_msg_sender_check = True
        
        # Flag if calls transferFrom without proper authorization
        if calls_transferFrom and not has_msg_sender_check:
            results.append(func)
            
            # Limit results
            if len(results) >= 20:
                break
    
    return results