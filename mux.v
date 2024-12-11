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

module one_to_four_demux(sel, En, inp, deout);
    input [1:0] sel;
    input En;
    input inp;
    output [3:0] deout;

    assign deout = (En && inp) ? (
                    (sel == 2'b00) ? 4'b0001 :
                    (sel == 2'b01) ? 4'b0010 :
                    (sel == 2'b10) ? 4'b0100 :
                    (sel == 2'b11) ? 4'b1000 :
                    4'b0000) :
                    4'b0000;
endmodule