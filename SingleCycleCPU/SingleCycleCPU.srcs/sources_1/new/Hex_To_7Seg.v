`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/22 13:00:09
// Design Name: 
// Module Name: Hex_To_7Seg
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

module Hex_To_7Seg(
    input [3:0] hex,  // 4位十六进制数
    output reg [7:0] seg_code  // 7段显示码
);

    // 组合逻辑
    always @(*) begin
        // [7:0] 对应段码 DP, g, f, e, d, c, b, a
        case (hex)
            4'h0: seg_code = 8'b1100_0000; // 0
            4'h1: seg_code = 8'b1111_1001; // 1
            4'h2: seg_code = 8'b1010_0100; // 2
            4'h3: seg_code = 8'b1011_0000; // 3
            4'h4: seg_code = 8'b1001_1001; // 4
            4'h5: seg_code = 8'b1001_0010; // 5
            4'h6: seg_code = 8'b1000_0010; // 6
            4'h7: seg_code = 8'b1101_1000; // 7
            4'h8: seg_code = 8'b1000_0000; // 8
            4'h9: seg_code = 8'b1001_0000; // 9
            4'hA: seg_code = 8'b1000_1000; // A
            4'hB: seg_code = 8'b1000_0011; // B
            4'hC: seg_code = 8'b1100_0110; // C
            4'hD: seg_code = 8'b1010_0001; // D
            4'hE: seg_code = 8'b1000_0110; // E
            4'hF: seg_code = 8'b1000_1110; // F
            default: seg_code = 8'b0000_0000; // 默认情况（无效输入）
        endcase
    end

endmodule