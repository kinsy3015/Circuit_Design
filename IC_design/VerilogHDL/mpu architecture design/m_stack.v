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
      parameter PAGE = 4
      //parameter PAGE = 1024
    )
    (
    input clk,
    input reset,
    input load,
    input push,
    input pop,
    input [WORD -1 : 0] sp,
    input [WORD:0] data_i,
    output reg [WORD:0] data_o,
    output reg is_full,
    output reg is_empty
    );
    
    // stack variable
    reg [10:0] top;
    reg cnt;
    
    // memory variable
    
    //TODO : top bit cal f Imple
    reg [WORD - 1 : 0] mem[PAGE - 1 : 0];
    reg we, re;
    reg [WORD - 1 : 0]addr;
    reg [WORD - 1 : 0]mem_data;
    
    
    initial begin
        cnt = 0;
        //while (cnt < PAGE) begin
            //mem[cnt] = {0};
            //cnt = cnt + 1;
        //end
        mem[0] = {0};
        mem[1] = {0};
        mem[2] = {0};
        mem[3] = {0};
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
        else if(load) begin
            re <= 0;
            addr <= 0;
            mem[0] <= mem_data;
        end
        else begin
            if(is_full || is_empty) begin
                is_full <= top + 1 == PAGE? 1 : 0; 
                is_empty <= top == 0 ? 1 : 0; 
            end
            else if(push) begin
                re = 1;
                we = 0;
                mem_data <= mem[top];
                top = top + 1;
            end
            else if(pop) begin
                re = 0;
                we = 1;
                data_o <= mem_data;
                top = top - 1;
            end
        
        end
    end
    
    m_mem memory_m( .clk(), .we(we), .re(re), .addr(addr), .d_bit(mem_data), .data_o());
endmodule
