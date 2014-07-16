@echo off
rem  Vivado(TM)
rem  compile.bat: a Vivado-generated XSim simulation Script
rem  Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.

set PATH=$XILINX/lib/$PLATFORM:$XILINX/bin/$PLATFORM;/opt/Xilinx/2013.4/Vivado/2013.4/ids_lite/EDK/bin/lin64:/opt/Xilinx/2013.4/Vivado/2013.4/ids_lite/ISE/bin/lin64;/opt/Xilinx/2013.4/Vivado/2013.4/ids_lite/EDK/lib/lin64:/opt/Xilinx/2013.4/Vivado/2013.4/ids_lite/ISE/lib/lin64;/opt/Xilinx/2013.4/Vivado/2013.4/bin;%PATH%
set XILINX_PLANAHEAD=/opt/Xilinx/2013.4/Vivado/2013.4

xelab -m64 --debug typical --relax -L work -L secureip --snapshot axim_snooper_v1_0_behav --prj /home/sf306/phd_codebase/github/AXIM_snooper/managed_ip_project/edit_axim_snooper_v1_0.sim/sim_1/behav/axim_snooper_v1_0.prj   work.axim_snooper_v1_0
if errorlevel 1 (
   cmd /c exit /b %errorlevel%
)
