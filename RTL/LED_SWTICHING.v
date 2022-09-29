`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2022 10:05:59 AM
// Design Name: 
// Module Name: LED_SWTICHING
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
//FPGA CLK = 100MHZ 
///data is transmitted at 800 KHZ 
//REQUIRED CLK COUNT = 100MHZ/800 KHZ == 125  ns 
///clk cnt width == 2^7 = 128 ns // //7 enough for counting till 125 ns //
//every 50 microseconds the operation is resetted 
///DATA transfer time is 1.25 us == 125 ns 
///T_1H (1 code  , high time  = 0.8 us == 80 ns //
///T_0H(o code high time = 0.4 us    == 40 ns //
///T_0L (0 code low time = 0.85 us == 85 ns 
//T_1L  (1 code low time = 0.45 us == 45 ns //
//the DO line goes high for 80 ns and low for 40 ns //
/// COUNT_HIGH_VAL = CLK_CNT *0.64  = 80 ns 
// COUNT_LOW_VAL = CLK_CNT * 0.32 = 40 ns
 
`define TX_RATE 800_000           ///800 KHZ
`define FPGA_CLK 100_000_000       ///100 MHZ 
`define CNT_WID 5
module LED_SWTICHING(
input i_clk , 
input rst_n , 
input [7:0] Red_in , 
input [7:0] Green_in , 
input [7:0] Blue_in , 
output reg o_DOUT ,
output o_cnt_en ,  
output reg [2:0] p_STATE 

    );


parameter CLK_CNT  = `FPGA_CLK / `TX_RATE ;  ////125//
parameter CLK_DIV_WIDTH  =   7;
integer  CNT_HIGH_PULSE = CLK_CNT * 0.64 ;       ///80 ns 
integer  CNT_LOW_PULSE  = CLK_CNT * 0.32 ;       ///40 ns//


parameter RESET_CNT  = CLK_CNT * 100    ;   ///125 *100 = 1250 //
parameter RESET_CNT_WIDTH = 14   ;

///fsm states 
parameter RESET = 3'b000, 
          LATCH_DATA = 3'b001, 
          SET_DO = 3'b010,
          TX_DATA = 3'b011, 
          CHECK_STATUS = 3'b100;
          
parameter GREEN = 2'b00 ,  
          RED   = 2'b01 , 
          BLUE  = 2'b10 ;         
 
reg [13:0] Reset_cnt = 0 ;          
reg [2:0] current_bit_index = 0;       ///tells which current bit of color is being counted by DO line //
reg [7:0] current_byte ;       ///which color byte (RGB ) is being processed//
reg [1:0] o_color  = 0;       ///reg for stroing which of the RGB signals is processed in frame strips //
reg [6:0] clk_div = 0;      ///clk div reg //
reg [7:0] o_green  , o_red  , o_blue ;
reg [4:0] address_led  ; 
wire   current_address   ; 


assign o_cnt_en = (address_led == 0) ? 1'b1 : 1'b0;

always @(posedge i_clk)
     begin
       if (rst_n)                 //active high reset //
          begin
             o_DOUT <= 0;
             p_STATE <= RESET ;
             o_color = GREEN ;
             Reset_cnt <= 0;
             address_led <= 0;   //31 //
             current_bit_index <= 3'b111;
            end 
         else 
            begin
                   case (p_STATE )
      RESET :    begin
                o_DOUT <= 1'b0;
                address_led <= 0;
                   if (Reset_cnt == (RESET_CNT-1)) begin
                      Reset_cnt<= 1'b0;
                   //   address_led <= 0;
                      p_STATE <= LATCH_DATA ;
                   end    
                     else
                      Reset_cnt <= Reset_cnt + 1'b1 ;
                  end 
     LATCH_DATA : begin
                     
                     o_red <= Red_in ;
                     o_blue <= Blue_in ;
                     current_bit_index <= 3'b111;
                     current_byte <= Green_in ;
                     address_led <= address_led + 1'b1 ;
                     o_color <= GREEN ;
                     p_STATE <= SET_DO ;
                 end                                              
      SET_DO     : begin
                     o_DOUT <= 1'b1;
                     clk_div = 0;
                     p_STATE <= TX_DATA ;  
                    end  
     TX_DATA      :   begin
                         if ((current_byte[7] == 0) && (clk_div >= CNT_LOW_PULSE ))begin
                                o_DOUT <= 1'b0;
                         end        
                        else   if  ((current_byte[7] == 1) && (clk_div >=CNT_HIGH_PULSE))begin
                              o_DOUT <= 1'b0; 
                            end 
                          
                         if ( clk_div== CLK_CNT-1) begin
                             clk_div <= 0;
                             p_STATE <= CHECK_STATUS ;
                           end
                         else
                            clk_div <= clk_div + 1'b1 ;
                          //  p_STATE <= TX_DATA ;
                    end                    
                                      
     CHECK_STATUS :   begin
                            if (current_bit_index!=0) begin
                                current_byte <=  {current_byte , 1'b0} ;
                                  case (current_bit_index)
                                   3'b111 : current_bit_index <= 3'b110;
                                   3'b110:  current_bit_index <= 3'b101;
                                   3'b101:  current_bit_index <= 3'b100;
                                   3'b100:  current_bit_index <= 3'b011;
                                   3'b011:  current_bit_index <= 3'b010;
                                   3'b010:  current_bit_index <= 3'b001;
                                   3'b001:  current_bit_index <= 3'b000;
                                   endcase
                                    p_STATE <= SET_DO ;  
                                 end
                            else   
                                     begin
                                        ///if the current bit[7] == 0 , then move t next color strip //     
                                             case (o_color)
                                             GREEN :  begin 
                                                      current_bit_index <= 3'b111 ;
                                                       o_color <= RED ;
                                                       current_byte <= o_red  ;
                                                       p_STATE <= SET_DO ;
                                                       end 
                                             RED :    begin
                                                     current_bit_index <= 3'b111;
                                                      o_color <= BLUE ; 
                                                      current_byte <= o_blue ;
                                                      p_STATE <= SET_DO ;
                                                       end
                                             BLUE :    begin
                                                        if (address_led == 5'b10001)
                                                            p_STATE <= RESET ;
                                                         else
                                                           p_STATE <= LATCH_DATA ;          //latch new data //
                                                      end 
                                             endcase
                                            end 
                                        end
                   endcase
            end                
                                
            end                   
   assign current_address = ((p_STATE == SET_DO)|| (current_bit_index == 3'b111));    
                      
                                        
endmodule
