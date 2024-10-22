`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/09/30 15:46:18
// Design Name: 
// Module Name: m_alu
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


module m_alu
    #(parameter ADD = 3'b000,
    parameter SUB= 3'b001,
    parameter AND= 3'b010,
    parameter OR= 3'b011,
    parameter MUL= 3'b100,
    parameter DIV = 3'b101,
    parameter LSH = 3'b110,
    parameter RSH = 3'b111,
    parameter WORD = 8
    )
    (
    input wire clk,
    input wire reset,
    input wire [2:0] operation,
    input wire [7:0] data,
    output reg [7:0] acc,
    output reg [7:0] shift
    );
    
    reg [ WORD - 1 : 0 ] acc_data;
    reg [ WORD - 1 : 0 ] i_acc, o_acc;
    
    always @(posedge clk or negedge reset) begin
    
        if(~reset) begin
            acc <= 8'b0;
            shift <= 8'b0;
        end
        else begin
            case(operation) 
                ADD: begin
                    i_acc <= acc;
                    acc_data = data;
                    acc <= o_acc;
                    //acc <= acc + data;
                end
                SUB: begin
                    // TODO subtractor Imple
                    acc <= acc - data;
                end
                AND: begin
                    acc <= acc & data;
                end
                OR: begin
                    acc <= acc | data;            
                end
                MUL: begin
                    acc <= acc * data;
                end
                DIV: begin
                    acc <= acc / data;
                end
                LSH: begin
                    shift <= data << 1;
                end
                RSH: begin
                    shift <= data >> 1;
                end
                default: begin
                    acc <= acc;
                    shift <= shift;
                end
            endcase
        end 
    end
  
    m_acc acc_m(.clk(clk), .reset(reset), .data(acc_data), .i_acc(i_acc), .o_acc(o_acc));
    
endmodule
