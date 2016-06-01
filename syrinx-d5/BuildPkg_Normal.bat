del D:\dev\asyrinx.org\syrinx\syrinx-d5\D5\lib\*.dcu /q
SET BUILD_BAT=D:\dev\asyrinx.org\syrinx\syrinx-d5\D5\buildPkg
for /R D:\dev\asyrinx.org\syrinx\syrinx-d5\D5\source %%f in (*.pas) do call %BUILD_BAT% NORMAL %%~pf %%~ff /DPLEIADES
pause
