`timescale 1ns/ 1ps
module tb_Counter_HandShake;
parameter integer cnt = 3;
reg A_CLK, B_CLK, RSTB, HandShake; 
wire A_CNT_EN, B_DONE;
wire A_GRAY_DATA;
wire [8:0] A_GRAY_DATA_TMP;
Counter_4bit #(.cnt(cnt)) u0(.clk(A_CLK), .reset_b(RSTB), .b_done(B_DONE), .en_handshake(HandShake), .a_gray_cnt(A_GRAY_DATA_TMP) , .a_gray_data(A_GRAY_DATA), .a_clk_en(A_CNT_EN));
CDC_HandShake u1(.clk(B_CLK), .reset_b(RSTB), .a_gray_data(A_GRAY_DATA), .a_clk_en(A_CNT_EN), .b_done(B_DONE));
	initial begin
		A_CLK = 1;
		B_CLK = 1;
		RSTB = 1;
		HandShake = 0;
		forever A_CLK = #5 ~A_CLK;
	end
	initial begin
		forever B_CLK = #6 ~B_CLK;
	end
	initial begin
		RSTB = ~RSTB;
		#5;
		RSTB = ~RSTB;
		#20;
		HandShake = ~HandShake;
		#20;
		HandShake = ~HandShake;
		#300;
		RSTB = ~RSTB;
		#50;
		RSTB = ~RSTB;
		HandShake = ~HandShake;
		#20;
		HandShake = ~HandShake;
		#300;
		$display("Hello, Counter_HandShake!");
		$finish;
	end
	initial begin
		$dumpfile("waveform.vcd");
		$dumpvars(0, tb_Counter_HandShake);
	end
endmodule
