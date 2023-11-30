@echo off
setlocal enabledelayedexpansion

set str=%~1

call :strLen str strlen
echo String is %strlen% characters long

set characters=ö ä ü õ š ž Ö Ä Ü Õ Š Ž
set entities=ouml auml uuml otilde scaron zcaron Ouml Auml Uuml Otilde Scaron Zcaron

(for %%a in (%entities%) do ( 
   echo %%a 
))

set "numericCount=0"

for /L %%i in (0,1,%strlen%) do (
    set "char=!str:~%%i,1!"
    if "!char!" geq "0" if "!char!" leq "9" (
        set /A numericCount+=1
    )
)

echo Number of numeric characters in the string: %numericCount%

pause
exit /b

:strLen
if not "!%1:~%len%!"=="" set /A len+=1 & goto :strLen
(endlocal & set %2=%len%)
goto :eof
