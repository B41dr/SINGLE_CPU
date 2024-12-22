`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: Top_SCPU
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

module Top_SCPU(
    input clk,
    input reset,
    output [31:0] current_instruction_address,
    output [31:0] next_instruction_address,
    output [4:0] source_register,
    output [4:0] target_register,
    output [31:0] read_data1,
    output [31:0] read_data2,
    output [31:0] alu_result,
    output [31:0] data_bus
);

    // 指令字段
    wire [5:0] opcode;
    wire [4:0] destination_register;
    wire [15:0] immediate_value;

    // 中间信号
    wire [31:0] instruction_code;
    wire [31:0] extended_immediate;
    wire pc_write_op_code, register_write_op_code, register_destination, data_memory_source, alu_source_a, alu_source_b, memory_read, memory_write, extend_select;
    wire [1:0] pc_source;
    wire [2:0] alu_operation;
    wire alu_zero, alu_sign;
    wire [5:0] write_register;
    wire [31:0] write_data;
    wire [31:0] alu_input_a, alu_input_b;
    wire [31:0] data_memory_output;

    // 计算下一条指令地址
    wire [31:0] next_address_0 = current_instruction_address + 4;
    wire [31:0] next_address_1 = next_address_0 + (extended_immediate << 2);
    wire [31:0] next_address_2 = {current_instruction_address[31:28], instruction_code[25:0], 2'b00};

    // 数据总线输出
    assign data_bus = write_data;

    // 指令字段赋值
    assign opcode = instruction_code[31:26];
    assign source_register = instruction_code[25:21];
    assign target_register = instruction_code[20:16];
    assign destination_register = instruction_code[15:11];
    assign immediate_value = instruction_code[15:0];

    // 控制单元
    ControlUnit ControlUnit(
        .opcode(opcode), .zero(alu_zero), .sign(alu_sign),
        .pc_write_op_code(pc_write_op_code), .alu_source_a(alu_source_a), .alu_source_b(alu_source_b), .data_memory_source(data_memory_source), .register_write_op_code(register_write_op_code),
        .memory_read(memory_read), .memory_write(memory_write), .register_destination(register_destination), .extend_select(extend_select),
        .pc_source(pc_source), .alu_operation(alu_operation)
    );

    // 程序计数器
    PC PC(
        .clk(clk), .reset(reset), .pc_write_op_code(pc_write_op_code), .next_instruction_address(next_instruction_address),
        .current_instruction_address(current_instruction_address)
    );

    // 指令存储器
    InstructionMemory InstructionMemory(
        .instruction_address(current_instruction_address),
        .instruction_data_out(instruction_code)
    );

    // 寄存器文件
    RegisterFile RegisterFile(
        .clk(clk), .reset(reset), .register_write_op_code(register_write_op_code),
        .read_register1(source_register), .read_register2(target_register), .write_register(write_register), .write_data(write_data),
        .read_data1(read_data1), .read_data2(read_data2)
    );

    // 算术逻辑单元
    ALU ALU(
        .alu_operation(alu_operation), .input_a(alu_input_a), .input_b(alu_input_b),
        .result(alu_result), .zero(alu_zero), .sign(alu_sign)
    );

    // 数据存储器
    DataMemory DataMemory(
        .clk(clk), .data_address(alu_result), .data_in(read_data2), .read_op_code(memory_read), .write_op_code(memory_write),
        .data_out(data_memory_output)
    );

    // 立即数扩展
    ImmediateExtend ImmediateExtend(
        .original(immediate_value), .extend_select(extend_select),
        .extended(extended_immediate)
    );

    // 下一条指令地址选择
    Mux4_32bits Mux_nextIAddr(
        .choice(pc_source), .input0(next_address_0), .input1(next_address_1), .input2(next_address_2), .input3(current_instruction_address),
        .output(next_instruction_address)
    );

    // 写入寄存器选择
    Mux2_5bits Mux_WriteReg(
        .choice(register_destination), .input0(target_register), .input1(destination_register),
        .output(write_register)
    );

    // 写入数据选择
    Mux2_32bits Mux_WriteData(
        .choice(data_memory_source), .input0(alu_result), .input1(data_memory_output),
        .output(write_data)
    );

    // ALU 输入A选择
    Mux2_32bits Mux_ALU_inA(
        .choice(alu_source_a), .input0(read_data1), .input1({27'd0, immediate_value[10:6]}),
        .output(alu_input_a)
    );

    // ALU 输入B选择
    Mux2_32bits Mux_ALU_inB(
        .choice(alu_source_b), .input0(read_data2), .input1(extended_immediate),
        .output(alu_input_b)
    );

endmodule