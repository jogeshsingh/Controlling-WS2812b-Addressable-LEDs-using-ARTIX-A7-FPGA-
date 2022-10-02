## Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { i_clk }]; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { CLK100MHZ }];

## Switches
set_property -dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { rst_n }]; #IO_L12N_T1_MRCC_16 Sch=sw[0]
#set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS33 } [get_ports { i_MUX[0] }]; #IO_L13P_T2_MRCC_16 Sch=sw[1]
#set_property -dict { PACKAGE_PIN C10   IOSTANDARD LVCMOS33 } [get_ports { i_MUX[1] }]; #IO_L13N_T2_MRCC_16 Sch=sw[2]



set_property -dict { PACKAGE_PIN A9    IOSTANDARD LVCMOS33 } [get_ports { i_RX_SERIAL }];



## LEDs
#set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { p_STATE[0] }]; #IO_L24N_T3_35 Sch=led[4]
#set_property -dict { PACKAGE_PIN J5    IOSTANDARD LVCMOS33 } [get_ports { p_STATE[1] }]; #IO_25_35 Sch=led[5]
#set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { p_STATE[2] }]; #IO_L24P_T3_A01_D17_14 Sch=led[6]
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { o_RX_VALID }]; #IO_L24N_T3_A00_D16_14 Sch=led[7]


##OUTPUT to LED  STRIP //



set_property -dict { PACKAGE_PIN E15   IOSTANDARD LVCMOS33 } [get_ports { o_D1 }]; ##1 pin of PMOD B form upper  lane /
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { o_D2 }]; #7th pin of pmod B in down lane 

 ##PMOD C HEADER 
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { o_D3 }]; #IO_L20P_T3_A08_D24_14 Sch=jc_p[1]    , FIRST PIN OF PMOD UPPER LANE 
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { o_D4 }]; #IO_L23N_T3_A02_D18_14 Sch=jc_n[4]     , 8TH PIN OF PMOD LOWER LANE //