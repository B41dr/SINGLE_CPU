`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: Mux4_32bits
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


module Mux4_32bits(
    input [1:0] choice,
    input [31:0] input0,
    input [31:0] input1,
    input [31:0] input2,
    input [31:0] input3,
    output reg [31:0] output
    );
    
    always @(choice or input0 or input1 or input2 or input3) begin
        case(choice)
            2'b00: output = input0;
            2'b01: output = input1;
            2'b10: output = input2;
            2'b11: output = input3;
            default: output = 0;
        endcase
    end
    
endmodule
