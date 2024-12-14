module time_counter(F, CLK, spot0_time, spot1_time, spot2_time, spot3_time);
    input CLK;
    input [3:0] F;
    output reg [63:0] spot0_time, spot1_time, spot2_time, spot3_time;

    initial begin
        spot0_time = 0;
        spot1_time = 0;
        spot2_time = 0;
        spot3_time = 0;
    end

    wire CLK_OUT;

    timer_clock_divider tcd(
        .CLK_IN(CLK), 
        .CLK_OUT(CLK_OUT)
    );

    always @ (posedge CLK_OUT) begin
        if (F[0]) begin
            spot0_time = spot0_time + 1;
        end
        else begin
            spot0_time = 0;
        end
        if (F[1]) begin
            spot1_time = spot1_time + 1;
        end
        else begin
            spot1_time = 0;
        end
        if (F[2]) begin
            spot2_time = spot2_time + 1;
        end
        else begin
            spot2_time = 0;
        end
        if (F[3]) begin
            spot3_time = spot3_time + 1;
        end
        else begin
            spot3_time = 0;
        end
    end
endmodule