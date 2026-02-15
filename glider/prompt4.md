from glider import *

def query():
    """
    @title: Oracle Manipulation Vulnerability - Unbounded Trust in External Price Feeds
    @description: Detects lending/minting functions that use external oracle prices for collateral valuation without implementing critical safety mechanisms (deviation bounds, TWAP, multi-source aggregation, staleness checks, or circuit breakers). This pattern enabled the BonqDAO exploit where attackers manipulated Tellor oracle prices to mint unbacked stablecoins.
    @severity: Critical
    @author: orsinibear
    @tags: oracle-manipulation, price-feed, defi, lending, collateral-valuation, economic-exploit, bonqdao
    @references: https://cwe.mitre.org/data/definitions/829.html, CWE-829, BonqDAO Exploit 2023
    """
    
    results = []
    
    # Find functions that interact with price oracles
    # Common oracle function names
    oracle_functions = [
        "getPrice", "latestAnswer", "latestRoundData", 
        "getLatestPrice", "getCurrentPrice", "fetchPrice",
        "retrieveData", "getValue", "getDataBefore"
    ]
    
    functions = Functions().with_callee_names(oracle_functions).exec()
    
    for fn in functions:
        # Filter for main contracts only
        if not fn.get_contract().is_main():
            continue
        
        # Must be public or external (accessible entry points)
        if not (fn.is_public() or fn.is_external()):
            continue
        
        # Get function source code for pattern analysis
        try:
            source = fn.source_code().lower()
        except:
            continue
        
        # =============================================
        # DETECT VULNERABLE PATTERNS
        # =============================================
        
        has_oracle_call = False
        has_mint_or_borrow = False
        has_collateral_logic = False
        
        # Check 1: Verify oracle interaction exists
        callee_names = [call.name.lower() for call in fn.callee_values()]
        for oracle_fn in oracle_functions:
            if oracle_fn.lower() in callee_names:
                has_oracle_call = True
                break
        
        if not has_oracle_call:
            continue
        
        # Check 2: Look for mint/borrow operations (economic impact)
        mint_borrow_patterns = [
            "mint", "borrow", "loan", "debt", 
            "issue", "create", "generate"
        ]
        for pattern in mint_borrow_patterns:
            if pattern in source or pattern in callee_names:
                has_mint_or_borrow = True
                break
        
        # Check 3: Look for collateral valuation logic
        collateral_patterns = [
            "collateral", "value", "price", 
            "ratio", "ltv", "liquidation"
        ]
        for pattern in collateral_patterns:
            if pattern in source:
                has_collateral_logic = True
                break
        
        # Must have oracle + (mint/borrow OR collateral logic)
        if not (has_mint_or_borrow or has_collateral_logic):
            continue
        
        # =============================================
        # EXCLUDE SECURE PATTERNS (Safety Mechanisms)
        # =============================================
        
        is_vulnerable = True
        
        # Safety Check 1: Deviation bounds / sanity checks
        # Look for: price deviation, bounds, min/max price, threshold
        deviation_patterns = [
            "deviation", "bound", "threshold", "minprice", "maxprice",
            "pricediff", "pricechange", "acceptable", "tolerance"
        ]
        has_deviation_check = any(pattern in source for pattern in deviation_patterns)
        
        # Safety Check 2: TWAP (Time-Weighted Average Price)
        # Look for: twap, average, weighted, cumulative
        twap_patterns = [
            "twap", "average", "weighted", "cumulative", 
            "timeweighted", "movingaverage"
        ]
        has_twap = any(pattern in source for pattern in twap_patterns)
        
        # Safety Check 3: Multi-source aggregation / fallback oracle
        # Look for: chainlink, multiple oracles, fallback, backup
        multi_source_patterns = [
            "chainlink", "fallback", "backup", "secondary", 
            "alternative", "median", "aggregate"
        ]
        has_multi_source = any(pattern in source for pattern in multi_source_patterns)
        
        # Safety Check 4: Staleness / freshness validation
        # Look for: timestamp, stale, fresh, updated, age, heartbeat
        staleness_patterns = [
            "timestamp", "stale", "fresh", "updated", 
            "age", "heartbeat", "lastupdate", "block.timestamp"
        ]
        has_staleness_check = any(pattern in source for pattern in staleness_patterns)
        
        # Safety Check 5: Circuit breaker / emergency pause
        # Look for: pause, emergency, circuit, breaker, halt
        circuit_breaker_patterns = [
            "pause", "emergency", "circuit", "breaker", 
            "halt", "stop", "frozen", "disabled"
        ]
        has_circuit_breaker = any(pattern in source for pattern in circuit_breaker_patterns)
        
        # Safety Check 6: Rate limiting / gradual changes
        # Look for: ratelimit, delay, cooldown, gradual
        rate_limit_patterns = [
            "ratelimit", "delay", "cooldown", "gradual", 
            "timelock", "waiting"
        ]
        has_rate_limit = any(pattern in source for pattern in rate_limit_patterns)
        
        # Count safety mechanisms present (manual count since sum() not available)
        safety_count = 0
        if has_deviation_check:
            safety_count += 1
        if has_twap:
            safety_count += 1
        if has_multi_source:
            safety_count += 1
        if has_staleness_check:
            safety_count += 1
        if has_circuit_breaker:
            safety_count += 1
        if has_rate_limit:
            safety_count += 1
        
        # If at least 2 safety mechanisms are present, consider it safer
        # (Still flag if 0-1 mechanisms, as that's insufficient)
        if safety_count >= 2:
            is_vulnerable = False
        
        # Additional check: Look for require statements with price validation
        # Even basic validation is better than nothing
        if "require" in source:
            # Check if require is used with price-related conditions
            instructions = fn.instructions().exec()
            for inst in instructions:
                try:
                    inst_source = inst.source_code().lower()
                    if "require" in inst_source and any(p in inst_source for p in ["price", "value", "oracle"]):
                        # Has some form of validation, reduce vulnerability score
                        # But don't completely exclude unless other mechanisms exist
                        if safety_count >= 1:
                            is_vulnerable = False
                except:
                    pass
        
        # =============================================
        # ADDITIONAL HEURISTICS
        # =============================================
        
        # Check if function directly multiplies oracle price with collateral amount
        # This is the classic vulnerable pattern: collateralValue = amount * oraclePrice
        multiplication_with_price = False
        if "*" in source or "mul" in source:
            # Look for patterns where price/value is multiplied
            if ("price" in source or "value" in source) and \
               ("collateral" in source or "amount" in source):
                multiplication_with_price = True
        
        # Higher confidence if we see direct multiplication without safeguards
        if multiplication_with_price and safety_count == 0:
            is_vulnerable = True
        
        # =============================================
        # FLAG VULNERABLE FUNCTIONS
        # =============================================
        
        if is_vulnerable:
            results.append(fn)
    
    return results
