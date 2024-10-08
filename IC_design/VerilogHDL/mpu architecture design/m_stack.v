`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/08 09:24:51
// Design Name: 
// Module Name: m_stack
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


module m_stack
    #(parameter WORD = 16,
      parameter PAGE = 1024
    )
    (
    input clk,
    input reset,
    input push,
    input pop,
    input [WORD:0] data_i,
    output reg [WORD:0] data_o,
    output reg is_full,
    output reg is_empty
    );
    
    //TODO : top bit cal f Imple
    reg [WORD - 1 : 0] mem[PAGE - 1 : 0]; 
    reg [10:0] top;
    reg cnt;
    
    initial begin
        cnt = 0;
        while (cnt < PAGE) begin
            mem[cnt] = {0};
            cnt = cnt + 1;
        end
        top = 0;
        is_full = 0;
        is_empty = 1;
    end
    
    always@(posedge clk or negedge reset) begin
        if(~reset) begin
            top <= 0;
            is_full <= 0;
            is_empty <= 1;
        end
        else begin
            if(is_full || is_empty) begin
                is_full <= top + 1 == PAGE? 1 : 0; 
                is_empty <= top == 0 ? 1 : 0; 
            end
            else if(push) begin
                mem[top] <= data_i;
                top = top + 1;
            end
            else if(pop) begin
                data_o <= mem[top];
                top = top - 1;
            end
        
        end
    end 
endmodule
