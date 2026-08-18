# Hardware Implementation of a 16-Bit Dadda Multiplier and an 8-Bit Logarithmic Barrel Shifter 
 
**Author:** Subanandhan Nagarajan  
**Course/ID:** 25M1257  
**Category:** Self-Project  
 
## Project Overview 
This repository contains the RTL design, simulation, and hardware implementation of two fundamental digital logic blocks: a 16-bit signed Dadda Multiplier and an 8-bit Logarithmic Barrel Shifter. The project includes behavioral simulations, post-synthesis timing simulations, and full hardware block designs mapped to an FPGA. 
 
## 1. 16-Bit Signed Dadda Multiplier 
The Dadda Multiplier was implemented to achieve high-speed signed multiplication by reducing the partial product tree to two rows prior to final addition, resulting in lower latency than standard array multipliers.  
 
* **Design:** Designed structurally using half adders and full adders. 
* **I/O Details:** Takes two signed 16-bit numbers as input and yields a signed 32-bit output. 
* **Verification:** The module's structural output (`y[31:0]`) was directly verified against an expected behavioral output utilizing the standard Verilog `*` operator (`expected[31:0]`).  
* **Results:** Simulations verified functional correctness for various bounds (e.g., -5 times 7, -10 times -4). The post-timing synthesis waveform confirmed structural integrity and logic mapping stability. 
 
## 2. 8-Bit Logarithmic Barrel Shifter 
The barrel shifter was designed to execute logical shifts in a single clock cycle, making it highly efficient. 
 
* **Design:** Implemented using structural style modeling consisting of multiplexers arranged in power-of-two stages (2^0, 2^1, 2^2). 
* **Functionality:** Supports both Right and Left Shift (Logical) operations driven by a control signal (`ctrl`) and a shift amount signal (`shamt`). 
* **Verification:** Tested with a base input of `10110011`. When shifting by an amount of `010` (2), the expected bit movement matched perfectly across both structural and behavioral paths. 
 
## Hardware Design & FPGA Debugging 
The designs were pushed to hardware using a comprehensive block design intended for real-time debugging and data validation. 
 
### Block Design Infrastructure 
* **Clocking Wizard:** Generates and locks the necessary clock domains. 
* **Virtual I/O (VIO):** Allows manual stimulation of inputs directly from the hardware environment. 
* **Integrated Logic Analyzer (ILA):** Probes internal data paths and states for real-time hardware debugging. 
* **BRAM:** Block Memory Generator integrated for data storage operations. 
* **Controller:** Custom logic acting as the interface between the hardware debug IPs and the core multiplier/shifter modules. 
 
### Constraints (`.xdc`) 
The physical hardware pins were mapped using an XDC file with the following specifications: 
* **System Clock (`sys_clock`):** Mapped to package pin `H16`. 
* **Reset (`reset_rtl`):** Mapped to package pin `D19`. 
* Both utilized the `LVCMOS33` I/O standard operating at a 3.3V reference.
