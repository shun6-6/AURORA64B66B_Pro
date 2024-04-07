`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/06 18:50:50
// Design Name: 
// Module Name: aurora64b66b_channel
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


module aurora64b66b_channel(
    input               i_init_clk_100M         ,
    input               i_rst                   ,
    input               i_gtref_clk             ,
    output              gt_txp                  ,
    output              gt_txn                  ,
    input               gt_rxp                  ,
    input               gt_rxn                  ,

    input  [63:0]       s_axi_tx_tdata          ,
    input  [7 :0]       s_axi_tx_tkeep          ,
    input               s_axi_tx_tlast          ,
    input               s_axi_tx_tvalid         ,
    output              s_axi_tx_tready         ,
    output [63:0]       m_axi_rx_tdata          ,
    output [7 :0]       m_axi_rx_tkeep          ,
    output              m_axi_rx_tlast          ,
    output              m_axi_rx_tvalid         ,

    output              o_hard_err              ,
    output              o_soft_err              ,
    output              o_channel_up            ,
    output              o_lane_up               ,
    input  [2 :0]       i_loopback              ,

    output              o_user_clk              ,
    output              o_user_rst              ,

    input               gt0_qplllock_in         ,
    input               gt0_qpllrefclklost_in   ,
    output              gt0_qpllreset_out       ,
    input               gt_qpllclk_quad1_in     ,
    input               gt_qpllrefclk_quad1_in  
);

wire                    w_tx_out_clk        ;
wire                    w_gt_clk_locked     ;
wire                    w_user_clk          ;
wire                    w_sycn_clk          ;
wire                    w_pll_not_locked    ;
wire                    w_sys_reset_out     ;
wire                    w_system_rst        ;
wire                    w_gt_reset          ;

assign o_user_clk = w_user_clk              ;
assign o_user_rst = w_sys_reset_out         ;

aurora_64b66b_0_SUPPORT_RESET_LOGIC support_reset_logic_i
(
    .RESET            (i_rst          ),
    .USER_CLK         (w_user_clk     ),
    .INIT_CLK         (i_init_clk_100M),
    .GT_RESET_IN      (i_rst          ),
    .SYSTEM_RESET     (w_system_rst   ),
    .GT_RESET_OUT     (w_gt_reset     )
);

aurora_64b66b_0_CLOCK_MODULE clock_module_i
(
    // .INIT_CLK_P       (                 ),
    // .INIT_CLK_N       (                 ),
    // .INIT_CLK_O       (                 ),
    .CLK              (w_tx_out_clk     ),
    .CLK_LOCKED       (w_gt_clk_locked  ),
    .USER_CLK         (w_user_clk       ),
    .SYNC_CLK         (w_sycn_clk       ),
    .MMCM_NOT_LOCKED  (w_pll_not_locked )
);

aurora_64b66b_0 aurora_64b66b_0_i
(
  .s_axi_tx_tdata             (s_axi_tx_tdata         ),
  .s_axi_tx_tkeep             (s_axi_tx_tkeep         ),
  .s_axi_tx_tlast             (s_axi_tx_tlast         ),
  .s_axi_tx_tvalid            (s_axi_tx_tvalid        ),
  .s_axi_tx_tready            (s_axi_tx_tready        ),
  .m_axi_rx_tdata             (m_axi_rx_tdata         ),
  .m_axi_rx_tkeep             (m_axi_rx_tkeep         ),
  .m_axi_rx_tlast             (m_axi_rx_tlast         ),
  .m_axi_rx_tvalid            (m_axi_rx_tvalid        ),

  .rxp                        (gt_rxp                 ),
  .rxn                        (gt_rxn                 ),
  .txp                        (gt_txp                 ),
  .txn                        (gt_txn                 ),
  .refclk1_in                 (i_gtref_clk            ),
  .hard_err                   (o_hard_err             ),
  .soft_err                   (o_soft_err             ),
  .channel_up                 (o_channel_up           ),
  .lane_up                    (o_lane_up              ),
  .mmcm_not_locked            (w_pll_not_locked       ),
  .user_clk                   (w_user_clk             ),
  .sync_clk                   (w_sycn_clk             ),
  .reset_pb                   (w_system_rst           ),
  .gt_rxcdrovrden_in          (0                      ),
  .power_down                 (0                      ),
  .loopback                   (i_loopback             ),
  .pma_init                   (w_gt_reset             ),
  .gt_pll_lock                (w_gt_clk_locked        ),
  .drp_clk_in                 (i_init_clk_100M        ),
  .gt_qpllclk_quad1_in        (gt_qpllclk_quad1_in    ),
  .gt_qpllrefclk_quad1_in     (gt_qpllrefclk_quad1_in ),   
  .gt_to_common_qpllreset_out (gt0_qpllreset_out      ),
  .gt_qplllock_in             (gt0_qplllock_in        ), 
  .gt_qpllrefclklost_in       (gt0_qpllrefclklost_in  ),       
  .drpdi_in                   (0                      ),
  .drpdo_out                  (                       ), 
  .drprdy_out                 (                       ), 
  .drpen_in                   (0                      ), 
  .drpwe_in                   (0                      ), 
  .drpaddr_in                 (0                      ),
  .qpll_drpaddr_in            (0                      ),
  .qpll_drpdi_in              (0                      ),
  .qpll_drpdo_out             (                       ),   
  .qpll_drprdy_out            (                       ),   
  .qpll_drpen_in              (0                      ), 
  .qpll_drpwe_in              (0                      ), 
  .init_clk                   (i_init_clk_100M        ),
  .link_reset_out             (                       ), 
  .sys_reset_out              (w_sys_reset_out        ),
  .tx_out_clk                 (w_tx_out_clk           )
);

endmodule
