`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: RegisterFile
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

module RegisterFile(
    input clk, // 时钟信号
    input reset,  // 复位信号
    input register_write_op_code,  // 写使能信号，1为有效
    input [4:0] read_register1,  // 读寄存器1
    input [4:0] read_register2,  // 读寄存器2
    input [4:0] write_register,  // 写寄存器
    input [31:0] write_data,  // 写入数据
    output [31:0] read_data1,  // 读出数据1
    output [31:0] read_data2  // 读出数据2
);

    // 寄存器文件
    reg [31:0] registers [1:31];
    integer i;

    // 读操作
    assign read_data1 = (read_register1 == 0) ? 0 : registers[read_register1];
    assign read_data2 = (read_register2 == 0) ? 0 : registers[read_register2];

    // 写操作
    always @(negedge clk or negedge reset) begin
        if (reset == 0) begin
            // 复位时清空所有寄存器
            for (i = 1; i <= 31; i = i + 1) begin
                registers[i] <= 0;
            end
        end else if (register_write_op_code == 1 && write_register != 0) begin
            // 写使能有效且写寄存器不为0时，写入数据
            registers[write_register] <= write_data;
        end
    end

endmodule