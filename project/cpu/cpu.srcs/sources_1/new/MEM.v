`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/08 20:39:19
// Design Name: 
// Module Name: MEM
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


module MEM(
    input clk,
    input rst,
    input mode_cpu,
    input we,
    input [31:0]wa, //cpu写地址
    input [31:0]wd, //cpu写数据
    input [31:0]ra_cpu, //cpu 读地址
    input [31:0]ra_ddu, 
    output [31:0]rd
    );
    
    reg [31:0] ra;
    wire [7:0]addr; //cpu 读地址
    wire mode_we;
    
    assign addr = ra[9:2];
    assign mode_we = we & mode_cpu;
    
    dist_mem_gen_0   mo_dist_mem ( //256*32
  .a(wa[9:2]),        	// input wire [7 : 0] a
  .d(wd),        	// input wire [31 : 0] d
  .dpra(addr),  	// input wire [7 : 0] dpra
  .clk(clk),    	// input wire clk
  .we(mode_we),      	// input wire we
  .dpo(rd)    	// output wire [31 : 0] dpo
);
    
    always @(ra_cpu or ra_ddu or mode_cpu)
    begin
        if(mode_cpu) ra = ra_cpu;
        else ra = ra_ddu;
    end
    

    
endmodule
















