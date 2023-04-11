`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2023 08:57:31 AM
// Design Name: 
// Module Name: flush_reg
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


module flush_reg #(parameter width = 32)
   (input clk,reset,flush,
    input [width-1 : 0]     dIn,
    output reg [width-1 :0] dOut);
   always @(posedge clk )
   begin
        if(reset==0)
          dOut <=32'h00000000;
        else if (flush)
          // if(!den)
          dOut <=32'h00000000;
        else  
            dOut <= dIn;
     end
 
endmodule // Reg