module min_finder(E, S);
    input [3:0] E;
    output [1:0] S;

    assign S =  (E[3] == 1'b1) ? 2'b11 : 
                (E[2] == 1'b1) ? 2'b10 : 
                (E[1] == 1'b1) ? 2'b01 : 
                (E[0] == 1'b1) ? 2'b00 :
                2'b00;
endmodule
