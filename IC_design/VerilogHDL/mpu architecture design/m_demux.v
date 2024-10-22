`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/14 11:22:31
// Design Name: 
// Module Name: m_demux
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


module m_demux
    #(parameter WORD = 8,
    parameter DEMUX = 2
    ) 
    (
    input i,
    input [DEMUX - 1 : 0] select,
    output [WORD - 1 : 0] line
    );
    
    assign line[0] = (select == 2'b00) ? i : 0;
    assign line[1] = (select == 2'b01) ? i : 0; 
    assign line[2] = (select == 2'b10) ? i : 0; 
    assign line[3] = (select == 2'b11) ? i : 0; 
    
endmodule
