module spots_register(En, make_entry, CLK, RST, sel, E);
    input make_entry, CLK, En, RST;
    input [1:0] sel;
    output reg [3:0]  E;

    initial begin
        E = 4'b1111;
    end

    always @ (posedge CLK or negedge RST) begin
        if (~RST) begin
            E = 4'b1111;
        end
        else if (En) begin
            if (make_entry) begin
                E[sel] = 1'b0;
            end else begin
                E[sel] = 1'b1;
            end
        end
    end
endmodule
