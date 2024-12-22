`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: ControlUnit
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

module ControlUnit(
    input [5:0] opcode,  // 操作码
    input zero,  // 零标志
    input sign,  // 符号标志
    output reg pc_write_op_code,  // 程序计数器写使能
    output reg alu_source_a,  // ALU 源A选择
    output reg alu_source_b,  // ALU 源B选择
    output reg data_memory_source,  // 数据总线数据源选择
    output reg register_write_op_code,  // 寄存器写使能
    output reg InsMemRW,  // 指令存储器读写使能
    output reg memory_read,  // 存储器读使能
    output reg memory_write,  // 存储器写使能
    output reg register_destination,  // 寄存器目标选择
    output reg extend_select,  // 扩展选择
    output reg [1:0] pc_source,  // 程序计数器源选择
    output reg [2:0] alu_operation  // ALU 操作码
);

    always @(opcode or zero or sign) begin
        case (opcode)
            6'b000000: begin  // add
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b000110010;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b00_000;
            end
            6'b000001: begin  // sub
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b000110010;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b00_001;
            end
            6'b000010: begin  // addiu
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b010110001;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b00_000;
            end
            6'b010000: begin  // andi
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b010110000;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b00_100;
            end
            6'b010001: begin  // and
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b000110010;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b00_100;
            end
            6'b010010: begin  // ori
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b010110000;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b00_011;
            end
            6'b010011: begin  // or
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b000110010;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b00_011;
            end
            6'b011000: begin  // sll
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b100110010;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b00_010;
            end
            6'b011100: begin  // slti
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b010110001;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b00_110;
            end
            6'b100110: begin  // sw
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b010010101;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b00_000;
            end
            6'b100111: begin  // lw
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b011111001;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b00_000;
            end
            6'b110000: begin  // beq
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b000010001;
                pc_source[1:0] <= (zero == 1) ? 2'b01 : 2'b00;
                alu_operation[2:0] <= 3'b001;
            end
            6'b110001: begin  // bne
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b000010001;
                pc_source[1:0] <= (zero == 0) ? 2'b01 : 2'b00;
                alu_operation[2:0] <= 3'b001;
            end
            6'b110010: begin  // bltz
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b000010001;
                pc_source[1:0] <= (sign == 1) ? 2'b01 : 2'b00;
                alu_operation[2:0] <= 3'b000;
            end
            6'b111000: begin  // j
                pc_write_op_code <= 1;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b000010000;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b10_000;
            end
            6'b111111: begin  // halt
                pc_write_op_code <= 0;
                {alu_source_a, alu_source_b, data_memory_source, register_write_op_code, InsMemRW, memory_read, memory_write, register_destination, extend_select} <= 9'b000010000;
                {pc_source[1:0], alu_operation[2:0]} <= 5'b11_000;
            end
        endcase
    end

endmodule