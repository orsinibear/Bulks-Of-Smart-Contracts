---
hidden: true
---

# DfPathFinder

---
description: Returns all data flow paths between two points.
---

# DfPathFinder.get\_all\_paths\_between\_points()

`get_all_paths_between_points(source:` [`Point`](../point/)`,dest:` [`Point`](../point/)`) →` [`APISet`](../iterables/apiset.md)`[PointPath]`
---
description: >-
  Returns the first encountered data flow path from source to destination, if it
  exists. Otherwise, returns an empty tuple.
---

# DfPathFinder.get\_path\_between\_points()

`get_path_between_points(source:` [`Point`](../point/)`, destination:` [`Point`](../point/)`) → PointPath`
---
description: Checks if there is a data flow path from source to destination.
---

# DfPathFinder.is\_df\_path()

`is_df_path(source:` [`Point`](../point/)`, destination:` [`Point`](../point/)`) → bool`
---
description: Returns the Modifiers object for the modifiers of the function.
---

# Functions.modifiers()

`modifiers() →` [`Modifiers`](../callables/modifiers/)

## Query Example

```python
from glider import *


def query():
    modifiers = (
        Functions()
        .with_name("swapTokens")
        .modifiers()
        .exec(5)
    )
 
    return modifiers
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-17 at 1.14.09 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Filter functions that have modifiers satisfying the given expr.
---

# Functions.with\_modifier\_properties()

`with_modifier_properties(expr) →` [`Functions`](../callables/functions/)
# Functions.with\_modifier\_name\_regex()

`with_modifier_name_regex(`_`regex: str`_`) →` [`Functions`](../callables/functions/)

Adds a filter to get functions, that have modifier whose name matches the given regex.

## Example

```python
from glider import *

def query():
  
  # Fetch a list of functions with modifiers starting with 'only'
  functions = Functions().with_modifier_name_regex('^only.*').exec(3)

  return functions
```

## Output

<figure><img src="../../.gitbook/assets/image (6) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a Functions object representing the functions through which the
  functions from current Functions object could be called.
---

# Functions.caller\_functions\_recursive()

`caller_functions_recursive() →` [`Functions`](../callables/functions/)

The function will retrieve _**extended**_**/**_**inter-procedural**_ functions, meaning it works recursively. It returns the Functions object representing all the functions that ultimately call the function in question.

## Query Example

```python
from glider import *


def query():
  funcs = Functions().with_name("transfer").caller_functions_recursive().exec(2)
  
  return funcs
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-21 at 9.54.44 AM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a Modifiers object representing the modifiers through which the
  functions from current Functions object could be called.
---

# Functions.caller\_modifiers\_recursive()

`caller_modifiers_recursive() →` [`Modifiers`](../callables/modifiers/)

The function will retrieve _**extended**_**/**_**inter-procedural**_ modifiers, meaning it works recursively. It returns the Modifiers object representing all the modifiers that ultimately call the function in question.

## Query Example

```python
from glider import *

def query():
  modifiers = Functions().with_name("onlyOwner").caller_modifiers_recursive().exec(2)
  
  return modifiers
```

## Example Output

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get functions, that have modifier whose name matches the
  given regex.
---

# Functions.with\_modifier\_name\_regex()

`with_modifier_name_regex(regex: str) →` [`Functions`](../callables/functions/)
---
description: Filter functions that satisfies or have modifiers satisfying the given expr.
---

# Functions.with\_properties\_considering\_modifiers()

`with_properties_considering_modifiers(expr) →` [`Functions`](../callables/functions/)
---
description: Filter functions satisfying the given expression
---

# Functions.with\_properties()

`with_properties(expr) ->` [`Functions`](../callables/functions/)

E.g: `expr = FunctionFilters.HAS_ARGS & ~FunctionFilters.IS_CONSTRUCTOR` `with_properties(expr)` will return functions that have arguments and are not a constructor.

## Query Example

```python
from glider import *

def query():
    return (
        Functions()
        .with_properties(FunctionFilters.IS_EXTERNAL | FunctionFilters.IS_PUBLIC)
        .exec(10)
    )
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-10-09 at 12.50.39 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a list of Call objects that represents called functions from the
  function/modifier.
---

# Callable.callee\_values()

`callee_values() →` [`APIList`](../iterables/apilist.md)`[`[`Call`](../value/call/)`]`

## Query Example

```python
from glider import *

def query():
    functions = Functions().exec(1,5)

    for function in functions:
        for call in function.callee_values():
            print(f"function {function.name}, call {call.expression}")

    return functions
```

## Example Output

<figure><img src="../../.gitbook/assets/image (104).png" alt=""><figcaption></figcaption></figure>
---
description: Returns start_loop instructions of the function/modifier.
---

# Callable.start\_loop\_instructions()

`start_loop_instructions() →` [`Instructions`](../instructions/)

The functions will return start\_loop instructions for all types of loops e.g. while/for.

start\_loop instruction is not a "real" instruction but rather an abstract one representing the start of the loop.

## Example

```python
from glider import *
def query():
  functions = Functions().exec(100)

  loop_instructions = []
  for function in functions:
    for instruction in function.start_loop_instructions().exec():
      # Return the starting loop instructions for each function
      loop_instructions.append(instruction)

  return loop_instructions
```

## Example output

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the instructions which are reachable from the entry node
---

# Callable.get\_reachable\_instructions()

`get_reachable_instructions() →` [`APISet`](../iterables/apiset.md)`[`[`Instruction`](../instruction/)`]`

## Query Example

```python
from glider import *

def query():
    functions = Functions().exec(1) 
  
    for reachable_instruction in functions[0].get_reachable_instructions():
        print(f"{reachable_instruction.source_code()}")

    return functions
```

## Example Output

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a Functions object representing the functions through which the
  function could be called
---

# Callable.callee\_functions\_recursive()

`callee_functions_recursive() ->` [`Functions`](../callables/functions/)

The function is the _recursive_/_inter-procedural_ variant of [callee\_functions()](callable.callee_functions.md), meaning it works recursively. It returns the Functions object representing all the functions through which the function could be called.&#x20;

The difference between `callee_functions_recursive()` and `callee_functions()` the later one will only return direct callee functions, while the **recursive** version will find all the functions recursively that eventually call the target function.

## Query Example

```python
from glider import *


def query():
    functions = Functions().with_name("requestRandomness").exec(1)

    return functions[0].callee_functions_recursive().exec()
```

For the function:

```solidity
function requestRandomness(bytes32 _keyHash,uint256 _fee,uint256 _seed)
    public returns (bytes32 requestId)
  {
    LINK.transferAndCall(vrfCoordinator,_fee,abi.encode(_keyHash,_seed));
    
    uint256 vRFSeed  = makeVRFInputSeed(_keyHash,_seed,address(this),nonces[_keyHash]);
    
    nonces[_keyHash] = nonces[_keyHash].add(1);
    return makeRequestId(_keyHash,vRFSeed);
  }
```

The output will be:

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-21 at 12.38.28 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns expression instructions of the function/modifier.
---

# Callable.expression\_instructions()

`expression_instructions() →` [`Instructions`](../instructions/)

## Example

```python
from glider import *
def query():
  functions = Functions().exec(100)

  expressions = []
  for function in functions:
    for exp_instruction in function.expression_instructions().exec():
      # For each function, return the expressions
      expressions.append(exp_instruction)

  return expressions
```

## Example output

<figure><img src="../../.gitbook/assets/image (7) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the function's or modifier's name.
---

# Callable.name

`property: name -> str`

## Example

```python
from glider import *
def query():
  contracts = Contracts().exec(1)

  contracts_with_callables = []
  for c in contracts:
    for function in c.functions().exec():
      print(f"contract name: {c.name} | function name: {function.name}")

    for modifier in c.modifiers().list():
      print(f"contract name: {c.name} | function name: {modifier.name}")

  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (135).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instruction object with specified id from function.
hidden: true
---

# Callable.instruction\_with\_id()

`instruction_with_id() →` [`Instruction`](../instruction/)

This function is used internally while traversing CFG/DFG graphs.

## Example

```python
from glider import *
def query():
  functions = Functions().with_modifiers_name_not(["onlyOwner"]).exec(100)

  # Return the instruction with a specific id in a function
  return [functions[0].instruction_with_id(1)]
```

## Example output

```json
[
  {
    "contract": "0x798AcB51D8FBc97328835eE2027047a8B54533AD",
    "contract_name": "Context",
    "sol_function": `
    // Formatted for the example
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
    `,
    "sol_instruction": "return msg.sender"
  }
]
```
# Callable

The class is the base class for [Function](function/) and [Modifier](modifier/) classes.

---
description: Returns start assembly instructions of the function/modifier.
---

# Callable.start\_asm\_instructions()

`start_asm_instructions() →` [`Instructions`](../instructions/)

## Query Example

```python
from glider import *

def query():
  functions = Functions().exec(500)

  start_asm_instructions = []
  for function in functions:
    for instruction in function.start_asm_instructions().exec():
      # Return the start assembly instructions for each function
      start_asm_instructions.append(instruction)

  return start_asm_instructions
```

## Output Example

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: Returns if_loop instructions of the function/modifier.
---

# Callable.if\_loop\_instructions()

`if_loop_instructions() →` [`Instructions`](../instructions/)

The function returns [Instructions](../instructions/) that represent the condition part in loop operators. It will return for all types of loops e.g. while and for

## Example

```python
from glider import *
def query():
  functions = Functions().without_modifier_names(["onlyOwner"]).exec(100)

  if_loop_instructions = []
  for function in functions:
    # For each function without an "onlyOwner" modifier, return the if loop instructions
    for instruction in function.if_loop_instructions().exec():
      if_loop_instructions.append(instruction)

  return if_loop_instructions
```

## Example output

<figure><img src="../../.gitbook/assets/image (132).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the set of all instructions from the current function entry in the
  control flow graph.
---

# Callable.instructions\_recursive()

`instructions_recursive() ->` [`APISet`](../iterables/apiset.md)`[`[`Instruction`](../instruction/)`]`

The function is the _**recursive**_**/**_**inter-procedural**_ variant of the [`instructions()`](callable.instructions.md), meaning that it works recursively. It returns a set of Instructions object representing all the instructions which are reachable from the target function, the differences between `instructions_recursive()` and `instructions()` the latter will only return instructions directly accessible from the function. At the same time, the recursive version will find all the instructions recursively, which are eventually called when executing the function.

Also, note that the return types of `instructions_recursive() -> APISet[Instruction]` and `instructions() -> Instructions` are different, the recursive version returns an APISet of Instruction objects, while the original one returns Instructions (queryable) object.

## Query Example

```python
from glider import *

def query():
    # Let's find a function with name transferFrom
    functions = Functions().with_name('transferOwnership').exec(1)

    # Print the code of the function
    print(functions[0].source_code())

    # Return the list of (recursive) instructions, as it return a set, we need to cast it to list
    return list(functions[0].instructions_recursive().exec(10))

```

For the function:

```solidity
function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }
```

The output is:

## Example Output

<figure><img src="../../.gitbook/assets/image (114).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (115).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (116).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (117).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (118).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (119).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (120).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (121).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (122).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (123).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (124).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (125).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (126).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (127).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (128).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (129).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (130).png" alt=""><figcaption></figcaption></figure>
---
description: Returns throw instructions of the function/modifier.
---

# Callable.throw\_instructions()

`throw_instructions() →` [`Instructions`](../instructions/)

## Query Example&#x20;

```python
from glider import *


def query():
  functions = Functions().with_name("setTokenExchangeRate").exec(1)

  throw_instructions = []
  for function in functions:
    for instruction in function.throw_instructions().exec():
      # Return the throw instructions for each function
      throw_instructions.append(instruction)

  return throw_instructions
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-25 at 2.12.14 PM.png" alt=""><figcaption></figcaption></figure>

---
description: >-
  Returns the parent contract of the function/modifier if exists, otherwise
  (global functions) returns NoneObject.
---

# Callable.get\_contract()

`get_contract() →` [`Contract`](../contract/) `| NoneObject`

The function may return NoneObject in cases where it does not belong to any contract and is a global function, as Solidity supports that type of functions.

## Example

```python
from glider import *
def query():
  functions = Functions().without_modifier_names(["onlyOwner"]).exec(100)

  contracts = []
  for function in functions:
    # For each function without an "onlyOwner" modifier, return the contract
    contracts.append(function.get_contract())

  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (5) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the function's or modifier's signature.
---

# Callable.signature()

`signature() → str`

## Example

```python
from glider import *
def query():
  functions = Functions().exec(3,3)

  for function in functions:
    # Aggregate the signature of each function along with their name
    print(f"function name {function.name} | signature {function.signature()}")

  return functions
```

## Example output

<figure><img src="../../.gitbook/assets/image (137).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the function's or modifier's source line numbers.
hidden: true
---

# Callable.source\_line()

`source_line() → int`

## Example

```python
from glider import *
def query():
  functions = Functions().exec(100)

  functions_location = []
  for function in functions:
    # Return the source line number of each function
    functions_location.append({"function": function.name(), "line": function.source_line()})

  return functions_location
```

## Example output

```json
[
  {
    "function": "name",
    "line": 229
  },
  {
    "function": "symbol",
    "line": 234
  },
  {
    "function": "tokenURI",
    "line": 239
  },
  ...
]
```
---
description: Returns end_assembly instructions of the function/modifier.
---

# Callable.end\_asm\_instructions()

`end_asm_instructions() →` [`Instructions`](../instructions/)

## Query Example

```python
from glider import *

def query():
    functions = Functions().exec(300)

    assembly = []
    for function in functions:
        for asm_instruction in function.end_asm_instructions().exec():
            # For each function, return the assembly instructions
            assembly.append(asm_instruction)

    return assembly
```

## Example Output

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Modifier

The class represents a single modifier object.

\
Bases: [`Callable`](../)
# Modifier.functions()

`functions() →` [`Functions`](../../callables/functions/)

Returns the [Functions](../../callables/functions/) object for the functions which have the modifier.



An example to retrieve the functions object for the modifier is as below

```python
from glider import *
def query():
  modifierlist = Modifiers()\
      .with_name_prefix("check")\
      .exec(1)
  
  results =  []

  for modd in modifierlist:
    for funcs in modd.functions().exec():
      results.append(funcs)

  return results
```

## Output

<figure><img src="../../../.gitbook/assets/image (97).png" alt=""><figcaption></figcaption></figure>

---
description: Returns break instructions of the function/modifier.
---

# Callable.break\_instructions()

`break_instructions() →` [`Instructions`](../instructions/)

## Example

```python
from glider import *


def query():
  functions = Functions().with_name("removeLiquidityPool").exec(1, 1)

  results = []
  for function in functions:
    # For each function, return each break instruction
    for instruction in function.break_instructions().exec():
      results.append(instruction)

  return results
```

## Example output

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-21 at 11.22.13 AM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns continue instructions of the function/modifier.
---

# Callable.continue\_instructions()

`continue_instructions() →` [`Instructions`](../instructions/)

## Example

```python
from glider import *
def query():
  functions = Functions().exec(9000)

  continue_instructions = []
  for function in functions:
    # List all continue instructions inside the given functions
    for instruction in function.continue_instructions().exec():
      continue_instructions.append(instruction)

  return continue_instructions
```

## Example output

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the instructions of the function/modifier.
---

# Callable.instructions()

`instructions() →` [`Instructions`](../instructions/)

The function will return all of the instructions directly reachable from the function.

## Example

```python
from glider import *
def query():
  functions = Functions().exec(1)

  instructions = []
  for instruction in functions[0].instructions().exec():
    # Return an array of all instructions for a function
    instructions.append(instruction)

  return instructions
```

## Example output

<figure><img src="../../.gitbook/assets/image (133).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a LocalVariables object for the local variables of the
  function/modifier.
---

# Callable.local\_variables()

`local_variables() →` [`LocalVariables`](../localvariables/)

## Query Example

```python
from glider import *

def query():
    functions = Functions().exec(1, 100)

    for function in functions:
        for local_var in function.local_variables().list():
            print(local_var.name)

    return functions
```

## Output Example

<figure><img src="../../.gitbook/assets/image (134).png" alt=""><figcaption></figcaption></figure>
---
description: Returns entry_point instructions of the function/modifier.
---

# Callable.entry\_point\_instructions()

`entry_point_instructions() →` [`Instructions`](../instructions/)

The entry\_point of a function is not a "real" instruction, but rather an abstract instruction representing the starting point of the function.

## Example

```python
from glider import *
def query():
  functions = Functions().exec(100)

  entry_points = []
  for function in functions:
    for entry_point_instruction in function.entry_point_instructions().exec():
      # For each function, return entry points
      entry_points.append(entry_point_instruction)

  return entry_points
```

## Example output

<figure><img src="../../.gitbook/assets/image (6) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Constructs and returns procedure graph of the function/modifier.
hidden: true
---

# Callable.get\_pg()

`get_pg() → ProcedureGraph`

The ProcedureGraph is an internal data structure for representing CFG/DFG graphs of the code. There is low probability that anyone will need to directly access it while writing queries.

## Example

```python
from glider import *
def query():
  functions = Functions().without_modifier_names(["onlyOwner"]).exec(100)

  state_variables = []
  for function in functions:
    # For each function without an "onlyOwner" modifier, return all state variables in the procedure graph
    for state_var in function.get_pg().get_state_variables():
      state_variables.append(state_var.to_json())

  return state_variables
```

## Example output

```json
[
  { "id": -2, "node": "Ownable._owner", "type": "state_variable" },
  { "id": -8, "node": "VRFConsumerBase.nonces", "type": "state_variable" },
  { "id": -7, "node": "VRFConsumerBase.vrfCoordinator", "type": "state_variable" },
  { "id": -6, "node": "VRFConsumerBase.LINK", "type": "state_variable" }
]
```
---
description: >-
  Returns an Instructions object for the call instructions of the
  function/modifier.
---

# Callable.calls\_instructions()

`calls_instructions() →` [`Instructions`](../instructions/)

The function returns [Instructions](../instructions/) object for all instructions that have any type of call inside it, whether it is an external, internal, library or other type of call.

## Example

```python
from glider import *
def query():
  functions = Functions().exec(100)

  calls_instructions = []
  for function in functions:
    # List all call instructions in the given functions
    for instruction in function.calls_instructions().exec():
      calls_instructions.append(instruction)

  return calls_instructions
```

## Example output

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a Functions object that represents called functions from the
  function/modifier.
---

# Callable.callee\_functions()

`callee_functions() →` [`Functions`](../callables/functions/)

## Example

```python
from glider import *
def query():
  functions = Functions().exec(30)

  called_functions = []
  for function in functions:
    for called in function.callee_functions().exec():
      # Return each called function from this specific one
      called_functions.append(called)

  return called_functions
```

## Example output

<figure><img src="../../.gitbook/assets/image (103).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the source code of the function/modifier.
---

# Callable.source\_code()

`source_code() → str`

## Example

```python
from glider import *
def query():
  functions = Functions().exec(1,1)

  for function in functions:
    # Aggregate the code of each function along with their name
    print(f"function: {function.name}, code: {function.source_code()}")

  return functions
```

## Example output

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the address of the function/modifier.
---

# Callable.address()

`address() → str`

## Query Example

```python
from glider import *

def query():
  functions = Functions().with_name("transferFrom").exec(2)
  
  for function in functions:
    print(function.address())

  return functions
```

## Output Example

<figure><img src="../../.gitbook/assets/image (8) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Retrieves loops from Callable
---

# Callable.loops()

`loops() -> APIList[Loop]`

##
---
description: Returns try instructions of the function/modifier.
---

# Callable.try\_instructions()

`try_instructions() →` [`Instructions`](../instructions/)

## Query Example

```python
from glider import *


def query():
  functions = Functions().with_name("processFee").exec(1)

  try_instructions = []
  for function in functions:
    for instruction in function.try_instructions().exec():
      # Return the try instructions for each function
      try_instructions.append(instruction)

  return try_instructions
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-25 at 3.42.31 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns end_if instructions of the function/modifier.
---

# Callable.end\_if\_instructions()

`end_if_instructions() →` [`Instructions`](../instructions/)

## Example

```python
from glider import *
def query():
  functions = Functions().exec(100)

  conditional = []
  for function in functions:
    for if_instruction in function.end_if_instructions().exec():
      # For each function, return the conditional (if) instructions
      conditional.append(if_instruction)

  return conditional
```

## Example output

<figure><img src="../../.gitbook/assets/image (4) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if the function has modifiers, otherwise returns false
---

# Function.has\_modifiers()

`has_modifiers() → bool`

## Example

```python
from glider import *

def query():
    functions_with_modifiers = (
      Functions()
      .exec(100)
      .filter(lambda x: x.has_modifiers())
    )

    return functions_with_modifiers
```

## Output

<figure><img src="../../../.gitbook/assets/image (88).png" alt=""><figcaption></figcaption></figure>

# Function.return\_instructions()

`return_instructions() →` [`Instructions`](../../instructions/)

Returns the `return` instructions of the function.

```python
from glider import *

def query():
  # Fetch a list of functions
  functions = Functions().exec(20)

  # Retrieve the return instructions of the first function
  instruction = functions[0].return_instructions().exec()

  return instruction
```

\


Output:

<figure><img src="../../../.gitbook/assets/image (93).png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if the function is view, otherwise returns false.
---

# Function.is\_view()

`is_view() → bool`

## Example

```python
from glider import *

def query():
    view_functions = (
      Functions()
      .exec(100)
      .filter(lambda x: x.is_view())
    )

    return view_functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (89).png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if the function is payable, otherwise returns false.
---

# Function.is\_payable()

`is_payable() → bool`

## Example

```python
from glider import *

def query():
    payable_functions = (
      Functions()
      .exec(1000)
      .filter(lambda x: x.is_payable())
    )

    return payable_functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (4) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Function

The class represents a single function object.

Bases: [`Callable`](../../callables/)
---
description: Returns a Functions object that represents functions that call the function.
---

# Function.caller\_functions()

`caller_functions() →` [`Functions`](../../callables/functions/)

The caller functions are the functions that directly call the specified function.

## Example

```python
from glider import *

def query():
  # Retrieve a function with name _afterTokenTransfer
  functions = Functions().with_name('_afterTokenTransfer').exec(1)

  # Return its caller functions
  return functions[0].caller_functions().exec()
```

## Output

<figure><img src="../../../.gitbook/assets/image (86).png" alt=""><figcaption></figcaption></figure>



---
description: >-
  Returns true if the visibility of the function is public, otherwise returns
  false.
---

# Function.is\_public()

`is_public() → bool`

## Example

```python
from glider import *

def query():
    public_functions = (
      Functions()
      .exec(1000)
      .filter(lambda x: x.is_public())
    )

    return public_functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (6) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if the function is constructor, otherwise returns false.
---

# Function.is\_constructor()

`is_constructor() → bool`

## Example

```python
from glider import *

def query():
    constructors = (
      Functions()
      .exec(100)
      .filter(lambda x: x.is_constructor())
    )

    return constructors
```

## Output

<figure><img src="../../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if the function is pure, otherwise returns false.
---

# Function.is\_pure()

`is_pure() → bool`

## Example

```python
from glider import *

def query():
    pure_functions = (
      Functions()
      .exec(100)
      .filter(lambda x: x.is_pure())
    )

    return pure_functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (7) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the visibility of the function is external, otherwise returns
  false.
---

# Function.is\_external()

`is_external() → bool`

## Query Example

```python
from glider import *

def query():
    external_functions = (
      Functions()
      .exec(100)
      .filter(lambda x: x.is_external())
    )

    return external_functions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-15 at 2.48.19 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the Modifiers object for the modifiers of the function.
---

# Function.modifiers()

`modifiers() →` [`Modifiers`](../../callables/modifiers/)

Returns the [Modifiers](../../callables/modifiers/) object for the modifiers of the function.

## Example

```python
from glider import *

def query():
  # Fetch a list of functions
  functions = Functions().with_one_property([MethodProp.HAS_MODIFIERS]).exec(1)

  # Retrieve the modifiers of the first function
  modifers = functions[0].modifiers().exec()

  return modifers
```

## Output

<figure><img src="../../../.gitbook/assets/image (91).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the visibility of the function is private, otherwise returns
  false.
---

# Function.is\_private()

`is_private() → bool`

## Query Example

```python
from glider import *

def query():
    private_functions = (
      Functions()
      .exec(20)
      .filter(lambda x: x.is_private())
    )

    return private_functions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-15 at 3.00.38 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the visibility of the function is internal, otherwise returns
  false.
---

# Function.is\_internal()

`is_internal() → bool`

## Example

```python
from glider import *

def query():
    internal_functions = (
      Functions()
      .exec(20)
      .filter(lambda x: x.is_internal())
    )

    return internal_functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the function's properties.
---

# Function.properties()

`properties() →` [`APIList`](../../iterables/apilist.md)`[`[`MethodProp`](../../callables/methodprop/)`]`

Returns the function's properties as an [APIList](../../iterables/apilist.md) of [MethodProps](../../callables/methodprop/).

## Example

```python
from glider import *

def query():
  # Fetch a list of functions
  functions = Functions().exec(1)

  # Retrieve the properties of the first function
  properties = functions[0].properties()
  for prop in properties:
    print(prop)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (92).png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if the function is global, otherwise returns false.
---

# Function.is\_global()

`is_global() → bool`

## Query Example

```python
from glider import *

def query():
    global_functions = (
      Functions()
      .exec(85_200)
      .filter(lambda x: x.is_global())
    )

    return global_functions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-15 at 2.58.32 PM.png" alt=""><figcaption></figcaption></figure>
# Function.return\_tuple()

`return_tuple() → Tuple[Type, List[`[`Value`](../../value/) `|`[`NoneObject`](../../internal/noneobject/)`]]`

Returns the function's `return (type, value)` tuples.

## Query Example

```python
from glider import *

def query():
  # Fetch a list of functions
  functions = Functions().exec(1,4)

  for func in functions:
    # Retrieve the return instructions of the first function
    return_tuple = func.return_tuple()
    print(f"Type is - {return_tuple[0]}")
    for value in return_tuple[1]:
      print(value.expression)

  return functions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-19 at 2.57.57 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns end_loop instructions of the function/modifier.
---

# Callable.end\_loop\_instructions()

`end_loop_instructions() →` [`Instructions`](../instructions/)

The functions will return end\_loop instructions for all types of loops e.g. while/for

end\_loop instruction is not a "real" instruction but rather an abstract one representing the end of the loop.

## Example

```python
from glider import *
def query():
  functions = Functions().exec(500)

  loop = []
  for function in functions:
    for loop_instruction in function.end_loop_instructions().exec():
      # For each function, return the loop instructions
      loop.append(loop_instruction)

  return loop
```

## Example output

<figure><img src="../../.gitbook/assets/image (5) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns if instructions of the function/modifier.
---

# Callable.if\_instructions()

`if_instructions() →` [`Instructions`](../instructions/)

## Example

```python
from glider import *
def query():
  functions = Functions().exec(50)

  if_instructions = []
  for function in functions:
    for instruction in function.if_instructions().exec():
      if_instructions.append(instruction)

  return if_instructions
```

## Example output

<figure><img src="../../.gitbook/assets/image (131).png" alt=""><figcaption></figcaption></figure>
---
description: Returns keccak256 selector of the function's or modifier's signature.
hidden: true
---

# Callable.selector()

`selector() → int`

---
description: Returns an Arguments object for the arguments of the function/modifier.
---

# Callable.arguments()

`arguments() →` [`ArgumentPoints`](../point/argumentpoints/)

## Example

```python
from glider import *

def query():
    functions = Functions().exec(1,4)

    for func in functions:
        for arg in func.arguments().list():
            print(f"Function name: {func.name}, Argument: {arg.source_code()}")

    return functions

```

## Example output

<figure><img src="../../.gitbook/assets/image (101).png" alt=""><figcaption></figcaption></figure>



{% hint style="info" %}
The function returns ArgumentPoints, instead of APIList, in case the result of the function is used as the return value of the query it must be casted to `list()`
{% endhint %}
---
description: Returns catch instructions of the function/modifier.
---

# Callable.catch\_instructions()

`catch_instructions() →` [`Instructions`](../instructions/)

## Example

```python
from glider import *
def query():
  functions = Functions().exec(5000)

  catch_instructions = []
  for function in functions:
    # List all catch instructions inside a try/catch block from the given functions
    for instruction in function.catch_instructions().exec():
      catch_instructions.append(instruction)

  return catch_instructions
```

## Example output

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the function's/modifier's instructions that create a new contract.
---

# Callable.new\_contract\_instructions()

`new_contract_instructions() →` [`Instructions`](../instructions/)

## Query Example

```python
from glider import *

def query():
  functions = Functions().with_name("deploy").exec(20)

  deployment_instructions = []
  for func in functions:
    for inst in func.new_contract_instructions().exec():
      deployment_instructions.append(inst)
      
  return deployment_instructions
```

## Output Example

<figure><img src="../../.gitbook/assets/image (136).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the instruction is start assembly instruction, otherwise
  returns false.
---

# Instruction.is\_start\_assembly()

`is_start_assembly() -> bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(10000).filter(lambda x: x.is_start_assembly())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (201).png" alt=""><figcaption></figcaption></figure>
---
description: The class extends the Instruction class and represents end_loop instruction.
---

# EndLoopInstruction

Bases: [`Instruction`](./)

Example of `EndLoopInstruction`

<figure><img src="../../.gitbook/assets/image (211).png" alt=""><figcaption></figcaption></figure>
---
description: The class extends the Instruction class and represents break instruction.
---

# BreakInstruction

Bases: [`Instruction`](./)

Example of `BreakInstruction`

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the instruction is start_loop instruction, otherwise returns
  false.
---

# Instruction.is\_start\_loop()

`is_start_loop()` -> `bool`

## Output Example

```python
from glider import *

def query():
  return Instructions().exec(1000).filter(lambda x: x.is_start_loop())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Query Example

<figure><img src="../../.gitbook/assets/image (202).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the set of all instructions following the current node in the control
  flow graph.
---

# Instruction.next\_instructions\_recursive()

`next_instructions_recursive() →` [`APISet`](../iterables/apiset.md)`[`[`Instruction`](./)`]`

The difference between the next\_instructions\_recursive() function and [next\_instructions()](instruction.next_instructions.md) is that this function works in an recursive (**inter**-procedural) manner and returns all instructions following the current instruction in the CFG (control-flow-graph).

_The function is recursive (intra-procedural), and follows function calls; for the non-recursive (**intra**-procedural) variant of this function, use_ [_`next_instructions()`_](instruction.next_instructions.md)_._



For example, in the function:

```solidity
function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
```

for the instruction:

```solidity
_approve(_msgSender(), spender, amount);
```

the function will return instructions from `_approve()`.

### Query Example

```python
from glider import *
def query():

  instructions = Functions().with_name("approve").exec(1, 9).instructions().exec(1,1)
  
  return instructions + list(instructions.next_instructions_recursive())
```

### Output Example

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (2).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (2).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (4) (1) (1) (1) (2).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (5) (1) (1) (1) (2).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (6) (1) (1) (1) (2).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (7) (1) (1) (1) (2).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (8) (1) (1) (2).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
The function returns APISet, instead of APIList, in case the result of the function is used as the return value of the query it must be casted to `list()`
{% endhint %}
---
description: >-
  The class extends the Instruction class and represents new_variable
  instruction.
---

# NewVariableInstruction

Bases: [`Instruction`](./)

Example of `NewVariableInstruciton`

<figure><img src="../../.gitbook/assets/image (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the destination (lvalue) if the instruction has any type of assignment
---

# Instruction.get\_dest()

`get_dest() →` [`APIList`](../iterables/apilist.md)`[`[`Value`](../value/) `|` [`NoneObject`](../internal/noneobject/)`]`

For the function:

```solidity
function log10(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >= 10 ** 64) {
                value /= 10 ** 64;
                result += 64;
            }
            if (value >= 10 ** 32) {
                value /= 10 ** 32;
                result += 32;
            }
            if (value >= 10 ** 16) {
                value /= 10 ** 16;
                result += 16;
            }
            if (value >= 10 ** 8) {
                value /= 10 ** 8;
                result += 8;
            }
            if (value >= 10 ** 4) {
                value /= 10 ** 4;
                result += 4;
            }
            if (value >= 10 ** 2) {
                value /= 10 ** 2;
                result += 2;
            }
            if (value >= 10 ** 1) {
                result += 1;
            }
        }
        return result;
    }
```

The instruction:

```solidity
result += 64;
```

Will return the `result` variable as an instance of Value-derived class, as the result is a variable, it will be of type Var.&#x20;

## Query Example

```python
from glider import *
def query():
  instruction = Instructions().exec(1,1)
  dests = instruction[0].get_dest()
  for dest in dests:
    print(dest.expression)
      
  return [instruction[0]]
```

## Output

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: The class extends the Instruction class and represents if_loop instruction.
---

# IfLoopInstruction

Bases: [`Instruction`](./)

Example of `IfLoopInstruction`

<figure><img src="../../.gitbook/assets/image (8) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns a list of immediate following instructions in the control flow graph.
---

# Instruction.next\_instruction()

`next_instruction() →` [`APISet`](../iterables/apiset.md)`[`[`Instruction`](./)`]`

The difference between the next\_instruction() function and [next\_instructions()](instruction.next_instructions.md) is that this function will return a list of instructions that are immediately following the current instruction in the CFG (control-flow-graph).



_The function operates non-recursively, meaning it works intra-procedurally._



For example, in the function:

```solidity
function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMath: addition overflow");

    return c;
  }
```

for the instruction:&#x20;

```solidity
uint256 c = a + b;
```

the function will return the instruction:

```solidity
require(c >= a, "SafeMath: addition overflow");
```

## Query Example

```python
from glider import *
def query():
  instructions = Functions().with_name("sub").exec(1,1).instructions().exec(1,1)

  return instructions + instructions[0].next_instruction()
```

## Example Output

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: The class extends the Instruction class and represents end_if instruction.
---

# EndIfInstruction

Bases: [`Instruction`](./)

Example of `EndIfInstruction`

<figure><img src="../../.gitbook/assets/image (210).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a list of the previous instructions of the current node in the control
  flow graph.
---

# Instruction.previous\_instructions()

`previous_instructions() →` [`APISet`](../iterables/apiset.md)`[`[`Instruction`](./)`]`

The difference between the previous\_instructions() function and [previous\_instruction()](instruction.previous_instruction.md) is that this function will return all previous instructions of the current instruction in the CFG (control-flow-graph).

_The function is non-recursive (intra-procedural), and thus will not follow function calls; for the recursive (**inter**-procedural) variant of this function, use extended\_previous\_instructions()._

For example, in the function:

```solidity
function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }
```

for the instruction:&#x20;

```solidity
return c;
```

the function will return the instructions:

```solidity
uint256 c = a - b;
require(b <= a, errorMessage);
*entry_point_instruction*
```

```solidity
require(b <= a, errorMessage);
```

```solidity
*entry_point_instruction*
{
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
}
```

{% hint style="info" %}
Entry point instruction" is a type of instruction that does not exist in real code. It is used internally by the Glider engine
{% endhint %}

## Query Example

```python
from glider import *

def query():
  instructions = Functions().with_name("sub").exec(1,1).instructions().exec(1,3)

  return instructions + list(instructions[0].previous_instructions())
```

## Example Output

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>



{% hint style="info" %}
As can be seen from the last output, "virtual" instructions like entry-point instruction, end-if, etc. when being printed with source\_code() will print full code block's source
{% endhint %}

{% hint style="info" %}
The function returns APISet, instead of APIList, in case the result of the function is used as the return value of the query it must be casted to `list()`
{% endhint %}
---
description: >-
  Returns True if the instruction is catch instruction in a try-catch block,
  otherwise returns False.
---

# Instruction.is\_catch()

`is_catch()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(100000).filter(lambda x: x.is_catch())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: The class extends the Instruction class and represents expression instruction.
---

# ExpressionInstruction

Bases: [`Instruction`](./)

Example of `ExpressionInstruction`

<figure><img src="../../.gitbook/assets/image (213).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the instruction is return instruction, otherwise returns
  false.
---

# Instruction.is\_return()

`is_return()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(100).filter(lambda x: x.is_return())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (200).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the Instruction's Value object.
---

# Instruction.get\_value()

`get_value() ->` [`Value`](../value/) `|` [`NoneObject`](../internal/noneobject/)

## Query Example

```python
from glider import *

def query():
    instructions = Instructions().exec(2,1)
    results = []
    
    for inst in instructions: 
        print(inst.get_value())

    return instructions
```

## Example Output

<figure><img src="../../.gitbook/assets/image (189).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the instruction is end_loop instruction, otherwise returns
  false.
---

# Instruction.is\_end\_loop()

`is_end_loop()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(1000).filter(lambda x: x.is_end_loop())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (191).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the instruction is entry_point instruction, otherwise returns
  false.
---

# Instruction.is\_entry\_point()

`is_entry_point()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(1000).filter(lambda x: x.is_entry_point())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (192).png" alt=""><figcaption></figcaption></figure>
---
description: Returns True if the instruction is call instruction, otherwise returns False.
---

# Instruction.is\_call()

`is_call` -> `bool`

## Query example

```python
from glider import *

def query():
  return Instructions().exec(100).filter(lambda x: x.is_call())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output example

<figure><img src="../../.gitbook/assets/image (8) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the instruction's components.
---

# Instruction.get\_components()

`get_components() →` [`APIList`](../iterables/apilist.md)`[`[`Value`](../value/) `|` [`NoneObject`](../internal/noneobject/)`]`

## Query Example

```python
from glider import *

def query():
    instructions = Instructions().exec(1,10)
    for inst in instructions:
        for component in inst.get_components():
            print(component.expression)

    return instructions
```

## Output Example

<figure><img src="../../.gitbook/assets/image (188).png" alt=""><figcaption></figcaption></figure>
# Instruction

The class represents a single instruction object.

\
Bases: `Queryable`, `Point`
---
description: The class extends the Instruction class and represents throw instruction.
---

# ThrowInstruction

Bases: [`Instruction`](./)

Example of `ThrowInstruction`

<figure><img src="../../.gitbook/assets/image (6) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the instruction is end_if instruction, otherwise returns
  false.
---

# Instruction.is\_end\_if()

`is_end_if()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(1000).filter(lambda x: x.is_end_if())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (190).png" alt=""><figcaption></figcaption></figure>

---
description: >-
  Returns True if the instruction is Try instruction in a try-catch block,
  otherwise returns False.
---

# Instruction.is\_try()

`is_try()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(20000).filter(lambda x: x.is_try())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the list of builtin call names that are called from the instruction.
  E.g. keccak256, ecrecover...
---

# Instruction.builtin\_callee\_names()

`builtin_callee_names() → List[str]`

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().with_callee_name("keccak256").exec(1)

  print(instructions[0].builtin_callee_names())

  return instructions
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-03 at 11.13.46 AM.png" alt=""><figcaption></figcaption></figure>

---
hidden: true
---

# Instruction.procedure\_graph

Returns the instruction's parent function's procedure graph.

Query

