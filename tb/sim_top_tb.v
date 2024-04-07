`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/07 10:32:49
// Design Name: 
// Module Name: sim_top_tb
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


module sim_top_tb();

reg clk,rst,gt_clk;

always begin
    gt_clk = 0;
    #3.2;
    gt_clk = 1;
    #3.2;
end

always begin
    clk = 0;
    #5;
    clk = 1;
    #5;
end

wire [1 :0]               gt_txp   ;
wire [1 :0]               gt_txn   ;
wire [1 :0]               gt_rxp   ;
wire [1 :0]               gt_rxn   ;
wire [1 :0]               o_sfp_dis;



XC7Z100_top XC7Z100_top_u0(
    .i_gtref_clk_p       (gt_clk),
    .i_gtref_clk_n       (~gt_clk),
    .i_clk_100M_p        (clk),
    .i_clk_100M_n        (~clk),
    .gt_txp              (gt_txp),
    .gt_txn              (gt_txn),
    .gt_rxp              (gt_txp),
    .gt_rxn              (gt_txn),
    .o_sfp_dis           ()
);

endmodule
