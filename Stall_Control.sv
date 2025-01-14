//***********************************************************
// ECE 3058 Architecture Concurrency and Energy in Computation
//
// RISCV Processor System Verilog Behavioral Model
//
// School of Electrical & Computer Engineering
// Georgia Institute of Technology
// Atlanta, GA 30332
//
//  Module:     core_tb
//  Functionality:
//      Stall Controller for a 5 Stage RISCV Processor
//
//***********************************************************
import CORE_PKG::*;

module Stall_Control (
  input logic reset, 

  input logic [6:0] ID_instr_opcode_ip,
  input logic [4:0] ID_src1_addr_ip,
  input logic [4:0] ID_src2_addr_ip,

  //The destination register from the different stages
  input logic [4:0] EX_reg_dest_ip,  // destination register from EX pipe
  input logic [4:0] LSU_reg_dest_ip,
  input logic [4:0] WB_reg_dest_ip,
  input logic WB_write_reg_en_ip,

  // The opcode of the current instr. in ID/EX
  input [6:0] EX_instr_opcode_ip,

  output logic stall_op
);

  always_comb begin
    stall_op = 1'b0;
    case(ID_instr_opcode_ip) 

      OPCODE_OP: begin
        
        /**
        * Task 1
        * 
        * Here you will need to decide when to pull the stall control logic high. 
        * 
        * 1. Load to use stalls
        * 2. Stalls when reading and writing from Register File
        * For Register Register instructions, what registers are relevant
        */
        // Load Hazzard
        // check if EX stage is a load instruction
        // check if current reg in ID === dest reg in EX stage
        // WB Hazzard
        // check if WB is writing to reg
        // check that WB dest reg !==0
        // check if current reg in ID === dest reg in WB stage
        // check for conflict in dest reg of EX || LSU
        if ((EX_instr_opcode_ip === OPCODE_LOAD) && ((ID_src1_addr_ip === EX_reg_dest_ip) || (ID_src2_addr_ip === EX_reg_dest_ip))) begin
          stall_op = 1'b1;
        end else if ((WB_write_reg_en_ip) && (WB_reg_dest_ip !== 5'b00000) && (ID_src1_addr_ip === WB_reg_dest_ip) && (ID_src1_addr_ip !== EX_reg_dest_ip) && (ID_src1_addr_ip !== LSU_reg_dest_ip)) begin
          stall_op = 1'b1;
        end else if ((WB_write_reg_en_ip) && (WB_reg_dest_ip !== 5'b00000) && (ID_src2_addr_ip === WB_reg_dest_ip) && (ID_src2_addr_ip !== EX_reg_dest_ip) && (ID_src2_addr_ip !== LSU_reg_dest_ip)) begin
          stall_op = 1'b1;
        end
      end

// check for (WB_reg_dest_ip != 5'b0) ???

      OPCODE_OPIMM: begin

        /**
        * Task 1
        * 
        * Here you will need to decide when to pull the stall control logic high. 
        * 
        * 1. Load to use stalls
        * 2. Stalls when reading and writing from Register File
        * For Register Immedite instructions, what registers are relevant
        */
        if ((EX_instr_opcode_ip === OPCODE_LOAD) && ((ID_src1_addr_ip === EX_reg_dest_ip))) begin
          stall_op = 1'b1;
        end else if ((WB_write_reg_en_ip) && (WB_reg_dest_ip !== 5'b00000) && (ID_src1_addr_ip === WB_reg_dest_ip) && (ID_src1_addr_ip !== EX_reg_dest_ip) && (ID_src1_addr_ip !== LSU_reg_dest_ip)) begin
        stall_op = 1'b1;
        end
      end

      default: begin
        stall_op = 1'b0;
      end
    endcase
  end

endmodule
