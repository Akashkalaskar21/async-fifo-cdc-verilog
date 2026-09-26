`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2026 10:11:54 AM
// Design Name: 
// Module Name: async_fifo
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


module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input  wire                  wclk,
    input  wire                  wrst_n,
    input  wire                  winc,
    input  wire [DATA_WIDTH-1:0] wdata,
    output wire                  wfull,
    
    input  wire                  rclk,
    input  wire                  rrst_n,
    input  wire                  rinc,
    output wire [DATA_WIDTH-1:0] rdata,
    output wire                  rempty
);
    wire [ADDR_WIDTH-1:0] waddr, raddr;
    wire [ADDR_WIDTH:0]   wptr, rptr, wq2_rptr, rq2_wptr;

    // Instantiate 2-FF Synchronizer (Read to Write domain)
    sync_2ff #(.ADDR_WIDTH(ADDR_WIDTH)) sync_r2w (
        .clk(wclk), .rst_n(wrst_n), .din(rptr), .dout(wq2_rptr)
    );

    // Instantiate 2-FF Synchronizer (Write to Read domain)
    sync_2ff #(.ADDR_WIDTH(ADDR_WIDTH)) sync_w2r (
        .clk(rclk), .rst_n(rrst_n), .din(wptr), .dout(rq2_wptr)
    );

    // Instantiate Dual-Port Memory
    fifo_mem #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) fifomem (
        .wclk(wclk), .wclken(winc), .wfull(wfull),
        .waddr(waddr), .raddr(raddr), .wdata(wdata), .rdata(rdata)
    );

    // Instantiate Write Logic & Full Flag
    wptr_full #(.ADDR_WIDTH(ADDR_WIDTH)) wptr_h (
        .wclk(wclk), .wrst_n(wrst_n), .winc(winc),
        .wq2_rptr(wq2_rptr), .wfull(wfull), .waddr(waddr), .wptr(wptr)
    );

    // Instantiate Read Logic & Empty Flag
    rptr_empty #(.ADDR_WIDTH(ADDR_WIDTH)) rptr_h (
        .rclk(rclk), .rrst_n(rrst_n), .rinc(rinc),
        .rq2_wptr(rq2_wptr), .rempty(rempty), .raddr(raddr), .rptr(rptr)
    );
endmodule
