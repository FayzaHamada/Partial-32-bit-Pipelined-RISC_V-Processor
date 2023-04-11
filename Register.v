`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2023 08:43:40 AM
// Design Name: 
// Module Name: Register
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


module Reg #(parameter width = 32)
   (input clk,reset,
    input [width-1 : 0]     dIn,
    output reg [width-1 :0] dOut);
   always @(posedge clk )
     begin
        if(reset==0)
          dOut <=32'h00000000;
        else
          // if(!den)
            dOut <= dIn;
     end
endmodule // Reg