`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/21 17:58:07
// Design Name: 
// Module Name: m_Mask
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

module m_Mask
    #(parameter WORD = 8,
      parameter MUX = 2,
      parameter DWORD = 16)
    (
    input clk,
    input reset,
    input [WORD - 1:0] IMASK, // interrupt
    input [WORD - 1:0] PMASK, // pull-up / down
    input [WORD - 1:0] CMASK, //  control
    input [MUX - 1 : 0] select,
    input register_change,
    output reg [DWORD - 1:0] instruction,
    output reg context
    );
    
    reg initial_mask = 8'b00000000;
    reg [WORD - 1:0] select_Register;
    reg [WORD - 1:0] Register1;
    reg [WORD - 1:0] Register2;
    reg [WORD - 1:0] Register3;
    reg [WORD - 1:0] i_decode, p_decode, c_decode;
    
    
    initial begin
        select_Register = initial_mask;
        Register1 = initial_mask;
        Register2 = initial_mask;
        Register3 = initial_mask;
        i_decode = 8'h0x3F;
        p_decode = 8'h0x7F;
        c_decode = 8'h0xBF;
    end
    
    
    always @(posedge clk or negedge reset) begin

    if(reset) begin
        select_Register <= initial_mask;
        Register1 <= initial_mask;
        Register2 <= initial_mask;
        Register3 <= initial_mask;
    end
    else if (register_change) begin
        select_Register <= (select == 2'b00) ? Register1 :
                           (select == 2'b01) ? Register2 :
                           (select == 2'b10) ? Register3 : 0;
    end
    else begin
        i_decode <= i_decode & IMASK;
        p_decode <= p_decode & PMASK;
        c_decode <= c_decode & CMASK;
    end
      
    end
    
    m_register interrupt_register(.clk(clk), .reset(reset), .decode(i_decode), .instruction(instruction));
    m_register pull_register(.clk(clk), .reset(reset), .decode(p_decode), .instruction(instruction));
    m_register control_register(.clk(clk), .reset(reset), .decode(c_decode), .instruction(instruction));
    
    
endmodule
