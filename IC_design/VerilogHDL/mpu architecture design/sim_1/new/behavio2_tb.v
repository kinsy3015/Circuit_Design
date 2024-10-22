`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/17 21:04:05
// Design Name: 
// Module Name: behavio2_tb
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


module behavio2_tb();
parameter CLK_DUTY = 62.5; // 16MHz = 1/62.5ns
parameter WORD = 8;
    
//display variable    
reg clk, reset_n;


initial begin
reset_n = 0;
clk = 0;
$display("initial");
#500



$finish;
end

//16Mhz clk generator
//always begin
//#(CLK_DUTY/2) clk = ~clk;
//end
endmodule
