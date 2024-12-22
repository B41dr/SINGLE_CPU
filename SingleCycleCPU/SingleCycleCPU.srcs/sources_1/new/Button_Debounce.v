`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: Button_Debounce
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

module Button_Debounce(
    input clk,  // 时钟信号
    input btn_in,  // 按键输入
    output btn_out  // 消抖后的按键输出
);

    reg [2:0] btn_reg = 0;  // 按键状态寄存器
    wire clk_20ms;  // 20ms 时钟信号

    // 20ms 时钟分频模块
    ClockDivisor #(.n(1000000)) t_20ms (.clkin(clk), .clkout(clk_20ms));

    // 按键状态同步
    always @(posedge clk_20ms) begin
        btn_reg[0] <= btn_in;
        btn_reg[1] <= btn_reg[0];
        btn_reg[2] <= btn_reg[1];
    end

    // 消抖逻辑
    assign btn_out = (btn_reg[2] & btn_reg[1] & btn_reg[0]) | (~btn_reg[2] & btn_reg[1] & btn_reg[0]);

endmodule

module ClockDivisor(
    input clkin,  // 输入时钟信号
    output reg clkout = 0  // 输出时钟信号
);

    parameter n = 50000000;  // 分频系数
    reg [31:0] count = 0;  // 计数器

    always @(posedge clkin) begin
        if (count < n - 1) begin
            count <= count + 1;
        end else begin
            count <= 0;
            clkout <= ~clkout;
        end
    end

endmodule
