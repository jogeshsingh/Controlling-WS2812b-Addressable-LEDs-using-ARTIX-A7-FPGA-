`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2022 02:15:02 PM
// Design Name: 
// Module Name: DEMULTIPLEXER
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


module DEMULTIPLEXER(
input [23:0] i_din , 
input [1:0] i_SEL , 
output reg [23:0] o_RGB1, o_RGB2 , o_RGB3 , o_RGB4
    );
    
  always @(*)
     begin 
        case (i_SEL)
      2'b00 :  {o_RGB1 , o_RGB2 , o_RGB3 ,o_RGB4} = { i_din , 23'b0 , 23'b0 , 23'b0};
      2'b01 :  {o_RGB1 , o_RGB2 , o_RGB3 ,o_RGB4} = {  23'b0 ,i_din ,  23'b0 , 23'b0};
      2'b10 :  {o_RGB1 , o_RGB2 , o_RGB3 ,o_RGB4} = {  23'b0 , 23'b0 , i_din ,  23'b0};
      2'b11 :  {o_RGB1 , o_RGB2 , o_RGB3 ,o_RGB4} = {  23'b0 , 23'b0 , 23'b0 , i_din};
      default : {o_RGB1 , o_RGB2 , o_RGB3 ,o_RGB4} = {  23'b0 , 23'b0 , 23'b0 , 23'b0};
     endcase
   end  
        
endmodule
