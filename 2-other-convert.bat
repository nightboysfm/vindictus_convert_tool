@ECHO OFF

SET "SOURCE=%~dp0hfs-extracted"

IF NOT EXIST %SOURCE% GOTO :NOSOURCE
IF [%1]==[] GOTO :EMPTY
SET TARGET=%~1
SET CHAR=%~n1
ECHO SOURCE: %SOURCE%
ECHO TARGET: %TARGET%
ECHO CHAR: %CHAR%
ECHO -------------------------------------------------
pause

REM Copy all ressources to working directory
mkdir "%TARGET%\compiled\"
for /R "%SOURCE%" %%f in (*%CHAR%*.*) do (
  echo %%f
  copy "%%f" "%TARGET%\compiled"
)

REM Delete unwanted ressources
del "%TARGET%\compiled\*.txt"
del "%TARGET%\compiled\*.wav"
del "%TARGET%\compiled\*.usm"
del "%TARGET%\compiled\*.tga"

REM Convert textures
mkdir "%TARGET%\textures\"
"%~dp0\bin\vtfedit\VTFCmd.exe" -exportformat png -folder "%TARGET%\compiled\*.vtf" -output "%TARGET%\textures"

REM Decompile models
mkdir "%TARGET%\decompiled\"
REM OK: for /R "%TARGET%\compiled\" %%f in (*.mdl) do "%~dp0\bin\crowbar\CrowbarCommandLineDecomp.exe" -p "%%f" -o "%TARGET%\decompiled"

for /R "%TARGET%\compiled\" %%f in (*.mdl) do mkdir "%TARGET%\decompiled\%%~nf"
for /R "%TARGET%\compiled\" %%f in (*.mdl) do "%~dp0\bin\crowbar\CrowbarCommandLineDecomp.exe" -p "%%f" -o "%TARGET%\decompiled\%%~nf"
REM ECHO "f:%%f nxf:%%~nxf nf:%%~nf "



REM End of processing
GOTO :END

:EMPTY
ECHO ERROR: Drag a folder named with character name on this batch script. (ie. "%CHAR%")
GOTO :END

:NOSOURCE
ECHO ERROR : Source folder empty, be sure to edit this batch file and put the correct folder in the SOURCE variable
GOTO :END

:END

pause