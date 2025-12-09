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

:: No compatible Python found - offer to install
echo No compatible Python version found (need 3.10, 3.11, or 3.12).
echo Python 3.13 is NOT supported by aider yet.
echo.
echo Would you like to install Python 3.11 via winget?
echo (This will NOT change your default Python - 3.13 will remain default)
echo.
choice /C YN /M "Install Python 3.11"
if %errorlevel% equ 1 (
    echo.
    echo Installing Python 3.11 via winget...
    winget install Python.Python.3.11 --accept-package-agreements --accept-source-agreements
    if %errorlevel% neq 0 (
        echo ERROR: Failed to install Python 3.11
        echo Please install manually from: https://www.python.org/downloads/release/python-3119/
        pause
        exit /b 1
    )
    echo.
    echo Python 3.11 installed successfully!
    echo Please close this window and run install.bat again.
    pause
    exit /b 0
)
echo.
echo Please install Python 3.11 manually:
echo   winget install Python.Python.3.11
echo   or: https://www.python.org/downloads/release/python-3119/
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
echo   4. Run: aider --model ollama/qwen2.5-coder:3b
echo.
echo Recommended: Pull a lightweight coding model for Ollama (3B):
echo   ollama pull qwen2.5-coder:3b      (3B - recommended)
echo   ollama pull starcoder2:3b         (3B - alternative)
echo.
pause
