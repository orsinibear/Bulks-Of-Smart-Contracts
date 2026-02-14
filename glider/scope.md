


desc  -  

Users can avoid deficit reporting during liquidation by maintaining minimal collateral in another reserve. When main collateral is liquidated, any non-zero secondary collateral prevents deficit flagging, even if trivial amounts. This enables strategic avoidance of deficit status, delays debt recognition, and allows uncollectible debt to accrue interest. Short-term fix: treat small collateral as inactive. Long-term: redesign deficit reporting to prevent exploitation.


address-   
0x8147b99DF7672A21809c9093E6F6CE1a60F119Bd




scope prompt 

from glider import *

def query():
    """
    @title: Read-Only Reentrancy in Compound-style Lending Protocols
    @description: Detects borrow/redeem/liquidate functions calling exchangeRate or oracle price functions before transfers without reentrancy guards
    @severity: Critical
    @author: orsinibearr
    @tags: read-only-reentrancy, compound, lending
    @references: Fei/Rari exploit, CWE-841
    """
    
    results = []
    functions = Functions().exec(200)
    
    for func in functions:
        func_name = func.name.lower()
        
        # Compound-specific lending functions
        if not any(op in func_name for op in ['borrow', 'redeem', 'mint', 'liquidate']):
            continue
        
        source = func.source_code().lower()
        
        # Compound uses these for pricing/accounting
        compound_patterns = [
            'exchangeratecurrent',
            'exchangeratestored',
            'getaccountliquidity',
            'oracle.getunderlyingprice'
        ]
        
        has_oracle = any(pattern in source for pattern in compound_patterns)
        has_transfer = 'dotransfer' in source or 'transfer(' in source
        no_guard = 'nonreentrant' not in source and '_notentered' not in source
        
        if has_oracle and has_transfer and no_guard:
            results.append(func)
    
    return results