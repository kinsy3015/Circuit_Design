`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/07 15:44:19
// Design Name: 
// Module Name: m_CPU_FSM
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

`define Interrupt_flag  8'b10000000
`define Parity_flag     8'b01000000
`define Busy_flag       8'b00100000
`define Sign_flag       8'b00010000
`define Overflow_flag   8'b00001000
`define Negative_flag   8'b00000100
`define Zero_flag       8'b00000010
`define Carry_flag      8'b00000001

module m_CPU_FSM
    #(parameter IDLE = 3'b000,
     parameter ACTIVE = 3'b001,
     parameter FETCH = 3'b010,
     parameter DECODE = 3'b100,
     parameter EXCUTE = 3'b011,
     parameter SLEEP = 3'b101
     )
    (
    input clk,
    input reset,
    input sleep_request,
    input wakeup_request,
    output reg [1:0] state
    );
    
    reg [1:0] current_state, next_state;
    reg Control_Register;
    
    initial begin
        current_state = IDLE;
        Control_Register = 8'b000000000;
    end
    
    always@(posedge clk or negedge reset) begin
    
    case(current_state)
        ACTIVE : begin
            if(sleep_request) begin
                next_state <= SLEEP;
            end
            else begin
                next_state <= FETCH;
            end
        end
        FETCH : begin
            next_state <= DECODE;
        end
        DECODE : begin
            next_state <= EXCUTE;
        end
        EXCUTE : begin
            next_state <= FETCH;
        end
        SLEEP : begin
            if(wakeup_request) begin
                next_state <= ACTIVE;
            end
            else begin
                next_state <= SLEEP;
            end
        end
        
    endcase
    
        state <= current_state;
        if(~reset) begin
            current_state <= ACTIVE;
        end
        else begin
            current_state <= next_state;
        end
    end
    
endmodule
