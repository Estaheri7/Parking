module spots_register(En, make_entry, CLK, RST, sel, F, E);
    input make_entry, CLK, En, RST;
    input [1:0] sel;
    output reg [3:0] F, E;

    initial begin
        F = 4'b0000;
        E = 4'b1111;
    end

    always @ (posedge CLK or negedge RST) begin
        if (~RST) begin
            F = 4'b0000;
            E = 4'b1111;
        end
        if (En) begin
            if (make_entry) begin
                F[sel] = 1'b1;
                E[sel] = 1'b0;
            end else begin
                F[sel] = 1'b0;
                E[sel] = 1'b1;
            end
        end
    end
endmodule
