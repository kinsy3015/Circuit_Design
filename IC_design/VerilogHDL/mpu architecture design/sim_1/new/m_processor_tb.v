`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/17 20:16:48
// Design Name: 
// Module Name: m_processor_tb
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


module m_processor_tb();
    
parameter WORD = 8;
parameter MUX = 2;
parameter DWORD = 16;
reg [WORD - 1:0] h_IMASK; // Host / User Senario
reg [WORD - 1:0] h_PMASK;
reg [WORD - 1:0] h_CMASK;




m_8bit_register register();
m_alu alu();
m_acc_tb();
m_Comparator();
m_Counter();
m_mux();
m_demux();

endmodule
