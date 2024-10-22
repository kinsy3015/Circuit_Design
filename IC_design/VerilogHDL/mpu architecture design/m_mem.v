`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/08 10:53:32
// Design Name: 
// Module Name: m_mem
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


module m_mem
    #(parameter WORD = 16,
    parameter PAGE = 1024
    )
    (
    input clk,
    input we,
    input re,
    input [10:0] addr,
    inout [WORD - 1:0] d_bit,
    output reg [WORD - 1 : 0] data_o[PAGE - 1 : 0]
    );
    
    reg [WORD - 1 : 0] mem[PAGE - 1 : 0];
    assign d_bit = re ? mem[addr] : 0;
    
    always@(posedge clk) begin
        if(we) begin
           mem[addr] <= d_bit; 
        end    
    end
endmodule
