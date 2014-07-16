#!/bin/sh
# Vivado(TM)
# compile.sh: Vivado-generated Script for launching XSim application
# Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
# 
if [ -z "$PATH" ]; then
  PATH=$XILINX/lib/$PLATFORM:$XILINX/bin/$PLATFORM:/opt/Xilinx/2013.4/Vivado/2013.4/ids_lite/EDK/bin/lin64:/opt/Xilinx/2013.4/Vivado/2013.4/ids_lite/ISE/bin/lin64
else
  PATH=$XILINX/lib/$PLATFORM:$XILINX/bin/$PLATFORM:/opt/Xilinx/2013.4/Vivado/2013.4/ids_lite/EDK/bin/lin64:/opt/Xilinx/2013.4/Vivado/2013.4/ids_lite/ISE/bin/lin64:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=$XILINX/lib/$PLATFORM:/opt/Xilinx/2013.4/Vivado/2013.4/ids_lite/EDK/lib/lin64:/opt/Xilinx/2013.4/Vivado/2013.4/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=$XILINX/lib/$PLATFORM:/opt/Xilinx/2013.4/Vivado/2013.4/ids_lite/EDK/lib/lin64:/opt/Xilinx/2013.4/Vivado/2013.4/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

#
# Setup env for Xilinx simulation libraries
#
XILINX_PLANAHEAD=/opt/Xilinx/2013.4/Vivado/2013.4
export XILINX_PLANAHEAD
ExecStep()
{
   "$@"
   RETVAL=$?
   if [ $RETVAL -ne 0 ]
   then
       exit $RETVAL
   fi
}

ExecStep xelab -m64 --debug typical --relax -L work -L secureip --snapshot axim_snooper_v1_0_behav --prj /home/sf306/phd_codebase/github/AXIM_snooper/managed_ip_project/edit_axim_snooper_v1_0.sim/sim_1/behav/axim_snooper_v1_0.prj   work.axim_snooper_v1_0
