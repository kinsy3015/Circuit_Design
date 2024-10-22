`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/07 15:44:19
// Design Name: 
// Module Name: m_CPU_FSM
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

// TODO : Embedded Assmebly jump etc instruction function implementation

//`include "instruction.vh"

module m_CPU_FSM
    #(parameter IDLE = 3'b000,
    parameter ACTIVE = 3'b001,
    parameter FETCH = 3'b010,
    parameter DECODE = 3'b100,
    parameter EXCUTE = 3'b011,
    parameter SLEEP = 3'b101,
    parameter WORD = 16,
    parameter PAGE = 1024,
    parameter DWORD = 16,
    parameter REG_MUX = 2
    )
    (
    input clk,
    input reset,
    input [WORD - 1:0] IMASK, // interrupt
    input [WORD - 1:0] PMASK, // pull-up / down
    input [WORD - 1:0] CMASK, //  control
    input sleep_request,
    input wakeup_request,
    input wire [3: 0] instruction,
    output reg [1:0] state
    );
    
    reg [1:0] current_state, next_state;
    wire stack_full, stack_empty;
    reg [WORD - 1 : 0] memory[PAGE - 1 : 0];
    reg [DWORD - 1 : 0] t_instruction, r_instruction, m_instruction; // top / register / module instruction
    reg [WORD - 1 : 0] stack_data;
    reg [WORD - 1 : 0] sp;
    
    reg [REG_MUX - 1:0] Register_select;
    reg register_change;
    reg register_context;
    
    reg module_context;

    
    
    
    
    localparam LOAD  = 4'b0001; // Load value into reg_a
    localparam STORE = 4'b0010; // Store reg_a into memory
    localparam ADD   = 4'b0011; // Add reg_a and reg_b
    localparam BRANCH   = 4'b0100; // Jump to address
    localparam BEQ   = 4'b0101; // Branch if equal
    localparam RETURN   = 4'b0110; // Return from subroutine
    localparam INTERRUPT = 4'b0111; // interrupt subroutine

    
    initial begin
        current_state = IDLE;
        sp = 0;
    end
    
    always@(posedge clk or negedge reset) begin
    case(current_state)
        IDLE : begin
            next_state <= LOAD;
        end
        LOAD : begin
            //stack_data <= 
            //stack_push <= 1;
        end
        ACTIVE : begin
            if(sleep_request) begin
                next_state <= SLEEP;
            end
            else begin
                next_state <= FETCH;
            end
        end
        FETCH : begin
            if(~stack_full) begin
                //memory[];
                t_instruction <= r_instruction | m_instruction ;
            end
            next_state <= DECODE;
        end
        DECODE : begin
            next_state <= EXCUTE;
        end
        EXCUTE : begin
            next_state <= FETCH;
            case(instruction)
            LOAD : begin
            end // Load value into reg_a
            STORE : begin
            end // Store reg_a into memory
            ADD   : begin
            end // Add reg_a and reg_b
            BRANCH  : begin
            end // Jump to address
            BEQ   : begin
            end // Branch if equal
            RETURN : begin
            end
            
            endcase
            
            
        end
        SLEEP : begin
            if(wakeup_request) begin
                next_state <= ACTIVE;
            end
            else begin
                next_state <= SLEEP;
            end
        end
    endcase
    
        state <= current_state;
        if(~reset) begin
            current_state <= ACTIVE;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    
    m_stack stack_m( .clk(), .reset(), .push(), .pop(), .sp(), .data_i(stack_data), .data_o(),  .is_full(stack_full), .is_empty(stack_empty));
    m_acc acc_m( .clk(clk), .reset(reset), .data(), .i_acc(), .o_acc());
    m_Mask mask(.clk(clk), .reset(reset), .IMASK(IMASK), .PMASK(PMASK), .CMASK(CMASK), .select(Register_select), .register_change(register_change), .instruction(r_instruction), .context(register_context));
    
    m_Timer Timer1(.clk(clk), .reset(reset), .en(), .clear(), .i_data(), .step(), .Comp_Ref(), .timer_identity(2'b00), .o_data(), .instruction(m_instruction)); // Timer1 C: xxxx x001 O: xxxx x010
    m_Timer Timer2(.clk(clk), .reset(reset), .en(), .clear(), .i_data(), .step(), .Comp_Ref(), .timer_identity(2'b01), .o_data(), .instruction(m_instruction)); // Timer1 C: xxxx x001 O: xxxx x010
    m_Timer Timer3(.clk(clk), .reset(reset), .en(), .clear(), .i_data(), .step(), .Comp_Ref(), .timer_identity(2'b10), .o_data(), .instruction(m_instruction)); // Timer1 C: xxxx x001 O: xxxx x010
    



endmodule
