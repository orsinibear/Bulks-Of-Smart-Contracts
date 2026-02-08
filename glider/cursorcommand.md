Glider is running a prompt contest, check it out at  https://r.xyz/glider-query-database?utm_source=remedy&utm_medium=banner&utm_campaign=QueryDB+Contest

the ojective is to create prompts that can catch vulnerabilities in the codebase of protocol, this will help glider be a great security agent. 

for example the vulnerability an prompt below is a good exmple of what glider needs. you think of any vulnerability then write a prompt for it. The best way to model your prompt is by using the formats in api-docs-merged.md which is in the root directory of this code-base.


initialization protection
Query name: Uninitialized implementation vulnerability in UUPS and Beacon Proxy Patterns - Missing constructor initialization protection
Rarity: Legendary
Total Earnings: Not disclosed
This vulnerability occurs in upgradeable proxy contracts (UUPS and Beacon Proxy patterns) where the implementation contract's constructor fails to properly disable initializers, leaving the implementation contract susceptible to unauthorized initialization attacks.


```python
from glider import *

def query():
    targets = Contracts().with_function_name('initialize').exec(1000)
    
    results = []
    
    for contract in targets:
        # get the constructor
        constructor = contract.constructor()
        
        if isinstance(constructor,NoneObject): # seems we dont have constructor
            # check that there are delegatecalls in the instructions
            delegates = contract.functions().instructions().delegate_calls().exec()
            if len(delegates) > 0:
                results.append(contract)
            continue
        
        # skip if we have initializer modifier on constructor
        if len(constructor.modifiers().with_name('initializer').exec())>0:
            continue
        
        # skip if there are no delegate calls
        delegates = contract.functions().instructions().delegate_calls().exec()
        if len(delegates) == 0:
            continue
        
        # skip if there is _disableInitializers call in constructor
        if len(constructor.callee_functions().with_name('_disableInitializers').exec()) > 0:
            continue
        
        results.append(contract)
    
    return results
```

Now this is what i want you to do, write a prompt that will suit this vulnerability in vulnerability.md. there is a file prompt.md
feel free to write the prompt in there