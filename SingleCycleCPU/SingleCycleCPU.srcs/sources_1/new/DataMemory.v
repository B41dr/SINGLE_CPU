`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: DataMemory
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

module DataMemory(
    input clk,  // 时钟信号
    input [31:0] data_address,  // 地址
    input [31:0] data_in,  // 输入数据
    input read_op_code,  // 读使能信号，1有效
    input write_op_code,  // 写使能信号，1有效
    output [31:0] data_out  // 输出数据
);

    // 数据存储器
    reg [7:0] ram [0:63];  // 每个存储单元为8位，共64个存储单元

    // 读操作
    assign data_out[7:0]   = (read_op_code == 1) ? ram[data_address + 3] : 8'bz;
    assign data_out[15:8]  = (read_op_code == 1) ? ram[data_address + 2] : 8'bz;
    assign data_out[23:16] = (read_op_code == 1) ? ram[data_address + 1] : 8'bz;
    assign data_out[31:24] = (read_op_code == 1) ? ram[data_address + 0] : 8'bz;

    // 写操作
    always @(negedge clk) begin
        if (write_op_code == 1) begin
            ram[data_address + 0] <= data_in[31:24];
            ram[data_address + 1] <= data_in[23:16];
            ram[data_address + 2] <= data_in[15:8];
            ram[data_address + 3] <= data_in[7:0];
        end
    end

endmodule
