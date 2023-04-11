`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2022 03:55:51 AM
// Design Name: 
// Module Name: imem
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



module imem(input wire [31:0] addr, output wire [31:0] instr);
 reg [31:0] ROM[255:0];
 initial
 $readmemh("riscvtest.mem",ROM);
 assign  instr = ROM[addr[31:2]]; 
endmodule











