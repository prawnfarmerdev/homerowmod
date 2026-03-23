@echo off
REM Batch script to start KMonad with the homerow mod configuration for Windows

set CONFIG_FILE=%~dp0windows.kbd

where kmonad >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: KMonad not found. Please install KMonad first.
    pause
    exit /b 1
)

echo Starting KMonad with config: %CONFIG_FILE%
kmonad "%CONFIG_FILE%"