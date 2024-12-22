`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: SCPU_simulation
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

module SCPU_simulation;
    // 时钟信号和复位信号
    reg clk;
    reg reset;

    // 当前指令地址和下一个指令地址
    wire [31:0] current_instruction_address;
    wire [31:0] next_instruction_address;

    // 源寄存器和目标寄存器索引
    wire [4:0] source_register;
    wire [4:0] target_register;

    // 从寄存器读取的数据
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    // ALU结果和数据总线
    wire [31:0] alu_result;
    wire [31:0] data_bus;

    // 实例化顶层CPU模块
    Top_SCPU top_SCPU (
        .clk(clk),
        .reset(reset),
        .current_instruction_address(current_instruction_address),
        .next_instruction_address(next_instruction_address),
        .source_register(source_register),
        .target_register(target_register),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .alu_result(alu_result),
        .data_bus(data_bus)
    );

    // 生成时钟信号，周期为100ns
    always #50 clk = ~clk;

    // 初始设置
    initial begin
        // 初始化时钟信号
        clk = 1;
        
        // 初始化复位信号
        reset = 0;
        
        // 等待25ns
        #25;
        
        // 施加复位信号
        reset = 1;
        
        // 等待3000ns
        #3000;
        
        // 再等待100ns后结束仿真
        #100;
        $stop;
    end
endmodule