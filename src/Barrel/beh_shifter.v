`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2026 01:18:47
// Design Name: 
// Module Name: beh_shifter
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

module behavioral_shifter(
    input [7:0] data_in,
    input [2:0] shamt,
    input ctrl,
    output reg [7:0] data_out
    );

    always @(*) begin
        if (ctrl)
            data_out = data_in << shamt;
        else
            data_out = data_in >> shamt;
    end
endmodule

