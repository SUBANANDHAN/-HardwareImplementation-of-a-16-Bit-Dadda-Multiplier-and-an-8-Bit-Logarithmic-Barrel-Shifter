`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2026 01:19:29
// Design Name: 
// Module Name: controller
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

module shifter_controller_8bit (
    input  wire        clk,
    input  wire        start_stop,
    input  wire [7:0]  douta,      

    output reg  [4:0]  addra = 5'd0,
    output reg         ena   = 1'b0,
    output reg  [7:0]  data_to_shift,
    output reg  [2:0]  shamt,
    output reg         shift_mode
);

    reg state = 1'b0; // 0: Read Data, 1: Read Control

    always @(posedge clk) begin
        if (start_stop) begin
            ena <= 1'b1;
            case (state)
                1'b0: begin // Stage 1: Capture Data
                    data_to_shift <= douta;
                    addra <= addra + 1'b1;
                    state <= 1'b1;
                end
                1'b1: begin // Stage 2: Capture Shamt and Mode
                    shamt      <= douta[2:0];
                    shift_mode <= douta[3];
                    addra      <= addra + 1'b1;
                    state      <= 1'b0;
                end
            endcase
        end else begin
            ena   <= 1'b0;
            addra <= 5'd0;
            state <= 1'b0;
        end
    end
endmodule
