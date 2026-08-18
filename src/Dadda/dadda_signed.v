`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.01.2026 16:33:00
// Design Name: 
// Module Name: dadda_signed
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

module dadda_16x16_signed_method2 (
    input  [15:0] a,
    input  [15:0] b,
    output [31:0] y
);

    // -----------------------------
    // Step 1: Extract sign bits
    // -----------------------------
    wire signA = a[15];
    wire signB = b[15];

    // -----------------------------
    // Step 2: Absolute values
    // -----------------------------
    wire [15:0] absA = signA ? (~a + 16'd1) : a;
    wire [15:0] absB = signB ? (~b + 16'd1) : b;

    // -----------------------------
    // Step 3: Unsigned Dadda multiply
    // -----------------------------
    wire [31:0] magP;

    dadda_multiplier u_dadda_unsigned (
        .a(absA),
        .b(absB),
        .y(magP)
    );

    // -----------------------------
    // Step 4: Sign correction
    // -----------------------------
    wire signP = signA ^ signB;
    assign y = signP ? (~magP + 32'd1) : magP;

endmodule

