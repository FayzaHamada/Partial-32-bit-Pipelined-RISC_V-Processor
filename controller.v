`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2022 06:50:47 AM
// Design Name: 
// Module Name: controller
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


module controller(input clk,reset,FlushE,
input wire [6:0] op,
 input wire [2:0] funct3,
 input wire funct7b5,
 input wire ZeroE,
 output wire [1:0] ResultSrcW,
 output wire MemWriteM,
 output wire PCSrcE, ALUSrcE,
 output wire RegWriteW, JumpE,BranchE,
 output wire [1:0] ImmSrcD,
 output wire [2:0] ALUControlE ,
 output wire [1:0] ResultSrcE,
 output wire RegWriteM);  
wire [1:0] ALUOp;
//////ID_IE WIRES///////////////////////////////////////////////////
wire RegWriteD, JumpD,BranchD,ALUSrcD,MemWriteD;
wire [2:0] ALUControlD;
wire [1:0] ResultSrcD;
//////IE_EX WIRES///////////////////////////////////////////////////
wire RegWriteE,MemWriteE;
//////EX_DM WIRES///////////////////////////////////////////////////
wire [1:0] ResultSrcM;
maindec md(op,ResultSrcD, MemWriteD, BranchD,ALUSrcD, RegWriteD, JumpD, ImmSrcD, ALUOp);
aludec ad(op[5], funct3, funct7b5, ALUOp, ALUControlD);
//////EX Stage//////////////////////////////////////////////////////////////////////////////////////////////////////
flush_reg    Reg_WriteD(clk,reset,FlushE,RegWriteD,RegWriteE);
flush_reg    Result_SrcD(clk,reset,FlushE,ResultSrcD,ResultSrcE);
flush_reg    Jump_D(clk,reset,FlushE,JumpD,JumpE) ;
flush_reg    Branch_D(clk,reset,FlushE,BranchD,BranchE) ;
flush_reg    ALUSrc_D(clk,reset,FlushE,ALUSrcD,ALUSrcE) ;
flush_reg    MemWrite_D(clk,reset,FlushE,MemWriteD,MemWriteE);
flush_reg    ALUControl_D(clk,reset,FlushE,ALUControlD,ALUControlE);
assign  PCSrcE = BranchE & ZeroE | JumpE ;

//////Reg     Reg_WriteD(clk,reset,RegWriteD,RegWriteE);
//////Reg     Result_SrcD(clk,reset,ResultSrcD,ResultSrcE);
/////Reg     Jump_D(clk,reset,JumpD,JumpE) ;
/////Reg     Branch_D(clk,reset,BranchD,BranchE) ;
////Reg     ALUSrc_D(clk,reset,ALUSrcD,ALUSrcE) ;
////Reg     MemWrite_D(clk,reset,MemWriteD,MemWriteE);
////Reg     ALUControl_D(clk,reset,ALUControlD,ALUControlE);

//////MEM Stage//////////////////////////////////////////////////////////////////////////////////////////////////////
Reg     Reg_WriteE(clk,reset,RegWriteE,RegWriteM);
Reg     Result_SrcE(clk,reset,ResultSrcE,ResultSrcM);
Reg     MemWrite_E(clk,reset,MemWriteE,MemWriteM);

//////WB Stage//////////////////////////////////////////////////////////////////////////////////////////////////////
Reg     Reg_WriteW(clk,reset,RegWriteM,RegWriteW);
Reg     Result_SrcW(clk,reset,ResultSrcM,ResultSrcW);
endmodule









