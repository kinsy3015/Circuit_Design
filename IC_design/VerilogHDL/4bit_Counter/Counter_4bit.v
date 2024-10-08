module Counter_4bit #(parameter integer cnt = 0)
(
	input wire clk,
	input wire reset_b,
	input wire b_done,
	input wire en_handshake,
	output reg [8:0] a_gray_cnt = 0,
	output reg a_gray_data = 0,
	output reg a_clk_en = 1
);

reg [8:0] tmp_gray_cnt = 0;

always @ ( posedge clk or negedge reset_b ) begin

	//a_clk_en = en_shake;
	if(!reset_b) begin
		a_clk_en <= 1;
		a_gray_cnt <= 0;
	end
	else if(!a_clk_en) begin
		if( en_handshake == 1 ) begin
			a_clk_en = 0;
		end
		if(b_done) begin
			a_clk_en <= 1;
			a_gray_cnt <= 0;
		end
		//a_gray_data <= 1'b1;
		a_gray_data <= a_gray_cnt[8];
		a_gray_cnt <= { a_gray_cnt[7:0] , 1'b0 };
	end
	else begin
		if( en_handshake == 1 ) begin
			a_clk_en = 0;
		end
		a_gray_cnt <= (a_gray_cnt + cnt > 5'b01111) ? 4'b1111 : a_gray_cnt + cnt;
		if(!a_clk_en) begin
			tmp_gray_cnt = a_gray_cnt;
			a_gray_cnt[7] = tmp_gray_cnt[7];
			a_gray_cnt[6] = tmp_gray_cnt[7] ^ tmp_gray_cnt[6];
			a_gray_cnt[5] = tmp_gray_cnt[7] ^ tmp_gray_cnt[6] ^ tmp_gray_cnt[5] ;
			a_gray_cnt[4] = tmp_gray_cnt[7] ^ tmp_gray_cnt[6] ^ tmp_gray_cnt[5] ^ tmp_gray_cnt[4];
			a_gray_cnt[3] = tmp_gray_cnt[7] ^ tmp_gray_cnt[6] ^ tmp_gray_cnt[5] ^ tmp_gray_cnt[4] ^ tmp_gray_cnt[3];
			a_gray_cnt[2] = tmp_gray_cnt[7] ^ tmp_gray_cnt[6] ^ tmp_gray_cnt[5] ^ tmp_gray_cnt[4] ^ tmp_gray_cnt[3] ^ tmp_gray_cnt[2];
			a_gray_cnt[1] = tmp_gray_cnt[7] ^ tmp_gray_cnt[6] ^ tmp_gray_cnt[5] ^ tmp_gray_cnt[4] ^ tmp_gray_cnt[3] ^ tmp_gray_cnt[2] ^ tmp_gray_cnt[1];
			a_gray_cnt[0] = tmp_gray_cnt[7] ^ tmp_gray_cnt[6] ^ tmp_gray_cnt[5] ^ tmp_gray_cnt[4] ^ tmp_gray_cnt[3] ^ tmp_gray_cnt[2] ^ tmp_gray_cnt[1] ^ tmp_gray_cnt[0];
			a_gray_cnt[8] = 1;
		end
	end
end
endmodule
