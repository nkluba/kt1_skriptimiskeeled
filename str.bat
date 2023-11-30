@echo off 
chcp 65001 > nul
setlocal enabledelayedexpansion

set str=%~1

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

FOR /L %%i IN (0 1 11) DO  (
   call echo %%convert[%%i].character%%
   call echo %%convert[%%i].entity%%
)

pause
exit /b


:strLen
if not "!%1:~%len%!"=="" set /A len+=1 & goto :strLen
(endlocal & set %2=%len%)
goto :eof
