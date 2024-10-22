`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/17 20:30:36
// Design Name: 
// Module Name: m_bit_register
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


module m_8bit_register
    (
    input clk,
    input reset,
    input decode0,
    input decode1,
    input decode2,
    input decode3,
    input decode4,
    input decode5,
    input decode6,
    input decode7
    );
    reg [7: 0] merge_8bit;
    always @(posedge clk or negedge reset) begin 
        merge_8bit <= {decode0, decode1, decode2,decode3,decode4,decode5,decode6,decode7};
    end
    
    m_register ( .clk(clk), .reset(reset), .decode(merge_8bit));
endmodule