```python
from glider import *
def query():
  node_instruction = []
  instructions = Instructions().exec(1)
  #get the procedure_graph object 
  procedure_graph = instructions[0].procedure_graph
  #The procdure_graph has a property called all_nodes 
  #which returns a list of all the nodes in the graph
  all_nodes = procedure_graph.all_nodes
  #return the instruction corresponding to the first node
  node_instruction.append(all_nodes[0].instruction)
  return node_instruction

```

Output

```json
{
  "contract": "0x798AcB51D8FBc97328835eE2027047a8B54533AD",
  "contract_name": "Context",
  "sol_function": "function _msgSender() internal view virtual returns (address) {\n        return msg.sender;\n    }",
  "sol_instruction": "{\n        return msg.sender;\n    }"
}
```
---
description: >-
  Returns a list of all instructions following the current node in the control
  flow graph.
---

# Instruction.next\_instructions()

`next_instructions() →` [`APISet`](../iterables/apiset.md)`[`[`Instruction`](./)`]`

The difference between the next\_instructions() function and [next\_instruction()](instruction.next_instruction.md) is that this function will return all instructions following the current instruction in the CFG (control-flow-graph).

_The function is non-recursive (intra-procedural), and thus will not follow function calls; for the recursive (**inter**-procedural) variant of this function, use_ [_`extended_next_instructions()`_](instruction.next_instructions_recursive.md)_._



For example, in the function:

```solidity
function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMath: addition overflow");

    return c;
  }
```

for the instruction:&#x20;

```solidity
uint256 c = a + b;
```

the function will return the instructions:

```solidity
require(c >= a, "SafeMath: addition overflow");
```

```solidity
return c;
```

### Query Example

```python
from glider import *
def query():
  instructions = Functions().with_name("sub").exec(1,1).instructions().exec(1,1)

  return instructions + list(instructions[0].next_instructions())
```

### Output Example

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (2).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
The function returns APISet, instead of APIList, in case the result of the function is used as the return value of the query it must be casted to `list()`
{% endhint %}
---
description: Returns true if the instruction is an if instruction, otherwise returns false.
---

# Instruction.is\_if()

`is_if()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(1000).filter(lambda x: x.is_if())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (195).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the list of instructions following the current instruction till the
  branching point.
---

# Instruction.next\_block()

`next_block() →` [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Query Example

```python
from glider import *

def query():
  ins = Instructions().start_asm_instructions().exec(1)

  return ins + ins[0].next_block()
```

## Output Example

### Virtual instruction, that represent asm start block

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Next block instructions:

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (4) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (5) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the instruction is from assembly block, otherwise returns
  false.
---

# Instruction.is\_from\_assembly()

`is_from_assembly() -> bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(1000).filter(lambda x: x.is_from_assembly())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (194).png" alt=""><figcaption></figcaption></figure>
---
description: Returns all instructions from the assembly block
---

# StartAssemblyInstruction.get\_block\_instructions()

`get_block_instructions() →` [`APIList`](../../iterables/apilist.md)`[`[`Instruction`](../)`]`

## Query Example

```python
from glider import *

def query():
    assembly_instructions = Functions().exec(1,57).start_asm_instructions().exec()

    return assembly_instructions + assembly_instructions[0].get_block_instructions()
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (223).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (225).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (226).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  The class extends the Instruction class and represents the start of an
  assembly block.
---

# StartAssemblyInstruction

Bases: [`Instruction`](../../instructions/)

Example of `StartAsseblyInstruction`

<figure><img src="../../../.gitbook/assets/image (4) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the instruction's i-th component.
---

# Instruction.get\_component()

`get_component(`_`i : int`_`) →` [`Value`](../value/) `|` [`NoneObject`](../internal/noneobject/)

## Query Example

```python
from glider import *

def query():
    instructions = Instructions().exec(1,1)
  
    print(instructions[0].get_component(0).expression)
    return instructions
```

## Output Example

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the list of function names that are called from the instruction. It
  returns an empty list for an instruction that does not call any functions
---

# Instruction.callee\_names()

`callee_names() → List[str]`

For example, for the instruction:

```solidity
require(!_exists(tokenId), "ERC721: token already minted");
```

The functions will return `['_exists', 'require']`

## Query Example

```python
from glider import *


def query():
  # Fetch an instruction
  instruction = Instructions().with_callee_name('require').exec(1,30)
  
  # Print the list of function names called from the instruction
  print(instruction[0].callee_names()) 
  return instruction
```

## Example Output

<figure><img src="../../.gitbook/assets/image (182).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the corresponding source line numbers of a instruction
hidden: true
---

# Instruction.source\_lines()

Query

```python
from glider import *
def query():
  #fetch a list of instructions
  instructions = Instructions().exec(1) 
  #print the corresponding source line numbers of the instruction
  print(instructions[0].source_lines())
  return []
```

Output

```json
{
  "print_output": [
    "[19, 20, 21]"
  ]
}
```
---
description: Returns metadata on all calls in the Instruction.
---

# Instruction.get\_callees()

`get_callees() → Dict`

## Query Example

```python
from glider import *

def query():
    instructions = Instructions().exec(3,182)
    results = []
    
    for inst in instructions: 
        print(inst.get_callees())

    return instructions
```

## Example Output

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the instruction is end_assembly instruction, otherwise returns
  false.
---

# Instruction.is\_end\_assembly()

`is_end_assembly()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(1000).filter(lambda x: x.is_end_assembly())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (6) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: The class extends the Instruction class and represents continue instruction.
---

# ContinueInstruction

Bases: [`Instruction`](./)

Example of `ContinueInstruciton`

<figure><img src="../../.gitbook/assets/image (208).png" alt=""><figcaption></figcaption></figure>
---
description: The class extends the Instruction class and represents return instruction.
---

# ReturnInstruction

Bases: [`Instruction`](./)

Example of `ReturnInstruction`

<figure><img src="../../.gitbook/assets/image (3) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the instruction is if_loop instruction, otherwise returns
  false.
---

# Instruction.is\_if\_loop()

`is_if_loop()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(1000).filter(lambda x: x.is_if_loop())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (197).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns True if the instruction is a comparison instruction i.e performing
  comparison operation/s using operators like >, <, == etc.., otherwise returns
  False.
---

# Instruction.is\_cmp()

`is_cmp()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(1000).filter(lambda x: x.is_cmp())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (4) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the instruction is placeholder instruction, otherwise returns
  false. A placeholder instruction is generally found in modifiers
---

# Instruction.is\_placeholder()

`is_placeholder()` -> `bool`

## Query Example

```python
from glider import *

def query():
  ins = (
    Modifiers()
    .exec(1)
    .instructions()
    .exec()
    .filter(lambda x: x.is_placeholder())
  )
  return ins
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (199).png" alt=""><figcaption></figcaption></figure>
---
description: The class represents a condition in if-statement or a ternary operator.
---

# Condition

`Condition(`_`token: str = ''`_`)`

The [IfInstruction.get\_condition()](../ifinstruction.get\_condition.md) function can be used to get the condition object of an if-statement.

Base: **object**

***

{% content-ref url="condition.is_eq.md" %}
[condition.is\_eq.md](condition.is\_eq.md)
{% endcontent-ref %}

{% content-ref url="condition.is_geq.md" %}
[condition.is\_geq.md](condition.is\_geq.md)
{% endcontent-ref %}

{% content-ref url="condition.is_gr.md" %}
[condition.is\_gr.md](condition.is\_gr.md)
{% endcontent-ref %}

{% content-ref url="condition.is_le.md" %}
[condition.is\_le.md](condition.is\_le.md)
{% endcontent-ref %}

{% content-ref url="condition.is_leq.md" %}
[condition.is\_leq.md](condition.is\_leq.md)
{% endcontent-ref %}
---
description: Returns true if it is a non-equality check, otherwise returns false.
---

# Condition.is\_neq()

`is_neq() → bool`

## Query Example

```python
from glider import *


def query():
  instructions = (
    Instructions()
    .if_instructions()
    .exec(100)
    .filter(lambda instruction : instruction.get_condition().is_neq())
  )

  return instructions
```

## Example Output

<figure><img src="../../../../.gitbook/assets/Screenshot 2025-09-03 at 1.44.15 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if it is ">=" check, otherwise returns false.
---

# Condition.is\_geq()

## Query Example

```python
from glider import *

def query():

  instructions = Functions().with_name("log10").exec(1).instructions().if_instructions().exec(1)

  print(instructions[0].get_condition().is_geq())

  return instructions
```

## Output Example

<figure><img src="../../../../.gitbook/assets/image (217).png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if it is an equality check, otherwise returns false.
---

# Condition.is\_eq()

`is_eq() -> bool`

## Query Example

```python
from glider import *

def query():
  instructionlist = Instructions().if_instructions().exec(1)
  
  condition = instructionlist[0].get_condition()
  print(condition.is_eq())
  return instructionlist
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (216).png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if it is ">" check, otherwise returns false.
---

# Condition.is\_gr()

## Query Example

```python
from glider import *

def query():
  instructions = Instructions().if_instructions().exec(10).filter(lambda instruction : instruction.get_condition().is_gr())

  return instructions
```

## Output Example

<figure><img src="../../../../.gitbook/assets/Screenshot 2025-09-03 at 1.42.09 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if it is "<=" check, otherwise returns false.
---

# Condition.is\_leq()

## Query Example

```python
from glider import *

def query():

  instructions = Functions().with_name("processProof").exec(1,1).instructions().if_instructions().exec(1)
  print(instructions[0].get_condition().is_leq())

  return instructions
```

## Output Example

<figure><img src="../../../../.gitbook/assets/image (220).png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if it is "<" check, otherwise returns false.
---

# Condition.is\_le()

## Query Example

```python
from glider import *

def query():

  instructions = Functions().with_name("min").exec(1).instructions().if_instructions().exec(1)
  print(instructions[0].get_condition().is_le())

  return instructions
```

## Output Example

<figure><img src="../../../../.gitbook/assets/image (219).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  The class extends the Instruction class and represents if instruction,  for
  both Solidity and assembly (yul) level.
---

# IfInstruction

Bases: [`Instruction`](../)

Example of `IfInstruction`

<figure><img src="../../../.gitbook/assets/image (214).png" alt=""><figcaption></figcaption></figure>
# IfInstruction.first\_true\_instruction()

`first_true_instruction() →` [`Instruction`](../)

The function returns the first instruction for the true-case scenario of the if-statement

## Query Example

for the function:

```solidity
function transfer(address _to, uint256 _amount) returns (bool success) 
     {
        if (_to == 0x0) throw;

        if (balances[msg.sender] >= _amount && _amount > 0 && balances[_to] + _amount > balances[_to]) 
        {
            balances[msg.sender] -= _amount;
            balances[_to] += _amount;
            Transfer(msg.sender, _to, _amount);
            return true;
         } 
         else 
         {
            return false;
         }
     }
```

The query (exec numbers are tuned here to match that exact if-statement)

```python
from glider import *

def query():
  instructionlist = Instructions().if_instructions().exec(1,1)
  
  first_true = instructionlist[0].first_true_instruction()

  return [first_true]
```

## Output

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
The [next\_instruction()](../instruction.next_instruction.md) is not used as it will always return an empty list of instructions. This is because no instruction can be run after a return statement, and the [next\_instruction()](../instruction.next_instruction.md) is non-recursive (intra-procedural).
{% endhint %}
# IfInstruction.first\_false\_instruction()

`first_false_instruction() →` [`Instruction`](../)

The function returns the first instruction for the false-case scenario of the if-statement

## Query Example

for the function:

```solidity
function transfer(address _to, uint256 _amount) returns (bool success) 
     {
        if (_to == 0x0) throw;

        if (balances[msg.sender] >= _amount && _amount > 0 && balances[_to] + _amount > balances[_to]) 
        {
            balances[msg.sender] -= _amount;
            balances[_to] += _amount;
            Transfer(msg.sender, _to, _amount);
            return true;
         } 
         else 
         {
            return false;
         }
     }
```

The query (exec numbers are tuned here to match that exact if-statement)

```python
from glider import *

def query():
  instructionlist = Instructions().if_instructions().exec(1,1)
  
  first_false = instructionlist[0].first_false_instruction()

  return [first_false]
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (7) (1) (1).png" alt=""><figcaption></figcaption></figure>
# IfInstruction.get\_condition()

`get_condition() →` [`Condition`](condition/)

Returns condition of the if-statement.

## Query Example

```python
from glider import *

def query():
  instructionlist = Instructions().if_instructions().exec(1)
  
  condition = instructionlist[0].get_condition()
  print(condition.is_eq())
  return instructionlist
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (215).png" alt=""><figcaption></figcaption></figure>

---
description: Returns corresponding node in procedure graph.
hidden: true
---

# Instruction.procedure\_graph\_node

Query

```python
from glider import *
def query():
  #fetch a list of instructions
  instructions = Instructions().exec(1,16)
  procedure_graph_node = instructions[0].procedure_graph_node
  #Return the instruction corresponding to the procedure_graph_node 
  return [procedure_graph_node.instruction]
```

Output

```json
{
  "contract": "0x798AcB51D8FBc97328835eE2027047a8B54533AD",
  "contract_name": "Ownable",
  "sol_function": "function transferOwnership(address newOwner) public virtual onlyOwner {\n        require(newOwner != address(0),\"Ownable: new owner is the zero address\");\n        _setOwner(newOwner);\n    }",
  "sol_instruction": "require(newOwner != address(0),\"Ownable: new owner is the zero address\")"
}
```
---
description: The class extends the Instruction class and represents start_loop instruction.
---

# StartLoopInstruction

Bases: [`Instruction`](./)

Example of `StartLoopInstruction`

<figure><img src="../../.gitbook/assets/image (5) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns True if the instruction is a storage write instruction, else returns
  False. A storage write instruction writes to the state variable of a contract
---

# Instruction.is\_storage\_write()

`is_storage_write()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(30).filter(lambda x: x.is_storage_write())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (7) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a list of all instructions following the current point in the current
  data flow graph.
---

# Instruction.forward\_df()

`forward_df() →` [`APISet`](../iterables/apiset.md)`[`[`Point`](../point/)`]`

The `forward_df()` function is an intra-procedural analysis function. This means that the function does not operate recursively and instead returns instructions within the current function instruction set.

For example, in the function:&#x20;

```solidity
function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }
```

For the instruction `uint256 c = a * b;` the forward data flow will return instructions:

```solidity
require(c / a == b, "SafeMath: multiplication overflow");
return c;
```

The easy way to put this is that it will follow the nodes where the variable `c` is being used directly or indirectly.

## Query Example

```python
from glider import *

def query():
    # Fetch an instruction
    instructions = Instructions().exec(1,16)
    
    # Return the list of instructions following the current instruction
    return instructions + list(instructions[0].forward_df())
```

## Example Output

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>



{% hint style="info" %}
The function returns APISet, instead of APIList, in case the result of the function is used as the return value of the query it must be casted to `list()`
{% endhint %}
---
description: >-
  Returns the list of all previous points of the current point in the current
  data flow graph and outside of that.
---

# Instruction.backward\_df\_recursive()

`backward_df_recursive() →` [`APISet`](../iterables/apiset.md)`[`[`Point`](../point/)`]`

The function works similarly to [Instruction.backward\_df()](instruction.backward_df.md); the main difference is that in case of Instruction.backward\_df() the function will return backward dataflow point for every point in the Instruction, while Instruction.backward\_df() returns only those connected with the current Instruction.&#x20;

Like all other dataflow (DF) functions, it returns a list/set of Points, which can be instructions or "points" in the code, such as arguments, variables, etc.

## Query Example

```python
from glider import *


def query():
  # Fetch an instruction
  instructions = Instructions().with_callee_name('verify').exec(1)
  
  for points in instructions[0].backward_df_recursive():
    print(points.source_code())

  # Return the list of previous instructions of the current instruction
  return instructions
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-17 at 1.41.25 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a list of all previous instructions/arguments/variables of the current
  point in the data flow graph.
---

# Instruction.backward\_df()

`backward_df() →` [`APISet`](../iterables/apiset.md)`[`[`Point`](../point/)`]`

The `backward_df()` function is an intra-procedural analysis function. This means that the function does not operate recursively and instead returns `instruction/argument/variable` within the current function instruction set.

The function returns the derived classes from [Point](../point/), such as [ArgumentPoint](../point/argumentpoint.md), [VarValue](../point/varvalue/), [Instruction](./), etc.

## Query Example

```python
from glider import *


def query():
  # Fetch an instruction
  instructions = Instructions().with_callee_name('verify').exec(1)
  
  for points in instructions[0].backward_df():
    print(points.source_code())

  # Return the list of previous instructions of the current instruction
  return instructions
```

## Output Example

<figure><img src="../../.gitbook/assets/image (180).png" alt=""><figcaption></figcaption></figure>

For the same contract, this query showcases that the return list elements are type-casted from Point:

```python
from glider import *


def query():
  # Fetch an instruction
  instructions = Instructions().with_callee_name('verify').exec(1)
  
  for points in instructions[0].backward_df():
    if isinstance(points, ArgumentPoint):
      print(points.get_variable().name)
    print(points.source_code())

  # Return the list of previous instructions of the current instruction
  return instructions
```

<figure><img src="../../.gitbook/assets/image (181).png" alt=""><figcaption></figcaption></figure>



{% hint style="info" %}
The function returns APISet, instead of APIList, in case the result of the function is used as the return value of the query it must be casted to `list()`
{% endhint %}
---
description: Returns a list of immediate previous instructions in the control flow graph.
---

# Instruction.previous\_instruction()

`previous_instruction() →` [`APISet`](../iterables/apiset.md)`[`[`Instruction`](./)`]`

The difference between the previous\_instruction() function and [previous\_instructions()](instruction.previous_instructions.md) is that this function will return a list of immediate previous instructions of the current instruction in the CFG (control-flow-graph).



_The function operates non-recursively, meaning it works intra-procedurally._



For example, in the function:

```solidity
function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }
```

for the instruction:&#x20;

```solidity
uint256 c = a - b;
```

the function will return the instruction:

```solidity
require(b <= a, errorMessage);
```

## Query Example

```python
from glider import *
def query():
  instructions = Functions().with_name("sub").exec(1,1).instructions().exec(1,2)

  return instructions + list(instructions[0].previous_instruction())
```

## Output Example

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>



{% hint style="info" %}
The function returns APISet, instead of APIList, in case the result of the function is used as the return value of the query it must be casted to `list()`
{% endhint %}
---
description: >-
  Returns true if the instruction is  an expression instruction, otherwise
  returns false.
---

# Instruction.is\_expression()

`is_expression()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(1000).filter(lambda x: x.is_expression())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (193).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the set of all instructions preceding the current node in the control
  flow graph.
---

# Instruction.previous\_instructions\_recursive()

`previous_instructions_recursive() →` [`APISet`](../iterables/apiset.md)`[`[`Instruction`](./)`]`

The function returns all instructions that are previous to the instruction in the CFG (control flow graph).

The difference between the extended\_previous\_instructions() function and [previous\_instructions()](instruction.previous_instructions.md) is that the former works in an inter-procedural manner.

_The function is inter-procedural, and follows function calls; for the **intra**-procedural variant of this function, use_ [_previous\_instructions()_](instruction.previous_instructions.md)_._



For example, in the function:

```solidity
function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }
```

for the instruction:

```solidity
require(c / a == b, "SafeMath: multiplication overflow")
```

having that the mul() is being called inside the function:

```solidity
function _transfer(address from, address to, uint256 amount) private {
        uint256 taxAmount=0;
        if (!_isExcludedFromFee[from] && !_isExcludedFromFee[to]) {
            require(tradeOpen, "Trading not open");
            taxAmount = amount.mul((_buyCount>_reduceBuyTaxAt)?_finalBuyTax:_initialBuyTax).div(100);

            if (from == uniswapV2Pair && to != address(uniswapV2Router)) {
                require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the limit");
                _buyCount++;
            }

            if (to != uniswapV2Pair) {
                require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the limit");
            }

            if(to == uniswapV2Pair && from!= address(this) ){
                taxAmount = amount.mul((_buyCount>_reduceSellTaxAt)?_finalSellTax:_initialSellTax).div(100);
            }

        //....
    }
```

the function will return previous instructions from mul():

```solidity
       if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
```

as well as from \_transfer():

```solidity
        uint256 taxAmount=0;
        if (!_isExcludedFromFee[from] && !_isExcludedFromFee[to]) {
            require(tradeOpen, "Trading not open");
            taxAmount = amount.mul((_buyCount>_reduceBuyTaxAt)?_finalBuyTax:_initialBuyTax).div(100);

            if (from == uniswapV2Pair && to != address(uniswapV2Router)) {
                require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the limit");
                _buyCount++;
            }

            if (to != uniswapV2Pair) {
                require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the limit");
            }

            if(to == uniswapV2Pair && from!= address(this) ){
                taxAmount = amount.mul((_buyCount>_reduceSellTaxAt)?_finalSellTax:_initialSellTax).div(100);
            }
```

Furthermore, it will also return instructions from transferFrom() function as the \_transfer() is being called from there as well:

```solidity
function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }
```

## Query Example

```python
from glider import *


def query():
  instructions = Functions().with_all_properties([MethodProp.INTERNAL]).instructions().with_callee_name('require').exec(1, 2)

  return instructions + list(instructions[0].previous_instructions_recursive())
```

## Example Output

<figure><img src="../../.gitbook/assets/image (183).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (184).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (185).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (186).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (187).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
The function returns APISet, instead of APIList, in case the result of the function is used as the return value of the query it must be casted to `list()`
{% endhint %}
---
description: >-
  Returns True if the instruction is a storage read instruction, else returns
  False. A storage read instruction just reads the value of a state variable
  without making any changes to it
---

# Instruction.is\_storage\_read()

`is_storage_write()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(10).filter(lambda x: x.is_storage_read())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (203).png" alt=""><figcaption></figcaption></figure>
---
description: Returns parent function/modifier of the instruction.
---

# Instruction.get\_parent()

`get_parent() → Callable | NoneObject`

The function returns a [Callable](../callable/) object, specifically either a [Function](../callable/function/) or [Modifier](../callable/modifier/) object, where the current instruction is placed.

## Query Example

```python
from glider import *


def query():
  #return the parent function/modifier of an instruction
  return [Instructions().exec(1)[0].get_parent()]
```

## Example Output

<figure><img src="../../.gitbook/assets/image (10) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the list of all points following the current point in the current data
  flow graph and outside of that.
---

# Instruction.forward\_df\_recursive()

`forward_df_recursive() →` [`APISet`](../iterables/apiset.md)`[`[`Point`](../point/)`]`

The function works similarly to [Instruction.forward\_df()](instruction.forward_df.md); the main difference is that in case of Instruction.forward\_df() the function will return forward dataflow point for every point in the Instruction, while Instruction.forward\_df() returns only those connected with the current Instruction.&#x20;

Like all other dataflow (DF) functions, it returns a list/set of Points, which can be instructions or "points" in the code, such as arguments, variables, etc.

## Query Example

```python
from glider import *

def query():
    # Fetch an instruction
    instructions = (
        Functions()
        .with_address("0xBC6e47b27f61531602662E3cC4DB688DB8cb7Ce8")
        .with_name("getInvariant")
        .exec(1)
        .instructions()
        .exec(1,2)

    )
    
    # Return the list of instructions following the current instruction
    instruction = instructions[0]

    # Iterate through each recursive point and print it's source code
    for point in instruction.forward_df_recursive():
        print(point.source_code())

    # Return the entry instruction to print all downstream points
    return instructions
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-17 at 2.50.45 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  The class extends the Instruction class and represents end_assembly
  instruction.
---

# EndAssemblyInstruction

Bases: [`Instruction`](./)

Example of `EndAssemblyInstruction`

<figure><img src="../../.gitbook/assets/image (209).png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if the instruction creates a new contract.
---

# Instruction.is\_new\_contract()

`is_new_contract() -> bool`

## Query Example

```python
from glider import *

def query():
  ins = (
    Functions()
    .with_name("deploy")
    .instructions()
    .exec(100)
    .filter(lambda x: x.is_new_contract())
  )
  return ins
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (198).png" alt=""><figcaption></figcaption></figure>
---
description: The class extends the Instruction class and represents try instruction
---

# TryInstruction

Bases: [`Instruction`](../)

Example of `TryInstruction`

<figure><img src="../../../.gitbook/assets/image (221).png" alt=""><figcaption></figcaption></figure>
---
description: The method returns a list of instruction in a try block.
---

# TryInstruction.get\_block\_instructions()

`get_block_instructions() -> APIList[`[`Instruction`](../)`]`

## Query Example

```python
from glider import *

def query():
    try_instructions = Instructions().try_instructions().exec(1)

    return try_instructions + try_instructions[0].get_block_instructions()
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (229).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (230).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  The class extends the Instruction class and represents placeholder
  instruction.
---

# PlaceholderInstruction

Bases: [`Instruction`](./)

Example of `PlaceholderInstruction`

<figure><img src="../../.gitbook/assets/image (2) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns True if the instruction is CONTINUE instruction, otherwise returns
  False.
---

# Instruction.is\_continue()

`is_continue()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(100000).filter(lambda x: x.is_continue())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (5) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the source code of the instruction
---

# Instruction.source\_code()

## Query Example

```python
from glider import *
def query():

  instructions = Instructions().exec(1,1)

  print(instructions[0].source_code())
  
  return instructions
```

## Output Example

<figure><img src="../../.gitbook/assets/image (207).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  The class extends the Instruction class and represents entry_point
  instruction.
---

# EntryPointInstruction

Bases: [`Instruction`](./)

Example of `EntryPointInstruction`

<figure><img src="../../.gitbook/assets/image (212).png" alt=""><figcaption></figcaption></figure>
---
description: Returns True if the instruction is throw instruction, otherwise returns False.
---

# Instruction.is\_throw()

`is_throw()` -> `bool`

## Query Example

```python
from glider import *


def query():
  return (
    Functions()
    .with_name("BliBliToken")
    .exec(1)
    .instructions()
    .exec()
    .filter(lambda x: x.is_throw())
  ) 
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-03 at 12.59.15 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the list of Value objects representing the destination(s) of the
  instruction. This function returns the list to accommodate cases like 'a= b =
  c= 5', where the destinations are [a, b, c].
---

# Instruction.get\_dests()

`get_dests() → APIList[`[`Value`](../value/) `|` [`NoneObject`](../internal/noneobject/)`]`&#x20;

## Query Example

```python
from glider import *


def query():
  instruction = Instructions().exec(1,1)
  dests = instruction[0].get_dests()
  
  for dest in dests:
    print(dest.expression)
      
  return [instruction[0]]
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-03 at 11.44.21 AM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns all instructions from the catch block
---

# CatchInstruction.get\_block\_instructions()

`get_block_instructions() ->` [`APIList`](../../iterables/apilist.md)`[`[`Instruction`](../)`]`

## Query Example

```python
from glider import *

def query():
    catch_instructions = Instructions().catch_instructions().exec(1,1)

    return catch_instructions + catch_instructions[0].get_block_instructions()
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (232).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (233).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (234).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (235).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (236).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (237).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (238).png" alt=""><figcaption></figcaption></figure>
---
description: The class extends the Instruction class and represents catch instruction.
---

# CatchInstruction

Bases: [`Instruction`](../)

Example of `CatchInstruction`

<figure><img src="../../../.gitbook/assets/image (231).png" alt=""><figcaption></figcaption></figure>
---
description: Returns True if the instruction is break instruction, otherwise returns False.
---

# Instruction.is\_break()

`is_break()` -> `bool`

## Query Example

```python
from glider import *

def query():
  return Instructions().exec(10000).filter(lambda x: x.is_break())
```

With the Glider 1.0 update, calling the [`exec`](../instructions/instructions.exec.md) function returns an [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`. You can then use [`Instruction`](./) functions, which are applied to each element of the [`APIList`](../iterables/apilist.md)`[`[`Instruction`](./)`]`

## Output Example

<figure><img src="../../.gitbook/assets/image (9) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: The aim of this class is to filter structs with some properties.
---

# Structs

---
description: Executes the formed query and returns the list of Struct objects.
---

# Structs.exec()

`exec(`_`limit_count: int = 0, offset_count: int = 0`_`) →` [`APIList`](../iterables/apilist.md)`[`[`Struct`](../struct/)`]`

## Query Example

```python
from glider import *


def query():
  contracts = Contracts().with_name("DefaultReserveInterestRateStrategy").exec(1)

  for contract in contracts:
    for struct in contract.structs().exec():
      print(struct.name)

  return contracts
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-10 at 5.43.41 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Executes the formed query and returns the list of Error objects.
---

# Errors.exec()

`exec(`_`limit_count: int = 0, offset_count: int = 0`_`) →` [`APIList`](../iterables/apilist.md)`[`[`Error`](../error/)`]`

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().exec(1, 2265)

  for contract in contracts:
    for error in contract.errors().exec():
      print(error.name)

  return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-29 at 6.21.15 PM.png" alt=""><figcaption></figcaption></figure>
---
description: The aim of this class is to filter errors with some properties.
---

# Errors

---
description: Filter instructions satisfying the given expr of global variables.
---

# Instructions.with\_globals()

`with_globals(expr: Any) →` [`Instructions`](./)

&#x20;
---
description: >-
  Returns Functions object for the functions where the instructions can be
  executed in.
---

# Instructions.functions\_recursive()

`functions_recursive() →` [`Functions`](../callables/functions/)

Consider the following Solidity code:

```solidity
function includeInFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = false;
}
```

For the following instruction:

```solidity
_isExcludedFromFee[account] = false;
```

The `includeInFee` function can call the instruction above. &#x20;

With `functions_recursive()`, one can retrieve the functions that are called recursively through the entire call chain.

## Query Example

```python
from glider import *

def query():
    # Fetch a function
    functions = (
        Functions()
        .with_name("includeInFee")
        .exec(1)
    )

    print(
        functions
        .instructions()
        .functions_recursive()
        .exec()
        .name
    )

    return functions
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-18 at 9.49.57 AM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the 'end loop' instructions.
---

# Instructions.end\_loop\_instructions()

`end_loop_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().end_loop_instructions().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (249).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get instructions that call a function with the given
  signature.
---

# Instructions.with\_callee\_signature()

`with_callee_signature(signature: str) →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return (
    Instructions()
    .with_callee_signature("deposit(uint256)")
    .exec(2,12)
  )
```

## Example Output

<figure><img src="../../.gitbook/assets/image (270).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (269).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns an Instructions object for the instructions that are from assembly
  block.
---

# Instructions.asm\_block\_instructions()

`asm_block_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().asm_block_instructions().exec(2, 2)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (239).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the instructions that create new contract.
---

# Instructions.new\_contract\_instructions()

`new_contract_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().new_contract_instructions().exec(1,2)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (258).png" alt=""><figcaption></figcaption></figure>
---
description: Returns a list of the functions calls instructions
---

# Instructions.low\_level\_external\_calls()

`low_level_function_calls() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().low_level_external_calls().exec(3)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the call instructions
---

# Instructions.calls()

`calls() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():  
  return Instructions().calls().exec(3, 72)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (241).png" alt=""><figcaption></figcaption></figure>
---
description: Returns a list of delegate call instructions from non assembly.
---

# Instructions.delegate\_calls\_non\_assembly()

`delegate_calls_non_assembly() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().delegate_calls_non_assembly().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (246).png" alt=""><figcaption></figcaption></figure>
# Instructions.return\_instructions()

Returns an [Instructions](./) object for the 'return' instructions.

`return_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().return_instructions().exec(2,18)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (260).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get instructions that call a function whose name has the
  given suffix.
---

# Instructions.with\_callee\_name\_suffix()

`with_callee_name_suffix(suffix: str, sensitivity: bool = True) →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return (
    Instructions()
    .with_callee_name_suffix("dao", sensitivity=False)
    .exec(2,10)
  )
```

## Example Output

<figure><img src="../../.gitbook/assets/image (268).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the 'end assembly' instructions.
---

# Instructions.end\_asm\_instructions()

`end_loop_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().end_asm_instructions().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (247).png" alt=""><figcaption></figcaption></figure>
---
description: Executes the formed query and returns the list of Instruction objects
---

# Instructions.exec()

`exec(limit_count: int = 0, offset_count: int = 0) →` [`APIList`](../iterables/apilist.md)`[`[`Instruction`](../instruction/)`]`

`limit_count` is the number of instructions to query, while `offset_count` is the offset applied to the results returned. For example with `offset_count` = 2, will return `limit_count` instructions starting from the 3rd instructions.

## Query Example

```python
from glider import *


def query():
  return Instructions().exec(10)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (251).png" alt=""><figcaption></figcaption></figure>
---
description: Returns a list of all low level static call instructions.
---

# Instructions.low\_level\_static\_calls()

`low_level_static_calls() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().low_level_static_calls().exec(3)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (256).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns Functions object for the functions where the instructions can be
  executed in.
---

# Instructions.modifiers\_recursive()

`modifiers_recursive() →` [`Functions`](../callables/functions/)

Consider the following Solidity code:

```solidity
function includeInFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = false;
}
```

For the following instruction:

```solidity
_isExcludedFromFee[account] = false;
```

The `includeInFee` function can call the instruction above. &#x20;

With `modifiers_recursive()`, one can retrieve the modifiers that are called recursively through the entire call chain.

## Query Example

```python
from glider import *

def query():
    # Fetch a function
    functions = (
        Functions()
        .with_name("includeInFee")
        .exec(1)
    )

    print(
        functions
        .instructions()
        .modifiers_recursive()
        .exec()
        .name
    )

    return functions
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-18 at 9.52.51 AM.png" alt=""><figcaption></figcaption></figure>
---
description: Filter instructions satisfying the given expr of operators.
---

# Instructions.with\_operators()

`with_operators(expr: Any) →` [`Instructions`](./)
---
description: Returns a list of all library call instructions.
---

# Instructions.library\_calls()

**`library_calls`**`() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().library_calls().exec(1,4)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (255).png" alt=""><figcaption></figcaption></figure>

This outputs the call to the `Math.log10(value)` library function.
---
description: Returns an Instructions object for the 'throw' instructions
---

# Instructions.throw\_instructions()

`throw_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().throw_instructions().exec(2,1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (263).png" alt=""><figcaption></figcaption></figure>
---
description: Returns a list of delegate call instructions from assembly.
---

# Instructions.delegate\_calls\_from\_assembly()

`delegate_calls_from_assembly() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().delegate_calls_from_assembly().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (245).png" alt=""><figcaption></figcaption></figure>
# Instructions

The aim of this class is to filter instructions with some properties.

Bases: [Queryable](../internal/queryable/)

{% content-ref url="instructions.callees.md" %}
[instructions.callees.md](instructions.callees.md)
{% endcontent-ref %}

{% content-ref url="broken-reference" %}
[Broken link](broken-reference)
{% endcontent-ref %}

{% content-ref url="instructions.calls.md" %}
[instructions.calls.md](instructions.calls.md)
{% endcontent-ref %}

{% content-ref url="instructions.delegate_calls.md" %}
[instructions.delegate\_calls.md](instructions.delegate_calls.md)
{% endcontent-ref %}

{% content-ref url="instructions.delegate_calls_from_assembly.md" %}
[instructions.delegate\_calls\_from\_assembly.md](instructions.delegate_calls_from_assembly.md)
{% endcontent-ref %}

{% content-ref url="instructions.delegate_calls_non_assembly.md" %}
[instructions.delegate\_calls\_non\_assembly.md](instructions.delegate_calls_non_assembly.md)
{% endcontent-ref %}

{% content-ref url="instructions.delegate_calls_non_assembly.md" %}
[instructions.delegate\_calls\_non\_assembly.md](instructions.delegate_calls_non_assembly.md)
{% endcontent-ref %}

{% content-ref url="instructions.entry_points.md" %}
[instructions.entry\_points.md](instructions.entry_points.md)
{% endcontent-ref %}

{% content-ref url="instructions.exec.md" %}
[instructions.exec.md](instructions.exec.md)
{% endcontent-ref %}

{% content-ref url="instructions.external_calls.md" %}
[instructions.external\_calls.md](instructions.external_calls.md)
{% endcontent-ref %}

{% content-ref url="instructions.functions.md" %}
[instructions.functions.md](instructions.functions.md)
{% endcontent-ref %}

{% content-ref url="instructions.high_level_static_calls.md" %}
[instructions.high\_level\_static\_calls.md](instructions.high_level_static_calls.md)
{% endcontent-ref %}

{% content-ref url="instructions.if_instructions.md" %}
[instructions.if\_instructions.md](instructions.if_instructions.md)
{% endcontent-ref %}

{% content-ref url="instructions.internal_calls.md" %}
[instructions.internal\_calls.md](instructions.internal_calls.md)
{% endcontent-ref %}

{% content-ref url="instructions.library_calls.md" %}
[instructions.library\_calls.md](instructions.library_calls.md)
{% endcontent-ref %}

{% content-ref url="broken-reference" %}
[Broken link](broken-reference)
{% endcontent-ref %}

{% content-ref url="broken-reference" %}
[Broken link](broken-reference)
{% endcontent-ref %}

{% content-ref url="instructions.low_level_external_calls.md" %}
[instructions.low\_level\_external\_calls.md](instructions.low_level_external_calls.md)
{% endcontent-ref %}

{% content-ref url="instructions.low_level_static_calls.md" %}
[instructions.low\_level\_static\_calls.md](instructions.low_level_static_calls.md)
{% endcontent-ref %}

{% content-ref url="instructions.modifiers.md" %}
[instructions.modifiers.md](instructions.modifiers.md)
{% endcontent-ref %}

{% content-ref url="broken-reference" %}
[Broken link](broken-reference)
{% endcontent-ref %}

{% content-ref url="instructions.with_callee_name.md" %}
[instructions.with\_callee\_name.md](instructions.with_callee_name.md)
{% endcontent-ref %}

{% content-ref url="instructions.without_callee_names.md" %}
[instructions.without\_callee\_names.md](instructions.without_callee_names.md)
{% endcontent-ref %}

{% content-ref url="instructions.with_callee_name_prefix.md" %}
[instructions.with\_callee\_name\_prefix.md](instructions.with_callee_name_prefix.md)
{% endcontent-ref %}

{% content-ref url="instructions.with_callee_name_suffix.md" %}
[instructions.with\_callee\_name\_suffix.md](instructions.with_callee_name_suffix.md)
{% endcontent-ref %}

{% content-ref url="instructions.with_callee_signature.md" %}
[instructions.with\_callee\_signature.md](instructions.with_callee_signature.md)
{% endcontent-ref %}

{% content-ref url="broken-reference" %}
[Broken link](broken-reference)
{% endcontent-ref %}

{% content-ref url="broken-reference" %}
[Broken link](broken-reference)
{% endcontent-ref %}
---
description: >-
  Adds a filter to get instructions that call a function whose name has the
  given prefix.
---

# Instructions.with\_callee\_name\_prefix()

`with_callee_name_prefix(prefix: str, sensitivity: bool = True) →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return (
    Instructions()
    .with_callee_name_prefix("upgrade")
    .exec(1)
  )
```

## Example Output

<figure><img src="../../.gitbook/assets/image (267).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get instructions that don't call a function with the given
  name.
