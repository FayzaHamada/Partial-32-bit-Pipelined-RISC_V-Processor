`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2022 04:46:20 AM
// Design Name: 
// Module Name: mux3
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


module mux3 #(parameter WIDTH = 32)
 (input wire [WIDTH-1:0] d0, d1, d2,
 input wire [1:0] s,
 output wire[WIDTH-1:0] y);
 assign  y = s[1] ? d2 : (s[0] ? d1 : d0);
endmodule




