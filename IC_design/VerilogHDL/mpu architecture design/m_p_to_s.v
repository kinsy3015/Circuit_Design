`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/08 15:55:06
// Design Name: 
// Module Name: p_to_s
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


module m_p_to_s
    #(parameter WORD = 8)
    (
    input clk,
    input reset,
    input [WORD - 1 : 0] data_in,
    input start,
    output reg data_o
    );
    
    reg [ WORD - 1 : 0 ] reg_data;
    reg [ 3:0 ]cnt;
    
    initial begin
        reg_data = 0;
        cnt = 0;
    end
    
    always@(posedge clk or negedge reset) begin
    
        if(reset) begin
            reg_data = 0;
            data_o = 0;
        end
        else begin
            if(!start && data_in > 0 && cnt == 0) begin
                reg_data <= data_in;
            end
            else if(!start && cnt != 8) begin
                reg_data <= {reg_data[6:0], 1'b0};
                data_o <= reg_data[7];
                cnt = cnt + 1;
            end
        end
    end
    
endmodule
