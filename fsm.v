module fsm(enter, exit, CLK, RST, switch, E, capacity, full, open_door);
    input enter, exit, CLK, RST;
	 input [1:0] switch;
	 input [3:0] E;
    output full, open_door;
    output reg [2:0] capacity;

    parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100;
    reg [2:0] state;
    initial begin
        state = s4;
        capacity = s4;
    end

    assign full = (state == s0) & enter;
    assign open_door = ((state != s0) & enter) | ((state != s4) & exit & ~E[switch]);

    always @ (posedge CLK or negedge RST) begin
        if (~RST) begin
            state = s4;
            capacity = s4;
        end
        else begin case(state)
            s4: if ((enter == 1 & exit == 0) | (enter == 1 & exit == 1)) begin
                state = s3;
                capacity = s3;
            end else begin
                state = s4;
                capacity = s4;
            end

            s3: if (enter == 1 & exit == 0) begin
                state = s2;
                capacity = s2;
            end else if (enter == 0 & exit == 1 & ~E[switch]) begin
                state = s4;
                capacity = s4;
            end else begin
                state = s3;
                capacity = s3;
            end

            s2: if (enter == 1 & exit == 0) begin
                state = s1;
                capacity = s1;
            end else if (enter == 0 & exit == 1 & ~E[switch]) begin
                state = s3;
                capacity = s3;
            end else begin
                state = s2;
                capacity = s2;
            end

            s1: if (enter == 1 & exit == 0) begin
                state = s0;
                capacity = s0;
            end else if (enter == 0 & exit == 1 & ~E[switch]) begin
                state = s2;
                capacity = s2;
            end else begin
                state = s1;
                capacity = s1;
            end

            s0: if (enter == 0 & exit == 1 & ~E[switch]) begin
                state = s1;
                capacity = s1;
            end else begin
                state = s0;
                capacity = s0;
            end
        endcase
		  end
    end
endmodule