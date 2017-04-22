@echo off
set xv_path=F:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 9f579deb1f5449d5b9368598f5787c47 -m64 --debug typical --relax --mt 2 -L fifo_generator_v13_1_3 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot logic_analyser_tb_behav xil_defaultlib.logic_analyser_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
