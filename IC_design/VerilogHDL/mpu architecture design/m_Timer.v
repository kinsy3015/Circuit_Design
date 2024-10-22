module m_Timer
    #(parameter WORD = 8,
    parameter DWORD = 16,
    parameter STEP_Cnt = 4,
    parameter Ref_Cnt = 255,
    parameter Default_step = 1
    )
    (
    input clk,
    input reset,
    input en,
    input clear,
    input [WORD - 1 : 0] i_data, // offset
    input [STEP_Cnt - 1 : 0] step,
    input [WORD - 1 : 0] Comp_Ref,
    input [1:0] timer_identity,
    output reg [WORD - 1 : 0] o_data,
    output reg [DWORD - 1:0] instruction
    );

    reg divide_clk;   

    m_divider clk_divider(.clk(clk), .reset(), .ratio_setting(), .divide_ratio(), .clk_o(divide_clk));
    m_Counter Timer(.clk(divide_clk), .reset(reset), .en(), .clear(), .i_data(), .step(), .Comp_Ref(), .timer_identity(timer_identity), .o_data(), .instruction(m_instruction)); 
    // Timer1 C: xxxx x001 O: xxxx x010 // Timer1 C: xxxx x011 O: xxxx x100  // Timer1 C: xxxx x101 O: xxxx x110 

endmodule