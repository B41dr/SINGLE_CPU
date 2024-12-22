`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: PC
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

module PC(
    input clk,  // 时钟信号
    input reset,  // 复位信号
    input pc_write_op_code,  // 程序计数器写使能信号
    input [31:0] next_instruction_address,  // 下一条指令地址
    output reg [31:0] current_instruction_address  // 当前指令地址
);

    // 初始化当前指令地址
    initial current_instruction_address = 0;

    // 时序逻辑
    always @(posedge clk or negedge reset) begin
        if (reset == 0) begin
            // 复位时将当前指令地址清零
            current_instruction_address <= 0;
        end else if (pc_write_op_code == 1) begin
            // 写使能有效时，更新当前指令地址为下一条指令地址
            current_instruction_address <= next_instruction_address;
        end
    end

endmodule