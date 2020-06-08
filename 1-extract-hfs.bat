@ECHO OFF

IF [%1]==[] GOTO :EMPTY
SET SOURCE=%~1
SET "TARGET=%~dp0hfs-extracted"

ECHO SOURCE: %SOURCE%
ECHO TARGET: %TARGET%
ECHO -------------------------------------------------
pause

REM Extract HFS encrypted file
mkdir "%TARGET%\"
"%~dp0bin\hfsextract\HFSExtract.CLI.exe" "%SOURCE%" "%TARGET%"

REM End of processing
GOTO :END

:EMPTY
ECHO ERROR: Drag the "hfs" folder from Vindictus install directory on this batch script.
GOTO :END

:END

pause