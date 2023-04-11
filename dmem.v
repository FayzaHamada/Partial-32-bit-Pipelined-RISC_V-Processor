`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2022 04:29:18 AM
// Design Name: 
// Module Name: dmem
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





module dmem(input wire clk, we,
 input wire [31:0] a,
 input wire [31:0] wd,
 output wire [31:0] rd);
 reg [31:0] RAM[255:0];
 assign rd = RAM[a[31:2]]; // word aligned
 always @(posedge clk)
 if (we) RAM[a[31:2]] <= wd;
endmodule













