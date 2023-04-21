@echo off
rem so light it can't be seen on a white room
:menu
cls
echo.
echo -------- Simple Menu ---------
echo Enter 1 to Clean up temp files.
echo Enter 2 to Backup files.
echo Enter 3 to Check PC specs.
echo Enter 4 to Exit.
choice /c 1234 /n /m "Enter an option:"
goto :option%errorlevel%

:option1
echo Deleting temporary files...
del /f /q /s %temp%\*.* %WinDir%\Temp\*.* %WinDir%\Prefetch\*.* %AppData%\Temp\*.* %HomePath%\AppData\LocalLow\Temp\*.* %SYSTEMDRIVE%\AMD\*.* %SYSTEMDRIVE%\NVIDIA\*.* %SYSTEMDRIVE%\INTEL\*.* C:\$Recycle.Bin\*.* C:\Users\%username%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*
rd /s /q %WinDir%\Temp %WinDir%\Prefetch %temp% %AppData%\Temp %HomePath%\AppData\LocalLow\Temp %SYSTEMDRIVE%\AMD %SYSTEMDRIVE%\NVIDIA %SYSTEMDRIVE%\INTEL
md %WinDir%\Temp %WinDir%\Prefetch %temp% %AppData%\Temp %HomePath%\AppData\LocalLow\Temp
echo Done!
pause
goto :menu

:option2
set /p "src=Enter the source folder path: "
set /p "dest=Enter the destination folder path: "
echo Backing up %src% to %dest%...
xcopy /s /e /h /i /c "%src%" "%dest%"
echo Backup completed.
pause
goto :menu

:option3
cls
setlocal
REM Check RAM
wmic ComputerSystem get TotalPhysicalMemory | findstr /C:"4294967296" >nul
if %errorlevel% equ 0 (
    echo RAM Is Outdated - wmic ComputerSystem get TotalPhysicalMemory
) else (
    echo RAM Is Updated - wmic ComputerSystem get TotalPhysicalMemory
)

REM Check CPU
wmic cpu get NumberOfCores | findstr /C:"2" >nul
if %errorlevel% equ 0 (
    echo CPU Is Outdated - wmic cpu get NumberOfCores
) else (
    echo CPU Is Updated - wmic cpu get NumberOfCores
)

REM Check Storage
wmic diskdrive get size | findstr /C:"250000000000" >nul
if %errorlevel% equ 0 (
    echo Storage is Updated - wmic logicaldisk get size,freespace,caption
) else (
    echo Storage is Outdated - wmic logicaldisk get size,freespace,caption
)
endlocal
pause
goto :menu

:option4
exit