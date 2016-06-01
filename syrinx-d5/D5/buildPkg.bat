rem @ECHO OFF

:begin
	cd %2
	SET PATHDCC32=C:\Progra~1\Borland\Delphi5\Bin\DCC32.EXE
	SET PATHBPL=D:\dev\asyrinx.org\syrinx\syrinx-d5\D5\bpl
	SET PATHLIB=D:\dev\asyrinx.org\syrinx\syrinx-d5\D5\lib
	if "%1" == "NORMAL" goto build_normal
	if "%1" == "DEBUG" goto build_debug
goto build_normal

:build_debug
	@ECHO ON
	call %PATHDCC32% /N%PATHLIB%\debug /$D+ /U%PATHLIB%\debug;%PATHBPL% /LE%PATHBPL% /LN%PATHBPL% /B %3 %4
	@ECHO OFF
goto end

:build_normal
	@ECHO ON
	call %PATHDCC32% /N%PATHLIB% /$D- /U%PATHLIB%;%PATHBPL% /LE%PATHBPL% /LN%PATHBPL% /B %3 %4
	@ECHO OFF
goto end

:end
