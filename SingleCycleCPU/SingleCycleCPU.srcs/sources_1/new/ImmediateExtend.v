`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: ImmediateExtend
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

module ImmediateExtend(
    input [15:0] original,  // 原始立即数
    input extend_select,  // 扩展选择信号，0: 零扩展；1: 符号扩展
    output reg [31:0] extended  // 扩展后的立即数
);

    // 组合逻辑
    always @(*) begin
        // 低16位直接赋值
        extended[15:0] = original;
        // 根据扩展选择信号决定高16位的值
        if (extend_select == 0) 
        begin  
            // 零扩展
            extended[31:16] = 16'b0;
        end
        else 
        begin  
            // 符号扩展
            if (original[15] == 0) 
            begin
                extended[31:16] = 16'b0;
            end 
            else 
            begin
                extended[31:16] = 16'hFFFF;
            end
        end
    end

endmodule