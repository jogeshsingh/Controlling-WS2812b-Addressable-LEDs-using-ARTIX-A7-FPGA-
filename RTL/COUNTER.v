`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2022 09:43:01 AM
// Design Name: 
// Module Name: COUNTER
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

`define WIDTH_CNT 5
module COUNTER(
input i_clk ,  
input i_rst_n, 
output [`WIDTH_CNT-1:0] o_counter
    );
   
   
  reg [`WIDTH_CNT-1:0] o_CNT = 0;
  
  //initialize the clk counter //
  always @(posedge  i_clk)
      begin  
           if (i_rst_n)
            o_CNT <= 5'b00000;
    else 
             
            o_CNT <= o_CNT + 1'b1;
         
     end           
     
     ///assign the reg counter to the output //
     assign o_counter = o_CNT ; 
      
  
  
    
endmodule
