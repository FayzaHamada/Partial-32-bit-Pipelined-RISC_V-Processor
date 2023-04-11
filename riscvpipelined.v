`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2022 06:55:34 AM
// Design Name: 
// Module Name: riscvsingle
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


module riscvpipeline(input wire clk, reset ,
 output wire [31:0]resultw, PC,
input wire [31:0] Instr,
output wire MemWriteM,
output wire [31:0] ALUResult, WriteData,
input wire[31:0] ReadData);
wire PCSrcE, ALUSrcE, RegWriteW, JumpE, branchE,ZeroE;
wire[1:0] ResultSrcW, ImmSrcD;
wire [2:0] ALUControlE;
wire [31:0] Instr_D;
wire [1:0] ResultSrcE ;
wire RegWriteM;
wire FlushE;

controller c(clk,reset,FlushE,Instr_D[6:0], Instr_D[14:12], Instr_D[30], ZeroE,ResultSrcW, MemWriteM, PCSrcE,ALUSrcE, RegWriteW, JumpE, branchE ,ImmSrcD, ALUControlE,ResultSrcE,RegWriteM);

datapath  dp(clk, reset,ResultSrcE,ResultSrcW, PCSrcE,ALUSrcE, RegWriteM,RegWriteW,ImmSrcD, ALUControlE,ZeroE,FlushE, PC, Instr,ALUResult, WriteData, ReadData,Instr_D,resultw);
endmodule













