
@echo off

for /f "skip=1 delims=" %%A in (
  'wmic csproduct get uuid'
) do for /f "delims=" %%B in ("%%A") do set "uuid=%%A"

for /f "skip=1 delims=" %%A in (
  'wmic computersystem get name'
) do for /f "delims=" %%B in ("%%A") do set "compName=%%A"


@echo|set /p=%uuid%   %compName%