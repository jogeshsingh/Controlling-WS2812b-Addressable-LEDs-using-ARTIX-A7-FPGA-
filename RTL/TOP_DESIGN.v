`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2022 03:24:50 PM
// Design Name: 
// Module Name: TOP_DESIGN
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

`define WIDTH_C 5
module TOP_DESIGN(
input i_clk , 
input rst_n ,  
    input [1:0] i_MUX, 
output wire o_D, 
output [2:0] p_STATE 
    );
    
  wire [23:0] o_MEM_data;  
  wire [23:0] o_RGB ;
  wire [`WIDTH_C-1:0] o_COUNT ;
  wire o_CNT_en ;
 
 
   
    MUX_4_1 MUX_UO2(
 .in_1(24'b00111100_01010101_10101010)  , 
 .in_2(24'b01110111_10111100_01110101) , 
 .in_3(24'b10101011_01110001_01101100) , 
 .in_4(24'b10011001_01001001_01101001) ,
 .i_sel(i_MUX), 
 .o_MUX(o_RGB) 
    );
   
    
    LED_SWTICHING LED_U01(
 .i_clk(i_clk) , 
 .rst_n(rst_n) , 
 .Red_in(o_RGB[15:8]) , 
 .Green_in(o_RGB[23:16]) , 
 .Blue_in(o_RGB[7:0]) , 
 .o_DOUT(o_D)  ,  
 .p_STATE(p_STATE)  
 );
 
 

   
 
 
endmodule
