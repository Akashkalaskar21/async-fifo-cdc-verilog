`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2026 10:10:33 AM
// Design Name: 
// Module Name: wptr_full
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


module wptr_full #(
    parameter ADDR_WIDTH = 4
)(
    input  wire                wclk,
    input  wire                wrst_n,
    input  wire                winc,
    input  wire [ADDR_WIDTH:0] wq2_rptr,
    output reg                 wfull,
    output wire [ADDR_WIDTH-1:0] waddr,
    output reg  [ADDR_WIDTH:0] wptr
);
    reg  [ADDR_WIDTH:0] wbin;
    wire [ADDR_WIDTH:0] wgraynext, wbinnext;
    wire                wfull_val;

    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            wbin  <= 0;
            wptr  <= 0;
            wfull <= 0;
        end else begin
            wbin  <= wbinnext;
            wptr  <= wgraynext;
            wfull <= wfull_val;
        end
    end

    assign waddr     = wbin[ADDR_WIDTH-1:0];
    assign wbinnext  = wbin + (winc & ~wfull);
    assign wgraynext = (wbinnext >> 1) ^ wbinnext;

    // Full condition: MSB & 2nd MSB inverted, remaining bits match
    assign wfull_val = (wgraynext == {~wq2_rptr[ADDR_WIDTH:ADDR_WIDTH-1], wq2_rptr[ADDR_WIDTH-2:0]});
endmodule
