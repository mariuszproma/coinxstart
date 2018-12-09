@echo on
if %1.==. GOTO SetDefault
set threads=%1
goto endofsetting
:SetDefault
set threads=20
:endofsetting
echo threads
set /a nodes=threads/2
echo nodes
set /a loopcount=nodes
echo loopcount
start java -jar selenium-server-standalone-3.141.59.jar -role hub
timeout /t 5
:loop
start java -jar selenium-server-standalone-3.141.59.jar -role node -hub http://localhost:4444/grid/register
set /a loopcount=loopcount-1
if %loopcount%==0 goto exitloop
goto loop
:exitloop
timeout /t 15
java -jar scrap.jar