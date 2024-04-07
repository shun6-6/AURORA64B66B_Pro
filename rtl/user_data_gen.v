`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/02 22:10:28
// Design Name: 
// Module Name: user_data_gen
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


module user_data_gen(
    input               i_clk                       ,
    input               i_rst                       ,

    output [63:0]       m_axi_tx_tdata              ,
    output [7 :0]       m_axi_tx_tkeep              ,
    output              m_axi_tx_tlast              ,
    output              m_axi_tx_tvalid             ,
    input               m_axi_tx_tready             ,
    input  [63:0]       s_axi_rx_tdata              ,
    input  [7 :0]       s_axi_rx_tkeep              ,
    input               s_axi_rx_tlast              ,
    input               s_axi_rx_tvalid             
);

localparam              P_SEND_LEN = 100            ;

reg  [63:0]             rm_axi_tx_tdata             ;
reg  [7 :0]             rm_axi_tx_tkeep             ;
reg                     rm_axi_tx_tlast             ;
reg                     rm_axi_tx_tvalid            ;
reg  [15:0]             r_cnt                       ;
reg  [15:0]             r_send_cnt                  ;

wire                    w_start                     ;
wire                    w_active                    ;
wire [63:0]             ws_axi_rx_tdata             ;
wire [7 :0]             ws_axi_rx_tkeep             ;
wire                    ws_axi_rx_tlast             ;
wire                    ws_axi_rx_tvalid            ;

assign w_start = r_cnt == 100                      ;
assign w_active = m_axi_tx_tvalid & m_axi_tx_tready ;
assign m_axi_tx_tdata  = rm_axi_tx_tdata            ;
assign m_axi_tx_tkeep  = rm_axi_tx_tkeep            ;
assign m_axi_tx_tlast  = rm_axi_tx_tlast            ;
assign m_axi_tx_tvalid = rm_axi_tx_tvalid           ;
assign ws_axi_rx_tdata  = s_axi_rx_tdata            ;
assign ws_axi_rx_tkeep  = s_axi_rx_tkeep            ;
assign ws_axi_rx_tlast  = s_axi_rx_tlast            ;
assign ws_axi_rx_tvalid = s_axi_rx_tvalid           ;

always@(posedge i_clk,posedge i_rst)
begin
    if(i_rst)
        r_cnt <= 'd0;
    else if(rm_axi_tx_tlast)
        r_cnt <= 'd0;
    else if(r_cnt == 100)
        r_cnt <= r_cnt;
    else 
        r_cnt <= r_cnt + 1;

end

always@(posedge i_clk,posedge i_rst)
begin
    if(i_rst)
        r_send_cnt <= 'd0;
    else if(w_active && r_send_cnt == P_SEND_LEN - 1)
        r_send_cnt <= 'd0;
    else if(w_active)
        r_send_cnt <= r_send_cnt + 1;
    else
        r_send_cnt <= r_send_cnt;
end

always@(posedge i_clk,posedge i_rst)
begin
    if(i_rst)
        rm_axi_tx_tvalid <= 'd0;
    else if(w_active && r_send_cnt == P_SEND_LEN - 1)
        rm_axi_tx_tvalid <= 'd0;
    else if(w_start)
        rm_axi_tx_tvalid <= 'd1;
    else 
        rm_axi_tx_tvalid <= rm_axi_tx_tvalid;
end

always@(posedge i_clk,posedge i_rst)
begin
    if(i_rst)
        rm_axi_tx_tlast <= 'd0;
    else if(w_active && r_send_cnt == P_SEND_LEN - 2)
        rm_axi_tx_tlast <= 'd1;
    else    
        rm_axi_tx_tlast <= 'd0;
end

always@(posedge i_clk,posedge i_rst)
begin
    if(i_rst)
        rm_axi_tx_tdata <= 'd0;
    else if(rm_axi_tx_tlast)
        rm_axi_tx_tdata <= 'd0;
    else if(w_active)
        rm_axi_tx_tdata <= rm_axi_tx_tdata + 1;
    else 
        rm_axi_tx_tdata <= rm_axi_tx_tdata;
end

always@(posedge i_clk,posedge i_rst)
begin   
    if(i_rst)
        rm_axi_tx_tkeep <= 8'hff;
    else 
        rm_axi_tx_tkeep <= 8'hff;
end

endmodule