---

# Instructions.without\_callee\_name()

`without_callee_name(name: str, sensitivity: bool = True) →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return (
    Instructions()
    .without_callee_name("keccak256")
    .exec(2,1)
  )
```

## Example Output

<figure><img src="../../.gitbook/assets/image (273).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the 'start loop' instructions.
---

# Instructions.start\_loop\_instructions()

`start_loop_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().start_loop_instructions().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (262).png" alt=""><figcaption></figcaption></figure>
# Instructions.modifiers()

**`modifiers`**`() →` [`Modifiers`](../callables/modifiers/)

Returns [Modifiers](../callables/modifiers/) object for the modifiers of the instructions. Note: The function will return parent modifiers for those instructions that belong to a modifier, not to a function. To get parent functions of that instructions use `functions()` method.

## Query Example

```python
from glider import *


def query():
  return Instructions().modifiers().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (257).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get Instructions that call a function with the given
  signature.
---

# Instructions.with\_one\_of\_callee\_names()

`with_one_of_callee_names(names: List[str], sensitivity: bool = True) →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return (
    Instructions()
    .with_one_of_callee_names(["deposit", "withdraw"])
    .exec(2,1)
  )
```

## Example Output

<figure><img src="../../.gitbook/assets/image (271).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (272).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the 'continue' instructions
---

# Instructions.continue\_instructions()

`continue_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().continue_instructions().exec(1, 1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (243).png" alt=""><figcaption></figcaption></figure>
---
description: Returns a list of all delegate call instructions.
---

# Instructions.delegate\_calls()

`delegate_calls() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().delegate_calls().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (244).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the 'if' instructions.
---

# Instructions.if\_instructions()

**`if_instructions()`**` ``→` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().if_instructions().exec(2)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (253).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the Instructions object withe all the external call instructions.
---

# Instructions.external\_calls()

`external_calls() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().external_calls().exec(3, 13)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (5) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (6) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (7) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get Instructions that call a function with the given name.
---

# Instructions.with\_callee\_name()

`with_callee_name(name: str, sensitivity: bool = True) →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return (
    Instructions()
    .with_callee_name("assert", sensitivity=False)
    .exec(1)
  )
```

## Example Output

<figure><img src="../../.gitbook/assets/image (266).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a list of all internal call instructions if the parameter is skipped.
  Otherwise, returns call instructions of corresponding type (internal, public
  or private)
---

# Instructions.internal\_calls()

`internal_calls(visibility: str = '') →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().internal_calls().exec(3,3)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (254).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the 'expression' instructions.
---

# Instructions.expression\_instructions()

`expression_instructions() →` [`Instructions`](./)

In Glider, all objects lacking defined types, such as [`IfInstruction`](../instruction/ifinstruction/), [`CatchInstruction`](broken-reference), [`BreakInstruction`](../instruction/breakinstruction.md), etc., are considered `expressions`

## Query Example

```python
from glider import *


def query():  
  return Instructions().expression_instructions().exec(4)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (252).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get Instructions that have callees with all the given names.
---

# Instructions.with\_all\_callee\_names()

`with_all_callee_names(names: List[str], sensitivity: bool = True) →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return (
    Instructions()
    .with_all_callee_names(["require", "balanceOf"], sensitivity=False)
    .exec(1)
  )
