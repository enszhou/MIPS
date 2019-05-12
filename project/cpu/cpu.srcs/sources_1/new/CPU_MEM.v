`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 18:12:54
// Design Name: 
// Module Name: CPU_MEM
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


module CPU_MEM(
    input clk_2mhz,
    input cont,
    input run,
    input rst,
    input mode_cpu,
    input [31:0] addr,
    output [31:0] pc,mem_data,reg_data
    );
    
    wire clk_cpu, we;
    wire [31:0] ra_cpu,wd;
    
    //assign clk_cpu = clk_2mhz & run;
    assign clk_cpu = clk_2mhz;
    
    MEM mo_mem(clk_cpu, rst, mode_cpu, we, ra_cpu, wd, ra_cpu, addr, mem_data);   
    CPU mo_cpu(clk_cpu, cont, run, rst, mem_data, addr[6:2], ra_cpu, we,wd,reg_data, pc);
    
endmodule
