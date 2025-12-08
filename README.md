# Aider Local Coding Assistant

A personalized setup for [Aider](https://aider.chat) - an AI pair programming tool that works with local LLMs via Ollama.

## Features

- Works with local models (no API costs for basic usage)
- Integrates with Ollama for local LLM inference
- Can also use Claude/GPT APIs for more complex tasks
- Git-aware: understands your repo and makes commits

## Requirements

- **Python 3.10, 3.11, or 3.12** (3.13 not yet supported)
- **Ollama** installed and running
- **Git** installed

## Quick Start

### Windows

```batch
install.bat
```

### Linux/Mac

```bash
chmod +x install.sh
./install.sh
```

## Manual Installation

1. Install Python 3.11 or 3.12 if not available:
   - Windows: Download from https://www.python.org/downloads/release/python-3119/
   - Or use: `winget install Python.Python.3.11`

2. Create virtual environment:
   ```bash
   python3.11 -m venv venv
   ```

3. Activate and install:
   ```bash
   # Windows
   .\venv\Scripts\activate
   # Linux/Mac
   source venv/bin/activate

   pip install aider-chat
   ```

## Usage

### With Ollama (Free, Local)

```bash
# Activate environment first
.\venv\Scripts\activate  # Windows
source venv/bin/activate  # Linux/Mac

# Use with local models
aider --model ollama/deepseek-coder-v2:16b
aider --model ollama/codellama:13b
aider --model ollama/qwen2.5-coder:14b
```

### With Claude API (Best Quality)

```bash
# Set your API key
set ANTHROPIC_API_KEY=your-key-here  # Windows
export ANTHROPIC_API_KEY=your-key-here  # Linux/Mac

aider --model claude-3-5-sonnet-20241022
```

## Recommended Local Models for Coding

| Model | VRAM Needed | Quality | Speed |
|-------|-------------|---------|-------|
| `deepseek-coder-v2:16b` | 10GB | Excellent | Medium |
| `qwen2.5-coder:14b` | 9GB | Excellent | Medium |
| `codellama:13b` | 8GB | Good | Fast |
| `deepseek-coder:6.7b` | 5GB | Good | Fast |
| `codellama:7b` | 5GB | Decent | Very Fast |

Pull models with:
```bash
ollama pull deepseek-coder-v2:16b
ollama pull qwen2.5-coder:14b
```

## Configuration

Create `.aider.conf.yml` in your project or home directory:

```yaml
# Default model
model: ollama/deepseek-coder-v2:16b

# Auto-commit changes
auto-commits: true

# Show diffs before applying
show-diffs: true

# Git settings
git: true
```

## Tips

1. **Start in your project directory** - Aider reads your codebase
2. **Add files to context** with `/add filename.py`
3. **Use `/help`** to see all commands
4. **For large changes**, use Claude API - local models struggle with complex refactors

## Troubleshooting

### "Python 3.13 not supported"
Install Python 3.11: `winget install Python.Python.3.11`

### "Ollama connection refused"
Start Ollama: `ollama serve`

### "Model not found"
Pull the model first: `ollama pull modelname`
