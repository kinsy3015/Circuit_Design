module CDC_HandShake(
	input wire clk, 
	input wire reset_b,
	input wire a_gray_data,
	input a_clk_en,
	output reg b_done = 1
);

reg [8:0] b_gray_cnt = 0;

always @ (posedge clk or negedge reset_b) begin
	if(!a_clk_en) begin
		b_done <= 0;
		b_gray_cnt <= { b_gray_cnt[7:0], a_gray_data };
		if(b_gray_cnt[8] == 1) begin
			b_gray_cnt = 0;
			b_done <= 1;
		end
	end
end
endmodule
