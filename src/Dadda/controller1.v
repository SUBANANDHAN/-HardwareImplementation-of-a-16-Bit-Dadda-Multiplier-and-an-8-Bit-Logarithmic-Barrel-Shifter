`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2026 10:47:27
// Design Name: 
// Module Name: controller1
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

module controller (
    input  wire        clk,
    input  wire        start_stop,
    input  wire [31:0] douta,      // 32-bit wide input

    output reg  [3:0]  addra = 4'd0,
    output reg         ena   = 1'b0,

    output reg  [15:0] a_out,      // 16-bit operands
    output reg  [15:0] b_out
);

    reg ena_d = 1'b0;

    // Address and Enable Logic
    always @(posedge clk) begin
        if (start_stop) begin
            ena <= 1'b1;
            // Delay increment to capture Addr 0 first
            if (ena) begin
                addra <= addra + 1'b1;
            end
        end else begin
            ena   <= 1'b0;
            addra <= 4'd0;
        end
    end

    // Data Capture Logic (2-cycle total latency)
    always @(posedge clk) begin
        ena_d <= ena; 
        if (ena_d) begin
            a_out <= douta[31:16]; // High 16 bits
            b_out <= douta[15:0];  // Low 16 bits
        end
    end

endmodule