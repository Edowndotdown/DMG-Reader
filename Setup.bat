if exist init.dll ( 
goto PassUAC
 )
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

assoc .dmg=DMGReaderFile
ftype DMGReaderFile="%cd%\DMGReader.bat" "%%1"
setx WorkingDIRDMG "%cd%"

if exist DMG.ico ( goto Readerdown )
bitsadmin.exe /transfer "ICO" https://github.com/Edowndotdown/DMG-Reader/blob/main/DMG.ico "%cd%\DMG.ico"
:Readerdown
if not exist DMG.ico ( echo FATAL ERROR DMG.ico not found!! && pause && exit )
set iconPath=%cd%\DMG.ico

:: Add registry entry for the file type icon
reg add "HKEY_CLASSES_ROOT\DMGReaderFile\DefaultIcon" /ve /t REG_SZ /d "%iconPath%" /f

echo Icon associated with .dmg files.
if exist "C:\Program Files\7-Zip\7z.exe" ( goto s7z )
bitsadmin.exe /transfer "7z" https://www.7-zip.org/a/7z2407-x64.exe "%cd%\7z.exe"
start 7z.exe
:s7z
if exist DMGReader.bat ( goto endsetup )
bitsadmin.exe /transfer "DMG" https://github.com/Edowndotdown/DMG-Reader/blob/main/DMGReader.bat "%cd%\DMGReader.bat"





:endsetup
echo true >init.dll
cls
echo Installation has finished. A file explorer restart is required to continue. Restart Now? y/n
choice /c yn /n /m " "
if %errorlevel% equ y taskkill /im explorer.exe /f && explorer
start DMGReader && exit
:PassUAC

exit