
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------    

if exist init.dll ( 
goto PassUAC
 )
:strtsetup
assoc .dmg=DMGReaderFile
ftype DMGReaderFile="%cd%\DMGReader.bat" "%%1"
setx WorkingDIRDMG "%cd%"


bitsadmin.exe /transfer "ICO" https://github.com/Edowndotdown/DMG-Reader/raw/main/DMG.ico "%cd%\DMG.ico"

if not exist DMG.ico ( echo FATAL ERROR DMG.ico not found!! && pause && exit )
set iconPath=%cd%\DMG.ico


reg add "HKEY_CLASSES_ROOT\DMGReaderFile\DefaultIcon" /ve /t REG_SZ /d "%iconPath%" /f

echo Icon associated with .dmg files.
if exist "C:\Program Files\7-Zip\7z.exe" ( goto s7z )
bitsadmin.exe /transfer "7z" https://www.7-zip.org/a/7z2407-x64.exe "%cd%\7z.exe"
start 7z.exe
:s7z
if exist DMGReader.bat ( goto umountgrb )
bitsadmin.exe /transfer "DMG" https://github.com/Edowndotdown/DMG-Reader/raw/main/DMGReader.bat "%cd%\DMGReader.bat"

:umountgrb
if exist unmount.bat ( goto regsetup )
bitsadmin.exe /transfer "Unmount" https://github.com/Edowndotdown/DMG-Reader/raw/main/unmount.bat "%cd%\DMGReader.bat"


:regsetup
echo Windows Registry Editor Version 5.00 >regapp.reg

echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DMG Reader] >>regapp.reg
echo "DisplayName"="DMG Reader for Windows" >>regapp.reg
echo "Publisher"="Edowndotdown" >>regapp.reg
echo "HelpLink"="https://github.com/Edowndotdown/DMG-Reader" >>regapp.reg
echo "InstallLocation"="%cd%\DMG-Reader" >>regapp.reg
echo "UninstallString"="%cd%\Setup.bat" >>regapp.reg
echo "DisplayIcon"="%cd%\dmg.ico" >>regapp.reg


start regapp.reg


:endsetup
echo true >init.dll
@echo off
cls
echo Installation has finished. A file explorer restart is required to continue. Restart Now? y/n
choice /c yn /n /m " "
if %errorlevel% equ 1 taskkill /im explorer.exe /f && explorer
exit
:PassUAC
@echo off
cls
echo DMG Reader - Uninstall / Repair menu
echo ====================================
echo 1. Uninstall
echo 3. Repair
echo 5. Exit
choice /c 135 /n /m " "
if %errorlevel% equ 1 goto uninstall
if %errorlevel% equ 2 goto repair
if %errorlevel% equ 3 exit
:uninstall
echo Uninstalling DMG Reader...
timeout 5 >nul
if not exist init.dll ( echo Could not uninstall due to an Invalid directory. && pause && exit )
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\DMG Reader" /f
cd..
rmdir /s DMG-Reader
echo Uninstall complete. Press any key to exit && pause >nul
exit
:repair
cls
if not exist init.dll ( echo Could not repair due to an Invalid directory. && pause && exit )
echo Repairing DMG Reader...
timeout 5 >nul
goto strtsetup
exit