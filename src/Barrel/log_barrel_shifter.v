`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2026 01:17:50
// Design Name: 
// Module Name: log_barrel_shifter
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

module barrel_shifter_8bit(
    input [7:0] data_in,
    input [2:0] shamt,
    input ctrl, // 0: Right Shift, 1: Left Shift
    output [7:0] data_out
    );

    wire [7:0] stage0, stage1, stage2;
    wire [7:0] initial_val, final_val;

    // --- Pre-reversal for Left Shift ---
    assign initial_val = ctrl ? {data_in[0], data_in[1], data_in[2], data_in[3], data_in[4], data_in[5], data_in[6], data_in[7]} : data_in;

    // Stage 0: Shift by 1 bit (2^0)
    genvar i;
    generate
        for (i=0; i<8; i=i+1) begin : stage_0
            mux2to1 m0 (initial_val[i], (i+1 > 7) ? 1'b0 : initial_val[i+1], shamt[0], stage0[i]);
        end
    endgenerate

    // Stage 1: Shift by 2 bits (2^1)
    generate
        for (i=0; i<8; i=i+1) begin : stage_1
            mux2to1 m1 (stage0[i], (i+2 > 7) ? 1'b0 : stage0[i+2], shamt[1], stage1[i]);
        end
    endgenerate

    // Stage 2: Shift by 4 bits (2^2)
    generate
        for (i=0; i<8; i=i+1) begin : stage_2
            mux2to1 m2 (stage1[i], (i+4 > 7) ? 1'b0 : stage1[i+4], shamt[2], stage2[i]);
        end
    endgenerate

    // --- Post-reversal for Left Shift ---
    assign final_val = stage2;
    assign data_out = ctrl ? {final_val[0], final_val[1], final_val[2], final_val[3], final_val[4], final_val[5], final_val[6], final_val[7]} : final_val;

endmodule

