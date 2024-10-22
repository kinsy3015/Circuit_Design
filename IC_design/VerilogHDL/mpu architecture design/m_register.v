`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/17 20:28:17
// Design Name: 
// Module Name: m_register
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


module m_register
    #(parameter WORD = 8,
    parameter DWORD = 16)
    (
    input clk,
    input reset,
    input ack,
    input [WORD - 1:0] decode,
    output reg context_request,
    output reg [DWORD - 1:0] instruction
    );
    
    reg initial_mask = 16'h0000;
    reg [DWORD - 1:0] b_instruction;
    
    initial begin
        context_request = 0;
    end
    
    always @(posedge clk or negedge reset) begin

    if(reset) begin
        context_request <= 0;
    end
    else begin
        case(decode[7:6])
            2'b00 : begin
                instruction <= b_instruction | (16'h003F | decode[5:0]);
            end
            2'b01 : begin
                instruction <= b_instruction | (16'h0FF0 | decode[7:0] << 4);
            end
            2'b10 : begin
                instruction <= b_instruction | (16'hF000 | (decode[3:0] << 12));
            end
            
         endcase
    
    end
    end
    
    // instruction pull-up down => 입출력 포트 정의?
    // cpu parsing decode 8b 0000 0000 => 
endmodule
