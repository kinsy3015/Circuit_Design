`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/09/30 14:21:11
// Design Name: 
// Module Name: my_fadder
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


module my_fadder(
    input A,
    input B,
    input C_in,
    output S,
    output C
    );
    
    
    assign S = A^B^C_in;
    assign C = (A&B) | (C_in&(A^B));
endmodule
