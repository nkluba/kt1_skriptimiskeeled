@echo off 
chcp 65001 > nul
setlocal enabledelayedexpansion

set str=%~1
set "separator=^!"

call :strLen str strlen
echo String is %strlen% characters long

rem Define an array for characters and their corresponding entities
set /a idx=0
for %%c in (ö ä ü õ š ž Ö Ä Ü Õ Š Ž) do (
    set "convert[!idx!].character=%%c"
    set /a idx+=1
)
set /a idx=0
for %%e in (ouml auml uuml otilde scaron zcaron Ouml Auml Uuml Otilde Scaron Zcaron) do (
    set "convert[!idx!].entity=%%e"
    set /a idx+=1
)

set /a strlen-=1
set /a idx-=1
set /a totalReplaced=0

rem loop and replace special characters with entities
for /L %%i in (0,1,%strlen%) do (
    set "char=!str:~%%i,1!"
    set "found="
    for /L %%j in (0,1,%idx%) do (
        if "!char!"=="!convert[%%j].character!" (
            set /a "replaced[%%j]+=1"
			set /a totalReplaced+=1
            set "converted=!converted!^^^&!convert[%%j].entity!;"
            set "found=1"
        )
    )
    if not defined found (
        set "converted=!converted!!char!"
    )
)

echo %converted%

if %totalReplaced% gtr 0 (
    echo Converted:
    for /L %%k in (0,1,%idx%) do (
        if defined replaced[%%k] (
            echo !convert[%%k].character!: !replaced[%%k]!
        )
    )
)

if %totalReplaced% gtr 0 (
    echo.
    echo Total: %totalReplaced%
) else (
    echo.
    echo Could not find any characters.
)

pause
exit /b


:strLen
if not "!%1:~%len%!"=="" set /A len+=1 & goto :strLen
(endlocal & set %2=%len%)
goto :eof
