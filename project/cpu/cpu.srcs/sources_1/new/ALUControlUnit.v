`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 12:43:45
// Design Name: 
// Module Name: ALUControlUnit
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


module ALUControlUnit(
    input [5:0] funct,
    input [1:0] ALUOp,
    input [5:0] opcode,
    output reg [3:0] ALUControlCode
    );
    
    localparam ADD = 4'b0000;
    localparam SUB = 4'b0010;
    
    always @(ALUOp or funct)
    begin
        case(ALUOp)
            2'b00: ALUControlCode = ADD;
            2'b01: ALUControlCode = SUB;
            2'b10: ALUControlCode = funct[3:0];
            2'b11:
                begin
                    if(opcode == 6'b001010) ALUControlCode = 6'b001010;
                    else ALUControlCode = opcode[3:0] - 4'd8;
                end
            default: ALUControlCode = ADD;
        endcase
    end
    
endmodule
