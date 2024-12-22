`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: Mux4_8bits
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


module Mux4_4bits(
    input [1:0] choice,
    input [3:0] input0,
    input [3:0] input1,
    input [3:0] input2,
    input [3:0] input3,
    output reg [3:0] output
    );
    
    always @(*) begin
        case(choice)
            0: output <= input0;
            1: output <= input1;
            2: output <= input2;
            3: output <= input3;
        endcase
    end
    
endmodule
