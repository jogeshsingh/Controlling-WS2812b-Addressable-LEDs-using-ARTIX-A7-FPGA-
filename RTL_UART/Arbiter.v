`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2022 11:53:29 AM
// Design Name: 
// Module Name: Arbiter
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

`define WIDTH_UART 8
`define WIDTH_SEL 2
module Arbiter(
input i_clk , 
input [`WIDTH_UART-1:0] i_uart, 
output reg [`WIDTH_SEL-1:0] o_sel_mux 
    );


always @(i_clk)
  begin
    if (i_uart == 8'h31)          //number 1  //
       o_sel_mux = 2'b00;                
     else if (i_uart == 8'h32)    //number 2 //
       o_sel_mux = 2'b01 ;
    else if (i_uart == 8'h33)  //number 3 -- ///
       o_sel_mux = 2'b10;
else 
       o_sel_mux = 2'b11;
     end             
    
endmodule
