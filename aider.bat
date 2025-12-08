@echo off
:: Quick launcher for aider with Ollama

:: Get the directory where this script is located
set SCRIPT_DIR=%~dp0

:: Activate venv and run aider
call "%SCRIPT_DIR%venv\Scripts\activate.bat"

:: Default to deepseek-coder if no model specified
if "%~1"=="" (
    aider --model ollama/deepseek-coder-v2:16b
) else (
    aider %*
)
