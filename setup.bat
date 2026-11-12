@echo off
setlocal

REM ===========================================================================
REM  Library-HolidaysFuncLib - one-time setup for STANDALONE development
REM
REM  The library itself needs nothing: it uses no other library. This script is
REM  only for running its unit tests. It clones DFUnit, the unit-test library,
REM  as a sibling of this folder (..\DFUnit), which is where the
REM  HolidaysFuncLibDev24.0 / 25.0 / 26.0 workspaces expect it for the test
REM  program AppSrc\UnitTests.src.
REM
REM  The HolidaysFuncLib24.0.sws / 25.0.sws files are what other workspaces use
REM  the library through, and RDC-Holidays-Functions-Library.sws is the
REM  DataFlex 26 package. None of them knows DFUnit, so a workspace that uses
REM  the library never needs this script.
REM ===========================================================================

cd /d "%~dp0"

echo.
echo === Library-HolidaysFuncLib standalone setup ===
echo Folder: %CD%
echo.

where git >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Git was not found on your PATH.
    echo         Install Git ^(or the GitHub Desktop app^), reopen the
    echo         command prompt, and run setup.bat again.
    echo.
    pause
    exit /b 1
)

if exist "..\DFUnit\.git" (
    echo [DFUnit] already present - pulling latest...
    git -C "..\DFUnit" pull --ff-only
) else (
    echo [DFUnit] cloning as a sibling...
    git clone https://github.com/NilsSve/Library-DFUnit.git "..\DFUnit"
    if errorlevel 1 (
        echo.
        echo [ERROR] Could not clone Library-DFUnit.
        echo         Check your connection and that you can reach:
        echo           https://github.com/NilsSve/Library-DFUnit.git
        echo.
        pause
        exit /b 1
    )
)

echo.
echo === Setup complete ===
echo.
echo DFUnit is now a sibling of this folder. Open HolidaysFuncLibDev26.0.sws
echo (or 25.0 / 24.0) in the Studio and build UnitTests.src to run the unit
echo tests of the library.
echo.
pause
exit /b 0
