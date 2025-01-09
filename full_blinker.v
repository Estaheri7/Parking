module full_blink(full, CLK, light);
    input full, CLK;
    output reg light;
    reg [3:0] counter;
    reg blinking;

    initial begin
        light = 1'b0;
        counter = 4'b0000;
        blinking = 0;
    end

    wire CLK_OUT;

    timer_clock_divider tcd(
        .CLK_IN(CLK), 
        .CLK_OUT(CLK_OUT)
    );

    always @ (posedge CLK_OUT or posedge full) begin
        if (full) begin
            blinking <= 1'b1;
            counter <= 0;
            light <= 1'b1;
        end
        else if (counter != 6 - 1 & blinking) begin
            light <= ~light;
            counter <= counter + 1;
        end
        else begin
            light <= 1'b0;
            counter <= 0;
            blinking <= 0;
        end
    end
endmodule
