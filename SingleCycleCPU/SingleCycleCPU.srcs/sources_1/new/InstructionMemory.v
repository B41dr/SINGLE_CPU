`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: InstructionMemory
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

module InstructionMemory(
    input [31:0] instruction_address,  // 指令地址
    output [31:0] instruction_data_out  // 指令数据输出
);

    // 指令存储器
    reg [7:0] rom [0:95];

    // 初始化指令存储器
    initial begin
        $readmemb("E:/_Vivado/MIPS_CPU_Design/SingleCycleCPU/test_instructions.txt", rom);
    end

    // 根据指令地址读取指令数据
    assign instruction_data_out[31:24] = rom[instruction_address + 0];
    assign instruction_data_out[23:16] = rom[instruction_address + 1];
    assign instruction_data_out[15:8]  = rom[instruction_address + 2];
    assign instruction_data_out[7:0]   = rom[instruction_address + 3];

endmodule
