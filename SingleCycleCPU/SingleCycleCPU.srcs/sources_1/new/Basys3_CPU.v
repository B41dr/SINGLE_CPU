`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: Basys3_CPU
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

module Basys3_CPU(
    input basys3_clock,  // Basys3 板上的时钟信号
    input reset_sw,  // 复位开关
    input [1:0] sw_code,  // 选择开关
    input next_button,  // 下一步按钮
    output [3:0] op_code,  // 操作码
    output [7:0] seg_code  // 7段显示码
);

    wire [31:0] currentIAddr, nextIAddr;  // 当前指令地址和下一个指令地址
    wire [4:0] rs, rt;  // 寄存器源和目标
    wire [31:0] ReadData1, ReadData2;  // 读取的数据
    wire [31:0] ALU_result, DataBus;  // ALU 结果和数据总线

    wire next_signal;  // 下一步信号
    wire [15:0] hex_code;  // 16位十六进制代码

    // CPU 核心模块
    Top_SCPU Top_SCPU(
        .clk(next_signal),  // 取指阶段使用的时钟信号，由下一步按钮提供
        .Reset(reset_sw),
        .currentIAddr(currentIAddr),
        .nextIAddr(nextIAddr),
        .rs(rs),
        .rt(rt),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .ALU_result(ALU_result),
        .DataBus(DataBus)
    );

    // 四位LED显示模块
    Four_LED Four_LED(
        .clock(basys3_clock),
        .reset(reset_sw),
        .hex3(hex_code[15:12]),
        .hex2(hex_code[11:8]),
        .hex1(hex_code[7:4]),
        .hex0(hex_code[3:0]),
        .op_code(op_code),
        .seg_code(seg_code)
    );

    // 16位4选1多路选择器模块
    Mux4_16bits Mux4_16bits(
        .choice(sw_code),
        .in0({currentIAddr[7:0], nextIAddr[7:0]}),
        .in1({3'b000, rs, ReadData1[7:0]}),
        .in2({3'b000, rt, ReadData2[7:0]}),
        .in3({ALU_result[7:0], DataBus[7:0]}),
        .out(hex_code)
    );

    // 按键消抖模块
    Button_Debounce Button_Debounce(
        .clk(basys3_clock),
        .btn_in(next_button),
        .btn_out(next_signal)
    );

endmodule