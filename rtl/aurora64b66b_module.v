`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/06 18:50:50
// Design Name: 
// Module Name: aurora64b66b_module
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


module aurora64b66b_module(
    input               i_init_clk_100M         ,
    input               i_rst                   ,
    input               gt_refclk_p             ,
    input               gt_refclk_n             ,
    output [1 :0]       gt_txp                  ,
    output [1 :0]       gt_txn                  ,
    input  [1 :0]       gt_rxp                  ,
    input  [1 :0]       gt_rxn                  ,

    input  [63:0]       s_axi_tx_0_tdata        ,
    input  [7 :0]       s_axi_tx_0_tkeep        ,
    input               s_axi_tx_0_tlast        ,
    input               s_axi_tx_0_tvalid       ,
    output              s_axi_tx_0_tready       ,
    output [63:0]       m_axi_rx_0_tdata        ,
    output [7 :0]       m_axi_rx_0_tkeep        ,
    output              m_axi_rx_0_tlast        ,
    output              m_axi_rx_0_tvalid       ,

    output              o_hard_err_0            ,
    output              o_soft_err_0            ,
    output              o_channel_up_0          ,
    output              o_lane_up_0             ,
    input  [2 :0]       i_loopback_0            ,

    output              o_user_clk_0            ,
    output              o_user_rst_0            ,

    input  [63:0]       s_axi_tx_1_tdata        ,
    input  [7 :0]       s_axi_tx_1_tkeep        ,
    input               s_axi_tx_1_tlast        ,
    input               s_axi_tx_1_tvalid       ,
    output              s_axi_tx_1_tready       ,
    output [63:0]       m_axi_rx_1_tdata        ,
    output [7 :0]       m_axi_rx_1_tkeep        ,
    output              m_axi_rx_1_tlast        ,
    output              m_axi_rx_1_tvalid       ,

    output              o_hard_err_1            ,
    output              o_soft_err_1            ,
    output              o_channel_up_1          ,
    output              o_lane_up_1             ,
    input  [2 :0]       i_loopback_1            ,

    output              o_user_clk_1            ,
    output              o_user_rst_1          


);

IBUFDS_GTE2 IBUFDS_GTXE2_CLK1  
(
    .O               (i_gtref_clk   ),
    .ODIV2           (              ),
    .CEB             (1'b0          ),
    .I               (gt_refclk_p   ),
    .IB              (gt_refclk_n   )
);

aurora_64b66b_0_gt_common_wrapper gt_common_support
(
    .gt_qpllclk_quad1_out       (gt_qpllclk_quad1_in    ),
    .gt_qpllrefclk_quad1_out    (gt_qpllrefclk_quad1_in ),
    .GT0_GTREFCLK0_COMMON_IN    (i_gtref_clk            ), 
    //----------------------- Common Block - QPLL Ports ------------------------
    .GT0_QPLLLOCK_OUT           (gt0_qplllock_in        ),
    .GT0_QPLLRESET_IN           (gt0_qpllreset_out      ),
    .GT0_QPLLLOCKDETCLK_IN      (i_init_clk_100M        ),
    .GT0_QPLLREFCLKLOST_OUT     (gt0_qpllrefclklost_in  ),
    //---------------------- Common DRP Ports ----------------------
    .qpll_drpaddr_in            (0),
    .qpll_drpdi_in              (0),
    .qpll_drpclk_in             (0),
    .qpll_drpdo_out             (), 
    .qpll_drprdy_out            (), 
    .qpll_drpen_in              (0), 
    .qpll_drpwe_in              (0)
);

aurora64b66b_channel aurora64b66b_channel_u0(
    .i_init_clk_100M            (i_init_clk_100M        ),
    .i_rst                      (i_rst                  ),
    .i_gtref_clk                (i_gtref_clk            ),
    .gt_txp                     (gt_txp[0]              ),
    .gt_txn                     (gt_txn[0]              ),
    .gt_rxp                     (gt_rxp[0]              ),
    .gt_rxn                     (gt_rxn[0]              ),

    .s_axi_tx_tdata             (s_axi_tx_0_tdata       ),
    .s_axi_tx_tkeep             (s_axi_tx_0_tkeep       ),
    .s_axi_tx_tlast             (s_axi_tx_0_tlast       ),
    .s_axi_tx_tvalid            (s_axi_tx_0_tvalid      ),
    .s_axi_tx_tready            (s_axi_tx_0_tready      ),
    .m_axi_rx_tdata             (m_axi_rx_0_tdata       ),
    .m_axi_rx_tkeep             (m_axi_rx_0_tkeep       ),
    .m_axi_rx_tlast             (m_axi_rx_0_tlast       ),
    .m_axi_rx_tvalid            (m_axi_rx_0_tvalid      ),

    .o_hard_err                 (o_hard_err_0           ),
    .o_soft_err                 (o_soft_err_0           ),
    .o_channel_up               (o_channel_up_0         ),
    .o_lane_up                  (o_lane_up_0            ),
    .i_loopback                 (i_loopback_0           ),

    .o_user_clk                 (o_user_clk_0           ),
    .o_user_rst                 (o_user_rst_0           ),

    .gt0_qplllock_in            (gt0_qplllock_in        ),
    .gt0_qpllrefclklost_in      (gt0_qpllrefclklost_in  ),
    .gt0_qpllreset_out          (gt0_qpllreset_out      ),
    .gt_qpllclk_quad1_in        (gt_qpllclk_quad1_in    ),
    .gt_qpllrefclk_quad1_in     (gt_qpllrefclk_quad1_in ) 
);

aurora64b66b_channel aurora64b66b_channel_u1(
    .i_init_clk_100M            (i_init_clk_100M        ),
    .i_rst                      (i_rst                  ),
    .i_gtref_clk                (i_gtref_clk            ),
    .gt_txp                     (gt_txp[1]              ),
    .gt_txn                     (gt_txn[1]              ),
    .gt_rxp                     (gt_rxp[1]              ),
    .gt_rxn                     (gt_rxn[1]              ),

    .s_axi_tx_tdata             (s_axi_tx_1_tdata       ),
    .s_axi_tx_tkeep             (s_axi_tx_1_tkeep       ),
    .s_axi_tx_tlast             (s_axi_tx_1_tlast       ),
    .s_axi_tx_tvalid            (s_axi_tx_1_tvalid      ),
    .s_axi_tx_tready            (s_axi_tx_1_tready      ),
    .m_axi_rx_tdata             (m_axi_rx_1_tdata       ),
    .m_axi_rx_tkeep             (m_axi_rx_1_tkeep       ),
    .m_axi_rx_tlast             (m_axi_rx_1_tlast       ),
    .m_axi_rx_tvalid            (m_axi_rx_1_tvalid      ),

    .o_hard_err                 (o_hard_err_1           ),
    .o_soft_err                 (o_soft_err_1           ),
    .o_channel_up               (o_channel_up_1         ),
    .o_lane_up                  (o_lane_up_1            ),
    .i_loopback                 (i_loopback_1           ),

    .o_user_clk                 (o_user_clk_1           ),
    .o_user_rst                 (o_user_rst_1           ),

    .gt0_qplllock_in            (gt0_qplllock_in        ),
    .gt0_qpllrefclklost_in      (gt0_qpllrefclklost_in  ),
    .gt0_qpllreset_out          (),
    .gt_qpllclk_quad1_in        (gt_qpllclk_quad1_in    ),
    .gt_qpllrefclk_quad1_in     (gt_qpllrefclk_quad1_in ) 
);

endmodule
