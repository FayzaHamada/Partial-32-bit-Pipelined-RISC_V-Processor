`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2022 05:32:12 AM
// Design Name: 
// Module Name: flopr
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


module flopr #(parameter WIDTH = 32)
 (input wire clk, reset,
 stall,
 input wire [WIDTH-1:0] d,
 output reg [WIDTH-1:0] q);

 always @(posedge clk)
 begin
  if (reset==0) begin
    q <= 32'h00000000;
 end
else if (stall)begin
   q <= d;
end
end
endmodule







