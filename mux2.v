`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2022 05:19:40 AM
// Design Name: 
// Module Name: mux2
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

module mux2 #(parameter WIDTH = 32)
 (input wire [WIDTH-1:0] d0, d1,
 input wire s,
 output wire [WIDTH-1:0] y);
 assign  y = s ? d1 : d0;
endmodule









