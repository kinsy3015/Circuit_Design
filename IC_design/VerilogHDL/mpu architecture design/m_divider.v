`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/21 16:20:00
// Design Name: 
// Module Name: m_divider
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


module m_divider
    #(parameter NOB = 4)
    (
    input clk,
    input reset,
    input ratio_setting,
    input [NOB - 1 : 0] divide_ratio,
    output reg clk_o
    );

    reg [NOB - 1 : 0] ratio = 0;
    reg [NOB - 1 : 0] cnt = 0;
    
    initial begin
        clk_o = 0;
        ratio = 0;
        cnt = 0;
    end
    
    always@(posedge clk or negedge reset) begin
        if(reset) begin
            clk_o <= 0;
            ratio <= 0;
            cnt <= 0;
        end
        else begin 
            if(ratio_setting) ratio <= divide_ratio;
            clk_o <= (cnt > (ratio / 2))? ~clk : clk;
            cnt <= (cnt > (ratio / 2))? 0 : cnt + 1;
        end
    end
endmodule