`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:52:46 01/07/2025 
// Design Name: 
// Module Name:    debouncer 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Simple debounce module
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module debouncer(
    input sig,
    input CLK,
    input RST,
    output reg deb_signal
    );
	 
	 parameter CLK_F = 40_000_000;
	 
	 localparam count_to = CLK_F / 2;
	 reg [1:0] state;
	 reg [25:0] counter;
	 reg btn_s, btn_s_prev;
	 
	 always @ (posedge CLK or negedge RST) begin
		if (~RST) begin
			state <= 0;
			deb_signal <= 0;
			btn_s <= 0;
			btn_s_prev <= 0;
		end else begin
		btn_s <= sig;
		btn_s_prev <= btn_s;
		deb_signal <= 0;
		
		case (state)
			0: begin
					if (btn_s && ~btn_s_prev) begin
					state <= 1;
					counter <= 0;
					end
				end
			1: begin
				if (counter < count_to - 1) begin
				counter <= counter + 1;
				end else begin
					deb_signal <= 1;
					state <= 0;
					end
				end
			endcase
		end
	end
endmodule