```

## Example Output

<figure><img src="../../.gitbook/assets/image (265).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the 'catch' instructions
---

# Instruction.catch\_instructions()

`catch_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():  
  return Instructions().catch_instructions().exec(1,1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (242).png" alt=""><figcaption></figcaption></figure>
---
hidden: true
---

# Instructions.CALLEES

---
description: Returns an Instructions object for the Modifier placeholder instructions.
---

# Instructions.placeholder\_instructions()

`placeholder_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().placeholder_instructions().exec(1,9)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (259).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the new variable creation instructions
---

# Instructions.new\_variable\_instructions()

`new_variable_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().new_variable_instructions().exec(2,3)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (204).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a set of Callables objects for the callables where the instructions
  can be executed in.
---

# Instructions.callables\_recursive()

`callables_recursive() →` [`APISet`](../iterables/apiset.md)`[`[`Callables`](../callables/)`]`&#x20;

Consider the following Solidity code:

```solidity
modifier onlyOwner() {
        require(_owner == _msgSender(),"Ownable: caller is not the owner");
        _;
}

function includeInFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = false;
}
```

For the following instruction:

```solidity
_isExcludedFromFee[account] = false;
```

Both the `includeInFee` function and `onlyOwner` modifier can call the instruction above. &#x20;

With `callables_recursive()`, one can retrieve the functions that are called recursively through the entire call chain.

## Query Example

```python
from glider import *

def query():
    # Fetch a function
    functions = (
        Functions()
        .with_name("includeInFee")
        .exec(1)
    )

    print(
        functions
        .instructions()
        .callables_recursive()
        .exec()
        .name
    )

    return functions
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-18 at 9.41.40 AM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the 'break' instructions
---

# Instructions.break\_instructions()

`break_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().break_instructions().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (240).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the 'entry point' instructions
---

# Instructions.entry\_point\_instructions()

`entry_point_instructions() →` [`Instructions`](./)

The [Instructions](./) object returned includes all entry points to functions.

## Query Example

```python
from glider import *


def query():
  return Instructions().entry_point_instructions().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (250).png" alt=""><figcaption></figcaption></figure>

As this returns the entry point to the function, the "sol\_instruction" field contains the function body.
---
description: Returns an Instructions object for the 'start assembly' instructions.
---

# Instructions.start\_asm\_instructions()

`start_asm_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().start_asm_instructions().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (261).png" alt=""><figcaption></figcaption></figure>
---
description: Returns a list of all high level static call instructions.
---

# Instructions.high\_level\_static\_calls()

`high_level_static_calls() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().high_level_static_calls().exec(1, 5)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (4) (1).png" alt=""><figcaption></figcaption></figure>

In this instance, the static call refers to `uniswapV2Router.WETH()`.
---
description: >-
  Returns Functions object for the functions of the instructions. Note: The
  function will return parent functions for those instructions that belong to a
  function, not to a modifier. To get parent modif
---

# Instructions.functions()

**`functions`**`() →` [`Functions`](../callables/functions/)

## Query Example

```python
from glider import *


def query():
  return Instructions().functions().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (3) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the 'end if' instructions.
---

# Instructions.end\_if\_instructions()

`end_if_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().end_if_instructions().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (248).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the 'if loop' instructions.
---

# Instructions.if\_loop\_instructions()

`if_loop_instructions() →` [`Instructions`](../instruction/)

## Query Example

```python
from glider import *


def query():
  return Instructions().if_loop_instructions().exec(2)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (2) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns an Instructions object for the 'try' instructions.
---

# Instructions.try\_instructions()

`try_instructions() →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return Instructions().try_instructions().exec(1)
```

## Example Output

<figure><img src="../../.gitbook/assets/image (264).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get instructions that don't call a function with the given
  name.
---

# Instructions.without\_callee\_names()

`without_callee_names(`_`name: str`_`,`` `_`sensitivity: bool = True`_`) →` [`Instructions`](./)

## Query Example

```python
from glider import *


def query():
  return (
    Instructions()
    .without_callee_names(["transfer", "transferFrom"])
    .exec(3, 101)
  )
```

## Example Output

<figure><img src="../../.gitbook/assets/image (274).png" alt=""><figcaption></figcaption></figure>
---
description: Write queries, describe code scenarios and find matching contract code
icon: plug
---

# API



## How Glider represents the contract code

Before diving deep into the API classes and methods, let's see an example of how the Glider engine "understands" or represents the contract code.



Let's look at the [USDT token contract code](https://vscode.blockscan.com/ethereum/0xdac17f958d2ee523a2206206994597c13d831ec7):

```solidity
/*
...
*/

contract TetherToken is Pausable, StandardToken, BlackList {

    string public name;
    string public symbol;
    uint public decimals;
    address public upgradedAddress;
    bool public deprecated;

    //  The contract can be initialized with a number of tokens
    //  All the tokens are deposited to the owner address
    //
    // @param _balance Initial supply of the contract
    // @param _name Token Name
    // @param _symbol Token symbol
    // @param _decimals Token decimals
    function TetherToken(uint _initialSupply, string _name, string _symbol, uint _decimals) public {
        _totalSupply = _initialSupply;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        balances[owner] = _initialSupply;
        deprecated = false;
    }

    // Forward ERC20 methods to upgraded contract if this one is deprecated
    function transfer(address _to, uint _value) public whenNotPaused {
        require(!isBlackListed[msg.sender]);
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).transferByLegacy(msg.sender, _to, _value);
        } else {
            return super.transfer(_to, _value);
        }
    }

    // Forward ERC20 methods to upgraded contract if this one is deprecated
    function transferFrom(address _from, address _to, uint _value) public whenNotPaused {
        require(!isBlackListed[_from]);
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).transferFromByLegacy(msg.sender, _from, _to, _value);
        } else {
            return super.transferFrom(_from, _to, _value);
        }
    }

    // Forward ERC20 methods to upgraded contract if this one is deprecated
    function balanceOf(address who) public constant returns (uint) {
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).balanceOf(who);
        } else {
            return super.balanceOf(who);
        }
    }

    // Forward ERC20 methods to upgraded contract if this one is deprecated
    function approve(address _spender, uint _value) public onlyPayloadSize(2 * 32) {
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).approveByLegacy(msg.sender, _spender, _value);
        } else {
            return super.approve(_spender, _value);
        }
    }

    // Forward ERC20 methods to upgraded contract if this one is deprecated
    function allowance(address _owner, address _spender) public constant returns (uint remaining) {
        if (deprecated) {
            return StandardToken(upgradedAddress).allowance(_owner, _spender);
        } else {
            return super.allowance(_owner, _spender);
        }
    }

    // deprecate current contract in favour of a new one
    function deprecate(address _upgradedAddress) public onlyOwner {
        deprecated = true;
        upgradedAddress = _upgradedAddress;
        Deprecate(_upgradedAddress);
    }

    // deprecate current contract if favour of a new one
    function totalSupply() public constant returns (uint) {
        if (deprecated) {
            return StandardToken(upgradedAddress).totalSupply();
        } else {
            return _totalSupply;
        }
    }

    // Issue a new amount of tokens
    // these tokens are deposited into the owner address
    //
    // @param _amount Number of tokens to be issued
    function issue(uint amount) public onlyOwner {
        require(_totalSupply + amount > _totalSupply);
        require(balances[owner] + amount > balances[owner]);

        balances[owner] += amount;
        _totalSupply += amount;
        Issue(amount);
    }

    // Redeem tokens.
    // These tokens are withdrawn from the owner address
    // if the balance must be enough to cover the redeem
    // or the call will fail.
    // @param _amount Number of tokens to be issued
    function redeem(uint amount) public onlyOwner {
        require(_totalSupply >= amount);
        require(balances[owner] >= amount);

        _totalSupply -= amount;
        balances[owner] -= amount;
        Redeem(amount);
    }

    function setParams(uint newBasisPoints, uint newMaxFee) public onlyOwner {
        // Ensure transparency by hardcoding limit beyond which fees can never be added
        require(newBasisPoints < 20);
        require(newMaxFee < 50);

        basisPointsRate = newBasisPoints;
        maximumFee = newMaxFee.mul(10**decimals);

        Params(basisPointsRate, maximumFee);
    }

    // Called when new token are issued
    event Issue(uint amount);

    // Called when tokens are redeemed
    event Redeem(uint amount);

    // Called when contract is deprecated
    event Deprecate(address newAddress);

    // Called if contract ever adds fees
    event Params(uint feeBasisPoints, uint maxFee);
}
```



For everything in the contract code (except comment sections), there is at least one entity that represents it in the Glider engine and allows the filtering and analysis of that data.

## Contracts

In Glider, every contract, interface, and library is represented by the [Contract](contract/) class.&#x20;

A set of contracts is represented by [Contracts](./#contracts) class.&#x20;

There are special flags and methods to distinguish or filter them.

In USDT the TetherToken will have a contract object for:

```solidity
contract TetherToken
```

Contract objects can be used to obtain full information about the contract, such as the deployed address, compiler versions/pragmas, state variables, base and derived contracts, etc.&#x20;

That said, the libraries, interfaces, and base contracts used in USDT code will also have a Contract object representing them:

```solidity
library SafeMath { // Contract (is_library: True)
//...
}
//...
contract Ownable { 
//...
}
//... 
```

As one address (one main contract) can have multiple interfaces, libraries, contracts declared or even derived, built in a complex folder structure, Glider will generate Contract objects for all of them, though the address will be the same, and only one contract will be considered to be the main.&#x20;

For the contract that is "main", meaning that its functions are being executed if a transaction is called, the engine marks this contract as "main" to distinguish it from others on the same address; see [Contract.is\_main()](contract/contract.is_main.md).

While the [Contract](contract/) class is used to obtain information about a single contract, the [Contracts](./#contracts) class is used to query and/or filter contracts from a set or the whole database.

Contracts contain references to other entities that belong to those contracts:

[Functions](callables/functions/)([Callables](callables/)), [Modifiers](callables/modifiers/)([Callables](callables/)), [StateVariables](statevariables/), [Structs](contract/contract.structs.md), [Enums](contract/contract.enums.md), [Errors](contract/contract.errors.md).

## Callables

Glider treats functions and modifiers as callable objects.&#x20;

Nonetheless, Glider has [Function](callable/function/) and [Modifier](callable/modifier/) classes that both derive from [Callable](callable/)

### Functions

Each function in the contract code is represented by a [Function](callable/function/) object.

The set of functions is represented by the [Functions](./#functions) object.

E.g transfer function in the TetherToken contract

```solidity
    // Forward ERC20 methods to upgraded contract if this one is deprecated
    function transfer(address _to, uint _value) public whenNotPaused {
        require(!isBlackListed[msg.sender]);
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).transferByLegacy(msg.sender, _to, _value);
        } else {
            return super.transfer(_to, _value);
        }
    }
```

Or any other function, for example `mul, div, sub, add` functions in the SafeMath library:

```solidity
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}
```

### Modifiers

Each modifier is represented by a [Modifier](callable/modifier/) object.

The set of modifiers is represented by a [Modifiers](./#modifiers) object.

E.g the `onlyOwner` modifier in `Ownable` contract:

```solidity
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
```

Or `onlyPayloadSize` in `BasicToken` contract:

```solidity
    modifier onlyPayloadSize(uint size) {
        require(!(msg.data.length < size + 4));
        _;
    }
```

And `whenNotPaused` and `whenPaused` modifiers in Pauable:

```solidity
  modifier whenNotPaused() {
    require(!paused);
    _;
  }

  /**
   * @dev Modifier to make a function callable only when the contract is paused.
   */
  modifier whenPaused() {
    require(paused);
    _;
  }

```

[Function](callable/function/) and [Modifier](callable/modifier/) objects can be used to obtain data about a specific object, while [Functions](./#functions) and [Modifiers](./#modifiers) objects are used to query and/or filter functions/modifiers by specific properties from a set or the whole database.

Functions have references to the modifiers that are being used in the function and vice versa.

{% hint style="info" %}
See methods: [Modifier.functions()](callable/modifier/modifier.functions.md) and [Function.modifiers()](callable/function/function.modifiers.md) for a single function/modifier instance

Also: [Modifiers.functions()](callable/modifier/modifier.functions.md) and [Functions.modifiers()](callable/function/function.modifiers.md) for the set
{% endhint %}

One of the most important references that functions/modifiers have is their reference to their [instructions](instructions/).

## Instructions

An easy way to think of an instruction is anything that ends with a semicolon ';' in the code. However, this is not always the case, as with some instructions like if-statements, don't use semicolons.

E.g in the function transfer:

```solidity
    function transfer(address _to, uint _value) public whenNotPaused {
        require(!isBlackListed[msg.sender]);
        if (deprecated) {
            return UpgradedStandardToken(upgradedAddress).transferByLegacy(msg.sender, _to, _value);
        } else {
            return super.transfer(_to, _value);
        }
    }
```

The instructions will be:

```solidity
require(!isBlackListed[msg.sender]);
--
if (deprecated)
--
return UpgradedStandardToken(upgradedAddress).transferByLegacy(msg.sender, _to, _value);
--
else
--
return super.transfer(_to, _value);
```

As the Modifier is also a [Callable](callable/), it also has instructions:

```solidity
  modifier whenNotPaused() {
    require(!paused);
    _;
  }
```

Here the `whenNotPaused` modifier's instructions will be:

```solidity
require(!paused);
--
_;
```

{% hint style="info" %}
Note that the special underline symbol (\_), which is also called placer/placeholder, is also considered an instruction.

See methods: [Instruction.is\_placer()](instruction/instruction.is_placeholder.md), [Modifier.placer\_instructions()](modifier/modifier.placeholder_instructions.md), [Modifiers.placer\_instructions()](modifiers/modifiers.placeholder_instructions.md)
{% endhint %}

The constructors are also considered functions; special methods can be used to query and check that a function is a constructor.

As with other entities, the [Instruction](instruction/) object is used to obtain data and analyze one specific instruction, and the [Instructions](./#instructions) object is used to query/filter instructions in a set or in a whole database.

An instruction on its own usually consists of different parts, for example:

```solidity
require(!paused);
```

This instruction consists of a `require()` call, a boolean expression `!paused`

In Glider, the "parts" of the instruction are called [values](value/).

### Value

The Value object represents a "part" of the instruction. Value by itself is a base class for different types of values such as [Call](value/call/), [Var](broken-reference), [Literal](value/literal/) etc.

E.g. in the instruction

```solidity
require(paused);
        <-Var->
<----Call----->
```

The "part" representing the require call, will be of type [Call](value/call/) (class derived from Value), and the value `paused` will be of type [Var](broken-reference) (class derived from Value) as it represents a variable.

## Arguments

The Argument and Arguments object are mainly used in context of functions and modifiers (as they are the ones having arguments).

E.g for the function `setParams` in TetherToken:

```solidity
function setParams(uint newBasisPoints, uint newMaxFee) public onlyOwner {
//...
}
```

The `newBasisPoints` and `newMaxFee` are arguments of the function, and an Argument object will be used to represent each of them.

The [Argument](argument/) class is used to represent a single argument of the function/modifier (callable), while the [Arguments](./#arguments) class is used to represent a set of arguments.

## StateVariables

The contracts also have state (storage) variables defined; Glider allows the users to query, filter and analyze them as well.&#x20;

E.g in the contract TetherToken:

```solidity
    string public name;
    string public symbol;
    uint public decimals;
    address public upgradedAddress;
    bool public deprecated;
```

or in BasicToken:

```solidity
    mapping(address => uint) public balances;

    // additional variables for use if transaction fees ever became necessary
    uint public basisPointsRate = 0;
    uint public maximumFee = 0;
```

These state variables will be represented by a StateVariable object each or a StateVariables object for a set (or whole database).

## LocalVariables

The local variables of functions/modifiers are represented by [LocalVariable](localvariable/) and [LocalVariables](./#localvariables) classes.

E.g. in `BasicToken.transfer()` function:

```solidity
    function transfer(address _to, uint _value) public onlyPayloadSize(2 * 32) {
        uint fee = (_value.mul(basisPointsRate)).div(10000);
        if (fee > maximumFee) {
            fee = maximumFee;
        }
        uint sendAmount = _value.sub(fee);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(sendAmount);
        if (fee > 0) {
            balances[owner] = balances[owner].add(fee);
            Transfer(msg.sender, owner, fee);
        }
        Transfer(msg.sender, _to, sendAmount);
    }
```

The `uint fee` and `uint sendAmount` will be the local variables defined in the function.
---
description: The aim of this class is to filter events with some properties.
---

# Events

---
description: Executes the formed query and returns the list of Event objects.
---

# Events.exec()

`exec(limit_count: int= 0, offset_count: int = 0) →` [`APIList`](../iterables/apilist.md)`[`[`Event`](../event/)`]`
# Callables.with\_name\_regex()

`with_name_regex(`_`regex: str`_`) →` [`Callables`](./)

Adds a filter to get callables whose names match the given regex expression. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To filter given a list of regex expression, refer to [Callables.with\_name\_regexes()](callables.with_name_regexes.md).

### Functions Example

```python
from glider import *

def query():
  # Retrieve the functions that have `claim` in their name but do not start with `_`
  functions = Functions().with_name_regex(r"^(?!_).*claim.*$").exec(100)

  # Return the first five functions
  return functions[:1]
```

Output:

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that have `claim` in their name but do not start with `only`
  modifiers = Modifiers().with_name_regex(r"^(?!only).*claim.*$").exec(100)

  # Return the first five modifiers
  return modifiers[:3]
```

Output:

<figure><img src="../../.gitbook/assets/image (161).png" alt=""><figcaption></figcaption></figure>
# Functions.without\_modifier\_names()

`without_modifier_names(`_`names: List[str]`_`,`` `_`sensitivity: bool = True`_`) →` [`Functions`](./)

Adds a filter to get functions that don't have any modifier with one of the given names.

## Example

```python
from glider import *

def query():
  
  # Fetch a list of functions without modifiers from the given list
  functions = Functions().without_modifier_names(['onlyAdmin','onlyOwner']).exec(10)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (9) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Functions.with\_one\_of\_the\_modifier\_names()

`with_one_of_the_modifier_names(`_`names: List[str]`_`,`` `_`sensitivity: bool = True`_`) →` [`Functions`](./)

Adds a filter to get functions that have a modifier with one of the given names.

## Example

```python
from glider import *

def query():
  
  # Fetch a list of functions with modifiers from the given list
  functions = Functions().with_one_of_the_modifier_names(['onlyAdmin','onlyOwner']).exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (8) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Functions

The aim of this class is to represent a set of functions and give functionality to filter functions with specified properties.

Bases: [`Callables`](../)
---
description: >-
  without_properties is deprecated and will be removed in future versions.
  Please use with_properties instead. Adds a filter to get functions that don't
  have any of the given properties.
---

# Functions.without\_properties()

**Deprecated**: This method is deprecated and will be removed in future versions.

**Alternative:** Use `with_properties()` instead for improved functionality.

`without_properties(`_`properties: List[MethodProp]`_`) →` [`Functions`](./)

## Example

```python
from glider import *

def query():
  
  # Fetch a list of functions which are not external/public
  functions = Functions().without_properties([MethodProp.EXTERNAL, MethodProp.PUBLIC]).exec(3)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (12) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Functions.with\_all\_modifier\_names()

`with_all_modifier_names(names: List[str], sensitivity: bool = True) →` [`Functions`](./)

Adds a filter to get functions that have modifiers with all the given names.

## Example

```python
from glider import *

def query():
  functions = Functions().with_all_modifier_names(['lock', 'onlyOwner']).exec(1)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (13) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Executes the formed query and returns a list of the Function objects.
---

# Functions.exec()

`exec(`_`limit_count: int = 0`_`,`` `_`offset_count: int = 0`_`) →` [`APIList`](../../iterables/apilist.md)`[`[`Function`](../../callable/function/)`]`

## Query Example

<pre class="language-python"><code class="lang-python"><strong>from glider import *
</strong>
def query():
  # Fetch a list of functions
  functions = Functions().exec(2)

  return functions
</code></pre>

## Output Example

<figure><img src="../../../.gitbook/assets/image (96).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  with_one_property is deprecated and will be removed in future versions. Please
  use with_properties in- stead. Adds a filter to get functions that at least
  have one of the given properties.
---

# Functions.with\_one\_property()

**Deprecated:** This method is deprecated and will be removed in future versions.

**Alternative:** Use `with_properties()` instead for improved functionality.

`with_one_property(`_`properties: List[`_[_`MethodProp`_](../methodprop/)_`]`_`) →` [`Functions`](./)

## Example

```python
from glider import *

def query():
  
  # Fetch a list of functions which a external
  functions = Functions().with_one_property([MethodProp.EXTERNAL]).exec(3, 100)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (11) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Functions.with\_modifier\_signature()

`with_modifier_signature(`_`signature: str`_`) →` [`Functions`](./)

Adds a filter to get functions that have a modifier with the given signature.

## Example

```python
from glider import *

def query():
  
  # Fetch a list of functions with specific modifier signature
  functions = Functions().with_modifier_signature('onlyOwner(address)').exec(2)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (7) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Functions.constructors()

`constructors() →` [`Functions`](./)

Adds a filter to get only the constructors.

## Example

```python
from glider import *

def query():
  # Fetch a list of constructors
  functions = Functions().constructors().exec(2)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (95).png" alt=""><figcaption></figcaption></figure>

## Old constructor syntax

The function also accounts for the old constructor syntax, which in the older Solidity versions was named the same as the contract.&#x20;

```python
from glider import *

def query():
  funcs = Functions().constructors().without_name('constructor').exec(2)
  return funcs
```

Output

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

# Functions.with\_one\_of\_the\_modifier\_name\_regexes()

`with_one_of_the_modifier_name_regexes(`_`regexes: List[str]`_`) →` [`Functions`](./)

Adds a filter to get functions that have a modifier whose name matches one of the given regexes.

## Example

```python
from glider import *

def query():
  
  # Fetch a list of functions with modifiers matching regex list
  functions = Functions().with_one_of_the_modifier_name_regexes(['^only.*', 'admin']).exec(10)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (10) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  with_all_properties is deprecated and will be removed in future versions.
  Please use with_properties in- stead. Adds a filter to get functions that have
  all given properties.
---

# Functions.with\_all\_properties()

**Deprecated:** This method is deprecated and will be removed in future versions.

**Alternative:** Use `with_properties()` instead for improved functionality.

`with_all_properties(`_`properties: List[`_[_`MethodProp`_](../methodprop/)_`]`_`) →` [`Functions`](./)

## Example

```python
from glider import *

def query():
  properties = [MethodProp.IS_PAYABLE, MethodProp.EXTERNAL]
  # Fetch a list of functions with all the properties
  functions = Functions().with_all_properties(properties).exec(3)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Functions.without\_modifiers()

`without_modifiers() →` [`Functions`](./)

Adds a filter to get functions that don't have modifiers at all.

## Example

```python
from glider import *

def query():
  functions = Functions().without_modifiers().exec(1)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (14) (1).png" alt=""><figcaption></figcaption></figure>
# Functions.without\_modifier\_name()

`without_modifier_name(`_`name: str`_`,`` `_`sensitivity: bool = True`_`) →` [`Functions`](./)

Adds a filter to get functions that either have no modifier with the given name or have no modifier at all.

## Example

```python
from glider import *

def query():
  
  # Fetch a list of functions without onlyOwner modifier
  functions = Functions().without_modifier_name('onlyOwner').exec(3)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (5) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Functions.with\_modifier\_name()

`with_modifier_name(`_`name: str`_`,`` `_`sensitivity: bool = True`_`) →` [`Functions`](./)

Adds a filter to get functions that have a modifier with the given name.

## Example

```python
from glider import *

def query():
  
  # Fetch a list of functions with nonReentrant modifier
  functions = Functions().with_modifier_name('nonReentrant').exec(2)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (4) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Callables.with\_arg\_memory\_type()

`with_arg_memory_type(`_`arg_memory_type: str`_`,`` `_`sensitivity: bool = True`_`) →` [`Callables`](./)

_`arg_memory_type` can take as arguments: "storage", "memory", "calldata"_

_By default, "memory" is set as the memory type of argument unless stated otherwise explicitly._

Adds a filter to get callables having specified argument memory type. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

### Functions Example

```python
from glider import *

def query():
  # Retrieve the functions that have a storage argument
  functions = Functions().with_arg_memory_type("storage").exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (24).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that have a calldata argument
  modifiers = Modifiers().with_arg_memory_type("calldata").exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get functions/modifiers associated with the given address.
---

# Callables.with\_address()

## Query Example

```python
from glider import *


def query():
    functions = (
        Functions()
        .with_name("swapTokens")
        .with_address("0x4186829914d1b7b130b5153f4aabd21142e8e658")
        .exec(1)
    )

    return functions
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-17 at 1.06.56 PM.png" alt=""><figcaption></figcaption></figure>
# Callables.with\_signature()

`with_signature(`_`signature: str`_`) →` [`Callables`](./)

Adds a filter to get callables that have the given signature. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To filter given a list of signatures, refer to [Callables.with\_signatures()](callables.with_signatures.md).

### Functions Example

```python
from glider import *

def query():
  # Retrieve all functions with the signature `transferFrom(address,address,uint256)`
  functions = Functions().with_signature("transferFrom(address,address,uint256)").exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (8) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve all the modifiers with the signature `nonReentrant()`
  modifiers = Modifiers().with_signature("nonReentrant()").exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (10) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a Functions object representing the functions which are called from
  the callables of the Callables object.
---

# Callables.callee\_functions\_recursive()

`callee_functions_recursive() →` [`Functions`](functions/)

## Query Example

```python
from glider import *


def query():
  functions = Functions().with_name("beforeTokenTransfer").exec(10)

  callee_functions = []
  for func in functions:
    for callee_func in func.callee_functions_recursive().exec():
      callee_functions.append(callee_func)

  return callee_functions
```

## Example Output

<figure><img src="../../.gitbook/assets/image (142).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (143).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (144).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (145).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (146).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (147).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (148).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (149).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (150).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (151).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (152).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (153).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (154).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (155).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (156).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (157).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (158).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (159).png" alt=""><figcaption></figcaption></figure>
# Callables.with\_name()

`with_name(`_`name: str`_`,`` `_`sensitivity: bool = True`_`) →` [`Callables`](./)

Adds a filter to get callables having specified name. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To get all but the specified name, refer to [Callables.without\_name()](callables.without_name.md).

To filter given a list of names, refer to [Callables.with\_one\_of\_the\_names()](callables.with_one_of_the_names.md).

### Functions Example

```python
from glider import *

def query():
  # Retrieve the functions named `distributeFunds`
  functions = Functions().with_name("distributeFunds").exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (11) (1).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers named `onlyCaller`
  modifiers = Modifiers().with_name("onlyCaller").exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Callables

The Callables class is the base class for the [Functions](functions/) and [Modifiers](modifiers/) classes, and implements a series of methods common to both Functions and Modifiers:

{% content-ref url="callables.contracts.md" %}
[callables.contracts.md](callables.contracts.md)
{% endcontent-ref %}

{% content-ref url="callables.instructions.md" %}
[callables.instructions.md](callables.instructions.md)
{% endcontent-ref %}

{% content-ref url="callables.with_name_prefix.md" %}
[callables.with\_name\_prefix.md](callables.with_name_prefix.md)
{% endcontent-ref %}

{% content-ref url="callables.with_name_prefixes.md" %}
[callables.with\_name\_prefixes.md](callables.with_name_prefixes.md)
{% endcontent-ref %}

{% content-ref url="callables.with_name_regex.md" %}
[callables.with\_name\_regex.md](callables.with_name_regex.md)
{% endcontent-ref %}

{% content-ref url="callables.with_name_regexes.md" %}
[callables.with\_name\_regexes.md](callables.with_name_regexes.md)
{% endcontent-ref %}

{% content-ref url="callables.with_name_suffix.md" %}
[callables.with\_name\_suffix.md](callables.with_name_suffix.md)
{% endcontent-ref %}

{% content-ref url="callables.with_name_suffixes.md" %}
[callables.with\_name\_suffixes.md](callables.with_name_suffixes.md)
{% endcontent-ref %}

{% content-ref url="callables.with_arg_count.md" %}
[callables.with\_arg\_count.md](callables.with_arg_count.md)
{% endcontent-ref %}

{% content-ref url="callables.with_arg_memory_type.md" %}
[callables.with\_arg\_memory\_type.md](callables.with_arg_memory_type.md)
{% endcontent-ref %}

{% content-ref url="callables.with_arg_name.md" %}
[callables.with\_arg\_name.md](callables.with_arg_name.md)
{% endcontent-ref %}

{% content-ref url="callables.with_arg_type.md" %}
[callables.with\_arg\_type.md](callables.with_arg_type.md)
{% endcontent-ref %}

{% content-ref url="callables.with_arg_types.md" %}
[callables.with\_arg\_types.md](callables.with_arg_types.md)
{% endcontent-ref %}

{% content-ref url="broken-reference" %}
[Broken link](broken-reference)
{% endcontent-ref %}

{% content-ref url="callables.with_name.md" %}
[callables.with\_name.md](callables.with_name.md)
{% endcontent-ref %}

{% content-ref url="callables.without_name.md" %}
[callables.without\_name.md](callables.without_name.md)
{% endcontent-ref %}

{% content-ref url="callables.with_one_of_the_names.md" %}
[callables.with\_one\_of\_the\_names.md](callables.with_one_of_the_names.md)
{% endcontent-ref %}

{% content-ref url="callables.without_names.md" %}
[callables.without\_names.md](callables.without_names.md)
{% endcontent-ref %}

{% content-ref url="callables.with_signature.md" %}
[callables.with\_signature.md](callables.with_signature.md)
{% endcontent-ref %}

{% content-ref url="callables.with_signatures.md" %}
[callables.with\_signatures.md](callables.with_signatures.md)
{% endcontent-ref %}
# Callables.with\_name\_suffixes()

`with_name_suffixes(`_`suffixes: List[str]`_`,`` `_`sensitivity: bool = True`_`) →` [`Callables`](./)

Adds a filter to get callables whose names have suffixes from the given list of suffixes. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To filter given a single prefix, refer to [Callables.with\_name\_suffix()](callables.with_name_suffix.md).

### Functions Example

```python
from glider import *

def query():
  # Retrieve the functions that have `Flashloan` or `cast` as suffix
  functions = Functions().with_name_suffixes(["Flashloan", "cast"]).exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (169).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that have `Initialized` or `Open` as suffix
  modifiers = Modifiers().with_name_suffixes(["Initialized", "Open"]).exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (171).png" alt=""><figcaption></figcaption></figure>
# Callables.with\_name\_prefixes()

`with_name_prefixes(`_`prefixes: List[str]`_`,`` `_`sensitivity: bool = True`_`) →` [`Callables`](./)

Adds a filter to get callables whose names have prefixes from the given list of prefixes. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To filter given a single prefix, refer to [Callables.with\_name\_prefix()](callables.with_name_prefix.md).

### Functions Example

```python
from glider import *

def query():
  # Retrieve the functions that have `min` or `max` as prefix
  functions = Functions().with_name_prefixes(["min", "max"]).exec(100)

  # Return the first five functions
  return functions[:4]
```

<figure><img src="../../.gitbook/assets/image (4) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that have `before` or `after` as prefix
  modifiers = Modifiers().with_name_prefixes(["before", "after"]).exec(100)

  # Return the first five modifiers
  return modifiers[:4]
```

Output:

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Callables.with\_name\_suffix()

`with_name_suffix(`_`suffix: str`_`,`` `_`sensitivity: bool = True`_`) →` [`Callables`](./)

Adds a filter to get callables whose names have the given suffix. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To filter given a list of suffixes, refer to [Callables.with\_name\_suffixes()](callables.with_name_suffixes.md).

### Functions Example

```python
from glider import *

def query():
  # Retrieve the functions that have `down` as suffix
  functions = Functions().with_name_suffix("down").exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (166).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that have `Initialized` as suffix
  modifiers = Modifiers().with_name_suffix("Initialized").exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (168).png" alt=""><figcaption></figcaption></figure>
# Callables.with\_name\_prefix()

`with_name_prefix(`_`prefix: str`_`,`` `_`sensitivity: bool = True`_`) →` [`Callables`](./)

Adds a filter to get callables whose names have the given prefix. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To filter given a list of prefixes, refer to [Callables.with\_name\_prefixes()](callables.with_name_prefixes.md).

### Functions Example

```python
from glider import *

def query():
  # Retrieve the functions that have `min` as prefix
  functions = Functions().with_name_prefix("min").exec(100)

  # Return the first five functions
  return functions[:4]
```

Output:

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that have `only` as prefix
  modifiers = Modifiers().with_name_prefix("only").exec(100)

  # Return the first five modifiers
  return modifiers[:4]
```

Output:

<figure><img src="../../.gitbook/assets/image (160).png" alt=""><figcaption></figcaption></figure>
# Callables.with\_arg\_count()

`with_arg_count(`_`arg_count: int`_`) →` [`Callables`](./)

Adds a filter to get callables having specified argument count. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

### Functions Example

```python
from glider import *

def query():
  # Retrieve the functions that have 12 arguments
  functions = Functions().with_arg_count(12).exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (172).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that have 5 arguments
  modifiers = Modifiers().with_arg_count(5).exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (173).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get functions/modifiers that have declarer contract with the
  given name.
---

# Callables.with\_declarer\_contract\_name()

`with_declarer_contract_name(`_`name: str, sensitivity: bool = True`_`) →` [`Callables`](./)

## Function Example

### Example Query

```python
from glider import *


def query():
  # Retrieve the contracts of a list of functions
  contracts = Functions().with_declarer_contract_name("TestToken").exec(2)

  # Return the first five contracts
  return contracts[:5]
```

### Query Output&#x20;

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-25 at 5.22.26 PM.png" alt=""><figcaption></figcaption></figure>

## Modifier Example

### Example Query

```python
from glider import *


def query():
  # Retrieve the contracts of a list of modifiers
  contracts = Modifiers().with_declarer_contract_name("TestToken").exec(2)

  # Return the first five contracts
  return contracts[:5]
```

### Query Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-25 at 5.19.25 PM.png" alt=""><figcaption></figcaption></figure>
---
description: The aim of this class is to filter modifiers with specified properties.
---

# Modifiers

Bases: [`Callables`](../)
---
description: Executes the formed query and returns an APIList of the Modifier objects.
---

# Modifiers.exec()

`exec(`_`limit_count: int = 0`_`,`` `_`offset_count: int = 0`_`) →` [`APIList`](../../iterables/apilist.md)`[`[`Modifier`](../../callable/modifier/)`]`

It accepts two integer parameters: the first one is `limit_count` which limits the count of the returned results, and the second is `offset_count` which sets the offset from which the result set must be returned.

In specific, in the Modifiers scenario, it will action a query to search for modifiers.

In solidity, a smart contract can define modifiers which can be called before the code of the function is run.

An example of such a contract would be as below:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Example {
    modifier onlyOwner {
    	require(msg.sender == owner);
    	_;
   	}
   	
   	//This function has the onlyOwner modifier
   	function setNewOwner(address newOwner) public onlyOwner {
   		owner = newOwner;
   	}

}
```

## Query Example

An example of a query which adds a filter to select functions which have modifiers with the name "onlyOwner" is:

```python
from glider import *

def query():
  modifiers = (
    Modifiers()
      .with_name("onlyOwner")
      .exec(5)
  )

  return modifiers
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Callables.instructions()

`instructions() →` [`Instructions`](../instructions/)

Returns the [Instructions](../instructions/) object for the instructions of the callables. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

### Functions Example

```python
from glider import *

def query():
  # Retrieve the instructions of a list of functions
  instructions = Functions().instructions().exec(100)

  # Return the first five instructions
  return instructions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (4) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the instructions of a list of modifiers
  instructions = Modifiers().instructions().exec(100)

  # Return the first five instructions
  return instructions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Callables.with\_arg\_types()

`with_arg_types(`_`arg_types: List[str]`_`,`` `_`sensitivity: bool = True`_`) →` [`Callable`](./)

Adds a filter to get callables having specified argument types like "address" or even non-elementary types like structs is strict ordering. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To filter given a single argument type, refer to [Callables.with\_arg\_type()](callables.with_arg_type.md).

_Note that the order of the argument types is important. I.e. calling `.with_arg_types(["a", "b"])` is **not equivalent** to calling `.with_arg_types(["b", "a"])` !_

_Note that the function will handle alias types, e.g. if uint256 is passed to the function, the results will also include the alias "uint" variables_

### Functions Example

```python
from glider import *

def query():
  # Retrieve the functions that have `uint256` and `address` as argument types
  functions = Functions().with_arg_types(["uint256", "address"]).exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (22).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that have `uint256` and `State` as their argument types
  modifiers = Modifiers().with_arg_types(["uint256", "State"]).exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (23).png" alt=""><figcaption></figcaption></figure>
# Callables.with\_arg\_name()

`with_arg_name(`_`arg_name: str`_`,`` `_`sensitivity: bool = True`_`) →` [`Callables`](./)

Adds a filter to get callables having specified argument name. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

### Functions Example

```python
from glider import *

def query():
  # Retrieve the functions that have `_address` as one of their arguments
  functions = Functions().with_arg_name("_address").exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that have `_caller` as one of their arguments
  modifiers = Modifiers().with_arg_name("_caller").exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Filter functions/modifiers satisfying the given expression of global
  variables.
---

# Callables.with\_globals()

`with_globals(`_`expr: Any`_`) → Callables`

Returns a list of Callables given a list of [global filters](../filters/globalfilters/).&#x20;

The argument represents an expression of GlobalFilter constants and is a bitmask of flags. For example, to find Functions that call msg.value, we will need to pass in the `GlobalFilters.MSG_VALUE` expression:

```python
Functions().with_globals(GlobalFilters.MSG_VALUE).exec(1)
```

If we want to find Functions that call msg.value _and_ msg.sender, we will need to pass in the `GlobalFilters.MSG_VALUE & GlobalFilters.MSG_SENDER` expression:

```python
Functions().with_globals(GlobalFilters.MSG_VALUE & GlobalFilters.MSG_SENDER).exec(1)
```

If we want to find Functions that call msg.data _but not_ msg.sender, we will need to pass in the following  `GlobalFilters.MSG_DATA & ~GlobalFilters.MSG_SENDER` expression:

```python
Functions().with_globals(GlobalFilters.MSG_DATA & ~GlobalFilters.MSG_SENDER).exec(1)
```

Finally, if we want to find functions that _either_ call msg.sender or tx.origin, we will need to pass in the following `GlobalFilters.TX_ORIGIN | GlobalFilters.MSG_SENDER` expression:

```python
Functions().with_globals(GlobalFilters.TX_ORIGIN | GlobalFilters.MSG_SENDER).exec(1)
```

## Example Query

```python
from glider import *


def query():
  functions = Functions().with_globals(GlobalFilters.TX_ORIGIN).exec(1,2)
  
  return functions
```

## Query Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-28 at 3.03.39 PM.png" alt=""><figcaption></figcaption></figure>
# Callables.without\_name()

`without_name(`_`name: str`_`,`` `_`sensitivity: bool = True`_`) →` [`Callables`](./)

Adds a filter to get callables that don't have the specified name. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To get the callables with a specified name, refer to [Callables.with\_name()](callables.with_name.md).

To filter given a list of undesired names, refer to [Callables.without\_names()](callables.without_names.md).

### Functions Example

```python
from glider import *

def query():
  # Retrieve all functions that are not named `distributeFunds`
  functions = Functions().without_name("distributeFunds").exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that are not named `onlyCaller`
  modifiers = Modifiers().without_name("onlyCaller").exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns Contracts object for the contracts of the functions/modifiers.
---

# Callables.contracts()

`contracts() →` [`Contracts`](../contracts/)

Returns the [Contracts](../contracts/) object for the contracts of the callables. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

The function will account for the inheritance of the contracts, thus, even one callable can have multiple contracts where it is accessible.

### Functions Example

```python
from glider import *

def query():
  # Retrieve the contracts of a list of functions
  contracts = Functions().contracts().exec(100)

  # Return the first five contracts
  return contracts[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (139).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the contracts of a list of modifiers
  contracts = Modifiers().contracts().exec(100)

  # Return the first five contracts
  return contracts[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (141).png" alt=""><figcaption></figcaption></figure>
# Callables.with\_signatures()

`with_signatures(`_`signatures: List[str]`_`) →` [`Callables`](./)

Adds a filter to get callables that have any of the given signatures. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To filter given a single signature, refer to [Callables.with\_signature()](callables.with_signature.md).

### Functions Example

```python
from glider import *

def query():
  # Retrieve all functions that have `approve(address)` or `claim(address,uint256)` as signatures
  functions = Functions() \
      .with_signatures([
          "approve(address)",
          "claim(address,uint256)"
      ]) \
      .exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (11) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve all the modifiers that have `nonReentrant()` or `initializer()` as their signatures
  modifiers = Modifiers() \
    .with_signatures([
      "nonReentrant()",
      "initializer()"
    ]) \
    .exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (12) (1).png" alt=""><figcaption></figcaption></figure>
# MethodProp.HAS\_ERRORS

The HAS\_ERRORS property is used to add a filter to include or exclude functions that revert with an error.

In solidity a smart contract a developer can define custom errors which are then called when an error is raised.

An example of such a contract would be as below:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Example {
    error myCustomError(uint256 requestedAmount,address caller);

    function collectAllowance(address caller,uint256 requestedAmount) public returns (bool success){
            //just revert to show how errors work
            revert myCustomError(requestedAmount,caller);
    }

}
```

An example of a query which would filter to include functions that use errors is&#x20;

```python
from glider import *
def query():
  props_included = [MethodProp.HAS_ERRORS]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# MethodProp.IS\_GLOBAL

A global function is defined outside of any contract scope.

An example of a global function is:

```solidity
pragma solidity ^0.7.0;

// solhint-disable

/**
 * @dev Reverts if `condition` is false, with a revert reason containing `errorCode`. Only codes up to 999 are
 * supported.
 */
function _require(bool condition, uint256 errorCode) pure {
    if (!condition) _revert(errorCode);
}
```

An example query to filter these functions:

```python
from glider import *
def query():
  props_included = [MethodProp.IS_GLOBAL]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(1)
  print(functions[0].source_code())
  print(functions[0].address())
  return functions
```

Output:

<figure><img src="../../../.gitbook/assets/image (6) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

# MethodProp.INTERNAL

This property will filter for functions that are exposed in a smart contract and marked with an access level of internal.&#x20;

Functions declared with internal access are callable only from functions inside of the smart contract and all child contracts. In solidity a function that has access set as internal will have a similar signature to this one:

```solidity
function myFunction(uint256 investAmount) internal {}
```

An example of a query that would filter for functions that are marked as internal is:

```python
from glider import *
def query():
  props_included = [MethodProp.INTERNAL]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (4) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# MethodProp.IS\_PAYABLE

In a smart contract a function can be marked as payable. This means that the function can accept the native token of the chain as a payment value.

An example  of a payable function is

```solidity
function depositETH() external payable {
	depositor[msg.sender].balance = msg.value;
}
```

An example of a query which would select all payable functions is:

```python
from glider import *
def query():
  props_included = [MethodProp.IS_PAYABLE]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (7) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# MethodProp.HAS\_MODIFIERS

In solidity a smart contract can define modifiers which can be called before the code of the function is run.

An example of such a contract would be as below:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Example {
    modifier onlyOwner {
    	require(msg.sender == owner);
    	_;
   	}
   	
   	//This function has the onlyOwner modifier
   	function setNewOwner(address newOwner) public onlyOwner {
   		owner = newOwner;
   	}

}
```



An example of a query which adds a filter to select functions which have modifiers is:

```python
from glider import *
def query():
  props_included = [MethodProp.HAS_MODIFIERS]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# MethodProp.PRIVATE

This property will filter for functions that are exposed in a smart contract and marked with an access level of private

Functions declared with private access are callable only from functions inside of the smart contract and not by any child contracts. In solidity a function that has access set as private will have a similar signature to this one:

```solidity
function myFunction(uint256 investAmount) private {}
```

An example of a query that would filter for functions that are marked as internal is:

```python
from glider import *
def query():
  props_included = [MethodProp.PRIVATE]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (10) (1) (1).png" alt=""><figcaption></figcaption></figure>
# MethodProp

# MethodProp.HAS\_CALLEES

The property HAS\_CALLEES is used to add a filter to include or exclude functions that have functions that call them from within the same contract.

An example of a query which will filter for functions that have callees is:

```python
from glider import *
def query():
  props_included = [MethodProp.HAS_CALLEES]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (178).png" alt=""><figcaption></figcaption></figure>
# MethodProp.HAS\_STATE\_VARIABLES\_WRITTEN

If a variable is declared outside of a function within a smart contract it is considered a STATE variable. Such variable's value are stored permanently on the blockchain, for instance account balances and admin addresses.

An example of a query which will select functions that modify STATE variables from within the code of the function is:

```python
from glider import *
def query():
  props_included = [MethodProp.HAS_STATE_VARIABLES_WRITTEN]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# MethodProp.HAS\_STATE\_VARIABLES\_READ

If a variable is declared outside of a function within a smart contract it is considered a STATE variable. Such variable's values are stored on the blockchain, for instance account balances and admin addresses.

An example of a query which will select functions that read STATE variables from within the code of the function is:

```python
from glider import *
def query():
  props_included = [MethodProp.HAS_STATE_VARIABLES_READ]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# MethodProp.IS\_VIEW

In a smart contract a function can be declared that will not modify any state variable values. These functions are marked as VIEW functions

An example of a view function is:

```solidity
function getOwner() external view returns address {
	return owner;
}
```

An example of a query that would select only VIEW functions is:

```python
from glider import *
def query():
  props_included = [MethodProp.IS_VIEW]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (9) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# MethodProp.HAS\_ARGS

The HAS\_ARGS property adds a filter to either include or exclude functions that have arguments in their signature.

An example of a function with a signature would be&#x20;

```solidity
function myFunction(uint256 investAmount){}
```

In the example below the query will filter out all functions that have arguments and only return those functions with no arguments in their signature

```python
from glider import *

def query():
  props_excluded = [MethodProp.HAS_ARGS]

  functions = Functions()\
      .without_properties(props_excluded)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (20).png" alt=""><figcaption></figcaption></figure>
# MethodProp.IS\_PURE

In a smart contract a function can be declared that neither reads nor modifies any state variables. These functions can be marked as PURE functions

An example of such a function is:

```solidity
function add(uint256 a,uint256 b) external pure returns uint256 {
	return a + b;
}
```

An example of a query that would select functions marked as pure functions is:

```python
from glider import *
def query():
  props_included = [MethodProp.IS_PURE]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (8) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# MethodProp.IS\_CONSTRUCTOR

A constructor function in a smart contract is called when the smart contract is instantiated, and can be used to set initial values of state variables within the contract

An example of a smart contract with a constructor is:

```solidity
contract Example {
    
    constructor(){
    	owner = msg.sender;
    }
    
 }
```

An example of a query which will select constructor functions is:

```python
from glider import *
def query():
  props_included = [MethodProp.IS_CONSTRUCTOR]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (5) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# MethodProp.EXTERNAL

This property will filter for functions that are exposed in a smart contract and marked with an access level of external. Adding this property filter to the query will add a filter for all functions with this property.&#x20;

Functions declared with external access are callable from an external third party.

In solidity a function that has access set as external will have a similar signature to this one:

```solidity
function myFunction(uint256 investAmount) external {}
```

An example of such a query would be:

```python
from glider import *
def query():
  props_any = [MethodProp.EXTERNAL]
  functions = Functions()\
      .with_one_property(props_any)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (19).png" alt=""><figcaption></figcaption></figure>
# MethodProp.PUBLIC

This property will filter for functions that are exposed in a smart contract and marked with an access level of public. Adding this property filter to the query will add a filter for all functions with this property.

Functions declared with public access are callable from an external third party and from within the smart contract functions.

```solidity
function myFunction(uint256 investAmount) public {}
```

An example of a query that would filter for functions that are marked as public is:

```python
from glider import *
def query():
  props_included = [MethodProp.PUBLIC]
  functions = Functions()\
      .with_all_properties(props_included)\
      .exec(5)

  return functions
```

## Output

<figure><img src="../../../.gitbook/assets/image (179).png" alt=""><figcaption></figcaption></figure>
# Callables.with\_name\_regexes()

`with_name_regexes(`_`regexes: List[str]`_`) →` [`Callables`](./)\


Adds a filter to get callables whose names match any of the regex expressions from the given list. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To filter given a single regex expression, refer to [Callables.with\_name\_regex()](callables.with_name_regex.md).

### Functions Example

```python
from glider import *

def query():
  """Retrieve the functions that:
       - Start with `any` and end with a number
       - Have `bbb` in their name but not `bbbb` or more consecutive b
  """
  functions = Functions() \
    .with_name_regexes([
      r"^any.*\d$",
      r"(?<!b)b{3}(?!b)"
    ]) \
    .exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (164).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

<pre class="language-python"><code class="lang-python"><strong>from glider import *
</strong>
def query():
  """Retrieve the modifiers that:
      - Start with `p` and end with `d`
      - Start with `l` and end with `d`
  """
  modifiers = Modifiers() \
    .with_name_regexes([
      r"^p.*d$",
      r"^l.*d$"
    ]) \
    .exec(100)

  # Return the first five modifiers
  return modifiers[:5]
</code></pre>

Output:

<figure><img src="../../.gitbook/assets/image (165).png" alt=""><figcaption></figcaption></figure>
# Callables.without\_names()

`without_names(`_`names: List[str]`_`,`` `_`sensitivity: bool = True`_`) →` [`Callables`](./)

Adds a filter to get callables that that don't have the specified names. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To get the callables without a specified name, refer to [Callables.without\_name()](callables.without_name.md).

To filter given a list of names, refer to [Callables.with\_one\_of\_the\_names()](callables.with_one_of_the_names.md).

### Functions Example

```python
from glider import *

def query():
  # Retrieve all functions that are not named `_msgSender` and `_msgData`
  functions = Functions().without_names(["_msgSender", "_msgData"]).exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (6) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that are not named `onlyOwner` and `onlyMinter`
  modifiers = Modifiers().without_names(["onlyOwner", "onlyMinter"]).exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (7) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Callables.with\_one\_of\_the\_names()

`with_one_of_the_names(`_`names: List[str]`_`,`` `_`sensitivity: bool = True`_`) →` [`Callables`](./)

Adds a filter to get callables having specified names. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To filter given a single name, refer to [Callables.with\_name()](callables.with_name.md).

To get all but some specified names, refer to [Callables.without\_names()](callables.without_names.md).

### Functions Example

```python
from glider import *

def query():
  # Retrieve all functions that are named `sendMessage` and `totalSupply`
  functions = Functions().with_one_of_the_names(["sendMessage", "totalSupply"]).exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (4) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that are named `onlyCaller` and `onlyClient`
  modifiers = Modifiers().with_one_of_the_names(["onlyCaller", "onlyClient"]).exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (5) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get functions/modifiers having specified callee names.
---

# Callables.with\_callee\_names()

`with_callee_names(`_`names: List[str]`_`,`` `_`sensitivity: bool = True`_`) →` [`Callables`](./)

Adds a filter to get callables that have all of the specified callees (functions that are being called within a function/modifier). Returns a filtered [Callables](./) child object.&#x20;

This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

## Function Example

```python
from glider import *


def query():
  # Retrieve all functions that call both the owner() and msgSender() functions
  functions = Functions().with_callee_names(["owner", "msgSender"]).exec(1)

  # Returns the function found
  return functions
```

## Example Output

```solidity
constructor () {
    _balances[_msgSender()] = 10000;
    _isExcludedFromFee[owner()] = true;
}
```

## Modifier Example

```python
from glider import *


def query():
  # Retrieve all the modifiers that call both the owner() and msgSender() functions
  modifiers = Modifiers().with_callee_names(["owner", "msgSender"]).exec(1)

  # Return the modifier found
  return modifiers
```

## Example Output

```solidity
modifier onlyOwner() {
    require(owner() == _msgSender(), "Ownable: caller is not the owner");
    _;
}
```

# Callables.with\_arg\_type()

`with_arg_type(`_`arg_type: str`_`,`` `_`sensitivity: bool = True`_`) →` [`Callables`](./)

Adds a filter to get callables having specified argument type like "address" or even non-elementary types like structs. Returns a filtered [Callables](./) child object. This method can be called on all [Callables](./) child classes: [Functions](functions/) and [Modifiers](modifiers/).

To filter given a list of argument types, refer to [Callables.with\_arg\_types()](callables.with_arg_types.md).

_Note that the function will handle alias types, e.g. if uint256 is passed to the function, the results will also include the alias "uint" variables_

### Functions Example

```python
from glider import *

def query():
  # Retrieve the functions that have `Order` as one of their argument types
  functions = Functions().with_arg_type("Order").exec(100)

  # Return the first five functions
  return functions[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (175).png" alt=""><figcaption></figcaption></figure>

### Modifiers Example

```python
from glider import *

def query():
  # Retrieve the modifiers that have `Set` as one of their argument types
  modifiers = Modifiers().with_arg_type("State").exec(100)

  # Return the first five modifiers
  return modifiers[:5]
```

Output:

<figure><img src="../../.gitbook/assets/image (176).png" alt=""><figcaption></figcaption></figure>
# Literal

---
description: Returns the type of the literal.
---

# Literal.type

## Query Example

```python
from glider import *


def query():
    functions = (
        Functions()
        .with_name("mul")
        .exec(1)
    )
    instructions = functions[0].instructions().exec()
    for instruction in instructions:
        for component in instruction.get_components():
            if isinstance(component, Literal):                  
                print(component.type)
                print(component.expression)

              
    return [instructions[0]]
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 12.16.56 PM.png" alt=""><figcaption></figcaption></figure>

---
description: Returns the value of the literal.
---

# Literal.value

## Query Example

```python
from glider import *


def query():
    functions = (
        Functions()
        .with_name("mul")
        .exec(1)
    )
    instructions = functions[0].instructions().exec()
    for instruction in instructions:
        for component in instruction.get_components():
            if isinstance(component, Literal):                  
                print(component)
                print(component.value)

              
    return [instructions[0]]
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 12.21.55 PM.png" alt=""><figcaption></figcaption></figure>

# Operator

The class represents an operator called inside an [instruction](../../instruction/).&#x20;
---
description: Retrieves the OperatorType of the operator.
---

# Operator.get\_operator()

`get_operator() →` [`OperatorType`](operatortype/)
# OperatorType.TILD

# OperatorType.DELETE

# OperatorType.NOT

# OperatorType.MULTIPLICATION

# OperatorType.LEFT\_SHIFT

# OperatorType.PLUSPLUS

# OperatorType.GREATER

# OperatorType

The OperatorType represents a type of operator.
# OperatorType.INDEX\_ACCESS

# OperatorType.ASSIGN\_AND

# OperatorType.MINUSMINUS

# OperatorType.ASSIGN

# OperatorType.ASSIGN\_DIVISION

# OperatorType.OROR

# OperatorType.ASSIGN\_LEFT\_SHIFT

# OperatorType.ASSIGN\_MODULO

# OperatorType.LESS

# OperatorType.EQUAL

# OperatorType.GREATER\_EQUAL

# OperatorType.NOT\_EQUAL

# OperatorType.ASSIGN\_OR

# OperatorType.ASSIGN\_ADDITION

# OperatorType.ASSIGN\_CARET

# OperatorType.MODULO

# OperatorType.RIGHT\_SHIFT

# OperatorType.CARET

# OperatorType.POWER

# OperatorType.ANDAND

# OperatorType.ASSIGN\_SUBTRACTION

# OperatorType.PLUS

# OperatorType.DIVISION

# OperatorType.MINUS

# OperatorType.ASSIGN\_MULTIPLICATION

# OperatorType.LESS\_EQUAL

# OperatorType.AND

# OperatorType.OR

# OperatorType.ASSIGN\_RIGHT\_SHIFT

# OperatorType.ADDITION

# OperatorType.SUBTRACTION

# OperatorType.UNKNOWN\_OPERATOR

# Value

This class represents different parts of an [instruction](../instruction/).

While an easy way to understand what instruction is is to imagine that it is everything that ends with ";" e.g

```solidity
require(predicate); 
uint a = 0;
foo(bar()-1);
```

These are all examples of instructions.

Value represents the internal parts of instruction, e.g for the instruction:

```solidity
foo(bar()-1);
```

the `bar()` - call, `bar()-1` expression and `foo(bar()-1)` calls will be the values of the instruction.

While the Value is a very important part of the engine, one will most likely never work with the Value class directly, but rather with the derived classes of the Value, which are:

* [Call](call/)
* [Var](broken-reference)
* [ValueExpression](valueexpression/)
* ValueContractType
* [Literal](literal/)

# IndexAccess

The class represents an index access of a mapping inside an [instruction](../../instruction/).&#x20;
---
description: Returns the sequence value of the index access.
---

# IndexAccess.get\_sequence()

`get_sequence() →` [`Value`](../) `|` [`NoneObject`](../../internal/noneobject/)
---
description: Returns the index value of the index access.
---

# IndexAccess.get\_index()

`get_index() →` [`Value`](../) `|` [`NoneObject`](../../internal/noneobject/)

&#x20;
---
description: Returns whether the value is tainted.
---

# Value.is\_tainted()

## Query Example

Consider the following Solidity function:

```solidity
function _transfer(address from,address to,uint256 amount) private {
    require(from != address(0),"ERC20: transfer from the zero address");
    require(amount > 0,"Transfer amount must be greater than zero");
    emit record(from,to); 

    // Emitted code for brevity
}
```

In this function, we want to determine if the following line is influenced by user input:

```solidity
require(from != address(0),"ERC20: transfer from the zero address");
```

We know that `from` comes from a function argument, which is user-controlled. Therefore, this line of code is influenced by user input, and therefore tainted.

To write a query to confirm this, we first query the components in the instruction and call `is_tainted()` against any of the Values.

```python
from glider import *


def query():    
    return (
        Contracts()
        .with_name("aa2Token")
        .exec(1)
        .functions()
        .with_name("_transfer")
        .exec(1)
        .instructions()
        .exec(2)
        .filter(is_tainted)
    )

def is_tainted(instruction):
    components = instruction.get_components()
    
    for component in components:
        if component.is_tainted():
            return True

    return False
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-16 at 6.36.15 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns a list of all VarValue objects of current value.
---

# Value.get\_vars()

`get_vars() ->` [`APIList`](../../iterables/apilist.md)`[`[`VarValue`](../../point/varvalue/)`]`

The function returns all the VarValues used (read/written) inside the Value.&#x20;

It returns VarValues for state, local and global variables and arguments, basically combining the calls to get\_state\_vars, get\_local\_vars, get\_global\_vars and get\_arg\_vars.

## Example

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .exec(1,10)
    )
    for instruction in instructions:
        print(instruction.get_components().get_vars().expression)
    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (43).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true when the value interacts with a global variable such as
  msg.sender, msg.data, etc. from inside the function.
---

# Value.has\_global\_df()

`has_global_df() → bool`

The function traverses the data-flow graph within the current function scope and returns true if the Value interacts with a global variable at any point in its data flow, and false otherwise.

By "interacts," we mean the Value is used in an operation that reads or writes a global variable, or is combined with a value derived from a global. For example, if we analyze the lastDatasetId value, the following counts as an interaction because lastDatasetId is used to access the global mapping datasetOwners:

`datasetOwners[lastDatasetId] = msg.sender;`

## Query Example

```python
from glider import *

def query():
    instructions = (
        Functions()
        .with_name("registerDatasetProfile")
        .exec(1)
        .instructions()
        .exec(2)
    )

    for instruction in instructions:
        components = instruction.get_components()
        for component in components:
            print("Value: " + component.expression)
            print("Contains global df: ", component.has_global_df())

    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-04 at 12.37.08 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a list of VarValue objects of current value whose corresponding object
  is a GlobalVariable.
---

# Value.get\_global\_vars()

`get_global_vars() ->` [`APIList`](../../iterables/apilist.md)`[`[`VarValue`](../../point/varvalue/)`]`

The function returns all the global variables, e.g. `msg.sender, msg.value, tx.origin, ...`, used inside the Value.

For the list of global variables, please refer to GlobalVariables.

## Example

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .exec(1,1)
    )
    for instruction in instructions:
        print(instruction.get_components().get_global_vars().expression)
    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (42).png" alt=""><figcaption></figcaption></figure>
# Value

---
description: >-
  Returns a list of all previous instructions/arguments of the current point in
  the data flow graph.
---

# Value.backward\_df()

`backward_df() ->` [`APISet`](../../iterables/apiset.md)`[`[`Point`](../../point/)`]`

The function works similarly to [Instruction.backward\_df()](../../instruction/instruction.backward_df.md); the main difference is that in case of Instruction.backward\_df() the function will return backward dataflow point for every point in the Value, while Value.backward\_df() returns only those connected with the current Value.&#x20;

Like all other dataflow (DF) functions, it returns a list/set of Points, which can be instructions or "points" in the code, such as arguments, variables, etc.

## Query Example

Consider the following Solidity function:

```solidity
function _transfer(address sender,address recipient,uint256 amount) internal virtual {
    require(sender != address(0),"ERC20: transfer from the zero address");
    require(recipient != address(0),"ERC20: transfer to the zero address");
    
    _beforeTokenTransfer(sender,recipient,amount);
    
    uint256 senderBalance = _balances[sender];
    require(senderBalance >= amount,"ERC20: transfer amount exceeds balance");
    _balances[sender] = senderBalance - amount;
    _balances[recipient] += amount;
    
    emit Transfer(sender,recipient,amount);
}
```

In this function, we want to locate the first require statement and determine the origin of the sender variable:

```solidity
require(sender != address(0),"ERC20: transfer from the zero address");
```

To do this, we first query for the instruction containing the require statement and then query for sender.

Finally, we call backward\_df() to identify where sender originates.

```python
from glider import *


def query():
    instructions = (
      Functions()
      .with_name('_transfer')
      .instructions()
      .exec(1, 1)
    )

    for instruction in instructions:
        for component in instruction.get_components():
            print(component)

            print("Value: " + component.expression)
            for point in component.backward_df():
                print(point.source_code())

    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-03 at 2.57.18 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a list of VarValue objects of current value whose corresponding object
  is a StateVariable.
---

# Value.get\_state\_vars()

`get_state_vars() ->`[`APIList`](../../iterables/apilist.md)`[`[`VarValue`](../../point/varvalue/)`]`

The function returns all the state variables used (read/written) inside the Value.

## Query Example

```python
from glider import *


def query():
    instructions = (
        Functions()
        .with_one_property([MethodProp.HAS_STATE_VARIABLES_READ,MethodProp.HAS_STATE_VARIABLES_WRITTEN])
        .instructions()
        .exec(1, 5)
    )

    for instruction in instructions:
        print(instruction.get_components().get_state_vars().expression)

    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-08 at 11.19.20 AM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if the value doesn't have a parent value, false otherwise
---

# Value.is\_main\_value()

`is_main_value() → bool`

**Query Example**

```python
from glider import *

def query():
    instructions = Instructions().exec(1, 5)
    for instruction in instructions:
        components = instruction.get_components()
        for component in components:
            print(component.is_main_value())
            if component.is_main_value():
                print(component.expression)
    return instructions
```

**Output**

<figure><img src="../../../.gitbook/assets/image (39).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the type of the value
---

# Value.type

`property type: Type`
---
description: >-
  Returns a list of all instructions following the current point in the current
  data flow graph and outside of that
---

# Value.forward\_df\_recursive()

`forward_df_recursive() →` [`APISet`](../../iterables/apiset.md)`[`[`Point`](../../point/)`]`

The function works similarly to [Value.forward\_df()](value.forward_df.md); the main difference is that in case of Value.forward\_df() the function will return forward dataflow point for every point in the Value, while Value.forward\_df() returns only those connected with the current Value.&#x20;

Like all other dataflow (DF) functions, it returns a list/set of Points, which can be instructions or "points" in the code, such as arguments, variables, etc.

## Query Example

Consider the following Solidity function:

```solidity
function _removeTokenFromOwnerEnumeration(address from,uint256 tokenId) private {
    uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
    uint256 tokenIndex = _ownedTokensIndex[tokenId];
    if (tokenIndex != lastTokenIndex) {
        uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];
        _ownedTokens[from][tokenIndex] = lastTokenId; 
        _ownedTokensIndex[lastTokenId] = tokenIndex; 
    }

    _ownedTokens[from].length--;
}
```

We want to check where the lastTokenIndex variable is used inside this function. To do this, we can query for the first instruction that assigns the lastTokenIndex:

```python
instructions = (
  Functions()
  .with_name("_removeTokenFromOwnerEnumeration")
  .instructions()
  .exec(1,1)
)
```

Once we get the lastTokenIndex variable:

```python
lastTokenIndex_variable = instruction.get_dest()
```

We can then call `forward_df_recursive()` which will return every point where lastTokenIndex is used:

```python
for point in assigned_variable.forward_df_recursive():
    print(point.source_code())
```

The full query can be found below:

```python
from glider import *


def query():
    instructions = (
      Functions()
      .with_name("_removeTokenFromOwnerEnumeration")
      .instructions()
      .exec(1,1)
    )

    for instruction in instructions:
        lastTokenIndex_variable = instruction.get_dest()
        for point in lastTokenIndex_variable.forward_df_recursive():
            print(point.source_code())

    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-08 at 9.53.48 AM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the list of all previous points of the current point in the current
  data flow graph and outside of that.
---

# Value.backward\_df\_recursive()

`backward_df_recursive() →` [`APISet`](../../iterables/apiset.md)`[`[`Point`](../../point/)`]`&#x20;

The function works similarly to [Value.backward\_df()](value.backward_df.md); the main difference is that in case of Value.backward\_df() the function will return backward dataflow point for every point in the Value, while Value.backward\_df() returns only those connected with the current Value.&#x20;

Like all other dataflow (DF) functions, it returns a list/set of Points, which can be instructions or "points" in the code, such as arguments, variables, etc.

## Query Example

Consider the following Solidity functions:

<pre class="language-solidity"><code class="lang-solidity">function transfer(address recipient,uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(),recipient,amount);
        return true;
}
    
function _msgSender() internal view virtual returns (address) {
        return msg.sender;
}

<strong>function _transfer(address sender,address recipient,uint256 amount) internal virtual {
</strong>        require(sender != address(0),"ERC20: transfer from the zero address");
        require(recipient != address(0),"ERC20: transfer to the zero address");
        
        _beforeTokenTransfer(sender,recipient,amount);
        
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount,"ERC20: transfer amount exceeds balance");
        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;
        
        emit Transfer(sender,recipient,amount);
}
</code></pre>

In the \_transfer function, we want to locate the first require statement and determine the origin of the sender variable across multiple functions:

```solidity
require(sender != address(0),"ERC20: transfer from the zero address");
```

To do this, we first query for the instruction containing the require statement and then query for sender:

```python
instructions = (
  Functions()
  .with_name('_transfer')
  .instructions()
  .exec(1, 1)
)
```

Finally, we call backward\_df\_recursive() to identify where the sender originates. Glider will transverse from the \_transfer() function, transfer() function, and msgSender() functions to identify the sender source.

```python
from glider import *


def query():
    instructions = (
      Functions()
      .with_name('_transfer')
      .instructions()
      .exec(1, 1)
    )

    for instruction in instructions:
        for component in instruction.get_components():
            print("Value: " + component.expression)
            for point in component.backward_df_recursive():
                print(point.source_code())

    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-04 at 3.15.48 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the value's expression.
---

# Value.expression

`property expression: str`

The property returns the "part" of the instruction that the Value represents.

## Query Example

```python
from glider import *


def query():
    instructions = (
        Instructions()
        .exec(1, 100)
    )
    
    for instruction in instructions:
        print(instruction.get_components().expression)
        
    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-08 at 11.05.44 AM.png" alt=""><figcaption></figcaption></figure>

---
description: >-
  Returns a list of all instructions following the current point in the current
  data flow graph
---

# Value.forward\_df()

`forward_df() -> APISet[Point]`

The function works similarly to [Instruction.forward\_df()](../../instruction/instruction.forward_df.md); the main difference is that in case of Instruction.forward\_df() the function will return forward-dataflow point for every point in the instruction, while Value.forward\_df() returns only those connected with the current Value.&#x20;

## Query Example

Consider the following Solidity function:

```solidity
function registerDatasetProfile(string memory contributor,string memory coverage,string memory creator,string memory date,string memory description,string memory format,string memory identifier,string memory language,string memory publisher,string memory relation,string memory rights,string memory source,string memory subject,string memory title,string memory dtype)
    public returns (uint)
    {
        lastDatasetId = lastDatasetId + 1;
        datasetOwners[lastDatasetId] = msg.sender;
        emit AssignDatasetId(lastDatasetId,msg.sender);
        metadata[lastDatasetId]['contributor'] = contributor;
        metadata[lastDatasetId]['coverage'] = coverage;
         metadata[lastDatasetId]['creator'] = creator;
         metadata[lastDatasetId]['date'] = date;
         metadata[lastDatasetId]['description'] = description;
         metadata[lastDatasetId]['format'] = format;
         metadata[lastDatasetId]['identifier'] = identifier;
         metadata[lastDatasetId]['language'] = language;
         metadata[lastDatasetId]['publisher'] = publisher;
         metadata[lastDatasetId]['relation'] = relation;
         metadata[lastDatasetId]['rights'] = rights;
         metadata[lastDatasetId]['source'] = source;
         metadata[lastDatasetId]['subject'] = subject;
         metadata[lastDatasetId]['title'] = title;
         metadata[lastDatasetId]['type'] = dtype;
         
         return lastDatasetId;
    }
```

In this Solidity example, we want to identify where the lastDatasetId variable flows to.&#x20;

To do this, we first query for the instruction that assigns the lastDatasetId variable:

```solidity
lastDatasetId = lastDatasetId + 1;
```

We then select the lastDatasetId component, and call forward\_df() to identify every point the lastDatasetId flows to.

<pre class="language-python"><code class="lang-python"><strong>from glider import *
</strong>
def query():
    instructions = (
        Functions()
        .with_name("registerDatasetProfile")
        .exec(1)
        .instructions()
        .exec(2)
    )

    for instruction in instructions:
        components = instruction.get_components()
        for component in components:
            print("Value: " + component.expression)

            for point in component.forward_df():
                print("Flows to: " + point.source_code())

            break

    return instructions
</code></pre>

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-04 at 12.24.59 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a list of VarValue objects of current value whose corresponding object
  is an argument variable.
---

# Value.get\_arg\_vars()

`get_arg_vars() ->` [`APIList`](../../iterables/apilist.md)`[`[`VarValue`](../../point/varvalue/)`]`

The function returns all the arguments' vars used inside the Value.

## Example

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .exec(1,10)
    )
    for instruction in instructions:
        print(instruction.get_components().get_arg_vars().expression)
    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (2) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the instruction in which the value is.
---

# Value.instruction

`property instruction:` [`Instruction`](../../instruction/)

---
description: >-
  Returns a list of VarValue objects of current value whose corresponding object
  is a LocalVariable.
---

# Value.get\_local\_vars()

`get_local_vars() ->` [`APIList`](../../iterables/apilist.md)`[`[`VarValue`](../../point/varvalue/)`]`

The function returns all the local variables used (read/written) inside the Value.

## Query Example

```python
from glider import *


def query():
    instructions = (
        Instructions()
        .new_variable_instructions()
        .exec(1)
    )

    for instruction in instructions:
        print(instruction.get_dest().get_local_vars().expression)

    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-08 at 11.32.26 AM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the list of Call values of current value
---

# Value.get\_callee\_values()

`get_callee_values() ->` [`APIList`](../../iterables/apilist.md)`[`[`Call`](../call/)`]`

## Query Example

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .low_level_external_calls()
        .exec(1, 137)
    )

    for ins in instructions:
        print(ins.get_value().get_callee_values())
        print(ins.get_value().get_callee_values()[0].expression)

    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-08 at 11.13.01 AM.png" alt=""><figcaption></figcaption></figure>
# Value.parent\_value

Returns the parent [Value](../) in case the current one is inside another Value; returns None otherwise.

`property parent_value:` [`Value`](../) `| None`

**Query Example**

```python
from glider import *

def query():
    instructions = Instructions().exec(1,1)
    value = instructions.get_components()

    print(f"Value: {value[0].expression}")
    print(f"Parent values: {value[0].parent_value.expression}")
    
    return instructions
```

**Output**

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (2) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Value.source\_code()

`source_code() → str`
---
description: >-
  Returns true when the value interacts with a global variable such as
  msg.sender, msg.data, etc. across multiple functions.
---

# Value.has\_global\_df\_recursive()

`has_global_df_recursive() → bool`

The function is the _**recursive**_**/**_**inter-procedural**_ variant of `has_global_df()`. It traverses the data-flow graph across function boundaries and returns true if the Value interacts with a global variable at any point in its data flow, and false otherwise.

By "interacts," we mean the Value is used in an operation that reads or writes a global variable, or is combined with a value derived from a global. For example, if we analyze the lastDatasetId value, the following counts as an interaction because lastDatasetId is used to access the global mapping datasetOwners:

`datasetOwners[lastDatasetId] = msg.sender;`

The difference between `has_global_df_recursive()` and `has_global_df()` is scope: the non-recursive version analyzes only the current function, while `has_global_df_recursive()` follows the Value’s data flow recursively (across calls) until it either finds an interaction with a global variable or exhausts the flow.

## Query Example

```python
from glider import *

def query():
    instructions = (
        Functions()
        .with_signature("approve(address,uint256)")
        .exec(100)
        .filter(lambda function : function.get_contract().name == "ERC20")[0]
        .instructions()
        .exec()
    )

    for instruction in instructions:
        components = instruction.get_components()
        for component in components:
            if component.has_global_df_recursive():
                print("Value: " + component.expression)

    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-04 at 2.24.53 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the name of the contract in which the called function is
---

# Call.get\_contract\_name()

`get_contract_name() -> str`

## Query Example

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .exec(1,98)
        .filter(lambda x: x.is_call())
    )

    for ins in instructions:
        print(ins.get_value().get_contract_name())

    return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (47).png" alt=""><figcaption></figcaption></figure>
---
description: Return the dict representing the special params of the call
---

# Call.get\_special\_params()

`get_special_params() → Dict[str, List[`[`Value`](../)`]]`

Some of the call types can have special parameters like `gas, salt, value`.  The function can be used to get a dict representing these values.

## **Query Example**

```python
from glider import *

def query():
  instructions = (
    Instructions()
    .external_calls()
    .exec(10,20)
    .filter(lambda instruction : instruction.get_parent().name == "_disperseEth")
  )

  results =[]

  for instruction in instructions:
    for call in instruction.get_components():
        if isinstance(call, Call):
          special_params = call.get_special_params()
          if special_params['call_value']:
            results.append(instruction)
            print(call.get_special_params(), call.expression)
    
  return results
```

## **Example Output**

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 2.38.45 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the type of the call
---

# Call.get\_call\_type()

`get_call_type() →` [`CallType`](calltype/)

The Call represents all types of call values: external, internal, log emit, etc. This function can be used to get the type of the call.

**Query Example**

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .exec(100)
        .filter(lambda x: x.is_call())
    )

    for ins in instructions:
        call = ins.get_value()
        if isinstance(call, Call):
            print(call.get_call_type())

    return instructions
```

**Output**

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (2) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the called function name
---

# Call.name

`property | name() -> str`

## Query Example

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .exec(1,98)
        .filter(lambda x: x.is_call())
    )

    for ins in instructions:
        print(ins.get_value().name)

    return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (2) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the called function signature
---

# Call.signature

`property | signature() -> str`

## Query Example

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .exec(1,98)
        .filter(lambda x: x.is_call())
    )

    for ins in instructions:
        print(ins.get_value().signature)

    return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (2) (1) (2) (1).png" alt=""><figcaption></figcaption></figure>
# Call

The class represents any type of call inside an [instruction](../../instruction/). The type of call can be different, such as an event call (emit Log();)), a function call, or an external call, etc.

A full list of supported call types can be seen in CallType.
---
description: Return the value representing the salt parameter of the contract creation call
---

# Call.get\_call\_salt()

`get_call_salt() ->` [`APIList`](../../iterables/apilist.md)`[Union[`[`Value`](../)`,` [`NoneObject`](../../internal/noneobject/)`]]`

The function returns the Value (or any derived class) that represents the special salt parameter used in contract creation calls; the list will be empty if the call is not a contract creation or does not have a salt parameter.

For example, in the instruction:

```solidity
pool = address(new UniswapV3Pool{salt: keccak256(abi.encode(token0, token1, fee))}());
```

the contract creation call:

```solidity
new UniswapV3Pool{salt: keccak256(abi.encode(token0, token1, fee))}
```

has a salt parameter:&#x20;

```solidity
keccak256(abi.encode(token0, token1, fee))
```

the function will return the value representing this expression (and it will be of type [Call](./) in this case, as its a keccak256 function call)

**Query Example**

```python
from glider import *

def query():
    instructions = (
        Contracts()
        .with_name("UniswapV3PoolDeployer")
        .functions()
        .with_name("deploy")
        .instructions()
        .exec(10)
        .filter(lambda x: x.is_new_contract())
    )


    for ins in instructions:
        print(ins.get_value().get_callee_values()[0].get_call_salt())
        print(ins.get_value().get_callee_values()[0].get_call_salt().expression)

    return instructions
```

**Output Example**

<figure><img src="../../../.gitbook/assets/image (51).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the function that is being called, if exists, otherwise returns
  NoneObject
---

# Call.get\_function()

`get_function() →` [`Function`](../../callable/function/) `| NoneObject`

The function will return the [Function](../../callable/function/) object of the function being called, as there can be cases (such as low-level external calls, or solidity built-in calls) where there is no defined function the function will return NoneObject:

For example, in the call:

```solidity
require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the limit")
```

The if the function is used on the call representing the `require(...)`, NoneObject will be returned, as there is no solidity code representing the builtin function.

On the other hand if the function is called on the call representing `balanceOf(to)` it will return the [Function](../../callable/function/) object of the `balanceOf`.

{% hint style="info" %}
Note that for the external calls made using interfaces, the function will return the interface Function object.

For the call:

```solidity
IUniswapV2Factory(factory).createPair(address(this),uniswapV2Router.WETH())
```

it will return a function object representing the `IUniswapV2Factory` interface's `createPair` function
{% endhint %}

## **Query Example**

```python
from glider import *

def query():
  instructions = (
    Instructions()
    .calls()
    .exec(10, 80)
    .filter(lambda instruction : instruction.get_parent().name in "slippedDailyRate")
  )

  results = []
  for instruction in instructions:
    for call in instruction.get_components():
      if isinstance(call, Call):
        if not isinstance(call.get_function(), NoneObject):
          print(call.expression)
          print(instruction.get_parent().get_contract().address())
          results.append(call.get_function())
          break
        else:
          print('no function object: ' + call.signature)
    break
  return results
```

## **Example Output**

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 2.29.13 PM.png" alt=""><figcaption></figcaption></figure>

### The function was called from the `slippedDailyRate()` function:

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 2.34.38 PM.png" alt=""><figcaption></figcaption></figure>
---
description: 'TYPE_CONVERSION: str = ''type_conversion'''
---

# CallType.TYPE\_CONVERSION

---
description: 'EVENT: str = ''event'''
---

# CallType.EVENT

---
description: 'EXTERNAL: str = ''external'''
---

# CallType.EXTERNAL

---
description: 'NEW_ELEMENTARY_TYPE: str = ''new_elementary_type'''
---

# CallType.NEW\_ELEMENTARY\_TYPE:

---
description: 'NEW_ARR: str = ''new_arr'''
---

# CallType.NEW\_ARR

# CallType

The class represents [call](../) types.

`EVENT: str = 'event'`

`EXTERNAL: str = 'external'`

`INTERNAL: str = 'internal'`

`LIBRARY: str = 'library'`

`LOW_LEVEL: str = 'low_level'`

`NEW_ARR: str = 'new_arr'`

`NEW_ELEMENTARY_TYPE: str = 'new_elementary_type'`

`NEW_STRUCT: str = 'new_struct'`

`PRIVATE: str = 'private'`

`PUBLIC: str = 'public'`

`SOLIDITY: str = 'solidity'`

`TYPE_CONVERSION: str = 'type_conversion'`

`UNKNOWN: str = 'unknown'`
---
description: 'INTERNAL: str = ''internal'''
---

# CallType.INTERNAL

---
description: 'SOLIDITY: str = ''solidity'''
---

# CallType.SOLIDITY

---
description: 'NEW_STRUCT: str = ''new_struct'''
---

# CallType.NEW\_STRUCT

---
description: 'LOW_LEVEL: str = ''low_level'''
---

# CallType.LOW\_LEVEL

---
description: 'UNKNOWN: str = ''unknown'''
---

# CallType.UNKNOWN

---
description: 'PRIVATE: str = ''private'''
---

# CallType.PRIVATE

---
description: 'PUBLIC: str = ''public'''
---

# CallType.PUBLIC

---
description: 'LIBRARY: str = ''library'''
---

# CallType.LIBRARY

---
description: Returns the call's qualifier (target) is exists
---

# Call.get\_call\_qualifier()

`get_call_qualifier() -> Union[`[`Value`](../value/)`,` [`NoneObject`](../../internal/noneobject/)`]`

The call's qualifier is the "target" of the call.

For example, for the call:

```solidity
(bool success_, ) = feeCollector_.call{ value: feeAmount_, gas: 1000 }("");
```

The qualifier is the:

```solidity
feeCollector_
```

Sometimes, the qualifier itself is a call. In that case, you will be returned another Call.

## **Query Example**

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .low_level_external_calls()
        .exec(1000)
        .filter(lambda instruction : instruction.get_parent().get_contract().name == "PoolEth")
    )

    for ins in instructions:
        print(ins.get_value().get_callee_values()[0].get_call_qualifier())
        print(ins.get_value().get_callee_values()[0].get_call_qualifier().expression)

    return instructions
```

## **Example Output**

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 1.04.07 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns Value representing the gas-parameter used in the external calls.
---

# Call.get\_call\_gas()

`get_call_gas() ->` [`APIList`](../../iterables/apilist.md)`[Union[`[`Value`](../value/)`,` [`NoneObject`](../../internal/noneobject/)`]]`

## **Query Example**

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .low_level_external_calls()
        .exec(1000)
        .filter(lambda instruction : instruction.get_parent().get_contract().name == "PoolEth")
    )

    for ins in instructions:
        callee_values = ins.get_value().get_callee_values()
        print(callee_values.get_call_gas())
        print(callee_values.get_call_gas().expression)

    return instructions
```

## **Example Output**

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 1.01.24 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the name of the contract in which the called function is.
---

# Call.get\_contract\_name()

`get_contract_name() → str`

&#x20;
---
description: Returns the arguments of the call in key/value format
---

# Call.kv\_parameters()

`kv_parameters() → List[Tuple[`[`Argument`](../../argument/)`,` [`Value`](../)`]] | NoneObject`

The function is used to return argument information in a key/value format; it returns a list of tuples, where the first element is the argument of the function, and the second element is the value that is being passed as that argument.

The function is mainly used to account for the key/value format of function calls, e.g:

```solidity
return someFuncWithManyInputs({a: address(0), b: true, c: "c", x: 1, y: 2, z: 3});
```

but it can also be used with a regular call syntax.

## **Query Example**

```python
from glider import *

def query():
  instructions = Instructions().external_calls().exec(1)

  for instruction in instructions:
    for call in instruction.get_components():
      if isinstance(call, Call):
        for arg, val in call.kv_parameters():
          print(arg.source_code(), val.expression)

  return instructions
```

## **Example Output**

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 2.41.30 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the arguments of the call, or empty array if the call has no
  arguments.
---

# Call.get\_args()

`get_args() ->` [`APIList`](../../iterables/apilist.md)`[Union[`[`Value`](../value/)`,` [`NoneObject`](../../internal/noneobject/)`]]`

## Query Example

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .exec(100)
        .filter(lambda x: x.is_call())
    )

    for ins in instructions:
        call = ins.get_value()
        if isinstance(call, Call):
            print(call.get_args().expression)

    return instructions
```

## Output&#x20;

<figure><img src="../../../.gitbook/assets/image (48).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the i-th argument of called function
---

# Call.get\_arg()

`get_arg(i: int) -> Union[`[`Value`](../value/)`,` [`NoneObject`](../../internal/noneobject/)`]`

## Query Example

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .with_callee_name("require")
        .calls()
        .exec(10)
    )

    for ins in instructions:
        call = ins.get_value()
        if isinstance(call, Call):
            print(call.name)
            print(call.get_arg(0).expression)
            print(call.get_arg(1).expression)

    return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 12.28.13 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the Value representing the "value" (ether sent) during the external
  call
