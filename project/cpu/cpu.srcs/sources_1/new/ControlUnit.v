`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/08 22:19:47
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input clk,
    input rst,
    input [5:0] opcode,
    output reg [1:0] ALUSrcB,ALUOp,PCSource,
    output reg ALUSrcA,IorD,IRWrite,PCWrite,PCWriteCond,MemWrite,RegDst,RegWrite,MemtoReg,PCWriteCond_bne
    );
    
    reg [3:0] state, nextstate;
    //reg [1:0] ALUSrcB,ALUOp,PCSource;
    //reg ALUSrcA,IorD,IRWrite,PCWrite,PCWriteCond,MemWrite,RegDst,RegWrite,MemtoReg;
    
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            state <= 4'b0000;
        end
        else
        begin
            state <= nextstate;
        end
    end
    
    always@(state or opcode)
    begin
        case(state)
            4'b0000: nextstate <= 4'b0001;
            4'b0001:
                begin
                    if(opcode == 6'h23 || opcode == 6'h2b) nextstate <= 4'b0010;
                    else if(opcode == 6'h4)nextstate <= 4'b1000;
                    else if(opcode == 6'h2)nextstate <= 4'b1001;
                    else if(opcode == 6'h5)nextstate <= 4'b1010;
                    else if(opcode == 6'h0)nextstate <= 4'b0110; //RR
                    else nextstate <= 4'b1011; //RI
                end
            4'b0010:
                begin
                    if(opcode == 6'h23) nextstate <= 4'b0011;
                    else nextstate <= 4'b0101;
                end
            4'b0011: nextstate <= 4'b0100;
            4'b0100: nextstate <= 4'b0000;
            4'b0101: nextstate <= 4'b0000;
            4'b0110: nextstate <= 4'b0111;
            4'b0111: nextstate <= 4'b0000;
            4'b1000: nextstate <= 4'b0000;
            4'b1001: nextstate <= 4'b0000;
            4'b1010: nextstate <= 4'b0000;
            4'b1011: nextstate <= 4'b1100; //compute
            4'b1100: nextstate <= 4'b0000; //reg write
            default: nextstate <= 4'b0000;
        endcase
        
    end
    
    always @(posedge clk or posedge rst)
    begin
    //if(clk)begin
        if(rst)
        begin
            ALUSrcA  <= 1'b0;   
            ALUSrcB  <= 2'b01;  
            ALUOp    <= 2'b00;  
            IorD     <= 1'b0;   
            PCSource <= 2'b00;  
            IRWrite  <= 1'b1;   
            MemWrite <= 1'b0;   
            RegWrite <= 1'b0;   
            PCWrite  <= 1'b1;   
            PCWriteCond <= 1'b0;
            PCWriteCond_bne <= 1'b0;
        end
        else
        begin
        case(nextstate)
            4'b0000:
                begin
                    ALUSrcA  <= 1'b0;
                    ALUSrcB  <= 2'b01;
                    ALUOp    <= 2'b00;
                    IorD     <= 1'b0;
                    PCSource <= 2'b00;
                    IRWrite  <= 1'b1;
                    MemWrite <= 1'b0;
                    RegWrite <= 1'b0;
                    PCWrite  <= 1'b1;
                    PCWriteCond <= 1'b0;
                    PCWriteCond_bne <= 1'b0;
                end
            4'b0001:
                begin
                    ALUSrcA  <= 1'b0; 
                    ALUSrcB  <= 2'b11;
                    ALUOp    <= 2'b00;
                    IRWrite  <= 1'b0;   
                    MemWrite <= 1'b0;   
                    RegWrite <= 1'b0;   
                    PCWrite  <= 1'b0;   
                    PCWriteCond <= 1'b0; 
                    PCWriteCond_bne <= 1'b0;                        
                end
            4'b0010:
              begin
                  ALUSrcA  <= 1'b1; 
                  ALUSrcB  <= 2'b10;
                  ALUOp    <= 2'b00;
                  IRWrite  <= 1'b0;   
                  MemWrite <= 1'b0;   
                  RegWrite <= 1'b0;   
                  PCWrite  <= 1'b0;   
                  PCWriteCond <= 1'b0;
                  PCWriteCond_bne <= 1'b0;                         
              end
            4'b0011:
              begin
                  IorD <= 1'b1;
                  IRWrite  <= 1'b0;   
                  MemWrite <= 1'b0;   
                  RegWrite <= 1'b0;   
                  PCWrite  <= 1'b0;   
                  PCWriteCond <= 1'b0;
                  PCWriteCond_bne <= 1'b0;                         
              end
            4'b0100:
              begin
                  RegDst <= 1'b0;
                  MemtoReg <= 1'b1;
                  IRWrite  <= 1'b0;   
                  MemWrite <= 1'b0;   
                  RegWrite <= 1'b1;   
                  PCWrite  <= 1'b0;   
                  PCWriteCond <= 1'b0;
                  PCWriteCond_bne <= 1'b0;                         
              end
            4'b0101:
              begin
                  IorD <= 1'b1;
                  IRWrite  <= 1'b0;   
                  MemWrite <= 1'b1;   
                  RegWrite <= 1'b0;   
                  PCWrite  <= 1'b0;   
                  PCWriteCond <= 1'b0; 
                  PCWriteCond_bne <= 1'b0;                        
              end
            4'b0110:
              begin
                  ALUSrcA  <= 1'b1; 
                  ALUSrcB  <= 2'b00;
                  ALUOp    <= 2'b10;
                  IRWrite  <= 1'b0;   
                  MemWrite <= 1'b0;   
                  RegWrite <= 1'b0;   
                  PCWrite  <= 1'b0;   
                  PCWriteCond <= 1'b0;   
                  PCWriteCond_bne <= 1'b0;                      
              end
            4'b0111:
              begin
                  RegDst <= 1'b1;
                  MemtoReg <= 1'b0;
                  IRWrite  <= 1'b0;   
                  MemWrite <= 1'b0;   
                  RegWrite <= 1'b1;   
                  PCWrite  <= 1'b0;   
                  PCWriteCond <= 1'b0; 
                  PCWriteCond_bne <= 1'b0;                        
              end
            4'b1000:
              begin
                  ALUSrcA  <= 1'b1; 
                  ALUSrcB  <= 2'b00;
                  ALUOp    <= 2'b01;
                  PCSource <= 2'b01;
                  IRWrite  <= 1'b0;   
                  MemWrite <= 1'b0;   
                  RegWrite <= 1'b0;   
                  PCWrite  <= 1'b0;   
                  PCWriteCond <= 1'b1;
                  PCWriteCond_bne <= 1'b0;                         
              end
            4'b1001:                 
              begin                  
                  PCSource <= 2'b10; 
                  IRWrite  <= 1'b0;  
                  MemWrite <= 1'b0;  
                  RegWrite <= 1'b0;  
                  PCWrite  <= 1'b1;  
                  PCWriteCond <= 1'b0;
                  PCWriteCond_bne <= 1'b0;
              end 
            4'b1010:                      
              begin                       
                  ALUSrcA  <= 1'b1;       
                  ALUSrcB  <= 2'b00;      
                  ALUOp    <= 2'b01;      
                  PCSource <= 2'b01;      
                  IRWrite  <= 1'b0;       
                  MemWrite <= 1'b0;       
                  RegWrite <= 1'b0;       
                  PCWrite  <= 1'b0;       
                  PCWriteCond <= 1'b0;    
                  PCWriteCond_bne <= 1'b1;
              end                         
            4'b1011:                      
              begin                       
                  ALUSrcA  <= 1'b1;       
                  ALUSrcB  <= 2'b10;      
                  ALUOp    <= 2'b11;           
                  IRWrite  <= 1'b0;       
                  MemWrite <= 1'b0;       
                  RegWrite <= 1'b0;       
                  PCWrite  <= 1'b0;       
                  PCWriteCond <= 1'b0;    
                  PCWriteCond_bne <= 1'b0;
              end                         
            4'b1100:                        
              begin                         
                  RegDst <= 1'b0;
                  MemtoReg <= 1'b0;       
                  IRWrite  <= 1'b0;         
                  MemWrite <= 1'b0;         
                  RegWrite <= 1'b1;         
                  PCWrite  <= 1'b0;         
                  PCWriteCond <= 1'b0;      
                  PCWriteCond_bne <= 1'b0;  
              end                                                                                                                             
            default:
                begin
                    IRWrite  <= 1'b0;   
                    MemWrite <= 1'b0;   
                    RegWrite <= 1'b0;   
                    PCWrite  <= 1'b0;   
                    PCWriteCond <= 1'b0;
                    PCWriteCond_bne <= 1'b0;
                end                                  
        endcase
        end
    //end    
    //else begin
    //    IRWrite  <= 1'b0;   
    //    MemWrite <= 1'b0;   
    //    RegWrite <= 1'b0;   
    //    PCWrite  <= 1'b0;   
    //    PCWriteCond <= 1'b0; 
    //end
    
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
