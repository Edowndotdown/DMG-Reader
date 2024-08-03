@echo off

set filePath=%1
cd "%WorkingDIRDMG%"
if "%filePath%"=="" (
    set QuickOpen=False
) else (
    set QuickOpen=True
)
if not exist init.dll ( echo WARNING Setup.bat has not run yet! && pause && exit)


rem Options section
rem ====================================
rem Edit any of the following vars freely!




rem Ensure Drive Mounted Properly to the correct Drive Letter
set "CheckMounts=0"

rem Unmount the Default Drive Letter if available
set "UnmountExistingDrive=1"

rem Unmount all DMG drives before mounting new DMGs
set "DoAutoUnmount=1"

rem Set default drive letter to new DMGs
set DefaultDriveLetter=Y

rem After Mounting, Close DMG Reader. (Only Runs if DoAutoUnmount is set to 1) 
set NeverShowUnmountDialogeAfterMount=1


rem Options section END
rem ==================================
rem Dont edit the following code unless you know what your doing!





if not exist "C:\Program Files\7-Zip\7z.exe" ( 
echo 7Zip is needed for this program. Please install BEFORE running.
echo press any key to open 7Zip website, or close program now. If you have 7Zip installed in a custom location, reinstall to default location
pause
start https://www.7-zip.org/download.html
exit
 )
if %NeverShowUnmountDialogeAfterMount% equ %DoAutoUnmount% ( set mountdialoge=1 ) else ( set mountdialoge=0 )
if %UnmountExistingDrive% equ 1 ( subst /d %UnmountExistingDrive%: )
set testmounts=0
if %DoAutoUnmount% equ 0 ( goto init )
cls
echo Unmounting Drives now...
:unmountloop
if %testmounts% equ y set testmounts=z
if %testmounts% equ x set testmounts=y
if %testmounts% equ w set testmounts=x
if %testmounts% equ v set testmounts=w
if %testmounts% equ u set testmounts=v
if %testmounts% equ t set testmounts=u
if %testmounts% equ s set testmounts=t
if %testmounts% equ r set testmounts=s
if %testmounts% equ q set testmounts=r
if %testmounts% equ p set testmounts=q
if %testmounts% equ o set testmounts=p
if %testmounts% equ n set testmounts=o
if %testmounts% equ m set testmounts=n
if %testmounts% equ l set testmounts=m
if %testmounts% equ k set testmounts=l
if %testmounts% equ j set testmounts=k
if %testmounts% equ i set testmounts=j
if %testmounts% equ h set testmounts=i
if %testmounts% equ g set testmounts=h
if %testmounts% equ f set testmounts=g
if %testmounts% equ e set testmounts=f
if %testmounts% equ d set testmounts=e
if %testmounts% equ c set testmounts=d
if %testmounts% equ b set testmounts=c
if %testmounts% equ a set testmounts=b
if %testmounts% equ 0 set testmounts=a
subst /d %testmounts%: >nul
if %testmounts% equ z goto init
goto unmountloop
:init
set DrLetter=%DefaultDriveLetter%
title DMG Reader 
mode 60,33                                                                           
cls
echo     ZZZZZZZZZZZZZZZZZZZZZZZZZZZYYXXVZYY                  
echo     Z                 ZZZZZZZZZZYYXXZZZYZ                
echo     Z                     ZZZZZZZYYX ZZZZXZ              
echo     Z                       ZZZZZZYY   ZZZYX             
echo     Z                        ZZZZZZY     ZZZYW           
echo     Z                          ZZZZZYYXXWWWVUTSU         
echo     Z                           ZZZZZZZYYYYXXXXWVT       
echo     Z                              ZZZZZZZZZZYYYYXWZ     
echo     Z                                ZZZZZZZZZZZZYYY     
echo     Z           WWWWWWWWWXXXXXXXXXXXXXXXNXZZZZZZZZZZZ    
echo     Z          ZWWUAOLITLCOAAAABAXXXXXXWXXZZZZZZZZZZZ    
echo     Z          YVVVAAAAAAAABAAAAAOXXXXXYXXZ  ZZZZZZZZZ   
echo     Z          WVVNOOOOOOOOOOOOONLWWWWXXWXY      ZZZZZ   
echo     Z          UUUUUUUUUUVVWXXXXXVWWWWWWVWY          Z   
echo     Z          TTTTTUWTTUUUUUUUUVVVVVVVVYVV          Z   
echo     Z         ZSUSUSSSSTTTTTTTTTUUUUUUUUXKU          Z   
echo     Z         ZRR                        TT          Z   
echo     Z         X//[92mDrag and drop file here[0m//S          Z   
echo     Z         OOO                       YRRY         Z   
echo     Z         ONNLNOOOOOOOOPPPPPPPPQQQQQRQQS         Z   
echo     Z        ZNNNNLNNNNNNNOOOOOOOOOPPMQPPPPP         Z   
echo     Z        ZMMMMMMMKNOMNNNNNNNNMNMMOOOOPPPZ        Y   
echo     Z        YPSLMMMMMMMMMLKKKLMNNNNNOOOOONOZ        Y   
echo     Z        ZJKJEFEEFHIJJKAKBAAKAACKKKKKJKLZ        Y   
echo     Z        ZJLLEFFFEFGHIJAKCAALAAALKKKKKLL         Y   
echo     Z        ZGHGGGGGGGGGGGGGGGFGFFFFFFFFFHLZ        Y   
echo     Z                                                Y   
echo     Z                                                Y   
echo     Z                                                Y   
echo     Z                                                Y   
echo     Z                                       V 1.8.03 Y   
echo     ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ   
del boot.dll
set file=NOT
if %QuickOpen% equ True (
set "file=%filePath%"
) else (
set /p "file="
 )
