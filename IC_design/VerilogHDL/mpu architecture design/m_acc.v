`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/09/30 14:26:53
// Design Name: 
// Module Name: m_acc
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


module m_acc(
    input wire clk,
    input wire reset,
    input wire [7:0] data,
    input wire [7:0] o_acc,
    output reg [7:0] acc
    );
    
    wire [7:0] sum;
    wire [7:0] carry;
    
    my_fadder fa0 (.A(o_acc[0]), .B(data[0]), .C_in(1'b0), .S(sum[0]), .C(carry[0]));
    my_fadder fa1 (.A(o_acc[1]), .B(data[1]), .C_in(carry[0]), .S(sum[1]), .C(carry[1]));
    my_fadder fa2 (.A(o_acc[2]), .B(data[2]), .C_in(carry[1]), .S(sum[2]), .C(carry[2]));
    my_fadder fa3 (.A(o_acc[3]), .B(data[3]), .C_in(carry[2]), .S(sum[3]), .C(carry[3]));
    my_fadder fa4 (.A(o_acc[4]), .B(data[4]), .C_in(carry[3]), .S(sum[4]), .C(carry[4]));
    my_fadder fa5 (.A(o_acc[5]), .B(data[5]), .C_in(carry[4]), .S(sum[5]), .C(carry[5]));
    my_fadder fa6 (.A(o_acc[6]), .B(data[6]), .C_in(carry[5]), .S(sum[6]), .C(carry[6]));
    my_fadder fa7 (.A(o_acc[7]), .B(data[7]), .C_in(carry[6]), .S(sum[7]), .C(carry[7]));
    

    always @ (posedge clk or negedge reset) begin
        if (~reset) begin
            acc <= 8'b0;
        end 
        else begin
            acc <= sum;
        end
    end
      
endmodule
