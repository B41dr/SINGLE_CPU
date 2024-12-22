`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: Mux2_5bits
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


module Mux2_5bits(
    input choice,
    input [4:0] input0,
    input [4:0] input1,
    output [4:0] output
    );
    
    assign output = (choice==0) ? input0 : input1;
    
endmodule