if "%file%" equ "NOT" echo No file found. && timeout 5 && goto init
set "location=%cd%/temp"
mkdir "%location%"
rmdir /s /q temp
mkdir "%location%"
echo %filePath%
xcopy "%file%" "%location%"
cd "%location%"
rename *.dmg cur.dmg
echo Y | "C:\Program Files\7-Zip\7z.exe" x cur.dmg
del cur.dmg
cd..
set testdir=0

subst %DrLetter%: %location%
if %CheckMounts% equ 0 ( 
set testdir=%DrLetter%
goto strt
 )
:loop
if %testdir% equ y set testdir=z
if %testdir% equ x set testdir=y
if %testdir% equ w set testdir=x
if %testdir% equ v set testdir=w
if %testdir% equ u set testdir=v
if %testdir% equ t set testdir=u
if %testdir% equ s set testdir=t
if %testdir% equ r set testdir=s
if %testdir% equ q set testdir=r
if %testdir% equ p set testdir=q
if %testdir% equ o set testdir=p
if %testdir% equ n set testdir=o
if %testdir% equ m set testdir=n
if %testdir% equ l set testdir=m
if %testdir% equ k set testdir=l
if %testdir% equ j set testdir=k
if %testdir% equ i set testdir=j
if %testdir% equ h set testdir=i
if %testdir% equ g set testdir=h
if %testdir% equ f set testdir=g
if %testdir% equ e set testdir=f
if %testdir% equ d set testdir=e
if %testdir% equ c set testdir=d
if %testdir% equ b set testdir=c
if %testdir% equ a set testdir=b
if %testdir% equ 0 set testdir=a
IF exist "%testdir%:/.DS_Store" ( goto strt ) 
if %testdir% equ z goto endloop
goto loop
:strt
%testdir%:
start %cd%
if %mountdialoge% equ 1 ( exit )
echo press any key to umount device
pause >nul
subst /d %testdir%:
exit
:endloop
echo     [91mZZZZZZZZZZZZZZZZZZZZZZZZZZZYYXXVZYY                  
echo     Z                 ZZZZZZZZZZYYXXZZZYZ                
echo     Z                     ZZZZZZZYYX ZZZZXZ              
echo     Z                       ZZZZZZYY   ZZZYX             
echo     Z                        ZZZZZZY     ZZZYW           
echo     Z                          ZZZZZYYXXWWWVUTSU         
echo     Z                           ZZZZZZZYYYYXXXXWVT       
echo     Z                              ZZZZZZZZZZYYYYXWZ     
echo     Z                                ZZZZZZZZZZZZYYY     
echo     Z           WWWWWWWWWXXXXXXXXXXXXXXXNXZZZZZZZZZZZ    
echo     Z          ZWWUAOLITLCOAAAABAXXXXXXWXXZZZZZZZZZZZ    
echo     Z          YVVVAAAAAAAABAAAAAOXXXXXYXXZ  ZZZZZZZZZ   
echo     Z          WVVNOOOOOOOOOOOOONLWWWWXXWXY      ZZZZZ   
echo     Z          UUUUUUUUUUVVWXXXXXVWWWWWWVWY          Z   
echo     Z          TTTTTUWTTUUUUUUUUVVVVVVVVYVV          Z   
echo     Z         ZSUSUSSSSTTTTTTTTTUUUUUUUUXKU          Z   
echo     Z         ZRR                        TT          Z   
echo     Z         X// FAILED TO FIND DEVICE  //S          Z   
echo     Z         OOO                       YRRY         Z   
echo     Z         ONNLNOOOOOOOOPPPPPPPPQQQQQRQQS         Z   
echo     Z        ZNNNNLNNNNNNNOOOOOOOOOPPMQPPPPP         Z   
echo     Z        ZMMMMMMMKNOMNNNNNNNNMNMMOOOOPPPZ        Y   
echo     Z        YPSLMMMMMMMMMLKKKLMNNNNNOOOOONOZ        Y   
echo     Z        ZJKJEFEEFHIJJKAKBAAKAACKKKKKJKLZ        Y   
echo     Z        ZJLLEFFFEFGHIJAKCAALAAALKKKKKLL         Y   
echo     Z        ZGHGGGGGGGGGGGGGGGFGFFFFFFFFFHLZ        Y   
echo     Z                                                Y   
echo     Z                                                Y   
echo     Z                                                Y   
echo     Z                                                Y   
echo     Z                                                Y   
echo     ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ  [0m
timeout 5 >nul
exit