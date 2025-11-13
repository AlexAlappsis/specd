#!/bin/bash
# specd Installation Script
#
# This script copies templates and slash commands from .specdocs to your project root.
# Run this once after adding specd as a git submodule.

set -e

echo "specd Installation"
echo "=================="
echo ""

# Check if .specdocs exists
if [ ! -d ".specdocs" ]; then
    echo "❌ Error: .specdocs directory not found."
    echo ""
    echo "Please add specd as a git submodule first:"
    echo "  git submodule add https://github.com/AlexAlappsis/specd .specdocs"
    echo "  git submodule update --init --recursive"
    exit 1
fi

# Check if spec/ already exists
if [ -d "spec" ]; then
    echo "⚠️  Warning: spec/ directory already exists."
    read -p "Overwrite existing spec/ directory? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
    echo "Removing existing spec/ directory..."
    rm -rf spec
fi

# Check if .claude/commands already exists
if [ -d ".claude/commands" ]; then
    echo "⚠️  Warning: .claude/commands/ directory already exists. Existing commands may be overridden"
    read -p "Overwrite existing commands? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi    
fi

echo ""
echo "📋 Copying templates..."
# Copy spec templates to project root
cp -r .specdocs/spec ./spec
echo "✓ Copied spec/ templates"

echo ""
echo "🔧 Copying slash commands..."
# Create .claude directory if it doesn't exist
mkdir -p .claude
# Copy commands to project root
cp -r .specdocs/.claude/commands ./.claude/
echo "✓ Copied .claude/commands/"

echo ""
echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "1. Run: /spec-init"
echo "   This will set up your initial specification files"
echo ""
echo "2. Start creating specs:"
echo "   /spec-feature    - Create features (FEAT-####)"
echo "   /spec-component  - Create components (COMP-####)"
echo "   /spec-impl       - Create implementations (IMPL-####)"
echo "   /spec-task       - Create tasks (TASK-####)"
echo ""
echo "3. Validate:"
echo "   /spec-sync       - Check cross-tier consistency"
echo ""
echo "📚 Documentation: ./spec/readme.md"
echo ""
