`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/14 11:21:33
// Design Name: 
// Module Name: m_mux
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


module m_mux
    #(parameter WORD = 8,
    parameter MUX = 2
    )
    (
    input [WORD - 1 : 0] line,
    input [MUX - 1 : 0] select,
    output o
    );
    assign o = (select == 2'b00) ? line[0] :
           (select == 2'b01) ? line[1] :
           (select == 2'b10) ? line[2] :
           (select == 2'b11) ? line[3] : 0;
endmodule
