`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2022 05:23:27 AM
// Design Name: 
// Module Name: flopenr
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


module flopenr #(parameter WIDTH = 8)
 (input wire clk, reset, en,
 input wire [WIDTH-1:0] d,
 output reg [WIDTH-1:0] q);
always @(posedge clk, posedge reset)
begin
 #10 if(reset) q <= 0;
  else if(en) q <= d;
 end
endmodule