# Proof of Concept: ERC-20 Allowance Bypass Vulnerability

## Overview

This PoC demonstrates the ERC-20 allowance bypass vulnerability where a spender can force a token owner to pay extra fees beyond the approved allowance amount.

## Vulnerability Description

When a token contract implements a fee mechanism in `transferFrom`, the fees are deducted from the sender's balance. However, if the allowance check doesn't account for these fees, a spender can cause the owner to lose more tokens than approved.

**Example:** If Alice approves 100 tokens to Bob, and there's a 10% transaction fee, Bob can cause Alice to lose 110 tokens (100 transfer + 10 fee) even though only 100 was approved.

## Safety Statement

⚠️ **This PoC runs entirely in a local Foundry environment and does NOT interact with any live networks (mainnet, testnets, or production systems).** All tests are isolated and safe to run.

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation) installed
- No RPC endpoint required (uses local Anvil fork)

## Setup

1. Install required dependencies:
```bash
forge install OpenZeppelin/openzeppelin-contracts --no-commit
forge install foundry-rs/forge-std --no-commit
```

2. Build the project:
```bash
forge build
```

## Running the PoC

Run the test that demonstrates the vulnerability:

```bash
forge test --vv
```

Or run with more verbose output:

```bash
forge test -vvv
```

## Expected Output

The test should pass, demonstrating that:
1. Alice approves 100 tokens to the spender
2. The spender calls `transferFrom` to transfer 100 tokens
3. Alice's balance decreases by MORE than 100 tokens (due to fees)
4. The actual amount deducted exceeds the approved allowance

Example output:
```
[PASS] test_transferFrom_exceedsApprovedAllowance() (gas: 87670)
Logs:
  Alice's balance before: 1000000000000000000000
  Approved allowance: 100000000000000000000
  Calling transferFrom to transfer 100 tokens...
  Alice's balance after: 889000000000000000000
  Balance decrease: 111000000000000000000
  VULNERABILITY CONFIRMED: Balance decrease (111) exceeds approved allowance (100)!
  
Suite result: ok. 1 passed; 0 failed; 0 skipped
```

## What This Proves

This PoC confirms that:
- The `transferFrom` function deducts fees from the sender's balance
- The allowance check only verifies the transfer amount, not the total (amount + fees)
- A spender can cause the owner to lose more tokens than approved
- This violates the ERC-20 standard expectation

## Files Structure

```
poc/
├── README.md              # This file
├── foundry.toml          # Foundry configuration
├── src/
│   └── VulnerableToken.sol    # Vulnerable token contract
└── test/
    └── AllowanceBypass.t.sol   # PoC test file
```

## Impact

If this vulnerability exists in a production token contract:
- Users may lose more tokens than they intended to approve
- Spenders can exploit this to drain additional tokens beyond the approved amount
- The vulnerability violates ERC-20 standard expectations and user trust

