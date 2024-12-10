module location_register(D, CLK, L);
    input CLK;
    input [1:0] D;
    output reg [1:0] L;

    always @ (posedge CLK) begin
        L = D;
    end
endmodule