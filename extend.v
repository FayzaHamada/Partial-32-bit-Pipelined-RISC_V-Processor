`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2022 05:34:23 AM
// Design Name: 
// Module Name: extend
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

module extend(input wire [31:7] instr,
 input wire [1:0] immsrc,
 output reg [31:0] immext);
 always@(*) 
 case(immsrc)
 // I-type
 2'b00:  immext = {{20{instr[31]}}, instr[31:20]};
 // S-type (stores)
 2'b01:  immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
 // B-type (branches)
 2'b10:  immext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; 
 // J-type (jal)
 2'b11:   immext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
 default:  immext = 32'bx; // undefined
 endcase
endmodule
