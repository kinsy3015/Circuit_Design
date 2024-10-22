`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/09/30 16:16:25
// Design Name: 
// Module Name: m_FSM
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

//TODO : opencores i2c_master_slave_core/ms_core => protocol FSM analysis & apply

module m_P_FSM
    #(parameter IDLE = 2'b00,
    parameter ACTIVE = 2'b01,
    parameter DONE = 2'b11)
    (input clk,
    input reset,
    input start,
    input finish,
    output reg [1:0] state);


always @(posedge clk or negedge reset) begin


    if(~reset) begin
        state <= IDLE;
    
    end
    else begin
        case(state)
            IDLE: begin
                if(state) begin
                    state <= ACTIVE;
                end
            end
            
            ACTIVE: begin
                if(finish) begin
                    state <= DONE;
                end
            end
            
            DONE: begin
                state <= IDLE;
            
            end
            default : begin
            
                state <= IDLE;
            end
        endcase
    end



end

endmodule
