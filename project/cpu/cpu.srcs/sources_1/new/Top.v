`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/06 21:42:24
// Design Name: 
// Module Name: Top
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


module Top(
    input cont,            
    input step,            
    input mem, 
    input mode_cpu,            
    input inc,             
    input dec,             
    input rst,             
    input CLK100MHZ,           
    output [15:0] led,     
    output [6:0]seg,
    output [7:0]an,
    output dp  
    );
    wire clk_8mhz,clk_cpu,clk_2mhz;
    wire run;
    wire [31:0] pc,mem_data,reg_data,addr;
    wire [15:0] display;
    
    
    assign dp = display[15];
    assign seg = display[14:8];
    assign an = display[7:0];
    
    //assign clk_cpu = clk_2mhz & run;
    
    clk_wiz_0 mo_clk_wiz_0(clk_8mhz,CLK100MHZ);
    CLK #(4) mo_clk_2m(clk_8mhz,0,1,clk_2mhz);
    DDU mo_ddu(cont,step,mem,inc,dec,pc,mem_data,reg_data,rst,clk_8mhz,clk_2mhz,run,addr,led,display);
    CPU_MEM mo_cpu_mem(clk_2mhz, run, rst, mode_cpu, addr, pc, mem_data,reg_data);
    
    //MEM mo_mem(clk_cpu,rst,mode_cpu,we,ra_cpu,wd,ra_cpu,addr,mem_data);
    //CPU mo_cpu(clk_cpu, rst, mem_data, addr[6:2], ra_cpu, we,wd,reg_data);
endmodule
