`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/14 11:00:59
// Design Name: 
// Module Name: m_Counter
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


module m_Counter
    #(parameter WORD = 8,
    parameter DWORD = 16,
    parameter STEP_Cnt = 4,
    parameter Ref_Cnt = 255,
    parameter Default_step = 1
    )
    (
    input clk,
    input reset,
    input en,
    input clear,
    input [WORD - 1 : 0] i_data, // offset
    input [STEP_Cnt - 1 : 0] step,
    input [WORD - 1 : 0] Comp_Ref,
    input [1:0] timer_identity,
    output reg [WORD - 1 : 0] o_data,
    output reg [DWORD - 1:0] instruction
    );
    
    reg [WORD - 1 : 0] counter;
    reg [WORD - 1 : 0] data;
    
    initial begin
        counter = 0;
        o_data = 0;
        data = 0;
        instruction = 0;
    end
    
    
    always@(posedge clk or negedge reset) begin
        if(reset | clear) begin
            counter <= 0;
            instruction <= 0;
            if(clear) begin
                data <= i_data;
            end
        end
        else begin
            counter <= counter + Default_step;
            if(counter == Comp_Ref) begin
                instruction <= (timer_identity == 2'b00)? instruction | 16'h01 :
                               (timer_identity == 2'b01)? instruction | 16'h03 :  
                               (timer_identity == 2'b10)? instruction | 16'h05 : 0;
            if(counter > Ref_Cnt) begin
                instruction <= (timer_identity == 2'b00)? instruction | 16'h02 :
                               (timer_identity == 2'b01)? instruction | 16'h04 :  
                               (timer_identity == 2'b10)? instruction | 16'h06 : 0; // m_instruction 하위 3비트 timer1/2/3 Overflow Compare detecting
            end
            data <= data + step;

            end
        end
    end
endmodule
