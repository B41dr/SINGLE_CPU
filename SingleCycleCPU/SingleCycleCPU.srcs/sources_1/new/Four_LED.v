`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: top_LEDs
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

module Four_LED(
    input clock,  // 时钟信号
    input reset,  // 复位信号
    input [3:0] hex0,  // 第一个4位十六进制数
    input [3:0] hex1,  // 第二个4位十六进制数
    input [3:0] hex2,  // 第三个4位十六进制数
    input [3:0] hex3,  // 第四个4位十六进制数
    output reg [3:0] op_code,  // 操作码
    output [7:0] seg_code  // 7段显示码
);

    wire clk_sys;  // 分频后的时钟信号
    wire [1:0] count;  // 计数器输出
    wire [3:0] hex_num;  // 选择的4位十六进制数

    // 时钟分频模块
    clk_div clk_div(
        .clk(clock),
        .clk_sys(clk_sys)
    );

    // 4位计数器模块
    Counter4 Counter4(
        .clk(clk_sys),
        .count(count)
    );

    // 4位16进制数到7段显示码转换模块
    Hex_To_7Seg Hex_To_7Seg(
        .hex(hex_num),
        .seg_code(seg_code)
    );

    // 4选1多路选择器模块
    Mux4_4bits Mux4_4bits(
        .choice(count),
        .in0(hex0),
        .in1(hex1),
        .in2(hex2),
        .in3(hex3),
        .out(hex_num)
    );

    // 根据计数器值生成操作码
    always @(count) begin
        case (count)
            2'b00: op_code = 4'b1110;
            2'b01: op_code = 4'b1101;
            2'b10: op_code = 4'b1011;
            2'b11: op_code = 4'b0111;
        endcase
    end

endmodule