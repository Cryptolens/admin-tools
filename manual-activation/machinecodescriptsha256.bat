
@echo off
setlocal enabledelayedexpansion
for /f "skip=1 delims=" %%A in (
  'wmic csproduct get uuid'
) do for /f "delims=" %%B in ("%%A") do set "uuid=%%A"

for /f "skip=1 delims=" %%A in (
  'wmic computersystem get name'
) do for /f "delims=" %%B in ("%%A") do set "compName=%%A"


set newuuid="%%uuid:~0,36%%"
@echo|set/p=%newuuid%> %TEMP%\cryptolensmachinecodefile.txt

set /a count=1 
for /f "skip=1 delims=:" %%a in ('CertUtil -hashfile %TEMP%\cryptolensmachinecodefile.txt SHA256') do (
  if !count! equ 1 set "hash=%%a"
  set/a count+=1
)

echo|set/p=%hash% %compName%

endlocal
