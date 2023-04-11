`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2022 05:46:40 AM
// Design Name: 
// Module Name: datapath
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
module datapath(input wire clk, reset,
 input wire [1:0] ResultSrcE,ResultSrcW,
input wire PCSrcE, ALUSrcE,
input wire RegWriteM,RegWriteW,
input wire [1:0] ImmSrcD ,
input wire [2:0] ALUControlE ,
output wire ZeroE,FlushE,
output wire [31:0] PCF ,
input wire [31:0] Instr ,
output wire [31:0] ALUResultM,WriteDataM ,
input wire [31:0] ReadDataM,
output wire [31:0] Instr_D,resultw);
wire [4:0] RD_M,RD_W;
wire [31:0] PCPlus4_M , PCPlus4_W , ALUResultW;

      wire [31:0] PCNext, PCPlus4, PCTarget,PCTargetE,ReadDataW;
      wire [31:0] ImmExtD,ImmExtE;
      wire [31:0] SrcA,SrcAE ,SrcBE ;
     //wire [31:0] ResultW;
      wire [31:0] PCPlus4_D, PC_D;
      wire [31:0] PC_E, PCPlus4_E;
      wire [31:0] WriteData_E;
      wire [4:0]  RD_E;
      wire [31:0] ALUResultE;
      wire [31:0] WriteDataD,WriteDataE;
      wire [4:0] RS1E,RS2E ;
     wire  [31:0]       RD1E , RD2E ;
      wire [1:0] ForwardAE,ForwardBE ;
      wire FlushD,StallD,StallF;
      
        
 // next PC logic
 //assign SrcB = WriteData;
 ///assign result = wd3;
 
 
 //IF STAGE/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
 adder pcadd4(PCF, 32'd4, PCPlus4);
 
  mux2   pcmux(PCPlus4, PCTargetE, PCSrcE, PCNext);
 
 flopr  pcreg(clk,reset,~StallF, PCNext, PCF);
 //flopr  pcreg(clk,reset,PCNext, PCF);
 //IF_ID pipelineRegisters
 
en_reg  IR_DReg(clk,reset,FlushD,StallD,Instr,Instr_D); //IF_ID_den
en_reg  PC4_DReg(clk,reset,FlushD,StallD,PCPlus4 ,PCPlus4_D); //IF_ID_den
en_reg  PCNext_DReg(clk,reset,FlushD,StallD,PCF,PC_D); //IF_ID_den
   
//Reg IR_DReg(clk,reset,Instr,Instr_D); //IF_ID_den
//Reg PC4_DReg(clk,reset,PCPlus4 ,PCPlus4_D); //IF_ID_den
//Reg  PCNext_DReg(clk,reset,PCF,PC_D); //IF_ID_den
 
//ID STAGE//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 // register file logic 
 regfile rf(clk, RegWriteW, Instr_D[19:15], Instr_D[24:20],RD_W, resultw, SrcA, WriteDataD);
 extend ext(Instr_D[31:7], ImmSrcD, ImmExtD);
 
 //ID_EX pipelineRegisters
   //Reg        IR_EReg(clk,reset,instr_D,instr_E);//IR_E_Clear
   
  flush_reg        PC8_EReg(clk,reset,FlushE,PC_D,PC_E);
  flush_reg        PC16_EReg(clk,reset,FlushE,PCPlus4_D,PCPlus4_E); 
  flush_reg      RS1_EReg(clk,reset,FlushE,SrcA , RD1E);  /////SOURCE 1
  flush_reg        RS2_EReg(clk,reset,FlushE,WriteDataD, RD2E); /////SOURCE 2
  flush_reg        RD_EReg(clk,reset,FlushE,Instr_D[11:7],RD_E); /////////////DESTINATION 
  flush_reg         RS1EReg(clk,reset,FlushE,Instr_D[19:15],RS1E);
  flush_reg        RS2EReg(clk,reset,FlushE,Instr_D[24:20],RS2E);
  flush_reg         extReg(clk,reset,FlushE,ImmExtD,ImmExtE);
   
   
   
   
   // Reg        PC8_EReg(clk,reset,PC_D,PC_E);
  //Reg        PC16_EReg(clk,reset,PCPlus4_D,PCPlus4_E);
   
 // Reg    RS1_EReg(clk,reset,SrcA , RD1E);  /////SOURCE 1
  //Reg        RS2_EReg(clk,reset,WriteDataD, RD2E); /////SOURCE 2
 //Reg        RD_EReg(clk,reset,Instr_D[11:7] ,RD_E); /////////////DESTINATION
   
 //Reg        RS1EReg(clk,reset,Instr_D[19:15] ,RS1E);
//Reg  RS2EReg(clk,reset,Instr_D[24:20] ,RS2E);
  // Reg         extReg(clk,reset,ImmExtD,ImmExtE);
   
   
   
   
  
 //EX STAGE ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 // ALU logic
 mux3 RSA1( RD1E,resultw,ALUResultM,ForwardAE,SrcAE  );
 
 mux3 RSB1(  RD2E,resultw,ALUResultM,ForwardBE,WriteDataE  );
 mux2 srcbmux(WriteDataE,ImmExtE, ALUSrcE, SrcBE);
 adder pcaddbranch(PC_E, ImmExtE, PCTargetE);
 alu alu(SrcAE , SrcBE , ALUControlE , ALUResultE , ZeroE);
 
 //EX_MEM pipelineRegisters
 
  Reg        PC20_EReg(clk,reset,PCPlus4_E,PCPlus4_M);
  
  Reg        RS2_MReg(clk,reset,WriteDataE,WriteDataM);
  
  Reg        RD_MReg(clk,reset,RD_E,RD_M);
  
  Reg       ALUResultReg_M(clk,reset,ALUResultE,ALUResultM);
   
 	 //MEM_WB pipelineRegisters /////////////////////////////////////////////////////////////////////////////////////////////////////
   Reg        PC24_EReg(clk,reset,PCPlus4_M, PCPlus4_W);
   Reg        RD_WReg(clk,reset,RD_M,RD_W);
   
   Reg        ALUResultReg_W(clk,reset,ALUResultM,ALUResultW);
   
   Reg        rDataReg(clk,reset,ReadDataM,ReadDataW);
 
 ////WB STAGE 
 mux3 resultmux(ALUResultW, ReadDataW, PCPlus4_W,ResultSrcW, resultw);
 
 Hazard_Unit hazard(PCSrcE,Instr_D[19:15],Instr_D[24:20],RS1E,RS2E,RD_E,RD_M,RD_W,
 RegWriteM,RegWriteW,ResultSrcE,FlushD,FlushE,StallD,StallF,ForwardAE,ForwardBE);
 
endmodule