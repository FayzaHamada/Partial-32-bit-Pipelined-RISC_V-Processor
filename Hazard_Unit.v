`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2023 08:41:06 PM
// Design Name: 
// Module Name: Hazard_Unit
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


module Hazard_Unit( input wire PCSrcE,
input wire [4:0] RS1D,RS2D,RS1E,RS2E,RD_E,RD_M,RD_W,
input wire RegWriteM,RegWriteW,
input wire [1:0] ResultSrcE,
output wire FlushD,FlushE,StallD,StallF,
output reg [1:0] ForwardAE,ForwardBE);
wire lwStall ;
always@(*)
begin 
if (((RS1E == RD_M) && RegWriteM) && (RS1E != 0))
 ForwardAE <= 10;
else if (((RS1E == RD_W) && RegWriteW) && (RS1E != 0)) 
 ForwardAE <= 01;
else  
 ForwardAE <= 00;
end 
always@(*)
begin 
if (((RS2E == RD_M) && RegWriteM) && (RS2E != 0))
 ForwardBE <= 10;
else if (((RS2E == RD_W) && RegWriteW) && (RS2E != 0)) 
 ForwardBE <= 01;
else  
 ForwardBE <= 00;
end 
//Stall when a load hazard occurs:
assign lwStall = ResultSrcE & ((RS1D == RD_E) | (RS2D == RD_E)) ;
assign StallF = lwStall ;
assign StallD = lwStall ;
//Flush when a branch is taken or a load introduces a bubble:
assign FlushD = PCSrcE ;
assign FlushE = lwStall | PCSrcE ;  
endmodule