---

# Call.get\_call\_value()

`get_call_value() → List[`[`Value`](../)`]`

As some types of calls can have, a special parameter set representing the ether value to send in the call), this function can be used to retrieve that value.

For example, in the call:

```solidity
(bool success, ) = recipient.call{value: amount}("");
```

The special parameter `value` is being set: `{value: amount}`

and the function will return the Value representing the:

`amount`

**Query Example**

```python
from glider import *

def query():
    instructions = (
        Instructions()
        .low_level_function_calls()
        .exec(1)
    )

    for ins in instructions:
        print(ins.get_value().get_callee_values()[0].get_call_value())
        print(ins.get_value().get_callee_values()[0].get_call_value().expression)


    return instructions
```

**Output Example**

<figure><img src="../../../.gitbook/assets/image (3) (1) (2).png" alt=""><figcaption></figcaption></figure>
# ValueExpression

---
description: >-
  Returns true if the value expression has a dependency on external variables in
  the current data flow graph, false otherwise.
---

# ValueExpression.has\_global\_df()

`has_global_df() → bool`
---
description: Returns the Operator that assigned the variable in the variable assignment.
---

# ValueExpression.get\_assignment\_operator()

`get_assignment_operator() →` [`Value`](../) `|` [`NoneObject`](../../internal/noneobject/)
---
description: >-
  Returns the Value object representing the leftmost destination of the
  instruction
---

# ValueExpression.get\_dest()

`get_dest() -> Union[`[`Value`](../value/)`,` [`NoneObject`](../../internal/noneobject/)`]`

This function will return '`a`' in this case: '`a = b = c = 5`'

## Query Example

```python
from glider import *


def query():
    instructions = (
        Instructions()
        .new_variable_instructions()
        .exec(1,1)
    )
    for instruction in instructions:
        print(instruction.get_value().get_dest().expression)
    return instructions
```

## Example Output&#x20;

<figure><img src="../../../.gitbook/assets/image (3) (1) (2) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the list of Value objects representing the destination(s) of the value
  expression. This function returns the list to accommodate cases like'a = b =
  c= 5',where the destinations are[a, b, c].
---

# ValueExpression.get\_dests()

`get_dests() →` [`APIList`](../../iterables/apilist.md)`[`[`Value`](../) `|` [`NoneObject`](../../internal/noneobject/)`]`
---
description: Returns the value expression's components
---

# ValueExpression.get\_components()

`get_components(self) -> APIList[Union[`[`Value`](../value/)`,` [`NoneObject`](../../internal/noneobject/)`]]`

## Query Example

```python
from glider import *


def query():
    instructions = (
        Instructions()
        .exec(1, 6)
    )
    for instruction in instructions:
        main_value = instruction.get_value()

        if isinstance(main_value, ValueExpression):
          for component in main_value.get_components():
              print(component)
              print(component.expression)
              
    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-08 at 1.49.30 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns whether the value expression is tainted.
hidden: true
---

# ValueExpression.is\_tainted()

`is_tainted() → bool`
---
description: >-
  Returns true if the value expression has a dependency on external variables in
  the current data flow graph and outside of that, false otherwise.
---

# ValueExpression.has\_global\_df\_recursive()

`has_global_df_recursive() → bool`
---
description: Returns the value expression's i-th component
---

# ValueExpression.get\_component()

`get_component(i: int) -> Union[`[`Value`](../value/)`,` [`NoneObject`](../../internal/noneobject/)`]`

## Query Example

```python
from glider import *


def query():
    instructions = (
        Instructions()
        .new_variable_instructions()
        .exec(1,1)
    )
    for instruction in instructions:
        print(instruction.get_value().get_component(0))
        print(instruction.get_value().get_component(0).expression)
    return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (45).png" alt=""><figcaption></figcaption></figure>
---
description: The class represents the list of local variables.
hidden: true
---

# LocalVariables

---
description: Returns the list of local variables having specified memory type.
---

# LocalVariables.with\_memory\_type()

`with_memory_type(memory_type: str) → List[`[`LocalVariable`](../localvariable/)`]`

**Query Example**

```python
from glider import *
def query():
  funcs = Functions().exec(1000)

  for func in funcs:
    local_vars = func.local_variables().with_memory_type('storage')
    for local_var in local_vars:
      print(local_var.name)
      print(local_var.type.name)
      return [local_var.get_parent()]

  return []
```

**Output**

```solidity
"root":{3 items
"contract":string"0x72e3142f8cf57ee0107f332fce18aca593735b1f"
"contract_name":string"ElonCat"
"sol_function":solidity
function claim(uint256 id) external {
        Node storage node = nodes[msg.sender][id];
        uint256 timeElapsed = block.timestamp - node.lastClaimTime;
        node.lastClaimTime = block.timestamp;
        _balances[msg.sender] =
            _balances[msg.sender] +
            timeElapsed *
            rewardPerSecond;
    }
}
"root":{1 item
"print_output":[2 items
0:string"node"
1:string"Node"
]
}
```
---
description: Returns the list of local variables having specified type.
---

# LocalVariables.with\_type()

`with_type(var_type: str) → List[`[`LocalVariable`](../localvariable/)`]`

**Query Example**

```python
from glider import *
def query():
  funcs = Functions().exec(1000)

  for func in funcs:
    local_vars = func.local_variables().with_type('bytes')
    for local_var in local_vars:
      print(local_var.name)
      print(local_var.type.name)
      return [local_var.get_parent()]

  return []
```

**Output**

```solidity
"root":{3 items
"contract":string"0xa4915dc6ee2652c471397c32ce5c8d3494ef3e6c"
"contract_name":string"Strings"
"sol_function":solidity
function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
}
"root":{1 item
"print_output":[2 items
0:string"buffer"
1:string"bytes"
]
}
```
---
description: Returns the list of all local variables.
---

# LocalVariables.list()

`list() → List[`[`LocalVariable`](../localvariable/)`]`

**Query Example**

```python
from glider import *
def query():
  funcs = Functions().exec(500)

  for func in funcs:
    local_vars = func.local_variables().list()
    for local_var in local_vars:
      print(local_var.name)
      print(local_var.type.name)
      return [local_var.get_parent()]

  return []
```

**Output**

```solidity
"root":{3 items
"contract":string"0xd705c24267ed3c55458160104994c55c6492dfcf"
"contract_name":string"SafeMath"
"sol_function":solidity
function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
}
"root":{1 item
"print_output":[2 items
0:string"c"
1:string"uint256"
]
}
```
---
description: >-
  Returns a list of all the arguments that are passed as parameters to the
  function.
---

# Arguments.list()

`list() -> List[`[`Argument`](../argument/)`]`

## Example Query

```python
from glider import *


def query():
  functions = Functions().exec(100)

  for f in functions:
    # list() converts the arguments into a list that we can iterate through
    for arg in f.arguments().list():
      print(f"Argument source code: {arg.get_variable().data}")

  return []
```

Example of a ERC721 transferFrom function with 3 arguments&#x20;

ERC721.transferFrom(address from ,address to ,uint256 tokenId)

## Output Example

```json
{
  "Function Name": "transferFrom",
  "Arguments": [
    {
      "Argument data": {
        "name": "from",
        "name_ssa": "from_0",
        "canonical_name": "ERC721.transferFrom(address,address,uint256).from",
        "type": "address",
        "memory_type": "memory"
      }
    },
    {
      "Argument data": {
        "name": "to",
        "name_ssa": "to_0",
        "canonical_name": "ERC721.transferFrom(address,address,uint256).to",
        "type": "address",
        "memory_type": "memory"
      }
    },
    {
      "Argument data": {
        "name": "tokenId",
        "name_ssa": "tokenId_0",
        "canonical_name": "ERC721.transferFrom(address,address,uint256).tokenId",
        "type": "uint256",
        "memory_type": "memory"
      }
    }
  ]
}
```
---
description: Returns a list of arguments having specified memory type.
---

# Arguments.with\_type()

`with_type(`_`arg_type: str`_`) → List[`[`Argument`](../argument/)`]`

## Query Example

```python
from glider import *
 
 
def query():
  functions = Functions().exec(1000)

  for f in functions:
    # Find arguments that are the bytes32 type 
    for arg in f.arguments().with_type("bytes32"):
      print(arg.get_variable().data)

  return []
```

## Output Example

Example output of an Argument with the memory type bytes32:

```json
{
    'name': '_keyHash', 
    'canonical_name': 'VRFRequestIDBase.makeVRFInputSeed(bytes32,uint256,address,uint256)._keyHash', 
    'type': {
        'type': 'elementary', 
        'name': 'bytes32'
    }, 
    'memory_type': 'memory'
}
```
---
description: Add a new conversion.
---

# Convertor.add()

**`add`**`(`_`from_type: str`_`,`` `_`to_type: str`_`) → None`



```python
from glider import *

def query():
  # Create a Convertor object 
  convertor = Convertor()

  # Add a conversion from address to bytes20
  convertor.add("uint160", "address")

  # Fetch a list of functions
  funs = Functions().with_arg_type('uint160').exec(1,100)
  # Return the functions with at least one argument convertible to bytes20
  # It will be only the argument of type address
  output = []
  for fun in funs:
    args = fun.arguments().with_type_convertible(["address"], convertor)
    if args:
      output.append(fun)
  return output
```

Output (first result only):

```solidity
"root":{3 items
"contract":string"0x4109ab7966c5461439bdb0beda92c92fec767966"
"contract_name":string"UniswapV3Pool"
"sol_function":solidity
function initialize(uint160 sqrtPriceX96) external override {
        require(slot0.sqrtPriceX96 == 0, 'AI');
 
        int24 tick = TickMath.getTickAtSqrtRatio(sqrtPriceX96);
 
        (uint16 cardinality, uint16 cardinalityNext) = observations.initialize(_blockTimestamp());
 
        slot0 = Slot0({
            sqrtPriceX96: sqrtPriceX96,
            tick: tick,
            observationIndex: 0,
            observationCardinality: cardinality,
            observationCardinalityNext: cardinalityNext,
            feeProtocol: 0,
            unlocked: true
        });
 
        emit Initialize(sqrtPriceX96, tick);
    }
}
  "contract": "0x798AcB51D8FBc97328835eE2027047a8B54533AD",
  "contract_name": "Ownable",
  "sol_function": "function transferOwnership(address newOwner) public virtual onlyOwner {\n        require(newOwner != address(0),\"Ownable: new owner is the zero address\");\n        _setOwner(newOwner);\n    }"
}

```

Note that the order of the arguments is important. In the above example, only conversions from `address` to `bytes20` are allowed and not from `bytes20` to `address`.
# Convertor.can\_convert()

**`can_convert`**`(`_`from_type: str`_`,`` `_`to_type: str`_`) → bool`



```python
from glider import *

def query():
  # Create a Convertor object 
  convertor = Convertor()

  # Add a conversion from address to bytes20
  convertor.add("address", "bytes20")

  # Returns true
  print(convertor.can_convert("address", "bytes20"))

  # Returns false as conversion from address to uint160 was not added
  print(convertor.can_convert("address", "uint160"))

  return []
```

Output:

```json
{
  "print_output": [
    "True",
    "False"
  ]
}
```
---
description: The aim of this class is to define type conversions.
---

# Convertor

The class is used in conjunction with [Arguments](../) functions such as [with\_type\_convertible()](../arguments.with\_type\_convertible.md).

For example, if you want to treat `uint160` as a type `address`, you can use the `Convertor` to add that conversion type.

Bases: **object**

{% content-ref url="convertor.add.md" %}
[convertor.add.md](convertor.add.md)
{% endcontent-ref %}

{% content-ref url="convertor.can_convert.md" %}
[convertor.can\_convert.md](convertor.can\_convert.md)
{% endcontent-ref %}

{% content-ref url="convertor.set_conversions.md" %}
[convertor.set\_conversions.md](convertor.set\_conversions.md)
{% endcontent-ref %}
# Convertor.set\_conversions()

**`set_conversions`**`(`_`conversions: dict`_`) → None`

Set allowed conversions.

Deletes any previous conversions added to the [Convertor](./).\
Takes as an argument a dictionary with as keys the convertible types and as values the lists of allowed converted types.

```python
from glider import *

def query():
  # Create a Convertor object 
  convertor = Convertor()

  # Set conversion from address to bytes20
  convertor.set_conversions({"bytes20": ["address", "uint160"]})

  # Fetch a list of functions
  funs = Functions().exec(10)

  # Return the functions with at least one argument convertible to bytes20
  # It will be only the argument of type address
  output = []
  for fun in funs:
    args = fun.arguments().with_type_convertible(["bytes20"], convertor)
    if args:
      output.append(fun)
  return output
```

Output (first result only):

```json
{
  "contract": "0x798AcB51D8FBc97328835eE2027047a8B54533AD",
  "contract_name": "Ownable",
  "sol_function": "function transferOwnership(address newOwner) public virtual onlyOwner {\n        require(newOwner != address(0),\"Ownable: new owner is the zero address\");\n        _setOwner(newOwner);\n    }"
}
```
---
description: >-
  The class represents a list of arguments and allows to filter them with
  certain properties.
hidden: true
---

# Arguments

---
description: Returns a list of arguments having specified memory type.
---

# Arguments.with\_memory\_type()

`with_memory_type(memory_type: str) -> List[`[`Argument`](../argument/)`]`

## Query Example

```python
from glider import *


def query():
  functions = Functions().exec(1000)

  for f in functions:
    # Find arguments that have storage memory types
    for arg in f.arguments().with_memory_type("storage"):
      print(arg.get_variable().data)

  return []
```

## Output Example

Example output of a memory storage Argument:

```python
{
    'name': 'role', 
    'canonical_name': 'Roles.add(Roles.Role,address).role', 
    'type': {
        'type': 'struct', 
        'name': 'Role', 
        'contract_name': 'Roles', 
        'relative_filepath': '0xa5CFFF6a2c1a48AE38e8279Cf708AdbF16023e50_Exercies.sol'
    }, 
    'memory_type': 'storage'
}
```
---
description: >-
  Returns a list of arguments that can be converted to specified types.
  Convertor will define a table of allowed conversions.
---

# Arguments.with\_type\_convertible()

`with_type_convertible(arg_type: List[str], convertor:` [`Convertor`](convertor/)`) -> List[`[`Argument`](../argument/)`]`



## Query Example

```python
from glider import *

def query():
  # Create a Convertor object 
  convertor = Convertor()

  # Add a conversion from address to bytes20
  convertor.add("address", "bytes20")

  # Fetch a list of functions
  funs = Contracts().non_interface_contracts().functions().exec(20)

  # Return the functions with at least one argument convertible to bytes20
  # It will be only the argument of type address
  output = []
  for fun in funs:
    args = fun.arguments().with_type_convertible(["bytes20"], convertor)
    if args:
      output.append(fun)
  return output
```

## Output Example

```solidity
{
  "contract": "0xd705c24267ed3c55458160104994c55c6492dfcf",
  "contract_name": "Token",
  "sol_function": "
    function balanceOf(address account) public view override returns (uint256) {
            return _balances[account];
    }
  "
}
```
---
description: Returns a list of arguments having specified name
---

# Arguments.with\_name()

`with_name(arg_name: str, sensitivity: bool = False) -> List[`[`Argument`](../argument/)`]`

## Query Example

```python
from glider import *
 

def query():
  functions = Functions().exec(1000)

  for f in functions:
    # Find arguments named "account"
    for arg in f.arguments().with_name("account"):
      print(arg.get_variable().data)

  return []
```

## Output Example&#x20;

Example output of an Argument named "account":

```json
{
    'name': 'account', 
    'canonical_name': 'Datagold.queryAccountInfo(address,string).account', 
    'type': {
        'type': 'elementary', 
        'name': 'address'
    }, 
    'memory_type': 'memory'
}
```
---
description: This class represents Filter objects used for filtering results.
---

# Filters

# GlobalFilters.TX\_GASPRICE

The TX\_GASPRICE property is used to add a filter to include or exclude functions that calls `tx.gasprice`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.TX_GASPRICE)
    .exec(1)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 2.16.40 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.BLOCK\_NUMBER

The BLOCK\_NUMBER property is used to add a filter to include or exclude functions that calls `block.number`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.BLOCK_NUMBER)
    .exec(1, 4)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.30.49 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.BLOCK\_TIME\_STAMP

The BLOCK\_TIME\_STAMP property is used to add a filter to include or exclude functions that calls `block.timestamp`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.BLOCK_TIME_STAMP)
    .exec(1)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.38.01 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.MSG\_SIG

The MSG\_SIG property is used to add a filter to include or exclude functions that calls `msg.sig`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.MSG_SIG)
    .exec(1)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.46.37 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Class containing all custom filters for global values.
---

# GlobalFilters

# GlobalFilters.MSG\_SENDER

The MSG\_SENDER property is used to add a filter to include or exclude functions that calls `msg.sender`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.MSG_SENDER)
    .exec(1)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.45.26 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.BLOCK\_PREVRANDAO

The BLOCK\_PREVRANDAO property is used to add a filter to include or exclude functions that calls `block.prevrandao`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.BLOCK_PREVRANDAO)
    .exec(1, 4)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.36.04 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.BLOCK\_GAS\_LIMIT

The BLOCK\_GAS\_LIMIT property is used to add a filter to include or exclude functions that calls `block.gaslimit`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.BLOCK_GAS_LIMIT)
    .exec(1, 4)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.18.43 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.MSG\_VALUE

The MSG\_VALUE property is used to add a filter to include or exclude functions that calls `msg.value`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.MSG_VALUE)
    .exec(1)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.47.41 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.BLOCK\_COINBASE

The BLOCK\_COINBASE property is used to add a filter to include or exclude functions that calls `block.coinbase`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.BLOCK_COINBASE)
    .exec(1, 4)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.28.03 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.MSG\_GAS

The MSG\_GAS property is used to add a filter to include or exclude functions that calls `msg.gas`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.MSG_GAS)
    .exec(1)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.42.10 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.NOW

The NOW property is used to add a filter to include or exclude functions that calls `now`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.NOW)
    .exec(1)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.49.11 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.BLOCK\_BASEFEE

The BLOCK\_BASEFEE property is used to add a filter to include or exclude functions that calls `block.basefee`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.BLOCK_BASEFEE)
    .exec(1)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.30.02 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.BLOCK\_DIFFICULTY

The BLOCK\_DIFFICULTY property is used to add a filter to include or exclude functions that calls `block.difficulty`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.BLOCK_DIFFICULTY)
    .exec(1, 4)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.25.23 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.TX\_ORIGIN

The TX\_ORIGIN property is used to add a filter to include or exclude functions that calls `tx.origin`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.TX_ORIGIN)
    .exec(1, 2)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 2.20.14 PM.png" alt=""><figcaption></figcaption></figure>
# GlobalFilters.MSG\_DATA

The MSG\_DATA property is used to add a filter to include or exclude functions that calls `msg.data`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.MSG_DATA)
    .exec(1)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.39.53 PM.png" alt=""><figcaption></figcaption></figure>
---
hidden: true
---

# GlobalFilters.get()

# GlobalFilters.BLOCK\_CHAIN\_ID

The BLOCK\_CHAIN\_ID property is used to add a filter to include or exclude functions that calls `block.chainid`.&#x20;

### Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_globals(GlobalFilters.BLOCK_CHAIN_ID)
    .exec(1)
  )
  
  return functions
```

### Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-08-28 at 12.29.01 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the address of the error.
---

# Error.address

_`property`_` ``address:`` `_`str`_

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().exec(1, 2265) 

  for contract in contracts:
    for error in contract.errors().exec():
      print(f"{error.name} - {error.address}")

  return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-14 at 1.43.29 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the source code of the error.
---

# Error.source\_code()

`source_code() → str`

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().exec(1, 2265)

  for contract in contracts:
    for error in contract.errors().exec():
      print(error.source_code())

  return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-29 at 6.19.02 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the list of arguments of the error.
---

# Error.args

_`property`_` ``args:`` `_`List[Dict]`_

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().exec(1, 2265) 

  for contract in contracts:
    for error in contract.errors().exec():
      print(f"{error.name} - {error.args}")

  return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-29 at 6.10.29 PM.png" alt=""><figcaption></figcaption></figure>
---
description: The class represents a single error object.
---

# Error

---
description: Returns the name of the error.
---

# Error.name

_`property`_` ``name :`` `_`str`_

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().exec(1, 2265)

  for contract in contracts:
    for error in contract.errors().exec():
      print(error.name)

  return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-29 at 6.12.43 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the signature of the error.
---

# Error.signature

_`property`_` ``signature :`` `_`str`_

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().exec(1, 2265)

  for contract in contracts:
    for error in contract.errors().exec():
      print(error.signature)

  return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-29 at 6.13.30 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the name of the variable.
---

# Variable.name

`property: name -> str`
---
description: >-
  The class represents a single variable. All other *Variable classes inherit
  from this class.
hidden: true
---

# Variable

---
description: Returns the canonical name of the variable.
---

# Variable.canonical\_name

`property: canonical_name -> str`
---
description: Returns the type of the variable
---

# Variable.type

`property: type -> Type`
---
description: Classes that describe Solidity global variables
---

# GlobalVariables

These classes describe global variables, such as `msg.sender` and `block.timestamp`, in the glider.

* `MsgData` | Base: `GlobalVariabe` | object that represents `msg.data`
* `MsgGas` | Base: `GlobalVariable` | object that represents `msg.gas`
* `MsgSender` | Base: `GlobalVariable` | object that represents `msg.sender`&#x20;
* `MsgSig` | Base: `GlobalVariable` | object that represents `msg.sig`
* `MsgValue` | Base: `GlobalVariable` | object that represents `msg.value`
* `Now` | Base: `GlobalVariable` | object that represents `now`
* `TxGasprice` | Base: `GlobalVariable` | object that represents `tx.gasprice`
* `TxOrigin` | Base: `GlobalVariable` | object that represents `tx.origin`
* `GlobalVariable` | Base: Object&#x20;
---
description: The class represents a single argument variable.
---

# ArgumentVariable

# Variables

---
description: The class represents the list of local variables.
---

# LocalVariables

---
description: The class represents the list of local variables.
---

# LocalVariables

---
description: Returns the list of local variables having specified memory type.
---

# LocalVariables.with\_memory\_type()

`with_memory_type(memory_type: str) →` [`APIList`](../../../iterables/apilist.md)`[`[`LocalVariable`](../localvariable/)`]`

## Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_name("functionCallWithValue")
    .exec(3)
  )

  for func in functions:
    local_vars = func.local_variables().with_memory_type("memory")
    for local_var in local_vars:
      print(local_var.source_code())

  return functions
```

## Example Output

<figure><img src="../../../../.gitbook/assets/Screenshot 2025-09-10 at 3.51.37 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the list of local variables having specified type.
---

# LocalVariables.with\_type()

`with_type(var_type: str) →` [`APIList`](../../../iterables/apilist.md)`[`[`LocalVariable`](../localvariable/)`]`

## Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_name("purchaseDataset")
    .exec(1)
  )

  for func in functions:
    local_vars = func.local_variables().with_type("address")
    for local_var in local_vars:
      print(local_var.source_code())

  return functions
```

## Example Output

<figure><img src="../../../../.gitbook/assets/Screenshot 2025-09-10 at 3.57.27 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the list of all local variables.
---

# LocalVariables.list()

`list() →` [`APIList`](../../../iterables/apilist.md)`[`[`LocalVariable`](../../../localvariable/)`]`&#x20;

## Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_name("communityMint")
    .exec(1)
  )

  for func in functions:
    local_vars = func.local_variables().list()
    for local_var in local_vars:
      print(local_var.source_code())

  return functions
```

## Example Output

<figure><img src="../../../../.gitbook/assets/Screenshot 2025-09-10 at 4.02.15 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the index of the local variable in relation to the function scope.
---

# LocalVariable.index

## Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_name("communityMint")
    .exec(1)
  )

  for func in functions:
    local_vars = func.local_variables().list()
    for local_var in local_vars:
      print(local_var.source_code())
      print(local_var.index)

  return functions
```

## Example Output

<figure><img src="../../../../.gitbook/assets/Screenshot 2025-09-10 at 4.50.47 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the source code of the local variable.
---

# LocalVariable.source\_code()

`source_code() → str`

## Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_name("communityMint")
    .exec(1)
  )

  for func in functions:
    local_vars = func.local_variables().list()
    for local_var in local_vars:
      print(local_var.source_code())

  return functions
```

## Example Output

<figure><img src="../../../../.gitbook/assets/Screenshot 2025-09-10 at 4.52.00 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns parent function/modifier of the local variable.
---

# LocalVariable.get\_parent()

`get_parent() →` [`Callable`](../../../callable/)

## Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_name("communityMint")
    .exec(1)
  )

  for func in functions:
    local_vars = func.local_variables().list()
    for local_var in local_vars:
      print(local_var.get_parent())

  return functions
```

## Example Output

<figure><img src="../../../../.gitbook/assets/Screenshot 2025-09-10 at 4.03.52 PM.png" alt=""><figcaption></figcaption></figure>
---
description: The class represents a single local variable.
---

# LocalVariable

---
description: Returns the memory type of the local variable.
---

# LocalVariable.memory\_property

`property memory_type: str`

## Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_name("communityMint")
    .exec(1)
  )

  for func in functions:
    local_vars = func.local_variables().list()
    for local_var in local_vars:
      print(local_var.memory_type)

  return functions
```

## Example Output

<figure><img src="../../../../.gitbook/assets/Screenshot 2025-09-10 at 4.05.37 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns detailed information about the argument variable.
---

# ArgumentVariable.data

## Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .exec(1, 50)
  )

  for func in functions:
    args = func.arguments()
    print(args.list()[0].get_variable().data)
    
  return functions
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (35).png" alt=""><figcaption></figcaption></figure>

### Detailed Output

```json5
{
    'name': 'target',
    'canonical_name': 'Address.functionCallWithValue(address,bytes,uint256,string).target',
    'type': {
        'type': 'elementary',
        'name': 'address'
     }, 
     'memory_type': 'memory'
}
```
---
description: Returns the name of the variable.
---

# Variable.name

`property name: str`

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(5)
  )

  print(state_variables[0].name)

  return state_variables
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (9) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: Returns source code of variable
---

# Variable.source\_code()

`source_code() → str`

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(5)
  )

  print(state_variables[0].source_code())

  return state_variables
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

# Variables

---
description: Returns the canonical name of the variable.
---

# Variable.canonical\_name

`property canonical_name: str`

## Query Example

```python
from glider import *

def query():

  state_variables = (
    StateVariables()
    .exec(5)
  )

  print(state_variables[0].canonical_name)

  return state_variables
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (7) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: Returns the type of the variable.
---

# Variable.type

`property type: Type`

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(5)
  )

  print(state_variables[0].type)

  return state_variables
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the canonical name of the variable.
---

# Variable.data

`property data: Dict`

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(5)
  )

  print(state_variables[0].data)

  return state_variables
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (8) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

Data example

```json5
{
    '_key': '5e36c16804631f71358ec0d5ed734cb8',
    '_id': 'variables/5e36c16804631f71358ec0d5ed734cb8',
    '_rev': '_iaeY95G--_',
    'name': 'symbol',
    'canonical_name': 'REBITCOIN.symbol',
    'type': {
                'type': 'elementary',
                'name': 'string'
            },
    'visibility': 'public',
    'accessible': True,
    'is_constant': True,
    'is_immutable': False,
    'relative_filepath': 'REBITCOIN.sol',
    'first_source_line': 17,
    'last_source_line': 17,
    'start_column': 5,
    'end_column': 43
}
```
---
description: Returns the source code of the argument variable.
---

# ArgumentVariable.source\_code()

`source_code() → str`

## Query Example

```python
from glider import *

def query():
  functions = (
    Functions()
    .exec(1, 50)
  )

  for func in functions:
    args = func.arguments()
    print(args.list()[0].get_variable().source_code())

  return functions
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (38).png" alt=""><figcaption></figcaption></figure>

---
description: Returns the memory type of the argument variable.
---

# ArgumentVariable.memory\_type

`property memory_type: str`

## Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .exec(1, 50)
    )

  for func in functions:
    args = func.arguments()
    print(f"Memory type: {args.list()[0].get_variable().memory_type}")

  return functions
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (37).png" alt=""><figcaption></figcaption></figure>

---
description: >-
  Returns the position of the argument variable in the function signature. The
  index represents the argument variable's position, starting from 0.
---

# ArgumentVariable.index

`property data: Dict`

## Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .exec(1, 50)
  )

  for func in functions:
    args = func.arguments()
    print(f"Argument index: {args.list()[0].get_variable().index}")
    
  return functions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-10 at 4.54.58 PM.png" alt=""><figcaption></figcaption></figure>
---
description: This class represents a state variable.
---

# StateVariable

# StateVariables

---
description: Class that represents the properties of StateVariables
---

# StateVariableProp

Base: Enum

State Variable Properties:

* `CONSTANT: str = 'constant'`
* `IMMUTABLE: str = 'immutable'`
* `INTERNAL: str = 'internal'`
* `PRIVATE: str = 'private'`
* `PUBLIC: str = 'public'`
---
description: Returns state variable's parent contract if it exists.
---

