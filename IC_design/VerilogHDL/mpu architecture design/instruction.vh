`define Interrupt_flag  8'b10000000
`define Parity_flag     8'b01000000
`define Busy_flag       8'b00100000
`define Sign_flag       8'b00010000
`define Overflow_flag   8'b00001000
`define Negative_flag   8'b00000100
`define Zero_flag       8'b00000010
`define Carry_flag      8'b00000001

// CPU MACRO
`define ADD     3'b000,
`define SUB     3'b001,
`define AND     3'b010,
`define OR      3'b011,
`define MUL     3'b100,
`define DIV     3'b101,
`define LSH     3'b110,
`define RSH     3'b111,
`define LOAD    3'b000
`define STORE   3'b000


// ALU MACRO
`define ADD     3'b000
`define SUB     3'b001
`define AND     3'b010
`define OR     3'b011
`define MUL     3'b100
`define DIV     3'b101
`define LSH     3'b110
`define RSH     3'b111


`define WORD     8
`define PAGE     1024