`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/14 11:02:10
// Design Name: 
// Module Name: m_Comparator
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


module m_Comparator
    #(parameter WORD = 8)
    (
    input clk,
    input reset,
    input [WORD - 1:0] A,
    input [WORD - 1:0] B,
    output reg E,
    output reg H,
    output reg L
    );
    
    always@(posedge clk or negedge reset) begin
        if(reset) begin
            E <= 0;
            H <= 0;
            L <= 0;
        end
        else begin
            E <= (A == B)? 1 : 0;
            H <= (A > B)? 1 : 0;
            L <= (A < B)? 1 : 0;
        end
    end
endmodule
