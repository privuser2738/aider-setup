@echo off
setlocal enabledelayedexpansion

echo ============================================
echo  Aider Local Coding Assistant - Installer
echo ============================================
echo.

:: Check for Python versions in order of preference
set PYTHON_CMD=

:: Try py launcher first (most reliable on Windows)
py -3.11 --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=py -3.11
    goto :found_python
)

py -3.12 --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=py -3.12
    goto :found_python
)

py -3.10 --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=py -3.10
    goto :found_python
)

:: Try direct commands
python3.11 --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=python3.11
    goto :found_python
)

python3.12 --version >nul 2>&1
if %errorlevel% equ 0 (
    set PYTHON_CMD=python3.12
    goto :found_python
)

:: No compatible Python found
echo ERROR: Python 3.10, 3.11, or 3.12 is required.
echo Python 3.13 is NOT supported by aider yet.
echo.
echo Install Python 3.11 with:
echo   winget install Python.Python.3.11
echo.
echo Or download from:
echo   https://www.python.org/downloads/release/python-3119/
echo.
pause
exit /b 1

:found_python
echo Found Python: %PYTHON_CMD%
%PYTHON_CMD% --version
echo.

:: Create virtual environment
echo Creating virtual environment...
%PYTHON_CMD% -m venv venv
if %errorlevel% neq 0 (
    echo ERROR: Failed to create virtual environment
    pause
    exit /b 1
)

:: Activate and install
echo.
echo Installing aider-chat (this may take a few minutes)...
call venv\Scripts\activate.bat

python -m pip install --upgrade pip
pip install aider-chat

if %errorlevel% neq 0 (
    echo ERROR: Failed to install aider-chat
    pause
    exit /b 1
)

:: Pull recommended Ollama models
echo.
echo ============================================
echo  Installation Complete!
echo ============================================
echo.
echo To use aider:
echo   1. Open a new terminal
echo   2. Navigate to your project: cd your-project
echo   3. Activate: %~dp0venv\Scripts\activate.bat
echo   4. Run: aider --model ollama/deepseek-coder-v2:16b
echo.
echo Recommended: Pull a coding model for Ollama:
echo   ollama pull deepseek-coder-v2:16b
echo   ollama pull qwen2.5-coder:14b
echo.
pause
