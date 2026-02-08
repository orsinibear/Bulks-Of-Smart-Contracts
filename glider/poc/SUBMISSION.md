# PoC Submission: ERC-20 Allowance Bypass Vulnerability

## Quick Start

```bash
# Install dependencies
forge install OpenZeppelin/openzeppelin-contracts --no-commit
forge install foundry-rs/forge-std --no-commit

# Run the PoC
forge test --match-test test_transferFrom_exceedsApprovedAllowance -vvv
```

Or use the provided script:
```bash
./run-poc.sh
```

## What This PoC Demonstrates

This Proof of Concept demonstrates a critical vulnerability in ERC-20 token contracts where:

1. **The Problem**: When `transferFrom` includes a fee mechanism, fees are deducted from the sender's balance without ensuring the allowance covers both the transfer amount AND the fees.

2. **The Impact**: A spender can cause the token owner to lose more tokens than approved. For example:
   - Alice approves 100 tokens to Bob
   - Bob calls `transferFrom` to transfer 100 tokens
   - Alice loses 110 tokens (100 transfer + 10 fee)
   - This violates ERC-20 standard expectations

3. **The Proof**: The test `test_transferFrom_exceedsApprovedAllowance()` shows:
   - Alice approves exactly 100 tokens
   - After `transferFrom(100)`, Alice's balance decreases by MORE than 100 tokens
   - The balance decrease exceeds the approved allowance

## Test Output

When you run the PoC, you should see output like:

```
[PASS] test_transferFrom_exceedsApprovedAllowance() (gas: 87670)
Logs:
  === Setting up the vulnerability scenario ===
  Alice's balance before: 1000000000000000000000
  Approved allowance: 100000000000000000000
  === Executing transferFrom ===
  Calling transferFrom to transfer 100 tokens...
  === Results ===
  Alice's balance after: 889000000000000000000
  Balance decrease: 111000000000000000000
  Bob received: 100000000000000000000
  Fees collected: 10000000000000000000
  === VULNERABILITY CONFIRMED ===
  Balance decrease (111) exceeds approved allowance (100)!
```

## Safety Statement

✅ **This PoC is completely safe to run:**
- Runs entirely in a local Foundry environment
- Does NOT interact with any live networks (mainnet, testnets, or production)
- Uses mock contracts and test addresses
- No real funds or tokens are at risk
- All operations are isolated and reversible

## Files Included

- `src/VulnerableToken.sol` - Vulnerable token contract demonstrating the issue
- `test/AllowanceBypass.t.sol` - PoC test file
- `foundry.toml` - Foundry configuration
- `remappings.txt` - Import remappings
- `README.md` - Detailed documentation
- `run-poc.sh` - Automated setup and test script
- `.gitignore` - Git ignore file

## Verification Steps

1. **Install Foundry** (if not already installed):
   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

2. **Install dependencies**:
   ```bash
   forge install OpenZeppelin/openzeppelin-contracts --no-commit
   forge install foundry-rs/forge-std --no-commit
   ```

3. **Build the project**:
   ```bash
   forge build
   ```

4. **Run the PoC**:
   ```bash
   forge test --match-test test_transferFrom_exceedsApprovedAllowance -vvv
   ```

5. **Verify the output** shows:
   - Balance decrease exceeds approved allowance
   - Vulnerability confirmation message

## Expected Behavior

The test should **PASS**, which confirms the vulnerability exists:
- The test passes because it successfully demonstrates that Alice loses more tokens than approved
- This is the expected behavior for a vulnerability PoC
- The assertion `assertGt(balanceDecrease, approvedAmount)` should succeed, proving the vulnerability

## Additional Test

The file also includes `test_transferFrom_withCorrectAllowance()` which demonstrates the correct behavior when allowance properly accounts for fees. This test shows how the vulnerability should be fixed.

## Impact Assessment

If this vulnerability exists in production:
- **Severity**: High
- **Affected Users**: All users who approve tokens to spenders
- **Potential Loss**: Users can lose additional tokens beyond approved amounts
- **ERC-20 Compliance**: Violates standard expectations

## Contact

For questions about this PoC, refer to the main README.md file or the vulnerability description in the parent directory.

