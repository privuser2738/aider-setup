#!/bin/bash

echo "============================================"
echo " Aider Local Coding Assistant - Installer"
echo "============================================"
echo

# Check for Python versions in order of preference
PYTHON_CMD=""

for cmd in python3.11 python3.12 python3.10 python3; do
    if command -v $cmd &> /dev/null; then
        version=$($cmd --version 2>&1 | grep -oP '\d+\.\d+')
        major=$(echo $version | cut -d. -f1)
        minor=$(echo $version | cut -d. -f2)

        if [[ $major -eq 3 ]] && [[ $minor -ge 10 ]] && [[ $minor -le 12 ]]; then
            PYTHON_CMD=$cmd
            break
        fi
    fi
done

if [ -z "$PYTHON_CMD" ]; then
    echo "ERROR: Python 3.10, 3.11, or 3.12 is required."
    echo "Python 3.13 is NOT supported by aider yet."
    echo
    echo "Install Python 3.11 with:"
    echo "  Ubuntu/Debian: sudo apt install python3.11 python3.11-venv"
    echo "  macOS: brew install python@3.11"
    echo "  Fedora: sudo dnf install python3.11"
    exit 1
fi

echo "Found Python: $PYTHON_CMD"
$PYTHON_CMD --version
echo

# Create virtual environment
echo "Creating virtual environment..."
$PYTHON_CMD -m venv venv
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to create virtual environment"
    echo "You may need to install venv: sudo apt install python3.11-venv"
    exit 1
fi

# Activate and install
echo
echo "Installing aider-chat (this may take a few minutes)..."
source venv/bin/activate

pip install --upgrade pip
pip install aider-chat

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to install aider-chat"
    exit 1
fi

echo
echo "============================================"
echo " Installation Complete!"
echo "============================================"
echo
echo "To use aider:"
echo "  1. Navigate to your project: cd your-project"
echo "  2. Activate: source $(dirname "$0")/venv/bin/activate"
echo "  3. Run: aider --model ollama/deepseek-coder-v2:16b"
echo
echo "Recommended: Pull a coding model for Ollama:"
echo "  ollama pull deepseek-coder-v2:16b"
echo "  ollama pull qwen2.5-coder:14b"
