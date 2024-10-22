`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/21 21:08:09
// Design Name: 
// Module Name: m_spi_tb
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


module m_spi_tb();
parameter CLK_DUTY = 62.5; // 16MHz = 1/62.5ns
parameter WORD = 8;

reg SCLK;
reg [WORD - 1 : 0] MOSI;
reg [WORD - 1 : 0] MISO;
reg SS;



initial begin
SCLK = 0;

#10
#60

#62.5

#500


//#500
$finish;
end

//16Mhz clk generator
always begin
#(CLK_DUTY/2) SCLK = ~SCLK;
end

endmodule
