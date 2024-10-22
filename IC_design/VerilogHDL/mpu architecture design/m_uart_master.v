`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/22 12:33:10
// Design Name: 
// Module Name: m_uart_master
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


module m_uart_master
   #(
    parameter WORD = 8,
    parameter BAUD_RATE = 115200,
    parameter CLK_FREQ = 16_000_000,
    parameter DIV_BOC = 12,
    parameter IDLE = 2'b00,
    parameter ACTIVE = 2'b01,
    parameter DONE = 2'b11,
    parameter USART = 0
    )
    (
    input clk,
    input reset,
    input [WORD - 1 : 0] data_i,
    input start,
    output reg TXD,
    output reg [1:0] state,
    output reg done,
    output reg error
    );
    
    reg [ DIV_BOC - 1 : 0 ] div_cnt = 0;
    reg [ WORD - 1 : 0] cnt = 0;
    reg divisor;
    // divisor < 2 then => USART Logic
    // 1/115200 => 8.68us / 8bit => 1.085us
    // 16MHz = 1/62.5ns => 1clk => 62.5ns ( side edge )
    // 62.5n / 0.001085n => 57603.68663 => 57604 cnt => not collect
    //reg clk_divisor = 57604;
    
    // g_CLKS_PER_BIT = (Frequency of i_Clk)/(Frequency of UART)
    // Example: 10 MHz Clock, 115200 baud UART
    // (10000000)/(115200) = 87
    
    reg [WORD - 1 : 0] data;
    
    initial begin
        TXD = 1;
        state = IDLE;
        error = 0;
        if (USART == 0) begin
            divisor = CLK_FREQ / (BAUD_RATE * WORD);
        end
        else begin
            divisor = 0;
        end
    end
    
    
    always @(posedge clk or negedge reset) begin
        if(reset) begin
           TXD <= 1;
           div_cnt <= 0;
           cnt <= 0;
           error <= 0;
           state <= IDLE;
        end
        else begin
           case(state)
            IDLE: begin
                if( div_cnt < divisor - 1) begin
                    div_cnt <= div_cnt + 1;
                end
                else begin
                    div_cnt <= 0;
                    if(start) begin
                        TXD <= 1;
                        TXD <= 0;
                        data <= data_i;
                        state <= ACTIVE;
                    end
                end
            end
            ACTIVE: begin
                //data <= {data[WORD - 2 : 0] , 1'b0};
                if( div_cnt < divisor - 1) begin
                    div_cnt <= div_cnt + 1;
                end
                else begin
                    div_cnt <= 0;
                    if( cnt < WORD -1 ) begin
                       TXD <= data[cnt];
                       cnt = cnt + 1;
                    end
                    else begin
                        done <= 1;
                        if(done) begin
                            state <= DONE;
                            cnt <= 0;
                        end
                    end
                end 
            end
            DONE: begin
                if( div_cnt < divisor - 1) begin
                    div_cnt <= div_cnt + 1;
                end
                else begin
                    div_cnt <= 0;      
                    TXD <= 1;
                    cnt <= 0;
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
