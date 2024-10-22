`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/22 12:33:10
// Design Name: 
// Module Name: m_uart_slave
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


module m_uart_slave
   #(
    parameter WORD = 8,
    parameter BAUD_RATE = 115200,
    parameter CLK_FREQ = 16_000_000,
    parameter DIV_BOC = 12,
    parameter IDLE = 2'b00,
    parameter ACTIVE = 2'b01,
    parameter DONE = 2'b11
   )
    (
    input clk,
    input reset,
    input RXD,
    input read,
    output reg [WORD - 1:0] data_o,
    output reg [1:0] state,
    output reg done,
    output reg error
    );
    
    reg [ WORD - 1 : 0] cnt = 0;
    reg [ DIV_BOC - 1 : 0 ] div_cnt = 0;
    reg divisor = CLK_FREQ / (BAUD_RATE * WORD);
    reg [WORD - 1 : 0] data;
    
    initial begin
        data = 0;
        data_o = 0;
        state = IDLE;
        error = 0;
    end
    
    
    always @(posedge clk or negedge reset) begin
        if(reset) begin
            data <= 0;
            data_o <= 0;
            state <= IDLE;
            div_cnt <= 0;
        end
        else begin
            case(state)
                IDLE: begin
                    if( div_cnt < divisor - 1) begin
                        div_cnt <= div_cnt + 1;
                    end
                    else begin
                        div_cnt <= 0;
                        if(RXD == 1'b0) begin
                            state <= ACTIVE;
                        end
                    end          
                end
                ACTIVE: begin
                    if( div_cnt < divisor - 1) begin
                        div_cnt <= div_cnt + 1;
                    end
                    else begin
                        div_cnt <= 0;
                        if( cnt < WORD - 1) begin
                            data <= {data[WORD - 2 : 0], RXD};
                        end
                        else begin
                            done <= 1;
                            if(done) begin
                                state <= DONE;
                            end
                        end
                    end   
                end
                DONE: begin    
                    if(read) begin
                        data_o <= data;
                        state <= IDLE;
                    end
                end
                default : begin
                    error <= 1;
                    state <= IDLE;
                end
            endcase
        end
        
    end
    
endmodule
