`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/09/30 15:09:44
// Design Name: 
// Module Name: m_acc_tb
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
// Procotol FSM Desgin
// PW TR GATE Ctrl SW Imple
// DDI PX ADD Ctrl Imple
// TODO : Communication protocol Testbanch Write


module m_acc_tb();
parameter CLK_DUTY = 62.5; // 16MHz = 1/62.5ns
parameter WORD = 8;
    
//display variable    
reg clk, reset_n;
reg [7:0] data, o_acc;
wire [7:0] acc_o;
reg A, B;
wire sum, carry;
integer time1, time2;


//cpu variable
wire [1:0] cpu_state;
reg sleep_request, wakeup_request;


//spi variable
reg sck, ss;
reg [WORD - 1 : 0] spi_data;
reg MOSI, MISO;
wire spi_o;

//inital Senario
initial begin
reset_n = 0;
clk = 0;
sck = 0;


#10 ss = 0;
#10 spi_data = 8;
//display checking
$display("initial");

o_acc = 4;
time1 = $time;
#500
time2 = $time;
$display(" now : %0t , before : %d",$time, time2 - time1);

//spi checking

//usart checking

//i2c checking



$finish;
end

//16Mhz clk generator
always begin
#(CLK_DUTY/2) clk = ~clk;
MOSI <= spi_o;
end

m_CPU_FSM cpu(.clk(clk), .reset(reset_n), .sleep_request(sleep_request), .wakeup_request(wakeup_request), .state(cpu_state));
m_p_to_s ptos(.clk(clk), .reset(reset_n), .data_in(spi_data), .start(ss), .data_o(spi_o));
m_acc acc(.clk(clk), .reset(reset_n), .data(data), .i_acc(o_acc), .o_acc(acc_o));
my_hadder hadder( .A(A), .B(B), .S(sum), .C(carry));

endmodule