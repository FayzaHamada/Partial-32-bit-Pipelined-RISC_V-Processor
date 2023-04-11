`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2022 07:49:25 AM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(input wire clk, reset,
 output wire [31:0] resultw,WriteData, DataAdr,
 output wire MemWrite,
 output  wire [31:0] PC);
 wire [31:0] Instr, ReadData;
  
 
 // instantiate processor and memories
 riscvpipeline rvpipe(clk, reset,resultw, PC, Instr, MemWrite, DataAdr, WriteData, ReadData);
 
 imem imem(PC, Instr);
 
 dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
 
endmodule













