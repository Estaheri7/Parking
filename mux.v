module two_to_one_mux(sel, inp_signal, result);
    input sel;
    input inp_signal;
    output result;

    assign result = (sel == 1'b0) ? inp_signal : ~inp_signal; 
endmodule

module two_bit_to_one_mux(sel, switch, L, result);
    input sel;
    input [1:0] switch, L;
    output [1:0] result;

    assign result = (sel == 1'b0) ? L : switch;
endmodule

// module one_to_four_demux(sel, En, make_entry, d0, d1, d2, d3);
//     input [1:0] sel;
//     input En;
//     input make_entry;
//     output reg d0, d1, d2, d3;

//     if (En) begin
//         if (sel == 2'b00) begin
//             d0 = make_entry;
//         end else if (sel == 2'b01) begin
//             d1 = make_entry;
//         end else if (sel == 2'b10) begin
//             d2 = make_entry;
//         end else if (sel == 2'b11) begin
//             d3 = make_entry;
//         end
//     end
// endmodule