`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/22 09:48:29
// Design Name: 
// Module Name: m_s_to_p
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


module m_s_to_p
    #(parameter WORD = 8)
    (
    input clk,
    input reset,
    input start,
    input serial_d,
    output reg [WORD - 1 : 0] parallel_8bit,
    output reg done
    );
    reg [2:0] cnt;
    reg [WORD - 1 : 0] merge_8bit;
    
    initial begin
        cnt = 0;
        merge_8bit = 0;
        parallel_8bit = 0;
        done = 0;
    end
    
    
    always @(posedge clk or negedge reset) begin
        if(reset) begin
            cnt = 0;
            merge_8bit = 0;
            parallel_8bit <= 0;
            done <= 0;
        end
        else begin
            if(start) begin
                cnt = 0;
            end
            else if (cnt < WORD) begin
                merge_8bit <= {merge_8bit[6:0], serial_d};
            end
            else begin
                parallel_8bit <= merge_8bit;
            end
        end
    end
endmodule
