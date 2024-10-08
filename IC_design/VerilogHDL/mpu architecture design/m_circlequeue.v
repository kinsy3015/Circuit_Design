`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/08 10:19:17
// Design Name: 
// Module Name: m_circlequeue
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


module m_circlequeue
    #(parameter WORD = 8,
    parameter PAGE = 1024
    )
    (
    input clk,
    input reset,
    input enqueue,
    input dequeue,
    input [0:0] data_i,
    output reg [0:0] data_o,
    output reg is_full,
    output reg is_empty
    );
    
    reg [WORD - 1 : 0] mem[PAGE - 1 : 0];
    reg [10:0] head, tail, cnt;
    
    initial begin
    cnt = 0;
    while (cnt < PAGE) begin
        mem[cnt] = {0};
        cnt = cnt + 1;
    end
    head = 0;
    tail = 0;
    cnt = 0;  
    end
    
    always@(posedge clk or negedge reset) begin
        if(~reset) begin
            head <= 0;
            tail <= 0;
            cnt <= 0;
            is_full <= 0;
            is_empty <= 0;
        end
        else begin
            if(enqueue && cnt + 1 == PAGE) begin
                is_full <= 1;
            end
            else if(enqueue) begin
                is_full <= 0;
                mem[tail] <= data_i;
                tail <= (tail + 1) % PAGE;
                cnt <= cnt + 1;
            end
            if(dequeue && cnt == 0) begin
                is_empty <= 0;
            end
            else if(dequeue) begin
                is_empty <= 1;
                data_o <= mem[head];
                head <= (head + 1) % PAGE;
                cnt <= cnt - 1;
            end
        end
    end
    
endmodule
