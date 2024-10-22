`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/17 20:57:35
// Design Name: 
// Module Name: behavior_tb
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

// TODO : Design => Behavior tb Verification
// Problem : Design / Implementation Pipeline don't exist


// Pipelining : 1. Design => Digital/Mixed IDEA, Opencores/MCU Datasheet Ref.
//              2. Implementation => Behavior Verification
//              3. Merge Module & Top-Bottom Code Merge

module behavior_tb();

parameter CLK_DUTY = 62.5; // 16MHz = 1/62.5ns
parameter WORD = 8;
parameter STEP_Cnt = 4;
parameter NOB = 4;
parameter MUX = 2;
//display variable    
reg clk, reset, ratio_setting;
reg [WORD - 1 : 0] i_data;
reg [STEP_Cnt - 1 : 0] step;
reg [NOB - 1 : 0] divide_ratio;
wire clk_o;
wire data_o;
wire [WORD - 1 : 0] line;
reg [MUX - 1 : 0] select;
reg i;


initial begin
clk = 0;
reset = 1;
i_data = 0;
step = 3;
ratio_setting = 1;
divide_ratio = 4;
select = 0;
i = 1;
#10
reset = 0;
select = 1;
#60
//reset = 0;
ratio_setting = 0;
select = 2;
#62.5
//$display("initial");
//data = 8;
//#62.5
//start = 1;
#500


//#500
$finish;
end

//16Mhz clk generator
always begin
#(CLK_DUTY/2) clk = ~clk;
end


//m_Comparator Comparator( .clk(clk), .reset(reset), .A(A), .B(B), .E(E), .H(H), .L(L)); Behavior Verification Done
//m_p_to_s p_to_s(.clk(clk), .reset(reset), .data_in(data), .start(start), .data_o(o_data), .done(done));
//m_Counter Counter(.clk(clk), .reset(reset), .en(en), .clear(clear), .i_data(i_data), .step(step), .o_data(o_data), .overflow(overflow));
//m_divider divider(.clk(clk), .reset(reset), .ratio_setting(ratio_setting), .divide_ratio(divide_ratio), .clk_o(clk_o)); 
//m_mux mux(.line(line), .select(select), .o(data_o));
m_demux demux(.i(i), .select(select), .line(line));


endmodule
