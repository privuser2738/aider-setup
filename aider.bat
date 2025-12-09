@echo off
:: Quick launcher for aider with Ollama

:: Get the directory where this script is located
set SCRIPT_DIR=%~dp0

:: Activate venv and run aider
call "%SCRIPT_DIR%venv\Scripts\activate.bat"

:: Default to qwen2.5-coder:3b if no model specified (lightweight)
if "%~1"=="" (
    aider --model ollama/qwen2.5-coder:3b
) else (
    aider %*
)