# StateVariable.contract()

`contract() →` [`Contract`](../../../contract/) `|` [`NoneObject`](../../../internal/noneobject/)

## Query Example

```python
from glider import *


def query():
  return [
    state_var.contract()
    for state_var 
    in StateVariables().exec(10,10)
  ]
```

## Example Output

<figure><img src="../../../../.gitbook/assets/Screenshot 2024-09-23 at 18.59.20.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the visibility of the state variable is public, otherwise
  returns false.
---

# StateVariable.is\_public()

`is_public() → bool`

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(30)
    .filter(lambda state_variable: state_variable.is_public())
  )

  print(state_variables[0].source_code())

  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (4) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: Returns true if the state variable is immutable, otherwise returns false.
---

# StateVariable.is\_immutable()

`is_immutable() → bool`

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(175)
    .filter(lambda state_variable: state_variable.is_immutable())
  )

  print(state_variables[0].source_code())

  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: >-
  Returns true if the state variable is accessible in current contract,
  otherwise returns false. The state variable isn't accessible in current
  contract if it is a private inherited state variable
---

# StateVariable.is\_accessible()

`is_accessible() → bool`

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(5, 10)
    .filter(lambda state_variable: state_variable.is_accessible())
  )

  print(state_variables[0].source_code())

  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the source code of the state variable.
---

# StateVariable.source\_code()

`source_code() → str`

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(5)
  )

  for state_var in state_variables:
    print(state_var.source_code())

  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: Returns true if the state variable is constant, otherwise returns false.
---

# StateVariable.is\_constant()

`is_constant() → bool`

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(40)
    .filter(lambda state_variable: state_variable.is_constant())
  )

  print(state_variables[0].source_code())

  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the visibility of the state variable is internal, otherwise
  returns false.
---

# StateVariable.is\_internal()

`is_internal() → bool`

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(20)
    .filter(lambda state_variable: state_variable.is_internal())
  )

  print(state_variables[0].source_code())

  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: Returns the list of the state variable's properties.
---

# StateVariable.properties()

`properties() → List[str]`

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(1)
  )

  print(state_variables[0].properties())

  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>



---
description: >-
  Returns true if the visibility of the state variable is private, otherwise
  returns false.
---

# StateVariable.is\_private()

`is_private() → bool`

## Query Example&#x20;

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(20)
    .filter(lambda state_variable: state_variable.is_private())
  )

  print(state_variables[0].source_code())

  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: >-
  Adds a filter to get state variables that at least have one of the given
  properties.
---

# StateVariables.with\_one\_property()

`with_one_property(properties: List[`[`StateVariableProp`](../statevariableprop.md)`]) →` [`StateVariables`](./)

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .with_one_property([StateVariableProp.PRIVATE, StateVariableProp.PUBLIC])
    .exec(5)
  )

  print(state_variables[0].source_code())
  print(state_variables[1].source_code())

  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: The aim of this class is to filter state variables with some properties.
---

# StateVariables

---
description: Adds a filter to get state variables that have all given properties
---

# StateVariables.with\_all\_properties()

`with_all_properties(properties: List[`[`StateVariableProp`](../statevariableprop.md)`]) →` [`StateVariables`](./)

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .with_all_properties([StateVariableProp.CONSTANT, StateVariableProp.PUBLIC])
    .exec(10)
  )

  print(state_variables[0].source_code())

  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: Executes the formed query and returns the list of StateVariable objects.
---

# StateVariables.exec()

`exec(limit_count: int = 0, offset_count: int = 0) ->` [`APIList`](../../../iterables/apilist.md)`[`[`StateVariable`](../statevariable.md)`]`

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .exec(5, 5)
  )
  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (5) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get state variables with the given name
---

# StateVariable.with\_name()

`with_name(name: str, sensitivity: bool = True) →` [`StateVariables`](./)

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .with_name("owner")
    .exec(5)
  )

  print(state_variables[0].source_code())

  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: Adds a filter to get state variables that have the given type.
---

# StateVariables.with\_type()

`with_type(variable_type: str) →` [`StateVariables`](../)

## Query Example

```python
from glider import *


def query():
  state_variables = (
    StateVariables()
    .with_type("mapping(uint256 => uint256)")
    .exec(5)
  )

  print(state_variables[0].source_code())
  print(state_variables[1].source_code())

  return state_variables
```

## Example Output

<figure><img src="../../../../.gitbook/assets/image (6) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Modifiers.placeholder\_instructions()

`placeholder_instructions() →` [`Instructions`](../instructions/)

Returns placeholder [instructions](../instructions/) for the set of [Modifiers](../callables/modifiers/).

The placeholder or placer instruction is the "\_" (underline) instruction which defines where the function code must be inline in the modifier.

## Query Example

An example to retrieve the instructions used by the modifiers with the name `lock` is as below

```python
from glider import *
def query():
  instructionlist = Modifiers()\
      .with_name("lock")\
      .placer_instructions()\
      .exec(5,5)
  return instructionlist
```

## Example Output

<figure><img src="../../.gitbook/assets/image (100).png" alt=""><figcaption></figcaption></figure>
---
description: Filter modifiers satisfying the given expression
---

# Modifiers.with\_properties()

`with_properties(expr) ->`` ``Modifiers`

E.g: `expr = FunctionFilters.HAS_ARGS & ~FunctionFilters.HAS_ERRORS` `with_properties(expr)` will return modifiers that have arguments and don't return errors.

### Query Example

```python
from glider import *

def query():
    return (
        Modifiers()
        .with_properties(FunctionFilters.HAS_GLOBAL_VARIABLES_READ | FunctionFilters.HAS_ERRORS)
        .exec(10)
    )

```

### Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-10-09 at 12.55.54 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the values of the enum.
---

# Enum.values

_`property`_` ``value:`` `_`str`_

## Query Example

```python
from glider import *

def query():
    contracts = Contracts().exec(1, 71)

    contract = contracts[0]
    
    for enum in contract.enums().exec():
      for enum_value in enum.values:
        print(enum_value)

    return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-25 at 6.32.13 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the name of the enum.
---

# Enum.name

_`property`_` ``name:`` `_`str`_

## Query Example

```python
from glider import *

def query():
    contracts = Contracts().exec(1, 71)

    for enum in contracts[0].enums().exec():
      print(enum.name)

    return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-25 at 6.24.51 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the data of the enum.
---

# Enum.data

_`property`_` ``data:`` `_`Dict`_

## Query Example

```python
from glider import *

def query():
    contracts = Contracts().exec(1, 71)

    for enum in contracts[0].enums().exec():
      print(enum.data)

    return []
```

## Example Output

The following query will output the following enum data:

```json
{
    '_key': '1c509fde9e5a2a8dbd30759d4e24e81b', 
    '_id': 'enums/1c509fde9e5a2a8dbd30759d4e24e81b', 
    '_rev': '_jw0UR9m---', 
    'name': 'CollateralManagerErrors', 
    'min': 0, 
    'max': 10, 
    'values': [
        'NO_ERROR', 'NO_COLLATERAL_AVAILABLE', 'COLLATERAL_CANNOT_BE_LIQUIDATED', 
        'CURRRENCY_NOT_BORROWED', 'HEALTH_FACTOR_ABOVE_THRESHOLD', 
        'NOT_ENOUGH_LIQUIDITY', 'NO_ACTIVE_RESERVE', 
        'HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD', 
        'INVALID_EQUAL_ASSETS_TO_SWAP', 'FROZEN_RESERVE', 'PAUSED_RESERVE'
    ], 
    'relative_filepath': '0xa52E67Ae57E9A029a117145700a2E4514762498C_DefaultReserveInterestRateStrategy.sol', 
    'first_source_line': 565, 
    'last_source_line': 567, 
    'start_column': 3, 
    'end_column': 4, 
    'address': '0xa52E67Ae57E9A029a117145700a2E4514762498C'
}
```
---
description: The class represents a single enum object.
---

# Enum

---
description: Returns the minimum value of the enum.
---

# Enum.min

_`property`_` ``min:`` `_`int`_

## Query Example

```python
from glider import *

def query():
    contracts = Contracts().exec(1, 71)

    for enum in contracts[0].enums().exec():
      print(enum.min)

    return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-25 at 6.24.09 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the source code of the enum.
---

# Enum.source\_code()

`source_code() → str`

## Query Example

```python
from glider import *

def query():
    contracts = Contracts().exec(1, 95)

    for enum in contracts.enums().exec():
      print(enum.source_code())

    return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-25 at 6.30.39 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the maximum value of the enum.
---

# Enum.max

_`property`_` ``max:`` `_`int`_

## Query Example

```python
from glider import *

def query():
    contracts = Contracts().exec(1, 71)

    for enum in contracts[0].enums().exec():
      print(enum.max)

    return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-25 at 6.22.46 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the address of the enum.
---

# Enum.address

_`property`_` ``address:`` `_`str`_

## Query Example

```python
from glider import *

def query():
    contracts = Contracts().exec(1, 71)

    for enum in contracts[0].enums().exec():
      print(enum.address)

    return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-25 at 5.10.34 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns state variable's parent contract if it exists.
---

# StateVariable.contract()

`contract() →` [`Contract`](../contract/) `| NoneObject`

The function returns the Contract object (if exists, otherwise NoneObject) of the contract where the state variable is declared.

**Query Example**

```python
from glider import *
def query():
	state_vars = StateVariables().exec(1)
	print(state_vars[0].name())
	return [state_vars[0].contract()]
```

**Output**

```solidity
"root":{2 items
"contract":string"0xd705c24267ed3c55458160104994c55c6492dfcf"
"contract_name":string"Ownable"
},
"root":{1 item
"print_output":[1 item
    0:string"_owner"
    ]
}
```
---
description: >-
  Returns true if the visibility of the state variable is public, otherwise
  returns false.
---

# StateVariable.is\_public()

`is_public() → bool`

**Query Example**

```python
from glider import *
def query():
  state_vars = StateVariables().exec(100)
  for state_var in state_vars:
    if state_var.is_public():
      print(state_var.name())
      return [state_var.contract()]
  return []
```

**Output**

```solidity
"root":{2 items
"contract":string"0xd705c24267ed3c55458160104994c55c6492dfcf"
"contract_name":string"Token"
},
"root":{1 item
"print_output":[1 item
0:string"tradeOpen"
]
}
```
---
description: Returns true if the state variable is immutable, otherwise returns false.
---

# StateVariable.is\_immutable()

`is_immutable() → bool`

**Query Example**

```python
from glider import *
def query():
  state_vars = StateVariables().exec(100)
  for state_var in state_vars:
    if state_var.is_immutable():
      print(state_var.name())
      return [state_var.contract()]
  return []
```

**Output**

```solidity
"root":{2 items
"contract":string"0x5e6b2027f794a069bfa5e80195e22544d40ae600"
"contract_name":string"NATEHALLINAN"
},
"root":{1 item
"print_output":[1 item
0:string"uniswapV2Router"
]
}
```
---
description: This class represents a single state variable.
hidden: true
---

# StateVariable

---
description: Returns true if the state variable is constant, otherwise returns false.
---

# StateVariable.is\_constant()

`is_constant() → bool`

**Query Example**

```python
from glider import *
def query():
  state_vars = StateVariables().exec(10)
  for state_var in state_vars:
    if state_var.is_constant():
      print(state_var.name())
      return [state_var.contract()]
  return []
```

**Output**

```solidity
"root":{2 items
"contract":string"0xd705c24267ed3c55458160104994c55c6492dfcf"
"contract_name":string"Token"
},
"root":{1 item
"print_output":[1 item
    0:string"_decimals"
    ]
}
```
---
description: Returns the state variable's name.
---

# StateVariable.name()

`name() → str`

**Query Example**

```python
from glider import *
def query():
	state_vars = StateVariables().exec(3)
	for state_var in state_vars:
		print(state_var.name())
	return []
```

**Output**

```solidity
"root":{1 item
"print_output":[3 items
0:string"_owner"
1:string"_decimals"
2:string"uniswapV2Router"
]
}
```
---
description: >-
  Returns true if the visibility of the state variable is internal, otherwise
  returns false.
---

# StateVariable.is\_internal()

`is_internal() → bool`

**Query Example**

```python
from glider import *
def query():
  state_vars = StateVariables().exec(100)
  for state_var in state_vars:
    if state_var.is_internal():
      print(state_var.name())
      return [state_var.contract()]
  return []
```

**Output**

```solidity
"root":{2 items
"contract":string"0x23297ee054e8f600af482013ddbe856b7178a7d3"
"contract_name":string"LibBytesRichErrors"
},
"root":{1 item
"print_output":[1 item
0:string"INVALID_BYTE_OPERATION_ERROR_SELECTOR"
]
}
```
---
description: Returns the list of the state variable's properties.
---

# StateVariable.properties()

`properties() → List[StateVariableProp]`

**Query Example**

```python
from glider import *
def query():
	state_vars = StateVariables().exec(3)
	for state_var in state_vars:
		print(state_var.name())
		print(state_var.properties())
	return []
```

**Output**

```solidity
"root":{1 item
"print_output":[6 items
0:string"_owner"
1:string"['private']"
2:string"_decimals"
3:string"['private', 'constant']"
4:string"uniswapV2Router"
5:string"['private']"
]
}
```
---
description: >-
  Returns true if the visibility of the state variable is private, otherwise
  returns false.
---

# StateVariable.is\_private()

`is_private() → bool`

**Query Example**

```python
from glider import *
def query():
  state_vars = StateVariables().exec(100)
  for state_var in state_vars:
    if state_var.is_private():
      print(state_var.name())
      return [state_var.contract()]
  return []
```

**Output**

```solidity
"root":{2 items
"contract":string"0xd705c24267ed3c55458160104994c55c6492dfcf"
"contract_name":string"Ownable"
}
"root":{1 item
"print_output":[1 item
0:string"_owner"
]
}
```
---
description: >-
  Adds a filter to get contracts whose compilation version isn't in the given
  range.
---

# Contracts.with\_compiler\_range\_not()

`with_compiler_range_not(lower_bound: str, upper_bound: str) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_compiler_range_not("0.8.0", "0.8.11").exec(3)

  for contract in contracts:
    print(contract.pragmas())

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (53).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get contracts that do not have a function with the given
  signatures.
---

# Contracts.without\_function\_signatures()

---
description: Adds a filter to get contracts that have an event with the given signature.
---

# Contracts.with\_event\_signature()

`with_event_signature(signature: str) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_event_signature('Deposit(uint256,address)').exec(1)
  events = contracts[0].events()
  for event in events:
    print(event.signature)

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (57).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts that have a struct with the given field name.
---

# Contracts.with\_struct\_field\_name()

`with_struct_field_name(name: str, sensitivity: bool = True) →` [`Contracts`](./)



## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_struct_field_name('balance', sensitivity=False).exec(1)
  structs = contracts[0].structs().exec()
  for struct in structs:
    for struct_field in struct.fields:
      print(struct_field.name)
  
  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (62).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get contracts that have a function whose name has the given
  suffix.
---

# Contracts.with\_function\_name\_suffix()

---
description: Adds a filter to get contracts that have functions with all the given names.
---

# Contracts.with\_all\_function\_names()

`with_all_function_names(names: List[str], sensitivity: bool = True) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = (
    Contracts().
    non_interface_contracts().
    with_all_function_names(["transfer", "TransferFrom"], sensitivity=False).
    exec(1))

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (85).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get contracts that have an event whose name has the given
  prefix.
---

# Contracts.with\_event\_prefix()

`with_event_prefix(prefix: str, sensitivity: bool = True) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_event_prefix("role", sensitivity=False).exec(1)
  events = contracts[0].events()
  for event in events:
    print(event.signature)

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (56).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get contracts that have at least one function from the given
  names.
---

# Contracts.with\_one\_of\_the\_function\_names()

`with_one_of_the_function_names(names: List[str], sensitivity: bool = True) →` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_one_of_the_function_names(["deposit", "withdraw"]).exec(1,1)

  functions = contracts.functions().exec()
  for function in functions:
    print(function.name)

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts whose names have the given prefix.
---

# Contracts.with\_name\_prefix()

`with_name_prefix(`_`prefix: str, sensitivity: bool = True`_`) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():

  main_contracts = Contracts().with_name_prefix("Acc", sensitivity=True).exec(5)

  return main_contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (81).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the Functions object for the functions of the contracts.
---

# Contracts.functions()

`functions() →` [`Functions`](../callable/function/)

## Example Query

```python
from glider import *

def query():

  functions = Contracts().functions().exec(1)

  return functions
```

## Output Example

<figure><img src="../../.gitbook/assets/image (79).png" alt=""><figcaption></figcaption></figure>
---
description: The aim of this class is to filter contracts with some properties.
---

# Contracts

---
description: Adds a filter to get contracts that have an error with the given name.
---

# Contracts.with\_error\_name()

`with_error_name(name: str, sensitivity: boot = True) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_error_name("Invalid").exec(1)
  errors = contracts[0].errors().exec()
  for error in errors:
    print(error.signature)

  return contracts

```

## Output Example

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts associated with the given address.
---

# Contracts.with\_address()

## Query Example

```python
from glider import *


def query():
    return (
        Contracts()
        .with_address("0xdbEea69930D24988091b59f73B7898e7b0E9406F")
        .exec(1)
    )
    
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-17 at 12.49.44 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts that have a function with the given name.
---

# Contracts.with\_function\_name()

`with_function_name(name: str, sensitivity: bool = True) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_function_name('receive').exec(1)

  functions = contracts.functions().exec()
  for function in functions:
    print(function.name)

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get contracts that don't have any function with the given
  name.
---

# Contracts.with\_function\_name\_not()

`with_function_name_not(name: str, sensitivity: bool = True) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_function_name_not('transfer').exec(1,1)

  functions = contracts.functions().exec()
  for function in functions:
    print(function.name)

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (59).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get contracts that have an error whose name has the given
  suffix.
---

# Contracts.with\_error\_suffix()

`with_error_suffix(suffix: str, sensitivity: bool = True) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_error_suffix("admin", sensitivity=False).exec(1)
  errors = contracts[0].errors().exec()
  for error in errors:
    print(error.signature)

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (55).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts that are interface.
---

# Contracts.interface\_contracts()

`interface_contracts() →` [`Contracts`](../contract/)

## Example Query

```python
from glider import *

def query():

  interface = Contracts().interface_contracts().exec(1)

  return interface
```

## Output Example

<figure><img src="../../.gitbook/assets/image (80).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts that are not interface.
---

# Contracts.non\_interface\_contracts()

`non_interface_contracts() →` [`Contracts`](./)

## Query Example

```python
from glider import *


def query():
  non_interface_contracts = Contracts().non_interface_contracts().exec(5)

  return non_interface_contracts
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-14 at 1.29.00 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts whose names match the given regex.
---

# Contracts.with\_name\_regex()

`with_name_regex(`_`regex: str`_`) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():

  non_interface_contract = Contracts().with_name_regex('^[^I][^A-Z].*').exec(1)

  return non_interface_contract
```

## Output Example

<figure><img src="../../.gitbook/assets/image (82).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get contracts whose compilation version is in the given
  range.
---

# Contracts.with\_compiler\_range()

`with_compiler_range(lower_bound: str, upper_bound: str) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_compiler_range("0.4.20", "0.4.24").exec(3)

  for contract in contracts:
    print(contract.pragmas())

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts that are main.
---

# Contracts.mains()

`mains() →` [`Contracts`](./)

The engine marks the contract as main, that is the one being executed on the deployed address

## Query Example

```python
from glider import *

def query():

  main_contracts = Contracts().mains().exec(5)

  return main_contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (8) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts that have a struct with the given fields count.
---

# Contracts.with\_struct\_fields\_count()

`with_struct_fields_count(number: int) →` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = (
    Contracts()
    .with_name("DepositSecurityModule")
    .with_struct_fields_count(2)
    .exec(1))

  structs = contracts[0].structs().exec()
  for struct in structs:
    for struct_field in struct.fields:
      print(struct_field.type)
  
  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (64).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts that have a function with the given signature.
---

# Contracts.with\_function\_signature()

---
description: Adds a filter to get contracts with the given name.
---

# Contracts.with\_name()

`with_name(name: str, sensitivity: bool = True) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_name("Manager").exec(10)
  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (60).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts that have an error with the given signature.
---

# Contracts.with\_error\_signature()

`with_error_signature(signature: str) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_error_signature('InsufficientBalance(uint256,uint256)').exec(1)
  errors = contracts[0].errors().exec()
  for error in errors:
    print(error.signature)

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get contracts that have an error whose name has the given
  prefix.
---

# Contracts.with\_error\_prefix()

`with_error_prefix(prefix: str, sensitivity: bool = True) ->` [`Contracts`](./)

## Example Query

```python
from glider import *

def query():
  contracts = Contracts().with_error_prefix("Wrong").exec(1)
  errors = contracts[0].errors().exec()
  for error in errors:
    print(error.signature)

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get contracts that do not have a function with the given
  signature.
---

# Contracts.without\_function\_signature()

---
description: >-
  Adds a filter to get contracts that have an event whose name has the given
  suffix.
---

# Contracts.with\_event\_suffix()

`with_event_suffix(suffix: str, sensitivity: bool = True) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_event_suffix('validated').exec(1)
  events = contracts[0].events()
  for event in events:
    print(event.signature)

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (58).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts that have a struct with the given field type.
---

# Contracts.with\_struct\_field\_type()

`with_struct_field_type(field_type: str, sensitivity: bool = True) →` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = (
    Contracts()
    .with_name("DepositSecurityModule")
    .with_struct_field_type('bytes32')
    .exec(1))

  structs = contracts[0].structs().exec()
  for struct in structs:
    for struct_field in struct.fields:
      print(struct_field.type)
  
  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (63).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get contracts that have a function whose name matches the
  specified regex.
---

# Contracts.with\_function\_name\_regex()

# Contracts.with\_one\_of\_the\_function\_signatures()

---
description: Adds a filter to get contracts that names have the given suffix.
---

# Contracts.with\_name\_suffix()

`with_name_suffix(`_`suffix: str, sensitivity: bool = True`_`) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():

  prefix_contracts = Contracts().with_name_suffix("link", sensitivity=False).exec(1)

  return prefix_contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (83).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get contracts that have an error whose name matches the given
  regex.
---

# Contracts.with\_error\_regex()

`with_error_regex(regex: str) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_error_regex('^Err.*').exec(1)
  errors = contracts[0].errors().exec()
  for error in errors:
    print(error.signature)

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (54).png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts that don't have the given name.
---

# Contracts.with\_name\_not()

`with_name_not(name: str, sensitivity: bool = True) →` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_name_not("Ownable").exec(10)
  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (61).png" alt=""><figcaption></figcaption></figure>

---
description: Adds a filter to get contracts that have a struct with the given name.
---

# Contracts.with\_struct\_name()

`with_struct_name(name: str, sensitivity: bool = True) →` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = (
    Contracts()
    .with_struct_name("User")
    .exec(1))

  structs = contracts[0].structs().exec()
  for struct in structs:
      print(struct.name)
  
  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (65).png" alt=""><figcaption></figcaption></figure>

---
description: >-
  Adds a filter to get contracts that have all functions with the given
  signatures.
---

# Contracts.with\_all\_function\_signatures()

---
description: >-
  Adds a filter to get contracts that have an event whose name matches the given
  regex.
---

# Contracts.with\_event\_regex()

`with_event_regex(regex: str) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_event_regex('^change.*').exec(1)
  events = contracts[0].events()
  for event in events:
    print(event.signature)

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get contracts that have a function whose name has the given
  prefix.
---

# Contracts.with\_function\_name\_prefix()

---
description: Executes the formed query and returns the list of Contract objects.
---

# Contracts.exec()

`exec(`_`limit_count: int = 0, offset_count: int = 0`_`) ->` [`APIList`](../iterables/apilist.md)`[`[`Contract`](../contract/)`]`

## Example Query 1

```python
from glider import *

def query():
  contracts = Contracts().exec(3)

  return contracts
```

## Output Example 1

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

## Example Query 2

```python
from glider import *

def query():
  contracts = Contracts().exec(1, 2)

  return contracts
```

## Output Query 2

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the State Variables object for the state variables of the contracts.
---

# Contracts.state\_variables()

`state_variables() →` [`StateVariables`](../statevariables/)

## Query Example

```python
from glider import *


def query():
    state_variables = (
        Contracts()
        .with_name("Manager")
        .exec(1)
        .state_variables()
        .exec()
    )

    return state_variables
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-17 at 11.03.22 AM.png" alt=""><figcaption></figcaption></figure>
---
description: Adds a filter to get contracts that have an event with the given name.
---

# Contracts.with\_event\_name()

`with_event_name(name: str, sensitivity: bool = True) ->` [`Contracts`](./)

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().with_event_name('Modified').exec(1)
  events = contracts[0].events()
  for event in events:
    print(event.signature)

  return contracts
```

## Output Example

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns parent function/modifier of the argument.
---

# Argument.get\_parent()

`get_parent() →` [`Callable`](../callable/)

## Example Query

```python
from glider import *
def query():
    func = (Contracts()
    .with_name('Pair')
    .non_interface_contracts()
    .functions()
    .with_arg_count(1)
    .exec(1)[0])
    arg = func.arguments().list()[0]
    
    print(arg.source_code())
    print(arg.get_parent().source_code())
    return []
```

## Output Example

```solidity
"root":{1 item
"print_output":[2 items
0:string"uint256 tokenId"
1:string"function withdraw(uint256 tokenId) public {
        // check that the sender is the caviar owner
        require(caviar.owner() == msg.sender, "Withdraw: not owner");

        // check that the close period has been set
        require(closeTimestamp != 0, "Withdraw not initiated");

        // check that the close grace period has passed
        require(block.timestamp >= closeTimestamp, "Not withdrawable yet");

        // transfer the nft to the caviar owner
        ERC721(nft).safeTransferFrom(address(this), msg.sender, tokenId);

        emit Withdraw(tokenId);
    }"
]
}
```
---
description: >-
  Returns the list of pairs, where the first element is the function and the
  second element is the argument number from which data flow reaches the
  argument (it may reach through a chain of calls).
---

# Argument.df\_reaches\_from\_functions\_arguments()

`df_reaches_from_functions_arguments() → List[Tuple[`[`Callable`](../callable/)`, int]]`

```python
from glider import *
def query():
    func = Contracts().non_interface_contracts().functions().with_arg_count(1).exec(1)[0]
    arg = func.arguments().list()[0]
    
    results = [func]
    for (f, arg_index) in arg.df_reaches_from_functions_arguments():
        results.append(f)
        print(f.source_code() + '\n\n'+str(arg_index))
    return results
```

For the argument **account** of the function **balanceOf**:

```solidity
function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }
```

The query will return:

`[(_transfer, 1), .... ]`

```json
"root":{3 items
"contract":string"0xd705c24267ed3c55458160104994c55c6492dfcf"
"contract_name":string"Token"
"sol_function":solidity
function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }
}
"root":{3 items
"contract":string"0xd705c24267ed3c55458160104994c55c6492dfcf"
"contract_name":string"Token"
"sol_function":solidity
function _transfer(address from, address to, uint256 amount) private {
        uint256 taxAmount=0;
        if (!_isExcludedFromFee[from] && !_isExcludedFromFee[to]) {
            require(tradeOpen, "Trading not open");
            taxAmount = amount.mul((_buyCount>_reduceBuyTaxAt)?_finalBuyTax:_initialBuyTax).div(100);

            if (from == uniswapV2Pair && to != address(uniswapV2Router)) {
                require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the limit");
                _buyCount++;
            }

            if (to != uniswapV2Pair) {
                require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the limit");
            }

            if(to == uniswapV2Pair && from!= address(this) ){
                taxAmount = amount.mul((_buyCount>_reduceSellTaxAt)?_finalSellTax:_initialSellTax).div(100);
            }

            uint256 contractTokenBalance = balanceOf(address(this));
            if (!inSwap && to == uniswapV2Pair && swapEnabled && contractTokenBalance>_taxSwapThreshold) {
                swapTokensForEth(min(amount,min(contractTokenBalance,_maxTaxSwap)));
                uint256 contractETHBalance = address(this).balance;
                if(contractETHBalance > 0) {
                    sendETHToFee(address(this).balance);
                }
            }
        }

        if(taxAmount>0){
          _balances[address(this)]=_balances[address(this)].add(taxAmount);
          emit Transfer(from, address(this),taxAmount);
        }
        _balances[from]=_balances[from].sub(amount);
        _balances[to]=_balances[to].add(amount.sub(taxAmount));
        emit Transfer(from, to, amount.sub(taxAmount));
    }
}
...
```

As you can see the `address to` argument flows into multiple calls to `balanceOf(to)`**,** like:

```solidity
require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the limit");
```

Returns Type: List\[Tuple\[[Callable](../callable/), int]]
---
description: >-
  Returns a list of all instructions following the current point in the current
  data flow graph.
---

# Argument.forward\_df()

`forward_df() → List[`[`Instruction`](../instruction/)`]`

## Example Query

```python
from glider import *
def query():
    func = Contracts().non_interface_contracts().functions().with_arg_count(1).exec(1, 1)[0]
    instrs = []
    for ins in func.arguments().list()[0].forward_df():
        instrs.append(ins)
    return instrs
```

## Output Example

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-23 at 12.32.45 PM.png" alt=""><figcaption></figcaption></figure>
# Argument.procedure\_graph\_node

---
description: The class represents a single argument.
hidden: true
---

# Argument

---
description: Returns the memory type of the argument
---

# Argument.memory\_type

_`property`_` ``memory_type:`` `_`str`_

## Query Example

```python
from glider import *


def query():
  functions = Functions().with_arg_count(2).exec(100)
 
  for f in functions:
    for arg in f.arguments().list():
        print(f"Argument: {arg.get_variable().name} - {arg.get_variable().memory_type}")

  return []
```

## Output Example

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-23 at 6.03.31 PM (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the type of the argument.
---

# Argument.type

_`property`_` ``type`_`: Type`_

## Query Example

```python
from glider import *


def query():
  functions = Functions().with_arg_count(2).exec(100)
 
  for f in functions:
    for arg in f.arguments().list():
        print(f"Argument type: {arg.get_variable().type}")

  return []
```

## Output Example

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-23 at 6.03.31 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a list of all previous instructions/arguments of the current point in
  the data flow graph. Intraprocedural
---

# Argument.backward\_df()

`backward_df() → List[Point]`

As Argument has no intraprocedural backward dataflow, this function solely exists to comply with the glider architecture, but if used will return an empty list

```python
from glider import *
def query():
    func = Contracts().non_interface_contracts().functions().with_arg_count(1).exec(1)[0]
    for ins in func.arguments().list()[0].backward_df():
        print(ins.source_code())
    return [func]
```

```json
"root":{3 items
"contract":string"0xd705c24267ed3c55458160104994c55c6492dfcf"
"contract_name":string"Token"
"sol_function":solidity
function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }
}
```
---
description: >-
  Returns the list of pairs, where the first element is the function and the
  second element is the argument to which data flow reaches from the argument
  (it may reach through a chain of calls).
---

# Argument.df\_reaching\_functions\_arguments()

`df_reaching_functions_arguments() → List[Tuple[`[`Callable`](../callable/)`, int]]`

```python
from glider import *


def query():
    func = Contracts().with_name('LendingPool').non_interface_contracts().functions().with_arg_count(5).exec(1)

    arg = func.arguments().list()[0]
    
    results = [func]
    for (f, arg_index) in arg.df_reaching_functions_arguments():
        results.append(f)
        print(f.source_code() + '\n\n'+str(arg_index))
    return func
```

For the argument `uint256 lpTokenAmount` in the function `nftRemove` at address 0xf792e438b3bd8501274d98a58d19f2777cacd9f6

```solidity
function nftRemove(
        uint256 lpTokenAmount,
        uint256 minBaseTokenOutputAmount,
        uint256 deadline,
        uint256[] calldata tokenIds,
        bool withFee
    ) public returns (uint256 baseTokenOutputAmount, uint256 fractionalTokenOutputAmount) {
        // remove liquidity and send fractional tokens and base tokens to sender
        (baseTokenOutputAmount, fractionalTokenOutputAmount) =
            remove(lpTokenAmount, minBaseTokenOutputAmount, tokenIds.length * ONE, deadline);
 
        // unwrap the fractional tokens into NFTs and send to sender
        unwrap(tokenIds, withFee);
    }
