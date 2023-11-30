@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

set str=%~1

call :strLen str strlen
echo String is %strlen% characters long

set characters=ö ä ü õ š ž Ö Ä Ü Õ Š Ž
set entities=ouml auml uuml otilde scaron zcaron Ouml Auml Uuml Otilde Scaron Zcaron

for /L %%i in (0,1,%strlen%) do (
    set "char=!str:~%%i,1!"
    set "found="
	echo !char!
	for %%a in (%characters%) do ( 
	    echo %%a 
		if !char! equ %%a (
            echo Found: !char!
        )
	    )
	)
)
	
pause
exit /b

:strLen
if not "!%1:~%len%!"=="" set /A len+=1 & goto :strLen
(endlocal & set %2=%len%)
goto :eof
