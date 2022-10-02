`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2022 11:47:55 AM
// Design Name: 
// Module Name: MULTIPLE_LED_STRIPS
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


module MULTIPLE_LED_STRIPS(
input i_clk, 
input  rst_n ,  
input i_RX_SERIAL , 
output o_RX_VALID, 
output o_D1 ,  o_D2, o_D3 , o_D4 
    );
    
    
    
 wire [7:0] UART_RX ; 
 wire [1:0] m_sel ; 
 
 UART_RX UART_U1(
 .i_clk(i_clk) , ///Fpga clk ///
 .i_Rx_serial(i_RX_SERIAL) , ///data is serially loaded from PC through this ////
 .o_RX_DV(o_RX_VALID) , ////DATA_VALID , output showing data is successfully received //
 .o_RX(UART_RX)////output led's showing the received ASCII code from PC //
 );    
    

   wire [23:0] o_RGB_1 ; 
   wire [23:0] o_RGB_2 ; 
   wire [23:0] o_RGB_3 ; 
   wire [23:0] o_RGB_4 ; 
   
   wire [23:0] o_RGB ;
              
    LED_SWTICHING LED_U01(
 .i_clk(i_clk) , 
 .rst_n(rst_n) , 
 .Red_in(o_RGB_1[15:8]) , 
 .Green_in(o_RGB_1[23:16]) , 
 .Blue_in(o_RGB_1[7:0]) , 
 .o_DOUT(o_D1)   
 //.o_cnt_en(o_CNT_en),  
 //.p_STATE(p_STATE)  
 );
 
 
            
    LED_SWTICHING LED_U02(
 .i_clk(i_clk) , 
 .rst_n(rst_n) , 
 .Red_in(o_RGB_2[15:8]) , 
 .Green_in(o_RGB_2[23:16]) , 
 .Blue_in(o_RGB_2[7:0]) , 
 .o_DOUT(o_D2)   
 //.o_cnt_en(o_CNT_en),  
 //.p_STATE(p_STATE)  
 );
 
 
            
    LED_SWTICHING LED_U03(
 .i_clk(i_clk) , 
 .rst_n(rst_n) , 
 .Red_in(o_RGB_3[15:8]) , 
 .Green_in(o_RGB_3[23:16]) , 
 .Blue_in(o_RGB_3[7:0]) , 
 .o_DOUT(o_D3)   
 //.o_cnt_en(o_CNT_en),  
 //.p_STATE(p_STATE)  
 );
 
            
    LED_SWTICHING LED_U04(
 .i_clk(i_clk) , 
 .rst_n(rst_n) , 
 .Red_in(o_RGB_4[15:8]) , 
 .Green_in(o_RGB_4[23:16]) , 
 .Blue_in(o_RGB_4[7:0]) , 
 .o_DOUT(o_D4)  
 //.o_cnt_en(o_CNT_en),  
// .p_STATE(p_STATE)  
 ); 
    
    Arbiter U0_AB(
.i_clk(i_clk) , 
.i_uart(UART_RX), 
.o_sel_mux(m_sel)  
    );
    
    assign o_RGB = {o_RGB[15:0] , UART_RX[7:1]} ;
  //  assign o_RGB_2 = {o_RGB_2[15:0] , UART_RX[7:1]} ;
   // assign o_RGB_3 = {o_RGB_3[15:0] , UART_RX[7:1]} ;
    //assign o_RGB_4 = {o_RGB_4[15:0] , UART_RX[7:1]} ;

DEMULTIPLEXER DUT_DEMUX_U1(
.i_din(o_RGB) , 
.i_SEL(m_sel) , 
.o_RGB1(o_RGB_1), 
.o_RGB2(o_RGB_2) , 
.o_RGB3(o_RGB_3) , 
.o_RGB4(o_RGB_4)
    );

/*
Multiplexer_4_1 U1_MUX(
.i_sel(m_sel) , 
.i_in1(o_RGB_1) ,
.i_in2(o_RGB_2) , 
.i_in3(o_RGB_3) , 
.i_in4(o_RGB_4) , 
.o_out(o_RGB) 
    );
*/
endmodule
