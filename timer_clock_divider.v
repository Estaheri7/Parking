module timer_clock_divider(CLK_IN, CLK_OUT);
    input CLK_IN;
    output reg CLK_OUT;
    reg [23:0] counter;

    initial begin
        counter = 0;
        CLK_OUT = 0;
    end

    always @(posedge CLK_IN) begin
        // 10^3 more
        if (counter == 100000 - 1) begin
            counter = 0;
            CLK_OUT = ~CLK_OUT;
        end
        else begin
            counter = counter + 1;
        end
    end
endmodule