```

The function will return tuples like this:

`[(removeQuote, 0), (remove, 0),...]`



```solidity
"root":{3 items
"contract":string"0xf792e438b3bd8501274d98a58d19f2777cacd9f6"
"contract_name":string"Pair"
"sol_function":solidity
function removeQuote(uint256 lpTokenAmount) public view returns (uint256, uint256) {
        uint256 lpTokenSupply = lpToken.totalSupply();
        uint256 baseTokenOutputAmount = (baseTokenReserves() * lpTokenAmount) / lpTokenSupply;
        uint256 fractionalTokenOutputAmount = (fractionalTokenReserves() * lpTokenAmount) / lpTokenSupply;
        uint256 upperFractionalTokenOutputAmount = (fractionalTokenReserves() * (lpTokenAmount + 1)) / lpTokenSupply;
 
        if (
            fractionalTokenOutputAmount % 1e18 != 0
                && upperFractionalTokenOutputAmount - fractionalTokenOutputAmount <= 1000 && lpTokenSupply > 1e15
        ) {
            fractionalTokenOutputAmount = upperFractionalTokenOutputAmount;
        }
 
        return (baseTokenOutputAmount, fractionalTokenOutputAmount);
    },
    
    
    function remove(
        uint256 lpTokenAmount,
        uint256 minBaseTokenOutputAmount,
        uint256 minFractionalTokenOutputAmount,
        uint256 deadline
    ) public returns (uint256 baseTokenOutputAmount, uint256 fractionalTokenOutputAmount) {
        // *** Checks *** //
 
        // check that the trade has not expired
        require(deadline == 0 || deadline >= block.timestamp, "Expired");
 
        // calculate the output amounts
        (baseTokenOutputAmount, fractionalTokenOutputAmount) = removeQuote(lpTokenAmount);
 
        // check that the base token output amount is greater than the min amount
        require(baseTokenOutputAmount >= minBaseTokenOutputAmount, "Slippage: base token amount out");
 
        // check that the fractional token output amount is greater than the min amount
        require(fractionalTokenOutputAmount >= minFractionalTokenOutputAmount, "Slippage: fractional token out");
 
        // *** Effects *** //
 
        // transfer fractional tokens to sender
        _transferFrom(address(this), msg.sender, fractionalTokenOutputAmount);
 
        // *** Interactions *** //
 
        // burn lp tokens from sender
        lpToken.burn(msg.sender, lpTokenAmount);
 
        if (baseToken == address(0)) {
            // if base token is native ETH then send ether to sender
            msg.sender.safeTransferETH(baseTokenOutputAmount);
        } else {
            // transfer base tokens to sender
            ERC20(baseToken).safeTransfer(msg.sender, baseTokenOutputAmount);
        }
 
        emit Remove(baseTokenOutputAmount, fractionalTokenOutputAmount, lpTokenAmount);
    },
    
    ...
```

As can be seen, the argument flows into function calls like:

<pre class="language-solidity"><code class="lang-solidity">remove(lpTokenAmount, minBaseTokenOutputAmount, tokenIds.length * ONE, deadline);

<strong>---> and inside remove():
</strong>
        (baseTokenOutputAmount, fractionalTokenOutputAmount) = removeQuote(lpTokenAmount);
...
</code></pre>

Returns: List\[Tuple\[[Callable](../callable/), int]]
---
description: Returns the Variable representing the argument.
---

# Argument.get\_variable()

`get_variable() ->` [`Variable`](../variable/)

## Example Query

```python
from glider import *


def query():
    func = Contracts().non_interface_contracts().functions().with_arg_count(1).exec(1, 1)[0]
    
    print(func.arguments().list()[0].get_variable())

    return []
```

## Output Example

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-23 at 12.56.50 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the name of the argument.
---

# Argument.name

_`property`_` ``name`_`: str`_

## Query Example

```python
from glider import *


def query():
  functions = Functions().with_arg_count(2).exec(100)
 
  for f in functions:
    for arg in f.arguments().list():
        print(f"Argument: {arg.get_variable().name}")

  return []
```

## Output Example

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-23 at 6.18.11 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the index of the argument.
---

# Argument.index

_`property`_` ``index`_`: int`_

## Query Example

```python

from glider import *


def query():
  functions = Functions().with_arg_count(5).exec(1)

  function_with_args = []
  for f in functions:
    # For each of its arguments...
    for arg in f.arguments().list():
        # ...return the data of the argument
        print(arg.source_code() + '\n\n' + str(arg.index))

  return functions
```

## Example Output

```solidity
"root":{3 items
"contract":string"0xd705c24267ed3c55458160104994c55c6492dfcf"
"contract_name":string"IUniswapV2Router02"
"sol_function":solidity
function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
},
"root":{1 item
        "print_output":[5 items
        0:string"uint256 amountIn
        
        0"
        1:string"uint256 amountOutMin
        
        1"
        2:string"address[] path
        
        2"
        3:string"address to
        
        3"
        4:string"uint256 deadline
        
        4"
        ]
}
```
---
description: Returns the internal data of the Argument
---

# Argument.data

_`property`_` ``data`

It contains the name, canonical\_name, type, and memory\_type of the Argument.

```python
from glider import *


def query():
  functions = Functions().with_arg_count(2).exec(100)
 
  for f in functions:
    for arg in f.arguments().list():
        print(f"Argument: {arg.get_variable().data}")

  return []
```

## Output Example

In the query above, the `data` property will return:

```python
{
    'name': 'recipient', 
    'canonical_name': 'IERC20.transfer(address,uint256).recipient', 
    'type': {
        'type': 'elementary', 
        'name': 'address'
    }, 
    'memory_type': 'memory'
}
```
---
description: Returns the source code of the argument.
---

# Argument.source\_code()

`source_code() → str`

## Query Example

```python
from glider import *

def query():
  functions = Functions().exec(100)

  for f in functions:
    for arg in f.arguments().list():
      print(f"Argument Source code: {arg.source_code()}")

  return []
```

## Output Example

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-23 at 5.29.15 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the name of the event.
---

# Event.address

_`property`_` ``address:`` `_`str`_

## Query Example

```python
from glider import *


def query():
  # Find contracts with the suffix "ERC20"
  contracts = Contracts().with_name_suffix("ERC20").exec(100)

  for c in contracts:
    for event in c.events().exec():
      # For each contract's event, print the event address
      print(event.address)

  return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-14 at 1.44.23 PM.png" alt=""><figcaption></figcaption></figure>
---
description: The class represents a single event object
---

# Event

---
description: Returns the source code of the event.
---

# Event.source\_code()

`source_code() → str`

## Query Example

```python
from glider import *


def query():
  # Find contracts with the suffix "ERC20"
  contracts = Contracts().with_name_suffix("ERC20").exec(100)

  for c in contracts:
    for event in c.events().exec():
      # For each contract's event, print the event address
      print(event.source_code())

  return []
```

## Output Example

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-14 at 1.46.50 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the signature of the event.
---

# Event.signature

_`property`_` ``signature:`` `_`str`_

## Example

```python
from glider import *


def query():
  # Find contracts with the suffix "ERC20"
  contracts = Contracts().with_name_suffix("ERC20").exec(100)

  for c in contracts:
    for event in c.events().exec():
      # For each contract's events, print the event signature
      print(event.signature)

  return []
```

## Example output

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-14 at 1.46.31 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns arguments' types of the event.
---

# Event.arg\_list()

`arg_list() → List[str]`

## Example query

```python
from glider import *


def query():
  # Find contracts with an event called "Transfer"
  contracts = Contracts().with_event_name('Transfer').exec(100)

  for contract in contracts:
    for event in contract.events().exec():
      if event.name == "Transfer":
        # For each "Transfer" event in every single contract, print its arguments
        print(event.arg_list())

  return []
```

## Output Example

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-14 at 1.45.08 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the data of the event.
---

# Event.data

_`property`_` ``data:`` `_`Dict`_

## Example query

```python
from glider import *


def query():
  # Find contracts with an event called "Transfer"
  contracts = Contracts().with_event_name('Transfer').exec(1)

  for contract in contracts:
    for event in contract.events().exec():
      if event.name == "Transfer":
        # For each "Transfer" event in every single contract, return its data
        print(event.data)

  return []
```

## Output Example

Example output of event data:

```json
{
    '_key': '82fac7da92cf739a6ee2c8b9622dae09', 
    '_id': 'events/82fac7da92cf739a6ee2c8b9622dae09', 
    '_rev': '_jw0UR2----', 
    'name': 'Transfer', 
    'signature': 'Transfer(address,address,uint256)', 
    'selector': 3723645613, 
    'args': [
        {
            'name': 'from', 
            'type': {
                'type': 'elementary', 
                'name': 'address'
            }, 
            'indexed': True
        }, {
            'name': 'to', 
            'type': {
                'type': 'elementary', 
                'name': 'address'
            }, 
            'indexed': True
        }, {
            'name': 'rawAmt', 
            'type': {
                'type': 'elementary', 
                'name': 'uint256'
            }, 
            'indexed': False
        }
    ], 
    'relative_filepath': '0x956ba4b0a0ad5642d39be1ac87eab1af2863fcca_Datagold.sol', 
    'first_source_line': 29, 
    'last_source_line': 29, 
    'start_column': 5, 
    'end_column': 73, 
    'address': '0x956ba4b0a0ad5642d39be1ac87eab1af2863fcca'
}
```
---
description: Returns the name of the event.
---

# Event.name

_`property`_` ``name:`` `_`str`_

## Example

```python
from glider import *


def query():
  # Find contracts with the suffix "ERC20"
  contracts = Contracts().with_name_suffix("ERC20").exec(100)

  for c in contracts:
    for event in c.events().exec():
      # For each contract's event, print the event name
      print(event.name)

  return []
```

## Example output

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-14 at 1.45.08 PM (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the modifier's properties.
---

# Modifier.properties()

`properties() →` [`APIList`](../iterables/apilist.md)`[`[`MethodProps`](../callables/methodprop/)`]`

## Query Example

```python
from glider import *

def query():
  # Fetch a list of modifiers
  modifiers = Modifiers().exec(1)

  # Retrieve the properties of the first modifier
  properties = modifiers[0].properties()
  for prop in properties:
    print(prop)

  return modifiers
```

## Output Example

<figure><img src="../../.gitbook/assets/image (99).png" alt=""><figcaption></figcaption></figure>
# Modifier.placeholder\_instructions()

`placeholder_instructions() →` [`Instructions`](../instructions/)

Returns placeholder [instructions](../instruction/) of the [modifier](../callable/modifier/).

The placeholder or placer instruction is the "\_" (underline) instruction which defines where the function code must be inline in the modifier.

## Return type

→ List\[[Instruction](../instruction/)]

An example of a query which can analyze placeholder instructions is:

```python
from glider import *

def query():
  modifierlist = (
      Modifiers()
      .with_name_prefix("lock")
      .exec(3)
  )
  
  results =  []

  for modd in modifierlist:
    for placers in modd.placeholder_instructions().exec():
      results.append(placers)

  return results
```

## Output

<figure><img src="../../.gitbook/assets/image (98).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the list of ArgumentPoints having specified name.
---

# ArgumentPoints.with\_name()

`with_name(arg_name: str, sensitivity: bool = False) →` [`APIList`](../../iterables/apilist.md)`[`[`ArgumentPoint`](../argumentpoint.md)`]`

## Query Example

```python
from glider import *


def query():
    functions = (
        Functions()
        .with_name("transfer")
        .exec(1)
    )

    arguments = functions[0].arguments()

    print(arguments.with_name("_amount").source_code())

    return functions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (11) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: 'Base class: object'
---

# ArgumentPoints

The class represents the list of ArgumentPoints.
---
description: Returns the list of ArgumentPoints having specified type.
---

# ArgumentPoints.with\_type()

`with_type(arg_type: str) →` [`APIList`](../../iterables/apilist.md)`[`[`ArgumentPoint`](../argumentpoint.md)`]`

## Query Example

```python
from glider import *


def query():
    functions = (
        Functions()
        .with_name("transferFrom")
        .exec(1)
    )

    arguments = functions[0].arguments()

    print(arguments.with_type("address").source_code())

    return functions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (12) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: Returns the list of ArgumentPoints having specified memory type.
---

# ArgumentsPoints.with\_memory\_type()

`with_memory_type(memory_type: str) →` [`APIList`](../../iterables/apilist.md)`[`[`ArgumentPoint`](../argumentpoint.md)`]`

## Query Example

```python
from glider import *


def query():
    functions = (
        Functions()
        .with_name("observe")
        .exec(1)
    )

    arguments = functions[0].arguments()

    print(arguments.with_memory_type("calldata").source_code())

    return functions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (10) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>



---
description: Convert ArgumentPoints to List[ArgumentPoint]
---

# ArgumentPoints.list()

`list() ->` [`APIList`](../../iterables/apilist.md)`[`[`ArgumentPoint`](../argumentpoint.md)`]`

## Query Example

```python
from glider import *


def query():
    functions = (
        Functions()
        .with_name("transferFrom")
        .exec(1)
    )

    arguments = functions[0].arguments()
    print(f"Arguments: {arguments}")
    print(f"List of arguments: {arguments.list()}")

    return functions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (33).png" alt=""><figcaption></figcaption></figure>
---
description: 'Base class: ExternalPoint'
---

# StatePoint

This class inherits from ExternalPoint and represents a specific instance of a state point, encapsulating a single state variable associated with a function or modifier.

---
description: Returns whether the object depends on any of its function's arguments.
---

# VarValue.is\_depending\_on\_any\_argument()

## Query Example

```python
from glider import *


def query():
  instructions = (
    Functions()
    .with_name("insertAccountProfile")
    .exec(1)
    .instructions()
    .exec()
  )

  for instruction in instructions:
    components = instruction.get_components()
    for component in components:
      if isinstance(component, VarValue):
        depend_on_argument = component.is_depending_on_any_argument()
        if depend_on_argument:
          print(component.expression)
          print(instruction.source_code())
        
  return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-10 at 2.38.32 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the list of all previous points of the current point in the current
  data flow graph and outside of that.
---

# VarValue.backward\_df\_recursive()

`backward_df_recursive() →` [`APISet`](../../iterables/apiset.md)`[`[`Point`](../point/)`]`

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1, 187)

  for instruction in instructions:
    components = instruction.get_components()
    for component in components:
      points = component.backward_df_recursive()
      print(points)
      for backward_df in points:
        print(backward_df.source_code())

  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (15) (1) (1).png" alt=""><figcaption></figcaption></figure>

To clarify, what is the difference between `backward_df` and `backward_df_recursive`? `backward_df_recursive` operates recursively. Below is the output when `backward_df` was used instead of `backward_df_recursive` :

<figure><img src="../../../.gitbook/assets/image (16) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: 'Base class: Value, Point'
---

# VarValue

---
description: >-
  Returns the list of all points following the current point in the current data
  flow graph and outside of that.
---

# VarValue.forward\_df\_recursive()

`forward_df_recursive() →` [`APISet`](../../iterables/apiset.md)`[`[`Point`](../point/)`]`

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1, 611)

  for instruction in instructions:
    components = instruction.get_components()
    for component in components:
      if isinstance(component, VarValue):
        points = component.forward_df_recursive()
        for forward_df in points:
          print(forward_df.source_code())

  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (18) (1).png" alt=""><figcaption></figcaption></figure>

To clarify, what is the difference between `forward_df` and `forward_df_recursive`? `forward_df_recursive` operates recursively. Below is the output when `forward_df` was used instead of `forward_df_recursive` :

<figure><img src="../../../.gitbook/assets/Screenshot 2024-09-26 at 15.30.52.png" alt=""><figcaption></figcaption></figure>
---
description: Returns parent function/modifier of the variable.
---

# VarValue.get\_parent()

`get_parent() →` [`Callable`](../../callable/)

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1, 2)

  for instruction in instructions:
    components = instruction.get_components()
    for component in components:
      if isinstance(component, VarValue):
        parent = component.get_parent()
        print(parent)
        
  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (20) (1).png" alt=""><figcaption></figcaption></figure>

---
description: Returns the points which define the variable.
---

# VarValue.get\_defining\_points()

`get_defining_points() →` [`APIList`](../../iterables/apilist.md)`[`[`Point`](../point/)`]`

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1, 2)

  for instruction in instructions:
    components = instruction.get_components()
    for component in components:
      if isinstance(component, VarValue):
        defining_points = component.get_defining_points()
        print(defining_points)
        if len(defining_points):
          print(defining_points[0].source_code())

  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (19) (1).png" alt=""><figcaption></figcaption></figure>

---
description: >-
  Returns the list of all points following the current point in the current data
  flow graph.
---

# VarValue.forward\_df()

`forward_df() →` [`APISet`](../../iterables/apiset.md)`[`[`Point`](../point/)`]`

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1, 611)

  for instruction in instructions:
    components = instruction.get_components()
    for component in components:
      if isinstance(component, VarValue):
        points = component.forward_df()
        print(points)
        for forward_df in points:
          print(forward_df.source_code())

  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (17) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns corresponding object of the variable.
---

# VarValue.get\_object\_of\_var()

`get_object_of_var() →` [`LocalVariable`](../../variables/localvariables/localvariable/) `|` [`StateVariable`](../../variables/statevariables/statevariable.md) `|` [`ArgumentVariable`](../../variables/argumentvariables.md) `|` [`GlobalVariable`](../../variables/globalvariables.md) `|` [`NoneObject`](../../internal/noneobject/)

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1, 2)

  for instruction in instructions:
    components = instruction.get_components()
    for component in components:
      if isinstance(component, VarValue):
        var_object = component.get_object_of_var()
        print(var_object)
        print(var_object.source_code())

  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: Returns the variable's type.
---

# VarValue.type

property type: Type

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1, 2)

  for instruction in instructions:
    components = instruction.get_components()
    for component in components:
      if isinstance(component, VarValue):
        var_value_type = component.type 
        print(var_value_type)

  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (21) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the list of all previous points of the current point in the data flow
  graph.
---

# VarValue.backward\_df()

`backward_df() →` [`APISet`](../../iterables/apiset.md)`[`[`Point`](../point/)`]`

## Query Example

```python
from glider import *


def query():
  instrucitons = (
    Instructions()
    .exec(1,30)
  )

  for instruciton in instrucitons:
    components = instruciton.get_components()
    for component in components:
      for backward_df in component.backward_df():
        print(backward_df.source_code())

  return instrucitons
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (14) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: Return object of argument variable
---

# ArgumentPoint.get\_variable()

`get_variable() →` [`ArgumentVariable`](../../variables/argumentvariables.md)

## Query Example

```python
from glider import *

def query():
    functions = (
        Functions()
        .with_name("transferFrom")
        .exec(1)
    )

    arguments = functions[0].arguments()

    print(arguments.with_type("address")[0].get_variable())
    print(arguments.with_type("address")[0].get_variable().source_code())


    return functions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (13) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: 'Base class: ExternalPoint'
---

# GlobalPoint

This class inherits from ExternalPoint and represents a specific instance of a global point, encapsulating a single global variable associated with a function or modifier.
# Point

---
description: Method that returns object of variable
---

# StatePoint.get\_variable()

`get_variable() →` [`StateVariable`](../../variables/statevariables/statevariable.md)

## Query Example

```python
from glider import *


def query():
    instructions = (
        Functions()
        .with_name("latestRoundData")
        .exec(1)
        .instructions()
        .exec()
    )

    for instruction in instructions:
      for df in instruction.get_components():
        if isinstance(df, VarValue):
          for state_point in df.get_defining_points():
            print(state_point.get_variable())
 

    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-10 at 1.55.48 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Abstract method that returns object of variable
---

# GlobalPoint.get\_variable()

`get_variable() →` [`GlobalVariable`](../../variables/globalvariables.md)

## Query Example

```python
from glider import *


def query():
    instructions = (
        Functions()
        .with_name("_msgSender")
        .exec(1)
        .instructions()
        .exec()
    )

    dfs = instructions.backward_df()
    for df in dfs:
      print(df.get_variable())
      print(df.source_code())

    return instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-10 at 10.52.07 AM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns all tainted sources that influence the point. This includes not only
  tainted sources within the current function but also extends to sources
  belonging to other functions.
---

# Point.get\_tainted\_sources\_affecting\_point()

`get_tainted_sources_affecting_point() →` [`APISet`](../../iterables/apiset.md)`[`[`Point`](./)`]`

Returns A set of tainted sources that affect the point.

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1,1)

  affected_points = instructions[0].get_tainted_sources_affecting_point()
  print(affected_points)
  for point in affected_points:
    print(point.source_code())
  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (32).png" alt=""><figcaption></figcaption></figure>



---
description: >-
  Returns the list of pairs, where the first element is the function and the
  second element the argument number from which data flow reaches to the point
  (it may reach through a chain of calls).
---

# Point.df\_reaches\_from\_functions\_arguments()

`df_reaches_from_functions_arguments() →` [`APIList`](../../iterables/apilist.md)`[Tuple[`[`Callable`](../../callable/)`, int]]`

## Query Example

```python
from glider import *

def query():
  instructions = Instructions().exec(1, 77)
  
  for ins in instructions:
    reaching_points = ins.df_reaches_from_functions_arguments()
    for reaching_point in reaching_points:
      print(f"Point: {reaching_point[0].source_code()} | Argument index {reaching_point[1]}")
  
  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Here is a more detailed output

```solidity
Point: 
constructor(bytes memory _a, bytes memory _data) payable {
        (address _as) = abi.decode(_a, (address));
        assert(KEY == bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1));
        require(Address.isContract(_as), "address error");
        StorageSlot.getAddressSlot(KEY).value = _as;
        if (_data.length &gt; 0) {
            Address.functionDelegateCall(_as, _data);
        }
}
ArgumentIndex: 0
```
---
description: >-
  Returns the first encountered path containing tainted data that influence the
  point, if it exists. Otherwise, returns an empty tuple.
---

# Point.get\_tainted\_path\_affecting\_point()

Returns a path containing tainted data that affect the point.

`get_tainted_path_affecting_point() →` [`APITuple`](../../iterables/apituple.md)`[`[`Point`](./)`]`

## Note

This path can include points belonging to other functions.

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1,1)

  affected_points = instructions[0].get_tainted_path_affecting_point()
  print(affected_points)
  for point in affected_points:
    print(point.source_code())
  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (31).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the list of pairs, where the first element is the function and the
  second element is the argument to which data flow reaches from the point (it
  may reach through a chain of calls).
---

# Point.df\_reaching\_functions\_arguments()

`df_reaching_functions_arguments() →` [`APIList`](../../iterables/apilist.md)`[Tuple[`[`Callable`](../../callable/)`, int]]`

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1, 77)
  
  for ins in instructions:
    reaching_points = ins.df_reaching_functions_arguments()
    for reaching_point in reaching_points:
      print(f"Point: {reaching_point[0].source_code()} | Argument index {reaching_point[1]}")
  
  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/Screenshot 2024-09-26 at 19.56.11.png" alt=""><figcaption></figcaption></figure>

### Here is a more detailed output

```solidity
Point1: 
function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length &gt; 0;
} 
ArgumentIndex1: 0
=====================================================================================
Point2: function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length &gt; 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
ArgumentIndex2: 1
=====================================================================================
Point3: 
function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length &gt; 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
}
ArgumentIndex3: 0
=====================================================================================
Point4: 
function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
}
ArgumentIndex4: 0
=====================================================================================
Point5: 
function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
} 
ArgumentIndex5: 0
```
---
description: >-
  Returns all paths containing tainted data that influence the point. This
  includes not only tainted paths within the current function but also extends
  to paths belonging to other functions.
---

# Point.get\_all\_tainted\_paths\_affecting\_point()

`get_all_tainted_paths_affecting_point() →` [`APISet`](../../iterables/apiset.md)`[`[`APITuple`](../../iterables/apituple.md)`[`[`Point`](./)`]]`

Returns a set of paths containing tainted data that affect the point.

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1,1)

  affected_points = instructions[0].get_all_tainted_paths_affecting_point()
  print(affected_points)
  for point in affected_points:
    print(point.source_code())
  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

---
description: >-
  Returns the list of all points following the current point in the current data
  flow graph and outside of that.
---

# Point.forward\_df\_recursive()

`forward_df_recursive() →` [`APISet`](../../iterables/apiset.md)`[`[`Point`](./)`]`

## Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_name("claimTreasuryFundRewards")
    .exec(100)
    .filter(lambda function : function.get_contract().address() == "0xc0961B2A7607418F3a4A3611daB84E43842Dbd44")
  )

  instructions = functions.instructions().exec()
  instruction = instructions[1]
 
  forward_dfs = instruction.forward_df_recursive()
  print(f"Count of Points returned by forward_dfs: {len(forward_dfs)}")

  for forward_df in forward_dfs:
    print(forward_df.source_code())

  return instructions

```

## Output Example

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 5.54.31 PM.png" alt=""><figcaption></figcaption></figure>

To clarify, what is the difference between `forward_df` and `forward_df_recursive`? `forward_df_recursive` operates recursively. Below is the output when `forward_df` was used instead of `forward_df_recursive` :

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 5.55.16 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns true if the point has a dependency on external variables in the
  current data flow graph, false otherwise.
---

# Point.has\_global\_df()

`has_global_df() → bool`

## Query Example

```python
from glider import *


def query():
  instructions = (
    Instructions()
    .exec(10)
    .filter(lambda x: x.has_global_df())
  )
  
  print(len(instructions))
  
  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>



---
description: >-
  Returns true if the point has a dependency on external variables in the
  current data flow graph and outside of that, false otherwise.
---

# Point.has\_global\_df\_recursive()

`has_global_df_recursive() → bool`

## Query Example

```python
from glider import *


def query():
  recursive_instructions = (
    Instructions()
    .exec(10, 10)
    .filter(lambda x: x.has_global_df_recursive())
  )

  print(len(recursive_instructions))

  return recursive_instructions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-10 at 9.27.43 AM.png" alt=""><figcaption></figcaption></figure>

## has\_global\_df\_recursive vs has\_global\_df

Let's dive into the difference between `has_global_df_recursive()` and `has_global_df()`.

The function `has_global_df_recursive()` works recursively, whereas `has_global_df()` does not. In the previous example, as well as in the example using `has_global_df()`, no significant differences were observed. However, in the example below, we can clearly see the distinction between the two functions.

The following query demonstrates the difference: `has_global_df()` returns `259` instructions, while `has_global_df_recursive()` returns `261` instructions.

### Here is a query to highlight the difference:

```python
from glider import *


def query():
  instructions_extended = ( # 261
    Instructions()
    .exec(500)
    .filter(lambda x: x.has_extended_global_df())
  )

  foo1 = set(instructions_extended)

  instructions = ( # 259
    Instructions()
    .exec(500)
    .filter(lambda x: x.has_global_df())
  )

  foo2 = set(instructions)

  res = []

  difference = foo1 - foo2

  for ins in difference:
    res.append(ins)

  return res
```

### Here is the output:

<figure><img src="../../../.gitbook/assets/image (29).png" alt=""><figcaption></figcaption></figure>
---
description: Abstract base class representing a point in a data flow graph.
---

# Point

---
description: Returns whether the point is tainted.
---

# Point.is\_tainted()

A point is considered tainted when it is influenced by an external input such as user input.

## Query Example

Consider the following Solidity function:

```solidity
function stake(
    address _to,uint256 _amount,bool _rebasing,bool _claim
) external returns (uint256) {
    miner.safeTransferFrom(msg.sender,address(this),_amount);
    _amount = _amount.add(rebase()); 
    if (_claim && warmupPeriod == 0) {
        return _send(_to,_amount,_rebasing);
    } else {
        Claim memory info = warmupInfo[_to];
        if (!info.lock) {
            require(_to == msg.sender,"External deposits for account are locked");
        }

        warmupInfo[_to] = Claim({
            deposit: info.deposit.add(_amount),gons: info.gons.add(vMINER.gonsForBalance(_amount)),expiry: epoch.number.add(warmupPeriod),lock: info.lock
        });

        gonsInWarmup = gonsInWarmup.add(vMINER.gonsForBalance(_amount));

        return _amount;
    }
}
```

In this function, we want to determine if the following line is influenced by user input:

<pre class="language-solidity"><code class="lang-solidity"><strong>gonsInWarmup = gonsInWarmup.add(vMINER.gonsForBalance(_amount));
</strong></code></pre>

We know that `_amount` comes from a function argument, which is user-controlled. Therefore, this line of code is influenced by user input, and therefore tainted.

To write a query to confirm this, we first query the components in the instruction and call `is_tainted()` against any of the Points.

```python
from glider import *


def query():
    return (
        Contracts()
        .with_name("MinerStaking")
        .exec(1)
        .functions()
        .with_name("stake")
        .exec(1)
        .instructions()
        .expression_instructions()
        .exec()
        .filter(lambda instruction : "gonsInWarmup" in instruction.get_dest().expression)
        .filter(is_tainted)
    )


def is_tainted(instruction):
    components = instruction.get_components()
    for component in components:
        for df in component.backward_df():
            if df.is_tainted():
                return True

    return False                

```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-16 at 5.25.41 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns the list of all previous points of the current point in the data flow
  graph.
---

# Point.backward\_df()

`backward_df() →` [`APISet`](../../iterables/apiset.md)`[`[`Point`](./)`]`

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1,2)

  backward_dfs = instructions[0].backward_df()
  for backward_df in backward_dfs:
    print(backward_df.source_code())

  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (23) (1).png" alt=""><figcaption></figcaption></figure>

---
description: >-
  Returns the list of all previous points of the current point in the current
  data flow graph and outside of that.
---

# Point.backward\_df\_recursive()

`backward_df_recursive() →` [`APISet`](../../iterables/apiset.md)`[`[`Point`](./)`]`

## Query Example

```python
from glider import *


def query():
  functions = (
    Functions()
    .with_name("_burn")
    .exec(10)
    .filter(
      lambda function : function.get_contract().address() == "0x0B79318ecc4cc8F314A985Fc2Da98891EFd238Bc" and function.get_contract().name == "ERC20Named"
    )
  )

  instructions = functions.instructions().exec(1,1)
  for instruction in instructions:
    backward_dfs = instruction.backward_df_recursive()
    if len(backward_dfs) > 3 and len(backward_dfs) < 7:
      print(f"Count of Points returned by backward_dfs: {len(backward_dfs)}")
      for backward_df in backward_dfs:
        print(backward_df.source_code())
      
  return functions
```

## Output Example

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 4.48.53 PM.png" alt=""><figcaption></figcaption></figure>

To clarify, what is the difference between `backward_df` and `backward_df_recursive`? `backward_df_recursive` operates recursively. Below is the output when `backward_df` was used instead of `backward_df_recursive` :

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 5.21.42 PM.png" alt=""><figcaption></figcaption></figure>

---
description: >-
  Returns the list of all points following the current point in the current data
  flow graph.
---

# Point.forward\_df()

`forward_df() →` [`APISet`](../../iterables/apiset.md)`[`[`Point`](./)`]`

## Query Example

```python
from glider import *


def query():
  instructions = Instructions().exec(1,1)

  forward_dfs = instructions[0].forward_df()
  for forward_df in forward_dfs:
    print(forward_df.source_code())

  return instructions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (22) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Base class ExternalPoint
---

# ArgumentPoint

This class inherits from ExternalPoint and represents a specific instance of an argument point, encapsulating a single argument variable associated with a function or modifier.
---
description: Abstract method that returns object of variable
---

# ExternalPoint.get\_variable()

`get_variable() →` [`Variable`](../../variables/variable/)

## Query Example

```python
from glider import *


def query():
    functions = (
        Functions()
        .with_name("transferFrom")
        .exec(1)
    )

    arguments = functions[0].arguments()
    print(arguments.list()[0].get_variable())
    print(arguments.list()[0].source_code())

    return functions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: 'Base class: Point'
---

# ExternalPoint

This class inherits from the abstract base class Point and represents a specific instance of an external point, encapsulating a single external variable associated with a function or modifier.
---
description: Retrieves the address of the external point.
---

# ExternalPoint.get\_address()

## Query Example

```python
from glider import *


def query():
    functions = (
        Functions()
        .with_name("transferFrom")
        .exec(1)
    )

    arguments = functions[0].arguments()
    print(arguments.list()[0].get_address())
    print(arguments.list()[0].source_code())

    return functions
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-16 at 2.33.19 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns parent function/modifier of the ExternalPoint.
---

# ExternalPoint.get\_parent()

## Query Example

```python
from glider import *


def query():
    functions = (
        Functions()
        .with_name("transferFrom")
        .exec(1)
    )

    arguments = functions[0].arguments()

    print(arguments.with_type("address")[0].get_parent())
    print(arguments.with_type("address")[0].get_variable().source_code())


    return functions
```

## Example Output

<figure><img src="../../../.gitbook/assets/image (275).png" alt=""><figcaption></figcaption></figure>
---
description: Returns corresponding node in procedure graph.
---

# ExternalPoint.source\_code()

`source_code() → str`

## Query Example

```python
from glider import *

def query():

    functions = (
        Functions()
        .with_name("transferFrom")
        .exec(1)
    )

    arguments = functions[0].arguments()
    print(arguments.list()[0].get_variable())
    print(arguments.list()[0].source_code())

    return functions
```

## Output Example

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
# Iterables

# APISet

A `APISet` integrates classic set operations with advanced features. It allows functions to be applied to all elements, enables set refinement using the `filter()` function, and includes a fallback mechanism to ensure default behavior when no transformations or filtering are applied.

### APISet Functionality

A `APISet` supports all classic set operations, such as union (`|`), intersection (`&`), difference (`-`), and symmetric difference (`^`). Additionally, it supports membership tests and other set-based operations. Functions called on the set are applied to every element, resulting in a new APISet with the processed data.

### The `filter()` Function

The `filter()` function uses a predicate to evaluate each element of the `APISet`. Elements where the predicate returns `true` are retained, while others are excluded, allowing precise control over the final set content.

### Flattening

When a function returns another `APISet`, the results are flattened into a single, unified `APISet`. This ensures a consistent set structure, simplifying further processing and analysis

### Functions that return APISet

* instructions.callabes\_recursive()
* instructions.modifiers\_recursive()
* [`instruction.backward_df()`](../instruction/instruction.backward_df.md)&#x20;
* [`instruction.forward_df()`](../instruction/instruction.forward_df.md)
* [`instruction.next_instructions_recursive()`](../instruction/instruction.next_instructions_recursive.md)
* [`instruction.previous_instructions_recursive()`](../instruction/instruction.previous_instructions_recursive.md)
* [`instruction.next_instructions()`](../instruction/instruction.next_instructions.md)
* [`instruction.previous_instruction()`](../instruction/instruction.previous_instruction.md)
* [`instruction.previous_instructions()`](../instruction/instruction.previous_instructions.md)
* [`callable.get_reachable_instructions()`](../callable/callable.get_reachable_instructions.md)
* point.backward\_df()
* point.backward\_df\_recursive()
* point.forward\_df()
* point.forward\_df\_recursive()
* point.get\_all\_tainted\_paths\_affecting\_point()
* point.get\_tainted\_sources\_affecting\_point()
* value.backward\_df()
* value.backward\_df\_recursive()
* value.forward\_df()
* value.forward\_df\_recursive()&#x20;
* callnode.callees\_recursive()
* callnode.callers\_recursive()
* callable.get\_reachable\_instructions()
* callable.instructions\_recursive()



# APIList

A `APIList` integrates classic list operations with advanced features. It allows functions to be applied to all elements, enables list refinement using `filter()` function, and includes a fallback mechanism to ensure default behavior when no transformations or filtering are applied.&#x20;

### APIList Functionality

A `APIList` supports all classic `list` operation, such as indexing, iteration, and length calculations. Functions called on the list are applied to every element, resulting a new `APIList` with the processed data.

### The `filter()` function

The `filter()` function uses a predicate to evaluate each element of the `APIList`. Elements where the predicate returns `true` are retained, while others are excluded, allowing precise control over the final list content.

### Flattening

When a function return another `APIList`, the results are flattened into a single, one-dimensional `APIList`. This ensures a unified list structure, facilitating easier processing and analysis.



### Functions that return APIList



* callables.exec()
* callable.callee\_values()
* callable.loops()
* [`functions.exec()`](../callables/functions/functions.exec.md)
* functions.list()
* [`function.properties()`](../callable/function/function.properties.md)
* modifiers.list()
* [`modifier.exec()`](../callables/modifiers/modifiers.exec.md)
* modifier.properties()
* instructions.exec()
* instructions.list()
* `instruction.get_dests()`
* [`instruction.next_block()`](../instruction/instruction.next_block.md)
* [`instruction.next_instruction()`](../instruction/instruction.next_instruction.md)
* [`instruction.exec()`](../instructions/instructions.exec.md)
* instruction.get\_components()
* breakinstruction.get\_block\_instructions()
* startassemblyinstruction.get\_block\_instructions()
* tryinstruction.get\_block\_instructions()
* [`call.get_args()`](../value/call/call.get_args.md)
* [`call.get_call_gas()`](../value/call/call.get_call_gas.md)
* [`call.get_call_salt()`](../value/call/call.get_call_salt.md)
* [`call.get_call_value()`](../value/call/call.get_call_value.md)
* [`value.get_arg_vars()`](../value/value/value.get_arg_vars.md)
* value.get\_callee\_values()
* [`value.get_global_vars()`](../value/value/value.get_global_vars.md)
* value.get\_local\_vars()
* [`value.get_state_vars()`](../value/value/value.get_state_vars.md)
* [`value.get_vars()`](../value/value/value.get_vars.md)
* tupleexpression.get\_components()
* value.expression.get\_components()
* value.get\_dests()
* varvalue.get\_defining\_points()
* point.df\_reaches\_from\_functions\_arguments()
* point.df\_reaching\_functions\_arguments()
* argumentpoint.list()
* argumentpoint.with\_memory\_type()
* argumentpoint.with\_name()
* argumentpoint.with\_type()
* argumentpoint.with\_type\_convertible()
* globalvariables.list()
* localvariables.list()
* localvariables.with\_memory\_type()
* localvariables.with\_type()
* statevariables.exec()
* statevariables.list()
* callnode.callees()
* callnode.callers()
* contract.get\_contracts\_from\_same\_src\_file()
* contracts().exec()
* enums.exec()
* errors.exec()
* events.exec()









---
hidden: true
---

# APITuple

---
description: Returns the name of the struct.
---

# Struct.name

_`property`_` ``name :`` `_`str`_

## Query Example

```python
from glider import *


def query():
  contracts = Contracts().with_name("DefaultReserveInterestRateStrategy").exec(1)

  for contract in contracts:
    for struct in contract.structs().exec():
      print(struct.name)

  return contracts
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-10 at 5.35.44 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the fields of the struct.
---

# Struct.fields

_`property`_` ``fields :` [_`APIList`_](../iterables/apilist.md)_`[`_[_`StructField`_](../structfield/)_`]`_

## Query Example

```python
from glider import *


def query():
  contracts = Contracts().with_name("DefaultReserveInterestRateStrategy").exec(1)

  for contract in contracts:
    for struct in contract.structs().exec():
      for struct_field in struct.fields:
        print(struct_field.name)

  return contracts
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-10 at 5.33.42 PM.png" alt=""><figcaption></figcaption></figure>
---
description: The class represents a single struct object.
---

# Struct

---
description: Returns the source code of the struct.
---

# Struct.source\_code()

## Query Example

```python
from glider import *


def query():
  contracts = Contracts().with_name("DefaultReserveInterestRateStrategy").exec(1)

  for contract in contracts:
    for struct in contract.structs().exec():
      print(struct.source_code())

  return contracts
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-10 at 5.37.45 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the data of the struct.
---

# Struct.data

_`property`_` ``data :`` `_`Dict`_

## Query Example

```python
from glider import *


def query():
  contracts = Contracts().with_name("DefaultReserveInterestRateStrategy").exec(1)

  for contract in contracts:
    for struct in contract.structs().exec():
      print(struct.data)

  return contracts
```

## Example Output

Input below represents the return value of struct.data:

```python
{
    '_key': 'd579420667d21aefc3e8d360573a0b7f', 
    '_id': 'structs/d579420667d21aefc3e8d360573a0b7f', 
    '_rev': '_jw0UR9a-_M', 
    'name': 'CalcInterestRatesLocalVars', 
    'fields': [
        {
            'name': 'totalDebt', 
            'type': 
                {
                    'type': 'elementary', 
                    'name': 'uint256'
                }
            }, 
            {
                'name': 'currentVariableBorrowRate', 
                'type': {
                    'type': 'elementary', 
                    'name': 'uint256'
                }
            }, {
                'name': 'currentStableBorrowRate', 
                'type': {
                    'type': 'elementary', 
                    'name': 'uint256'
                }
            }, {
                'name': 'currentLiquidityRate', 
                'type': {
                    'type': 'elementary', 
                    'name': 'uint256'
                }
            }, {
                'name': 'utilizationRate', 
                'type': {
                    'type': 'elementary', 
                    'name': 'uint256'
                }
            }
        ], 
        'relative_filepath': '0xa52E67Ae57E9A029a117145700a2E4514762498C_DefaultReserveInterestRateStrategy.sol', 
        'first_source_line': 148, 
        'last_source_line': 154, 
        'start_column': 3, 
        'end_column': 4, 
        'address': '0xa52E67Ae57E9A029a117145700a2E4514762498C'
    }
}
```
---
description: Returns the address of the struct.
---

# Struct.address

`property address: str`

## Query Example

```python
from glider import *


def query():
  contracts = Contracts().with_name("DefaultReserveInterestRateStrategy").exec(1)

  for contract in contracts:
    for struct in contract.structs().exec():
      print(struct.address)

  return contracts
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-10 at 5.03.49 PM.png" alt=""><figcaption></figcaption></figure>
---
description: This class represents a single struct field object.
---

# StructField

---
description: Returns the name of the struct field.
---

# StructField.name

_`property`_` ``name :`` `_`str`_

## Query Example

```python
from glider import *


def query():
  contracts = Contracts().with_name("DefaultReserveInterestRateStrategy").exec(1)

  for contract in contracts:
    for struct in contract.structs().exec():
      for struct_field in struct.fields:
        print(struct_field.name)

  return contracts
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-10 at 5.39.46 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the type of the struct field.
---

# StructField.type

_`property`_` ``type :`` `_`Type`_

## Query Example

```python
from glider import *


def query():
  contracts = Contracts().with_name("DefaultReserveInterestRateStrategy").exec(1)

  for contract in contracts:
    for struct in contract.structs().exec():
      for struct_field in struct.fields:
        print(struct_field.type)

  return contracts
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-09-10 at 5.40.57 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the type of the local variable.
---

# LocalVariable.type

`property type: Type`

**Query Example**

```python
from glider import *
def query():
  funcs = Functions().exec(500)

  for func in funcs:
    local_vars = func.local_variables().list()
    for local_var in local_vars:
      if local_var.memory_type == 'memory':
        print(local_var.name)
        print(local_var.type.name)
        return [local_var.get_parent()]

  return []
```

**Output**

```solidity
"root":{3 items
"contract":string"0xd705c24267ed3c55458160104994c55c6492dfcf"
"contract_name":string"Token"
"sol_function":solidity
function swapTokensForEth(uint256 tokenAmount) private lockTheSwap {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            address(this),
            block.timestamp
        );
    }
}
"root":{1 item
"print_output":[2 items
0:string"path"
1:string"address[]"
]
}
```
---
description: Returns parent function/modifier of the local variable.
---

# LocalVariable.get\_parent()

`get_parent() →` [`Callable`](../callable/)

The function returns the [Function](../callable/function/) or [Modifier](../callable/modifier/) object of the function/modifier where the local variable is declared.

**Query Example**

```python
from glider import *
def query():
  funcs = Functions().exec(500)

  for func in funcs:
    local_vars = func.local_variables().list()
    for local_var in local_vars:
      print(local_var.name)
      print(local_var.memory_type)
      return [local_var.get_parent()]

  return []
```

**Output**

```solidity
"root":{3 items
"contract":string"0xd705c24267ed3c55458160104994c55c6492dfcf"
"contract_name":string"SafeMath"
"sol_function":solidity
function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
},
"root":{1 item
"print_output":[2 items
0:string"c"
1:string"default"
]
}
```
---
description: >-
  The class represents a single local variable. Local variables are defined
  inside functions and modifiers.
hidden: true
---

# LocalVariable

---
description: Returns the memory type of the local variable.
---

# LocalVariable.memory\_type

`property name: str`

The memory type can be `calldata, memory, storage, default (stack)`

**Query Example**

```python
from glider import *
def query():
  funcs = Functions().exec(500)

  for func in funcs:
    local_vars = func.local_variables().list()
    for local_var in local_vars:
      if local_var.memory_type == 'memory':
        print(local_var.name)
        print(local_var.memory_type)
        return [local_var.get_parent()]

  return []
```

**Output**

```solidity
"root":{3 items
"contract":string"0xd705c24267ed3c55458160104994c55c6492dfcf"
"contract_name":string"Token"
"sol_function":solidity
function swapTokensForEth(uint256 tokenAmount) private lockTheSwap {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            address(this),
            block.timestamp
        );
    }
},
"root":{1 item
"print_output":[2 items
0:string"path"
1:string"memory"
]
}
```
---
description: >-
  Returns Contracts object for the contracts from which contract was inherited
  directly or indirectly.
---

# Contract.base\_contracts()

`base_contracts() →` [`Contracts`](../contracts/)

It returns the [Contracts](../contracts/) object representing the base contracts of a Contract. The function is recursive. See the example.

## Example query

```python
from glider import *

def query():
  contracts = Contracts().with_name("Deposit").exec(1)

  result = []

  result.append(contracts[0])

  base_contracts = contracts[0].base_contracts().exec()

  result.extend(base_contracts)
  
  return result
```

## Example output

