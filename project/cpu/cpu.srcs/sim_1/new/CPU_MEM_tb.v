`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 22:15:11
// Design Name: 
// Module Name: CPU_MEM_tb
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


module CPU_MEM_tb(

    );
    
    reg clk, rst, run, mode_cpu;
    wire [31:0] mem_data, reg_data, pc;
    reg [31:0]addr;
    
    CPU_MEM mo_cpu_mem_tb(clk, run, rst, mode_cpu, addr, pc, mem_data,reg_data);
    
    initial
    begin
        clk <= 0;
        rst <= 0;
        run <= 1;
        mode_cpu <= 1;
        addr <= 32'h8;
        #10 rst <= 1;
        #4 rst <= 0;
        #600 run <= 0;
        #100 mode_cpu <= 0;
    end
    
    always
    forever #1 clk = ~clk;
    
   
    
endmodule
