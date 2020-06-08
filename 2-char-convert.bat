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
for /R "%SOURCE%" %%f in (pc_%CHAR%_*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_inner*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_hair_*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_neamhain_*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (pc_female_chinaset_%CHAR%*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_base.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_common_*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_default*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_skin_*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_face*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_pupil_*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_eye*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_brow*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_ex.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_scar*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_piercing*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_painting*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_makeup*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_teeth*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_shoes_off.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_glove_off.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (%CHAR%_armor_off.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (npc_%CHAR%_*.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"
for /R "%SOURCE%" %%f in (ghost_%CHAR%.*) do echo "%%f" && copy "%%f" "%TARGET%\compiled"

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