<figure><img src="../../.gitbook/assets/image (67).png" alt=""><figcaption></figcaption></figure>

`Deposit` is the main contract. Below this text, a portion of the source code for this contract is provided. You can see that `Deposit` inherits from `Context`, `Ownable`, and `ReentrancyGuard`. The `Context` contract is derived from the `Ownable` contract

### Code Example

```solidity
// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;

...

contract Deposit is Ownable, ReentrancyGuard {
    ...
}
```

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

...

abstract contract Ownable is Context {
    ...
}
```
---
description: Returns all the functions of a Contract.
---

# Contract.functions()

`functions() →` [`Functions`](../callables/functions/)

The function returns all of the functions that the Contract has, including the inherited functions from its base classes.

## Example query

```python
from glider import *

def query():
  contracts = Contracts().exec(1)

  for contract in contracts:
    functions = contract.functions().exec()
    for function in functions:
      print(function.name)

  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: The function returns all the events of a Contract.
---

# Contract.events()

`events() →` [`APIList`](../iterables/apilist.md)`[`[`Event`](../event/)`]`

## Example query

```python
from glider import *


def query():
  contracts = Contracts().with_name("IERC721").exec(1)

  for contract in contracts:
    events = contract.events().exec()
    for event in events:
      print(event.signature)

  return contracts
```

## &#x20;Output Example

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if the Contract is main, false otherwise.
---

# Contract.is\_main()

`is_main() → bool`

The engine marks the contract as main, if it is the one being executed on the deployed address

## Example query

```python
from glider import *

def query():
  mains = Contracts().exec(30).filter(lambda x: x.is_main())

  return mains
```

## Example output

<figure><img src="../../.gitbook/assets/image (70).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the address of the contract.
---

# Contract.address()

`address() → str`

## Example query

```python
from glider import *

def query():
  contracts = Contracts().with_name("Deposit").exec(5)
  
  for contract in contracts:
    print(contract.address())

  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (66).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a collection of lists, with each list representing contracts
  originating from the same document.
---

# Contract.get\_contracts\_from\_same\_src\_file()

---
description: Returns call graph of the contract.
hidden: true
---

# Contract.call\_graph()

`call_graph() →` [`CallGraph`](../internal/callgraph/)

## Example query

```python
from glider import *

def query():
  contracts = Contracts().exec(50, 50)
  
  names = []
  for contract in contracts:
    call_graph = contract.call_graph()

    nodes = call_graph.name_prefix("min")

    for node in nodes:
      names.append(node.function_name())

  return [{"names": names}]
```

## Example output

```json
{
  "names": [
    "mint",
    "mint",
    "minVotingPeriod",
    "mint"
  ]
}
```
---
description: Returns the list of all state variables of the contract.
---

# Contract.state\_variables()

`state_variables() →` [`StateVariables`](../statevariables/)

Returns a StateVariables object for the state variables of the contract.

## Example query

```python
from glider import *

def query():
  contracts = Contracts().exec(1)

  state_variables = contracts[0].state_variables().exec()
  for state_variable in state_variables:
    print(state_variable.source_code())

  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (76).png" alt=""><figcaption></figcaption></figure>
---
description: The class represents a single contract object.
---

# Contract

The Contract class represents a contract or contract-like entity such as an interface or library.

If a single Solidity file includes different contracts, interfaces, and libraries, the engine will create separate Contract objects for each.

Bases: `Queryable`
---
description: Returns the ChainID of the blockchain where the Contract was deployed.
---

# Contract.chain\_id()

`chain_id() → int`

## Example query

```python
from glider import *

def query():
  contracts = Contracts().exec(5)

  for contract in contracts:
    print(contract.chain_id())

  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (68).png" alt=""><figcaption></figcaption></figure>
---
description: Returns all the modifiers of a Contract.
---

# Contract.modifiers()

`modifiers() →` [`Modifiers`](../callables/modifiers/)

The function also handles inherited modifiers.

## Example query

```python
from glider import *

def query():
  contracts = Contracts().exec(1,1)

  for contract in contracts:
    modifiers = contract.modifiers().exec()
    for modifier in modifiers:
      print(modifier.name)

  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (71).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the constructor of the contract, if exists.
---

# Contract.constructor()

`constructor() →` [`Function`](../callable/function/) `| NoneObject`

## Example query

```python
from glider import *

def query():
  constructors = (
    Contracts()
    .exec(8)
    .constructor()
    .filter(lambda x: not isinstance(x, NoneObject))
  )

  return constructors
```

Starting with Glider 1.0, you can use functions from [`Contracts`](../contracts/), [`Functions`](../callables/functions/), and [`Instructions`](../instructions/) on [`APIList`](../iterables/apilist.md)`[`[`Contract`](./)`]`, [`APIList`](../iterables/apilist.md)`[`[`Function`](../callable/function/)`]`, and [`APIList`](../iterables/apilist.md)`[`[`Instruction`](../instruction/)`]`. More details are available on the [Glider and Declarative Query Writing](../../glider-and-declarative-query-writing.md) page.

Additionally, the filter function is used to ignore [`NoneObject`](../internal/noneobject/). This occurs because not all contracts have a constructor, which may result in [`NoneObject`](../internal/noneobject/) being returned

## Example output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-24 at 11.55.41 AM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the list of all pragmas of the contract.
---

# Contract.pragmas()

`pragmas() → List[Tuple[str, str]]`

## Example query

```python
from glider import *

def query():
  contracts = Contracts().exec(5)

  for contract in contracts:
    print(contract.pragmas())


  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (74).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the list of all structs of the contract.
---

# Contract.structs()

`structs() →` [`Structs`](../structs/)

## Example query

```python
from glider import *

def query():
  contracts = Contracts().exec(1, 20)

  for contract in contracts:
    structs = contract.structs().exec()
    for struct in structs:
      print(struct.name)

  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (78).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns Contracts object for the contracts which were derived from the
  contract.
---

# Contract.derived\_contracts()

`derived_contracts() →` [`Contracts`](../contracts/)

## Example query

```python
from glider import *


def query():
  contracts = Contracts().exec(1)
  
  for contract in contracts:
    derived_contracts = contract.derived_contracts().exec()
    print(f"Contract name: {contract.name}")
    for derived_contract in derived_contracts:
      print(f"Derived contract name: {derived_contract.name}")
 
  return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-24 at 11.46.45 AM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns the name of a Contract.
---

# Contract.name

_`property`_` ``name`_`: str`_

## Example query

```python
from glider import *

def query():
  contracts = Contracts().exec(5)

  for contract in contracts:
    print(contract.name)

  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (72).png" alt=""><figcaption></figcaption></figure>
---
description: Returns the source code of the contract.
---

# Contract.source\_code()

`source_code() → str`

## Example query

```python
from glider import *

def query():
  contracts = Contracts().exec(1)

  print(contracts[0].source_code())

  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (75).png" alt=""><figcaption></figcaption></figure>
---
description: The function returns all the errors of a Contract.
---

# Contract.errors()

`errors() →` [`Errors`](../errors/)

## Example query

```python
from glider import *

def query():
  contracts = Contracts().exec(1, 13)

  for contract in contracts:
    errors = contract.errors().exec()
    for error in errors:
      print(error.signature)

  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns Contracts for the contracts from which the contract was inherited
  directly.
---

# Contract.direct\_base\_contracts()

`direct_base_contracts() →` [`Contracts`](../contracts/) `| NoneObject`

## Query Example

```python
from glider import *


def query():
  contracts = Contracts().exec(1, 7)
  
  for contract in contracts:
    direct_base_contracts = contract.direct_base_contracts().exec()
    print(f"Contract name: {contract.name}")
    for direct_base_contract in direct_base_contracts:
      print(f"Direct base contract name: {direct_base_contracts.name}")
 
  return contracts
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-24 at 11.55.41 AM (1).png" alt=""><figcaption></figcaption></figure>
---
description: The function returns all the enums of a Contract.
---

# Contract.enums()

`enums() →` [`Enums`](../enums/)

## Example query

```python
python
from glider import *

def query():
  contracts = Contracts().with_name("Math").exec(1)

  for contract in contracts:
    enums = contract.enums().exec()
    for enum in enums:
      print(enum.name)
      print(enum.values)

  return contracts
```

## Example output

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
---
description: Returns true if the Contract is a library, false otherwise.
---

# Contract.is\_lib()

`is_lib() → bool`

## Example query

```python
from glider import *

def query():
  libs = Contracts().exec(10).filter(lambda x: x.is_lib())

  return libs
```

## Example output

<figure><img src="../../.gitbook/assets/image (69).png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Adds a filter to get state variables that at least have one of the given
  properties.
---

# StateVariables.with\_one\_property()

`with_one_property(properties: List[`[`StateVariableProp`](statevariableprop/)`]) →` [`StateVariables`](./)

**Query Example**

```python
from glider import *
def query():
	state_vars = StateVariables().with_one_property([StateVariableProp.IMMUTABLE, StateVariableProp.PUBLIC]).exec(3)
	for state_var in state_vars:
		print(state_var.name())
		print(state_var.properties())
	return []
```

**Output**

```solidity
"root":{1 item
"print_output":[6 items
0:string"tradeOpen"
1:string"['public']"
2:string"name"
3:string"['public']"
4:string"symbol"
5:string"['public']"
]
}
```
---
description: State variable properties.
---

# StateVariableProp

---
description: 'StateVariableProp.INTERNAL: str = ''internal'''
---

# StateVariableProp.INTERNAL

---
description: 'StateVariableProp.PRIVATE: str = ''private'''
---

# StateVariableProp.PRIVATE

---
description: 'StateVariableProp.PUBLIC: str = ''public'''
---

# StateVariableProp.PUBLIC

---
description: 'StateVariableProp.IMMUTABLE: str = ''immutable'''
---

# StateVariableProp.IMMUTABLE

---
description: 'StateVariableProp.CONSTANT: str = ''constant'''
---

# StateVariableProp.CONSTANT

---
description: >-
  The aim of this class is to query and filter state variables with specific
  properties.
hidden: true
---

# StateVariables

Bases: Queryable
---
description: Adds a filter to get state variables with the given name.
---

# StateVariables.with\_name()

`with_name(name: str, sensitivity: bool = True) →` [`StateVariables`](./)

**Query Example**

```python
from glider import *
def query():
	state_vars = StateVariables().with_name('balance', sensitivity=False).exec(2)
	for state_var in state_vars:
		print(state_var.name())
		print(state_var.properties())
	return []
```

**Output**

```solidity
"root":{1 item
"print_output":[4 items
0:string"balance"
1:string"['internal']"
2:string"BALANCE"
3:string"['constant', 'internal']"
]
}
```
---
description: Adds a filter to get state variables that have all given properties.
---

# StateVariables.with\_all\_properties()

`with_all_properties(properties: List[`[`StateVariableProp`](statevariableprop/)`]) →` [`StateVariables`](./)

**Query Example**

```python
from glider import *
def query():
	state_vars = StateVariables().with_all_properties([StateVariableProp.IMMUTABLE, StateVariableProp.PUBLIC]).exec(1)
	for state_var in state_vars:
		print(state_var.name())
		print(state_var.properties())
	return []
```

**Output**

```solidity
"root":{1 item
"print_output":[2 items
0:string"uniswapV2Router"
1:string"['public', 'immutable']"
]
}
```
---
description: Executes the formed query and returns a list of StateVariable objects.
---

# StateVariables.exec()

`exec(limit_count: int = 0, offset_count: int = 0) → List[`[`StateVariable`](../statevariable/)`]`

**Query Example**

```python
from glider import *
def query():
	state_vars = StateVariables().exec(3,3)
	for state_var in state_vars:
		print(state_var.name())
		print(state_var.properties())
	return []
```

**Output**

```solidity
"root":{1 item
"print_output":[6 items
0:string"_isExcludedFromFee"
1:string"['private']"
2:string"_tTotal"
3:string"['private', 'constant']"
4:string"_initialBuyTax"
5:string"['private']"
]
}
```
---
description: Adds a filter to get state variables that have the given type.
---

# StateVariables.with\_type()

`with_type(variable_type: str) →` [`StateVariables`](./)

**Query Example**

```python
from glider import *
def query():
	state_vars = StateVariables().with_type('mapping(address => bool)').exec(1)
	for state_var in state_vars:
		print(state_var.name())
		print(state_var.properties())
	return []
```

**Output**

```solidity
"root":{1 item
"print_output":[2 items
0:string"_isExcludedFromFee"
1:string"['private']"
]
}
```
---
description: >-
  Returns a Functions object representing the functions which are called from
  the function
---

# Function.caller\_functions\_recursive()

`caller_functions_recursive() ->` [`Functions`](../callables/functions/)

The function is the _**extended**_**/**_**inter-procedural**_ variant of function caller\_functions, meaning it works recursively. It returns the Functions object representing all the functions that are eventually called from within the function.&#x20;

The difference between `caller_functions_recursive()` and `caller_functions()` is that the latter one will only return directly called functions, while the recursive version will find all the functions recursively that eventually get called from the target function.

## Query Example

```python
from glider import *


def query():
    functions = Functions().with_name('depositToken').exec(1,10)

    #lets take the first function from the result and return its extended_caller_functions
    output = functions[0].caller_functions_recursive().exec()

    #print the code of the function, to be aware of whose callers we get
    print(functions[0].source_code())

    return output
```

## Example Output

#### Source code of depositToken :

```solidity
function depositToken() public view returns (address) {
    return getAddress(_DEPOSIT_TOKEN_SLOT);
}
```

#### Source code of extended caller functions:

```solidity
function depositCurve() internal {
    uint256 tokenBalance = IERC20(depositToken()).balanceOf(address(this));
    IERC20(depositToken()).safeApprove(curveDeposit(), 0);
    IERC20(depositToken()).safeApprove(curveDeposit(), tokenBalance);

    // we can accept 0 as minimum, this will be called only by trusted roles
    uint256 minimum = 0;
    if (nTokens() == 2) {
      uint256[2] memory depositArray;
      depositArray[depositArrayPosition()] = tokenBalance;
      ICurveDeposit_2token(curveDeposit()).add_liquidity(depositArray, minimum);
    } else if (nTokens() == 3) {
      uint256[3] memory depositArray;
      depositArray[depositArrayPosition()] = tokenBalance;
      ICurveDeposit_3token(curveDeposit()).add_liquidity(depositArray, minimum);
    } else if (nTokens() == 4) {
      uint256[4] memory depositArray;
      depositArray[depositArrayPosition()] = tokenBalance;
      if (metaPool()) {
        ICurveDeposit_4token_meta(curveDeposit()).add_liquidity(underlying(), depositArray, minimum);
      } else {
        ICurveDeposit_4token(curveDeposit()).add_liquidity(depositArray, minimum);
      }
    }
  }

```

```solidity
function _liquidateReward() internal {
    if (!sell()) {
      // Profits can be disabled for possible simplified and rapoolId exit
      emit ProfitsNotCollected(sell(), false);
      return;
    }

    for(uint256 i = 0; i < rewardTokens.length; i++){
      address token = rewardTokens[i];
      uint256 rewardBalance = IERC20(token).balanceOf(address(this));
      if (rewardBalance == 0 || storedLiquidationDexes[token][weth].length < 1) {
        continue;
      }

      uint256 toHodl = rewardBalance.mul(hodlRatio()).div(hodlRatioBase);
      if (toHodl > 0) {
        IERC20(token).safeTransfer(hodlVault(), toHodl);
        rewardBalance = rewardBalance.sub(toHodl);
        if (rewardBalance == 0) {
          continue;
        }
      }
      IERC20(token).safeApprove(universalLiquidator(), 0);
      IERC20(token).safeApprove(universalLiquidator(), rewardBalance);
      // we can accept 1 as the minimum because this will be called only by a trusted worker
      ILiquidator(universalLiquidator()).swapTokenOnMultipleDEXes(
        rewardBalance,
        1,
        address(this), // target
        storedLiquidationDexes[token][weth],
        storedLiquidationPaths[token][weth]
      );
    }

    uint256 rewardBalance = IERC20(weth).balanceOf(address(this));

    notifyProfitInRewardToken(rewardBalance);
    uint256 remainingRewardBalance = IERC20(rewardToken()).balanceOf(address(this));

    if (remainingRewardBalance == 0) {
      return;
    }

    IERC20(rewardToken()).safeApprove(universalLiquidator(), 0);
    IERC20(rewardToken()).safeApprove(universalLiquidator(), remainingRewardBalance);

    // we can accept 1 as minimum because this is called only by a trusted role
    ILiquidator(universalLiquidator()).swapTokenOnMultipleDEXes(
      remainingRewardBalance,
      1,
      address(this), // target
      storedLiquidationDexes[weth][depositToken()],
      storedLiquidationPaths[weth][depositToken()]
    );

    uint256 tokenBalance = IERC20(depositToken()).balanceOf(address(this));
    if (tokenBalance > 0) {
      depositCurve();
    }
  }

```

```solidity
function doHardWork() external onlyNotPausedInvesting restricted {
    IBaseRewardPool(rewardPool()).getReward();
    _liquidateReward();
    investAllUnderlying();
  }

```

```solidity
function withdrawAllToVault() public restricted {
    if (address(rewardPool()) != address(0)) {
      exitRewardPool();
    }
    _liquidateReward();
    IERC20(underlying()).safeTransfer(vault(), IERC20(underlying()).balanceOf(address(this)));
  }
```
---
description: Basic concepts of using API module
---

# 📌 Main concepts

The part of a glider code that will query information from DB is contained in the API module, as well as other high-level graph functions can be found there.

The query chain is constructed in DSL format

```python
instructions = (
    Functions()
    .with_one_property([MethodProp.EXTERNAL, MethodProp.PUBLIC])
    .without_properties([MethodProp.HAS_MODIFIERS, MethodProp.IS_CONSTRUCTOR])
    .instructions()
    .with_callee_function_name("selfdestruct")
    .exec()
)
```

As you can see here, the chain consists of different types of filterings, such as with\_one\_property, without\_properties, etc.

The way to think of this filter chain is that every filter narrows down the set of results before entering the next filter chain. In other words, the filters can also be thought of as a chain joined with a logical AND operator.

## Changing entities

As can be seen from the code above, the chain can also change the entity it is filtering on.

Here, the part `.instructions()` will "level down" to the instructions of the functions that have been filtered previously in the chain, and the user can continue filtering on the new type of entity.&#x20;

Likewise, a "level-up" can also be made, for example, starting filtering with instructions and then changing the query entity to functions.

## Performance note

One should consider performance issues coming from changing entities multiple times during a chain of queries.

In such situations, it is much more effective to break it into multiple query chains and then combine the results.

## Pagination of results

The last part of the query always ends with .exec() call, which can also be used to paginate the results in case the returned set is big.

The function can be called with parameters:

`exec(limit)`

`exec(limit,offset)`
---
description: The aim of this class is to filter enums with some properties.
---

# Enums

---
description: Executes the formed query and returns the list of Enum objects.
---

# Enums.exec()

`exec(`_`limit_count: int = 0, offset_count: int = 0`_`) →` [`APIList`](../iterables/apilist.md)`[`[`Enum`](../enum/)`]`

## Query Example

```python
from glider import *

def query():
  contracts = Contracts().exec(1, 71)

  for contract in contracts:
    for enum in contract.enums().exec():
      print(enum.name)
  
  return []
```

## Example Output

<figure><img src="../../.gitbook/assets/Screenshot 2025-07-25 at 6.33.58 PM.png" alt=""><figcaption></figcaption></figure>
---
hidden: true
---

# Queryable

---
hidden: true
---

# Queryable.query\_aggregator

# Internal

---
description: >-
  Returns all nodes corresponding the callees of the corresponding callable with
  the callees of those callables etc.
---

# CallNode.callees\_recursive()

`callees_recursive() →` [`APISet`](../../iterables/apiset.md)`[`[`CallNode`](./)`]`

## Query Example

```python
from glider import *


def query():
    contracts = Contracts().exec(1,3)
    contract = contracts[0]

    call_nodes = contract.call_graph().all_nodes()
    call_node = call_nodes[32]

    print(f"Call node callable name: {call_node.callable_name()}")

    for callee in call_node.callees_recursive():
        print(f"Extended callee callable name: {callee.callable_name()}")

    return contracts
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-10 at 6.09.15 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns Functions object for the functions that call the current node
  corresponding function.
---

# CallNode.caller\_functions()

`caller_functions() →` [`Functions`](../../callables/functions/)

## Query Example

```python
from glider import *

# task: find a function that has `burn*` call and return all the functions that has a call to that function

def query():
  data = []
  instructions = Instructions().with_callee_name_prefix('burn').exec(10)
  
  for instruction in instructions:
    if len(data) > 0:
      break # demo first result only
    functionContainsBurn = instruction.get_parent() #api.functions.Function (*)
    contract = functionContainsBurn.get_contract() #api.contracts.Contract
    call_graph = contract.call_graph() #api.call_graph.CallGraph 
    nodes = call_graph.nodes() #Dict[str, CallNode]
    
    for id in nodes:
      if(id != functionContainsBurn.db_id):
        continue
      caller_functions = nodes[id].caller_functions #api.functions.Functions
      callers = caller_functions().exec() #List[Function]
      if len(callers) > 0:
        print(functionContainsBurn.source_code())
        for caller in callers:
          print(caller.source_code())
        data.append(instruction)
        
  return data
```

## Example Output

Output below represents printed output from the caller's source code:

```json
{
  "print_output": [
    "function _beforeTokenTransfer(\n        address from,address to,uint256 amount\n    ) internal virtual override {\n        super._beforeTokenTransfer(from,to,amount);\n        \n        if (from == address(0) && to != address(0)) {\n            require(_erc20TokenAddress != address(0),\"_erc20TokenAddress must be defined\");\n            uint256 balanceOfAddress = IERC20(_erc20TokenAddress).balanceOf(to);\n            require(balanceOfAddress >= 1,\"user does not hold a token\");\n            ERC20Burnable(_erc20TokenAddress).burnFrom(to,1);\n        }\n    }",
    "function _mint(address to,uint256 tokenId) internal virtual {\n        require(to != address(0),\"ERC721: mint to the zero address\");\n        require(!_exists(tokenId),\"ERC721: token already minted\");\n\n        _beforeTokenTransfer(address(0),to,tokenId);\n\n        _balances[to] += 1;\n        _owners[tokenId] = to;\n\n        emit Transfer(address(0),to,tokenId);\n\n        _afterTokenTransfer(address(0),to,tokenId);\n    }",
    "function _burn(uint256 tokenId) internal virtual {\n        address owner = ERC721.ownerOf(tokenId);\n\n        _beforeTokenTransfer(owner,address(0),tokenId);\n\n        \n        _approve(address(0),tokenId);\n\n        _balances[owner] -= 1;\n        delete _owners[tokenId];\n\n        emit Transfer(owner,address(0),tokenId);\n\n        _afterTokenTransfer(owner,address(0),tokenId);\n    }",
    "function _transfer(\n        address from,address to,uint256 tokenId\n    ) internal virtual {\n        require(ERC721.ownerOf(tokenId) == from,\"ERC721: transfer from incorrect owner\");\n        require(to != address(0),\"ERC721: transfer to the zero address\");\n\n        _beforeTokenTransfer(from,to,tokenId);\n\n        \n        _approve(address(0),tokenId);\n\n        _balances[from] -= 1;\n        _balances[to] += 1;\n        _owners[tokenId] = to;\n\n        emit Transfer(from,to,tokenId);\n\n        _afterTokenTransfer(from,to,tokenId);\n    }"
  ]
}
```
---
description: The class represents a single node in a call graph.
---

# CallNode

Bases: **object**

{% content-ref url="callnode.callee_functions.md" %}
[callnode.callee\_functions.md](callnode.callee_functions.md)
{% endcontent-ref %}

{% content-ref url="callnode.callees.md" %}
[callnode.callees.md](callnode.callees.md)
{% endcontent-ref %}

{% content-ref url="callnode.caller_functions.md" %}
[callnode.caller\_functions.md](callnode.caller_functions.md)
{% endcontent-ref %}

{% content-ref url="callnode.callers.md" %}
[callnode.callers.md](callnode.callers.md)
{% endcontent-ref %}

{% content-ref url="broken-reference" %}
[Broken link](broken-reference)
{% endcontent-ref %}

{% content-ref url="broken-reference" %}
[Broken link](broken-reference)
{% endcontent-ref %}
---
description: >-
  Returns all nodes corresponding the callers of the corresponding callable with
  the callers of those callables etc.
---

# CallNode.callers\_recursive()

`callers_recursive() →` [`APISet`](../../iterables/apiset.md)`[`[`CallNode`](./)`]`

## Query Example

```python
from glider import *


def query():
    contracts = Contracts().exec(1,3)
    contract = contracts[0]

    call_nodes = contract.call_graph().all_nodes()
    call_node = call_nodes[13]
    
    print(f"Call node callable name: {call_node.callable_name()}")
    
    for callee in call_node.callers_recursive():
        print(f"Extended caller callable name: {callee.callable_name()}")
 
    return contracts
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-10 at 6.08.48 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a list of CallNode whose corresponding functions are called from the
  current CallNode corresponding function.
---

# CallNode.callees()

`callees() →` [`APIList`](../../iterables/apilist.md)`[`[`CallNode`](./)`]`

## Query Example

```python
from glider import *


def query():
  data = []
  instructions = Instructions().with_callee_name_prefix('burn').exec(10)
  
  for instruction in instructions:
    if len(data) > 0:
      break # demo first result only
    functionContainsBurn = instruction.get_parent() #api.functions.Function (*)
    contract = functionContainsBurn.get_contract() #api.contracts.Contract
    call_graph = contract.call_graph() #api.call_graph.CallGraph 
    nodes = call_graph.nodes() #Dict[str, CallNode]
    
    for id in nodes:
      if(id != functionContainsBurn.db_id):
        continue
      callees = nodes[id].callees() #List[CallNode]
    
      if len(callees) > 0:
        print(functionContainsBurn.source_code())
        for callee in callees:
          print("callee: " + callee.callable_name())
        data.append(instruction)
        
  return data
```

## Example Output

Output below represents printed output from the caller's source code:

```json
{
  "print_output": [
    "function _burnRusdHeld() internal {\n        rusd().burn(rusdBalance());\n    }",
    "callee: rusd",
    "callee: rusdBalance"
  ]
}
```
---
description: Returns corresponding callable name.
---

# CallNode.callable\_name()

`callable_name() → str`

## Query Example

```python
from glider import *


def query():
    contracts = Contracts().exec(1)
    contract = contracts[0]

    call_nodes = contract.call_graph().all_nodes()
    for call_node in call_nodes:
        print(call_node.callable_name())

    return contracts
```

## Example Output

Output below represents printed output from the caller's source code:

```json
[
  {
    "print_output": [
      "_msgSender()",
      "_msgData()"
    ]
  }
]
```
---
description: Returns corresponding callable.
---

# CallNode.callable()

`callable() →` [`Callable`](../../callable/)

## Query Example

```python
from glider import *


def query():
    contracts = Contracts().exec(1)
    contract = contracts[0]

    call_nodes = contract.call_graph().all_nodes()
    for call_node in call_nodes:
        callable = call_node.callable()
        print(callable.signature())

    return contracts
```

## Example Output

Output below represents printed output from the caller's source code:

```json
[
  {
    "print_output": [
      "_msgSender()",
      "_msgData()"
    ]
  }
]
```
---
description: Returns whether the node represents a function.
---

# CallNode.is\_function

_`property`_` ``is_function : bool`

## Query Example

```python
from glider import *

def query():
    contracts = Contracts().exec(1,3)
    contract = contracts[0]

    call_nodes = contract.call_graph().all_nodes()
    call_node = call_nodes[13]
    
    print(f"Is call node {call_node.callable_name()} a function: {call_node.is_function}")
 
    return contracts
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-10 at 6.08.26 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a list of CallNodes whose corresponding functions call the current
  node's corresponding function.
---

# CallNode.callers()

`callers() →` [`APIList`](../../iterables/apilist.md)`[`[`CallNode`](./)`]`

## Query Example

```python
from glider import *


def query():
    data = []
    instructions = Instructions().with_callee_name_prefix('burn').exec(10)

    for instruction in instructions:
        if len(data) > 0:
            break # demo first result only
        functionContainsBurn = instruction.get_parent() #api.functions.Function (*)
        contract = functionContainsBurn.get_contract() #api.contracts.Contract
        call_graph = contract.call_graph() #api.call_graph.CallGraph 
        nodes = call_graph.nodes() #Dict[str, CallNode]
        for id in nodes:
            if(id != functionContainsBurn.db_id):
                continue
        callers = nodes[id].callers() # APIList[CallNode]
        if len(callers) > 0:
            print(functionContainsBurn.source_code())
            for caller in callers:
                print("caller: " + caller.callable_name())
            data.append(instruction)

    return data
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-10 at 6.09.37 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns Functions object for the functions that are called from the current
  node corresponding function.
---

# CallNode.callee\_functions()

`callee_functions() →` [`Functions`](../../callables/functions/)

## Query Example

```python
from glider import *

# task: find a function that has `burn*` call and print all the functions that is called from it

def query():
  data = []

  instructions = Instructions().with_callee_name_prefix('burn').exec(10)

  for instruction in instructions:
    if len(data) > 0:
      break # demo first result only
    functionContainsBurn = instruction.get_parent() #api.functions.Function (*)
    contract = functionContainsBurn.get_contract() #api.contracts.Contract
    call_graph = contract.call_graph() #api.call_graph.CallGraph 
    nodes = call_graph.nodes() #Dict[str, CallNode]

    for id in nodes:
      if(id != functionContainsBurn.db_id):
        continue
      callee_functions = nodes[id].callee_functions() #api.functions.Functions
      callees = callee_functions.exec() #List[Function]

      if len(callees) > 0:
        print(functionContainsBurn.source_code())

        for callee in callees:
          print("callee: " + callee.name)
        
        data.append(instruction)
        
  return data
```

## Example Output

Output below represents printed output from the caller's source code:

```json
{
  "print_output": [
    "function _burnRusdHeld() internal {\n        rusd().burn(rusdBalance());\n    }",
    "callee: rusd",
    "callee: rusdBalance",
    "callee: burn",
    "callee: burn"
  ]
}
```
---
description: >-
  Returns Modifiers object for the modifiers that call the current node
  corresponding callable.
---

# CallNode.caller\_modifiers()

`caller_modifiers() →` [`Modifiers`](../../callables/modifiers/)

## Query Example

```python
from glider import *


def query():
    contracts = Contracts().exec(1,3)
    contract = contracts[0]

    call_nodes = contract.call_graph().all_nodes()
    call_node = call_nodes[43]

    print(f"Call node function name: {call_node.callable_name()}")

    for modifier in call_node.caller_modifiers().exec():
        print(f"Caller modifier name {modifier.name}")

    return contracts
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-10 at 6.10.08 PM.png" alt=""><figcaption></figcaption></figure>
---
description: Returns whether the node represents a modifier.
---

# CallNode.is\_modifier

_`property`_` ``is_function : bool`

## Query Example

```python
from glider import *


def query():
    contracts = Contracts().exec(1,3)
    contract = contracts[0]

    call_nodes = contract.call_graph().all_nodes()
    call_node = call_nodes[55]
    
    print(f"Is call node {call_node.callable_name()} a modifier: {call_node.is_modifier}")
  
    return contracts
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-10 at 6.07.36 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns Modifiers object for the modifiers that are called from the current
  node corresponding callable.
---

# CallNode.callee\_modifiers()

`callee_modifiers() →` [`Modifiers`](../../callables/modifiers/)

## Query Example

```python
from glider import *


def query():
    contracts = Contracts().exec(10,1)
    contract = contracts[0]

    call_nodes = contract.call_graph().all_nodes()
    call_node = call_nodes[31]
    call_node_name = call_node.callable_name()
    
    for modifier in call_node.callee_modifiers().exec():
        print(f"Function name: {call_node_name} | Callee modifier name: {modifier.name}")

    return contracts
```

## Output Example

Output below represents printed output from the caller's source code:

```json
[
  {
    "print_output": [
      "Function name: renounceOwnership | Callee modifier name: onlyOwner"
    ]
  }
]
```

---
description: Returns the list of all call nodes.
---

# CallGraph.all\_nodes()

`all_nodes() →` [`APIList`](../../iterables/apilist.md)`[`[`CallNode`](../callnode/)`]`

## Query Example

```python
from glider import *


def query():
    contracts = Contracts().exec(1)
    contract = contracts[0]

    for func in contract.functions().exec():
        call_nodes = contract.call_graph().all_nodes()
        for call_node in call_nodes:
            print(call_node.callable_name())

    return contracts
```

## Example Output

```json
[
  {
    "print_output": [
      "_msgSender",
      "_msgData"
    ]
  }
]
```
---
description: Returns the node which represents the given function.
---

# CallGraph.get\_corresponding\_node\_for\_function()

`get_corresponding_node_for_function(function:` [`Callable`](../../callable/)`) →` [`CallNode`](../callnode/)

## Query Example

```python
from glider import *


def query():
    contracts = Contracts().exec(1)
    contract = contracts[0]

    for func in contract.functions().exec():
        call_node = contract.call_graph().get_corresponding_node_for_function(func)
        print(call_node.callable_name())

    return contracts
```

## Example Output

```json
[
  {
    "print_output": [
      "_msgSender",
      "_msgData"
    ]
  }
]
```
---
hidden: true
---

# CallGraph

This class represents a call graph.

Bases: **object**

{% content-ref url="callgraph.with_name_prefix.md" %}
[callgraph.with\_name\_prefix.md](callgraph.with_name_prefix.md)
{% endcontent-ref %}

{% content-ref url="callgraph.with_name_suffix.md" %}
[callgraph.with\_name\_suffix.md](callgraph.with_name_suffix.md)
{% endcontent-ref %}

{% content-ref url="callgraph.nodes.md" %}
[callgraph.nodes.md](callgraph.nodes.md)
{% endcontent-ref %}

{% content-ref url="callgraph.with_name.md" %}
[callgraph.with\_name.md](callgraph.with_name.md)
{% endcontent-ref %}

{% content-ref url="callgraph.with_name_not.md" %}
[callgraph.with\_name\_not.md](callgraph.with_name_not.md)
{% endcontent-ref %}
---
description: >-
  Returns the list of call nodes whose corresponding function has the specified
  name.
---

# CallGraph.with\_names()

`with_names(`_`names: List[str],sensitivity: bool = True`_`) →` [`APIList`](../../iterables/apilist.md)`[`[`CallNode`](../callnode/)`]`&#x20;

## Query Example

```python
from glider import *


def query():
    # Fetch the first contract
    contracts = Contracts().exec(1)
  
    # Get call nodes of functions ending with "Sender" 
    call_nodes = contracts[0].call_graph().with_names(["_msgSender", "_msgData"])
    for node in call_nodes:
        print(node.callable_name())

    return contracts
```

## Example Output

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-10 at 5.51.30 PM.png" alt=""><figcaption></figcaption></figure>
---
description: >-
  Returns a list of call nodes whose corresponding function doesn't have the
  specified name.
---

# CallGraph.with\_name\_not()

`with_name_not(`_`name: str`_`,`` `_`sensitivity: bool = True`_`) →` [`APIList`](../../iterables/apilist.md)`[`[`CallNode`](../callnode/)`]`

## Query Example

<pre class="language-python"><code class="lang-python">from glider import *


def query():
<strong>  # Fetch the first contract
</strong>  contracts = Contracts().exec(1)
  
  # Get call nodes of functions whose name is not "_msgSender"
  call_nodes = contracts[0].call_graph().with_name_not("_msgSender")
  for node in call_nodes:
    print(node.callable_name())

  return contracts
</code></pre>

## Example Output

```json
{
  "print_output": [
    "_msgData"
  ]
}
```
---
description: >-
  Returns the list of call nodes whose corresponding function name has the
  specified suffix.
---

# CallGraph.with\_name\_suffix()

`with_name_suffix(`_`suffix: str`_`,`` `_`sensitivity: bool = True`_`) →` [`APIList`](../../iterables/apilist.md)`[`[`CallNode`](../callnode/)`]`

## Query Example

```python
from glider import *


def query():
    # Fetch the first contract
    contracts = Contracts().exec(1)
  
    # Get call nodes of functions ending with "Sender" 
    call_nodes = contracts[0].call_graph().with_name_suffix("Sender")
    for node in call_nodes:
        print(node.callable_name())

    return contracts
```

## Output Example

```json
{
  "print_output": [
    "_msgSender"
  ]
}
```
---
description: >-
  Returns a list of call nodes whose corresponding function has the specified
  name.
---

# CallGraph.with\_name()

`with_name(`_`name: str`_`,`` `_`sensitivity: bool = True`_`) →` [`APIList`](../../iterables/apilist.md)`[`[`CallNode`](../callnode/)`]`

## Query Example

<pre class="language-python"><code class="lang-python">from glider import *


def query():
<strong>  # Fetch the first contract
</strong>  contracts = Contracts().exec(1)
  
  # Get call nodes of functions whose name is "_msgSender"
  call_nodes = contracts[0].call_graph().with_name("_msgSender")
  for node in call_nodes:
    print(node.callable_name())
    
  return contracts
</code></pre>

## Example Output

```json
{
  "print_output": [
    "_msgSender"
  ]
}
```
---
description: >-
  Returns the list of call nodes whose corresponding function name has the
  specified suffix.
---

# CallGraph.with\_name\_prefix()

`with_name_prefix(`_`suffix: str`_`,`` `_`sensitivity: bool = True`_`) →` [`APIList`](../../iterables/apilist.md)`[`[`CallNode`](../callnode/)`]`

## Query Example

<pre class="language-python"><code class="lang-python">from glider import *


def query():
<strong>    # Fetch the first contract
</strong><strong>    contracts = Contracts().exec(1)
</strong>  
    # Get call nodes of functions starting with "_msgSend" 
    call_nodes = contracts[0].call_graph().with_name_prefix("_msgSend")
    for node in call_nodes:
        print(node.callable_name())
    
    return contracts
</code></pre>

## Example Output

```json
{
  "print_output": [
    "_msgSender"
  ]
}
```
---
description: Returns the map of all call nodes. The key of the map is the id of a node.
---

# CallGraph.nodes()

`nodes() → Dict[str,` [`CallNode`](../callnode/)`]`

## Query Example

```python
from glider import *


def query():
  # Query first contract
  contracts = Contracts().exec(1)
  
  # Get all call nodes from the contract's call graph
  call_nodes = contracts[0].call_graph().nodes()
  
  # print all call nodes' corresponding function names
  for node_id in call_nodes:
    print(call_nodes[node_id].callable_name())
    
  return contracts
```

## Example Output

```json
{
    "print_output": [
        string"REBITCOIN",
        string"totalSupply",
        string"totalBurned",
        string"balanceOf",
        string"transfer",
        string"transferFrom",
        string"approve",
        string"allowance",
        string"burn",
        string"burnFrom",
        string"onlyOwner"
    ]
}
```
# NoneObject.dump\_into\_json()

---
hidden: true
---

# NoneObject

# NoneObject.instructions()

# NoneObject.name()

