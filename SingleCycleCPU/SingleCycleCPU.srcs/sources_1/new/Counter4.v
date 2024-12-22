`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: Counter4
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

module Counter4(
    input clk,  // 时钟信号
    output reg [1:0] count  // 2位计数器输出
);

    // 计数器逻辑
    always @(posedge clk) begin
        if (count == 2'b11) 
        begin
            count <= 0;  // 计数器达到最大值后重置为0
        end 
        else 
        begin
            count <= count + 1;  // 计数器加1
        end
    end

endmodule