`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: ALU
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

module ALU(
    input [2:0] alu_operation,  // ALU 操作码
    input [31:0] input_a,  // 操作数 input_a
    input [31:0] input_b,  // 操作数 input_b
    output reg [31:0] result,  // 运算结果
    output zero,  // 结果是否为0，1表示是，0表示否
    output sign  // 结果是否为负数，1表示是，0表示否
);

    // 计算零标志
    assign zero = (result == 0) ? 1 : 0;

    // 计算符号标志
    assign sign = result[31];

    // ALU 逻辑
    always @(alu_operation or input_a or input_b) begin
        case (alu_operation)
            3'b000: result = input_a + input_b;  // 加法
            3'b001: result = input_a - input_b;  // 减法
            3'b010: result = input_b << input_a;  // 逻辑左移
            3'b011: result = input_a | input_b;  // 逻辑或
            3'b100: result = input_a & input_b;  // 逻辑与
            3'b101: result = (input_a < input_b) ? 1 : 0;  // 无符号比较
            3'b110: begin  // 有符号比较
                if ((input_a[31] == input_b[31]) && (input_a < input_b)) result = 1;
                else if (input_a[31] == 1 && input_b[31] == 0) result = 1;
                else result = 0;
            end
            3'b111: result = input_a ^ input_b;  // 逻辑异或
        endcase
    end

endmodule