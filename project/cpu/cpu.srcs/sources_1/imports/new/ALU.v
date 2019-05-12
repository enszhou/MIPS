`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 18:37:04
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] a,
    input [31:0] b,
    input [3:0] ALUControlCode,
    output reg [31:0] result,
    output wire Zero
    );

    localparam ADD = 4'b0000;
    localparam SUB = 4'b0010;
    localparam AND = 4'b0100;
    localparam  OR = 4'b0101;
    localparam NOR = 4'b0111;
    localparam XOR = 4'b0110;
    localparam SLT = 4'b1010;

    wire [31:0] slt, c;
    assign Zero = ~(|result);
    assign c = a + ~b + 1;
    assign slt = c[31] ? 32'b1 : 32'b0;
    
    always @(*)
    begin  
        case(ALUControlCode)
           ADD: result = a + b;
           SUB: result = a - b;
           AND: result = a & b;                    
           OR : result = a | b;           
           NOR: result = ~(a | b);                  
           XOR: result = a ^ b;  
           SLT: result = slt;               
           default: result = 32'b1;
       endcase 
    end
endmodule
