module park_space_register(D, CLK, E, F);
    input CLK;
    input [3:0] D;
    output reg [3:0] E, F;

    always @ (posedge CLK) begin
        F <= D;
        E <= ~D;
    end
endmodule