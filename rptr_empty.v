`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2026 10:11:27 AM
// Design Name: 
// Module Name: rptr_empty
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


module rptr_empty #(
    parameter ADDR_WIDTH = 4
)(
    input  wire                rclk,
    input  wire                rrst_n,
    input  wire                rinc,
    input  wire [ADDR_WIDTH:0] rq2_wptr,
    output reg                 rempty,
    output wire [ADDR_WIDTH-1:0] raddr,
    output reg  [ADDR_WIDTH:0] rptr
);
    reg  [ADDR_WIDTH:0] rbin;
    wire [ADDR_WIDTH:0] rgraynext, rbinnext;
    wire                rempty_val;

    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n) begin
            rbin   <= 0;
            rptr   <= 0;
            rempty <= 1'b1;
        end else begin
            rbin   <= rbinnext;
            rptr   <= rgraynext;
            rempty <= rempty_val;
        end
    end

    assign raddr      = rbin[ADDR_WIDTH-1:0];
    assign rbinnext   = rbin + (rinc & ~rempty);
    assign rgraynext  = (rbinnext >> 1) ^ rbinnext;

    // Empty condition: Read pointer equals synchronized Write pointer
    assign rempty_val = (rgraynext == rq2_wptr);
endmodule
