# SystemVerilog Pipelined CPU Design

This repository contains the implementation of a **SystemVerilog Pipelined CPU Design**. The project uses a modular structure to implement a 5-stage pipelined architecture, including instruction fetch, decode, execute, memory access, and write-back stages. The design is intended to simulate the operation of a simple CPU.

---

## Files Included

### Modules
- **ALU.sv**: Implements the Arithmetic Logic Unit for arithmetic and logical operations.
- **Core.sv**: Top-level CPU module coordinating all stages of the pipeline.
- **DFlipFlop.sv**: D Flip-Flop for state retention in sequential logic.
- **DRAM.sv**: Memory module for data and instruction storage.
- **EX_Stage.sv**: Execution stage of the pipeline, using the ALU for computations.
- **Fetch.sv**: Fetches instructions from the instruction memory.
- **FWD_Control.sv**: Forwarding control logic to handle data hazards.
- **ID_Stage.sv**: Instruction decode stage, generating control signals and reading registers.
- **IF_Stage.sv**: Instruction fetch stage, fetching and buffering the next instruction.
- **Instr_Mem.sv**: Instruction memory module.
- **Mem_Stage.sv**: Handles memory operations in the pipeline.
- **Register_File.sv**: Implements the CPU's general-purpose registers.
- **Stall_Control.sv**: Handles stalling logic to manage control hazards.
- **WB_Stage.sv**: Write-back stage, writing results to the register file.
- **core_pkg.sv**: Contains constants and package definitions used across the design.

---

## Overview

### Pipeline Stages
1. **Instruction Fetch (IF)**:
   - Fetches instructions from the memory.
   - Buffered for the next pipeline stage.
   
2. **Instruction Decode (ID)**:
   - Decodes the instruction into control signals.
   - Reads operand values from the register file.

3. **Execute (EX)**:
   - Performs arithmetic and logical operations using the ALU.
   - Handles branch calculations.

4. **Memory Access (MEM)**:
   - Reads or writes data to/from memory.
   - Coordinates with the `DRAM` module.

5. **Write Back (WB)**:
   - Writes computation or memory operation results back to the register file.

---

## Features

- **Pipeline Architecture**: Implements a 5-stage instruction pipeline.
- **Data Forwarding**: Resolves hazards using `FWD_Control`.
- **Stall Management**: Includes stalling logic via `Stall_Control` for hazard mitigation.
- **ALU Operations**: Supports arithmetic (ADD, SUB) and logical (AND, OR) operations.
- **Memory Integration**: Memory read/write capabilities through `Mem_Stage` and `DRAM`.
- **Instruction Set**: Basic set of instructions for simulation and testing.

---

## Setup Instructions

### Prerequisites

- **SystemVerilog Simulator**:
  - ModelSim/QuestaSim
  - VCS
  - Xilinx Vivado (for simulation only)
- **Waveform Viewer**:
  - GTKWave or built-in waveform viewers for debugging.

---

### Steps

1. **Clone the Repository**:
   ```bash
   git clone <repository_url>
   cd Pipelined-CPU-SystemVerilog
   ```
2. **Compile the Modules: Use your preferred SystemVerilog simulator to compile all .sv files**:
   ```bash
   vlog *.sv # For ModelSim
   ```
3. ** Run Simulation: Execute the testvench and view the results:
   ```bash
   vsim -do "run -all"
   ```
4. **View Waveforms: Open the generated .wlf file in a waveform viewer for debugging**:
   ```bash
   vsim wave.wlf
   ```

## Modules Breakdown

### ALU.sv
- **Purpose**: Perform arithmetic and logical operations.
- **Inputs**:
  - `operand1`: First input operand.
  - `operand2`: Second input operand.
  - `alu_ctrl`: Control signal to select the operation.
- **Output**:
  - `result`: Result of the operation.

### Core.sv
- **Purpose**: Top-level module integrating all pipeline stages.

### Fetch.sv and IF_Stage.sv
- **Purpose**: Fetches and buffers the next instruction.

### Decode.sv and ID_Stage.sv
- **Purpose**: Decodes instructions and generates control signals.

### EX_Stage.sv
- **Purpose**: Executes instructions using the ALU.

### Mem_Stage.sv
- **Purpose**: Handles memory read/write operations.

### WB_Stage.sv
- **Purpose**: Writes results back to the register file.

### FWD_Control.sv
- **Purpose**: Implements data forwarding to resolve hazards.

### Stall_Control.sv
- **Purpose**: Manages stalling to handle hazards.

### Instr_Mem.sv
- **Purpose**: Simulates instruction memory.

### DRAM.sv
- **Purpose**: Simulates main memory for data storage.

### Register_File.sv
- **Purpose**: General-purpose register file for operand storage.

---

## Testing

### Simulation
- Validate each module and the entire pipeline using testbenches.

### Waveform Analysis
- Use waveform viewers to verify the timing and functionality of each stage.

