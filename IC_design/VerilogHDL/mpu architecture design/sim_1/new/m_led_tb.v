`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/15 10:25:35
// Design Name: 
// Module Name: m_led_tb
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


module m_led_tb();
    
parameter CLK_DUTY = 62.5; // 16MHz = 1/62.5ns
parameter WORD = 8; 
    
reg clk, reset_n;
reg [4:0] SW;
wire [7:0] LED;
    
    
    //inital Senario
initial begin
reset_n = 1;
clk = 0;
SW = 4'b1000;
#500
$finish;
end


//16Mhz clk generator
always begin
#(CLK_DUTY/2) clk = ~clk;
end


//m_7seg seg(.clk(clk), .LED(LED));
    
endmodule
