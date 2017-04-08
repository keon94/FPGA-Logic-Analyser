@echo off
set xv_path=F:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 401c048996484e60aff7e80220f8de4b -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot logic_analyser_tb_behav xil_defaultlib.logic_analyser_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
