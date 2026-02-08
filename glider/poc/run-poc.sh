#!/bin/bash

# Proof of Concept Runner Script
# This script sets up and runs the PoC for the ERC-20 Allowance Bypass vulnerability

set -e

echo "=========================================="
echo "ERC-20 Allowance Bypass PoC"
echo "=========================================="
echo ""

# Check if Foundry is installed
if ! command -v forge &> /dev/null; then
    echo "❌ Error: Foundry is not installed."
    echo "Please install Foundry from: https://book.getfoundry.sh/getting-started/installation"
    exit 1
fi

echo "✓ Foundry is installed"
echo ""

# Check if dependencies are installed
if [ ! -d "lib/openzeppelin-contracts" ]; then
    echo "Installing OpenZeppelin contracts..."
    forge install OpenZeppelin/openzeppelin-contracts --no-commit
    echo "✓ OpenZeppelin contracts installed"
else
    echo "✓ OpenZeppelin contracts already installed"
fi

if [ ! -d "lib/forge-std" ]; then
    echo "Installing forge-std..."
    forge install foundry-rs/forge-std --no-commit
    echo "✓ forge-std installed"
else
    echo "✓ forge-std already installed"
fi
echo ""

# Build the project
echo "Building project..."
forge build
echo "✓ Build successful"
echo ""

# Run the PoC test
echo "=========================================="
echo "Running PoC Test..."
echo "=========================================="
echo ""
forge test --match-test test_transferFrom_exceedsApprovedAllowance -vvv

echo ""
echo "=========================================="
echo "PoC Complete!"
echo "=========================================="
echo ""
echo "The test demonstrates that:"
echo "  1. Alice approves 100 tokens"
echo "  2. Spender transfers 100 tokens"
echo "  3. Alice loses MORE than 100 tokens (due to fees)"
echo "  4. The balance decrease exceeds the approved allowance"
echo ""
echo "This confirms the ERC-20 allowance bypass vulnerability."

