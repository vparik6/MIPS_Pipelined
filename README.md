---------------MIPS Pipelined Processor Simulator-----------------
------------------------------------------------------------------

===>>> First, create a new project in choice of your simulation tool. (questa sim prefered)

----- To run the 'top' level test 
---------1) Copy "final.dat" (found in MIPS_Pipelined/testfiles/) file your project directory to simulate the program execution.
------------2) Simulate using "mipstest.sv" testbench.


----- To run the 'unit' level test
---------1) Copy ".tv" (For ex. aludec_test.tv file found in MIPS_Pipelined/testfiles/) file for the test unit to your project directory to simulate the program execution.
------------2) Simulate using "unitTB.sv" testbench [where, {unit=aludec|controller|datapath|hazard}].
---------------NOTE: aluTB & signextTB does not require a .tv file to test.
