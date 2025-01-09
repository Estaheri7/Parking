`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:09:21 01/08/2025 
// Design Name: 
// Module Name:    digitsMUX 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module digitsMUX(
    input CLK,
    input [1:0] location,
	 input [2:0] capacity,
	 input [3:0] E,
    output reg [4:0] selector,
    output reg [7:0] segments_L
    );
	 
	 wire CLK_divided_1, CLK_divided_2;
    wire CLK_divided;

    digitMUX_clk_divider dmcd(CLK, CLK_divided_1);
    timer_clock_divider tfcd(CLK, CLK_divided_2);

    assign CLK_divided = (~E != 4'b1111) ? CLK_divided_1 : CLK_divided_2;
	
	 initial begin
		selector <= 5'b01000;
	 end
	 
	 always @ (posedge CLK_divided) begin
		case (selector)
			5'b01000: selector <= 5'b00100;
			5'b00100: selector <= 5'b00010;
			5'b00010: selector <= 5'b00001;
			5'b00001: selector <= 5'b01000;
		endcase
	 end
	 
	 always @ (posedge CLK_divided) begin
		if (selector == 5'b00100) begin
			if (~E == 4'b1111) begin
				segments_L <= 8'b00111000;
			end

			else begin
				segments_L <= 8'b00111111;
			end
		end
		else if (selector == 5'b01000) begin
			if (~E == 4'b1111) begin
				segments_L <= 8'b00111110;
			end
			else begin case (capacity)
				3'b000: segments_L <= 8'b00111111;
				3'b001: segments_L <= 8'b00000110;
				3'b010: segments_L <= 8'b01011011;
				3'b011: segments_L <= 8'b01001111;
				3'b100: segments_L <= 8'b01100110;
				endcase
			end
		end
		else if (selector == 5'b00001) begin
			if (~E == 4'b1111) begin
				segments_L <= 8'b01110001;
			end
			else begin 
				segments_L <= 8'b00111111;
			end
		end
		else if (selector == 5'b00010) begin
			if (~E == 4'b1111) begin
				segments_L <= 8'b00111000;
			end
			else begin case (location)
					2'b00: segments_L <= 8'b00111111;
					2'b01: segments_L <= 8'b00000110;
					2'b10: segments_L <= 8'b01011011;
					2'b11: segments_L <= 8'b01001111;
				endcase
			end
		end
	 end

endmodule
