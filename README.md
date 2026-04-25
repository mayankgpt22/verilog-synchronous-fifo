**Synchronous FIFO in Verilog**

**Overview**

This repository contains the RTL design and verification of a Synchronous FIFO (First-In First-Out) buffer implemented in Verilog HDL.
The FIFO supports synchronous read/write operations using a single clock and provides status flags for FULL and EMPTY conditions.

**Features**

Parameterized FIFO Depth and Data Width
Circular Buffer Architecture
Read and Write Pointer Management
FULL / EMPTY Flag Generation
Functional Verification Using Testbench
Synthesized and Implemented in AMD Vivado
Specifications
Parameter	Value
Data Width	8-bit
FIFO Depth	8
Clock Type	Single Clock
Reset Type	Synchronous/Asynchronous (edit based on your design)

**File Structure**

rtl/ → FIFO RTL source code
tb/ → Testbench for functional verification
screenshots/ → Simulation and synthesis results

**Verification Performed**

Write Operation Verification
Read Operation Verification
FIFO Full Condition Test
FIFO Empty Condition Test
Pointer Wrap-around Verification

**Tools Used**
Verilog HDL
AMD Vivado
Xilinx FPGA Synthesis / Implementation Flow
Results

**The design was successfully:**

Simulated in Vivado
Synthesized and implemented on Xilinx FPGA fabric
Verified for correct FIFO operation


Author
Mayank Gupta
