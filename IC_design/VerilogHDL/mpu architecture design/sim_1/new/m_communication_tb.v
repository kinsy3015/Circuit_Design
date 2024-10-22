`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/17 20:15:29
// Design Name: 
// Module Name: m_communication_tb
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


module m_communication_tb(

    );
    
    
m_uart_master uart_master();
m_uart_slave uart_slave();
m_can_tb can_tb();
m_spi_tb spi_tb();
m_P_FSM();
endmodule
