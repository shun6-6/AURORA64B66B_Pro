`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/02 09:47:26
// Design Name: 
// Module Name: XC7Z100_top
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


module XC7Z100_top(
    input                       i_gtref_clk_p       ,
    input                       i_gtref_clk_n       ,
    input                       i_clk_100M_p        ,
    input                       i_clk_100M_n        ,
    output [1 :0]               gt_txp              ,
    output [1 :0]               gt_txn              ,
    input  [1 :0]               gt_rxp              ,
    input  [1 :0]               gt_rxn              ,
    output [1 :0]               o_sfp_dis           
);

wire                            w_clk_100M          ;
wire                            w_clk_100M_rst      ;
wire                            w_c0_user_clk       ;
wire                            w_c0_user_rst       ;
wire                            w_c1_user_clk       ;
wire                            w_c1_user_rst       ;
wire                            w_100Mhz_locked     ;
(* MARK_DEBUG = "TRUE" *)wire [63:0]                        m_c0_axi_tx_tdata   ;
(* MARK_DEBUG = "TRUE" *)wire [7 :0]                        m_c0_axi_tx_tkeep   ;
(* MARK_DEBUG = "TRUE" *)wire                               m_c0_axi_tx_tlast   ;
(* MARK_DEBUG = "TRUE" *)wire                               m_c0_axi_tx_tvalid  ;
(* MARK_DEBUG = "TRUE" *)wire                               m_c0_axi_tx_tready  ;
(* MARK_DEBUG = "TRUE" *)wire [63:0]                        s_c0_axi_rx_tdata   ;
(* MARK_DEBUG = "TRUE" *)wire [7 :0]                        s_c0_axi_rx_tkeep   ;
(* MARK_DEBUG = "TRUE" *)wire                               s_c0_axi_rx_tlast   ;
(* MARK_DEBUG = "TRUE" *)wire                               s_c0_axi_rx_tvalid  ;
(* MARK_DEBUG = "TRUE" *)wire [63:0]                        m_c1_axi_tx_tdata   ;
(* MARK_DEBUG = "TRUE" *)wire [7 :0]                        m_c1_axi_tx_tkeep   ;
(* MARK_DEBUG = "TRUE" *)wire                               m_c1_axi_tx_tlast   ;
(* MARK_DEBUG = "TRUE" *)wire                               m_c1_axi_tx_tvalid  ;
(* MARK_DEBUG = "TRUE" *)wire                               m_c1_axi_tx_tready  ;
(* MARK_DEBUG = "TRUE" *)wire [63:0]                        s_c1_axi_rx_tdata   ;
(* MARK_DEBUG = "TRUE" *)wire [7 :0]                        s_c1_axi_rx_tkeep   ;
(* MARK_DEBUG = "TRUE" *)wire                               s_c1_axi_rx_tlast   ;
(* MARK_DEBUG = "TRUE" *)wire                               s_c1_axi_rx_tvalid  ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c0_hard_err       ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c0_soft_err       ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c0_frame_err      ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c0_channel_up     ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c0_lane_up        ;
(* MARK_DEBUG = "TRUE" *)wire [2 :0]                        w_c0_loopback       ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c1_hard_err       ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c1_soft_err       ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c1_frame_err      ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c1_channel_up     ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c1_lane_up        ;
(* MARK_DEBUG = "TRUE" *)wire [2 :0]                        w_c1_loopback       ;

assign w_c0_loopback = 3'b000;
assign w_c1_loopback = 3'b000;
assign o_sfp_dis     = 2'b00 ;

clk_wiz_100Mhz clk_wiz_100Mhz_u0
(
    .clk_out1   (w_clk_100M     ),
    .locked     (w_100Mhz_locked),
    .clk_in1_p  (i_clk_100M_p   ),
    .clk_in1_n  (i_clk_100M_n   )
); 

rst_gen_module#(    
    .P_RST_CYCLE                (10                 )   
)   
rst_gen_module_U0   
(   
    .i_clk                      (w_clk_100M         ),
    .o_rst                      (w_clk_100M_rst     )
);

user_data_gen user_data_gen_u0(
    .i_clk                      (w_c0_user_clk      ),
    .i_rst                      (w_c0_user_rst      ),

    .m_axi_tx_tdata             (m_c0_axi_tx_tdata  ),
    .m_axi_tx_tkeep             (m_c0_axi_tx_tkeep  ),
    .m_axi_tx_tlast             (m_c0_axi_tx_tlast  ),
    .m_axi_tx_tvalid            (m_c0_axi_tx_tvalid ),
    .m_axi_tx_tready            (m_c0_axi_tx_tready ),
    .s_axi_rx_tdata             (s_c0_axi_rx_tdata  ),
    .s_axi_rx_tkeep             (s_c0_axi_rx_tkeep  ),
    .s_axi_rx_tlast             (s_c0_axi_rx_tlast  ),
    .s_axi_rx_tvalid            (s_c0_axi_rx_tvalid )
);

user_data_gen user_data_gen_u1(
    .i_clk                      (w_c1_user_clk      ),
    .i_rst                      (w_c1_user_rst      ),

    .m_axi_tx_tdata             (m_c1_axi_tx_tdata  ),
    .m_axi_tx_tkeep             (m_c1_axi_tx_tkeep  ),
    .m_axi_tx_tlast             (m_c1_axi_tx_tlast  ),
    .m_axi_tx_tvalid            (m_c1_axi_tx_tvalid ),
    .m_axi_tx_tready            (m_c1_axi_tx_tready ),
    .s_axi_rx_tdata             (s_c1_axi_rx_tdata  ),
    .s_axi_rx_tkeep             (s_c1_axi_rx_tkeep  ),
    .s_axi_rx_tlast             (s_c1_axi_rx_tlast  ),
    .s_axi_rx_tvalid            (s_c1_axi_rx_tvalid )
);


aurora64b66b_module aurora64b66b_module_u0(
    .gt_refclk_p                (i_gtref_clk_p      ),
    .gt_refclk_n                (i_gtref_clk_n      ),
    .i_init_clk_100M            (w_clk_100M         ),
    .i_rst                      (w_clk_100M_rst     ),
    .gt_txp                     (gt_txp             ),
    .gt_txn                     (gt_txn             ),
    .gt_rxp                     (gt_rxp             ),
    .gt_rxn                     (gt_rxn             ),

    .s_axi_tx_0_tdata           (m_c0_axi_tx_tdata  ),
    .s_axi_tx_0_tkeep           (m_c0_axi_tx_tkeep  ),
    .s_axi_tx_0_tlast           (m_c0_axi_tx_tlast  ),
    .s_axi_tx_0_tvalid          (m_c0_axi_tx_tvalid ),
    .s_axi_tx_0_tready          (m_c0_axi_tx_tready ),
    .m_axi_rx_0_tdata           (s_c0_axi_rx_tdata  ),
    .m_axi_rx_0_tkeep           (s_c0_axi_rx_tkeep  ),
    .m_axi_rx_0_tlast           (s_c0_axi_rx_tlast  ),
    .m_axi_rx_0_tvalid          (s_c0_axi_rx_tvalid ),

    .s_axi_tx_1_tdata           (m_c1_axi_tx_tdata  ),
    .s_axi_tx_1_tkeep           (m_c1_axi_tx_tkeep  ),
    .s_axi_tx_1_tlast           (m_c1_axi_tx_tlast  ),
    .s_axi_tx_1_tvalid          (m_c1_axi_tx_tvalid ),
    .s_axi_tx_1_tready          (m_c1_axi_tx_tready ),
    .m_axi_rx_1_tdata           (s_c1_axi_rx_tdata  ),
    .m_axi_rx_1_tkeep           (s_c1_axi_rx_tkeep  ),
    .m_axi_rx_1_tlast           (s_c1_axi_rx_tlast  ),
    .m_axi_rx_1_tvalid          (s_c1_axi_rx_tvalid ),

    .o_hard_err_0               (w_c0_hard_err      ),
    .o_soft_err_0               (w_c0_soft_err      ),
    .o_channel_up_0             (w_c0_channel_up    ),
    .o_lane_up_0                (w_c0_lane_up       ),
    .i_loopback_0               (w_c0_loopback      ),
    .o_hard_err_1               (w_c1_hard_err      ),
    .o_soft_err_1               (w_c1_soft_err      ),
    .o_channel_up_1             (w_c1_channel_up    ),
    .o_lane_up_1                (w_c1_lane_up       ),
    .i_loopback_1               (w_c1_loopback      ),

    .o_user_clk_0               (w_c0_user_clk      ),
    .o_user_rst_0               (w_c0_user_rst      ),
    .o_user_clk_1               (w_c1_user_clk      ),
    .o_user_rst_1               (w_c1_user_rst      )
);

endmodule

