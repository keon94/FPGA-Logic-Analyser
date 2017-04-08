@echo off
set xv_path=F:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim logic_analyser_tb_behav -key {Behavioral:sim_1:Functional:logic_analyser_tb} -tclbatch logic_analyser_tb.tcl -view C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design/FIFO_tb_behav.wcfg -view C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design/LAnalyser_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
