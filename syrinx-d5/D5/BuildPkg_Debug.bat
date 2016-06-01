del D:\dev\asyrinx.org\syrinx\syrinx-d5\D5\lib\debug\*.dcu /q
SET BUILD_BAT=D:\dev\asyrinx.org\syrinx\syrinx-d5\D5\buildPkg.bat
for /R D:\dev\asyrinx.org\syrinx\syrinx-d5\D5\source %%I in (*.pas) do call %BUILD_BAT% DEBUG %%~pI %%~fI /DPLEIADES
pause
