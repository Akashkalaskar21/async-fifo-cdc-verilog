`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2026 10:10:03 AM
// Design Name: 
// Module Name: sync_2ff
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


module sync_2ff #(
    parameter ADDR_WIDTH = 4
)(
    input  wire                clk,
    input  wire                rst_n,
    input  wire [ADDR_WIDTH:0] din,
    output reg  [ADDR_WIDTH:0] dout
);
    reg [ADDR_WIDTH:0] q1;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q1   <= 0;
            dout <= 0;
        end else begin
            q1   <= din;
            dout <= q1;
        end
    end
endmodule
