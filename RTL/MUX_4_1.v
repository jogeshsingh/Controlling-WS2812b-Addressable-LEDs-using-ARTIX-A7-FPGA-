`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2022 03:26:18 PM
// Design Name: 
// Module Name: MUX_4_1
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
`define SEL_WIDTH 2
`define WIDTH_MUX 24
module MUX_4_1(
input [`WIDTH_MUX -1:0] in_1  , in_2 , in_3 , in_4 ,
input [`SEL_WIDTH-1:0] i_sel  , 
output reg [`WIDTH_MUX-1:0] o_MUX 
    );
  
  always @(*)
     begin
       case (i_sel)
      2'b00: o_MUX = in_1 ;
      2'b01: o_MUX = in_2 ;
      2'b10: o_MUX = in_3 ;
      2'b11: o_MUX = in_4 ;
       default : o_MUX = in_1 ; 
       endcase
     end     
endmodule
