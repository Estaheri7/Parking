`timescale 1ns/1ps

module tb_circuit();

    // Testbench signals
    reg enter, CLK, exit, RST;
    reg [1:0] switch;
    wire full, door_open;
    wire [2:0] capacity;
    wire [1:0] L;
    wire [3:0] F, E;
    wire [63:0] spot0_time, spot1_time, spot2_time, spot3_time;
    wire open_light, full_light;

    // Instantiate the circuit
    circuit uut (
        .enter(enter),
        .exit(exit),        // Fixed to 0 (ignored)
        .switch(switch),  // Fixed to 00 (ignored)
        .CLK(CLK),
        .RST(RST),
        .full(full),
        .door_open(door_open),
        .capacity(capacity),
        .L(L),
        .F(F),
        .E(E),
        .spot0_time(spot0_time),
        .spot1_time(spot1_time),
        .spot2_time(spot2_time),
        .spot3_time(spot3_time),
        .open_light(open_light),
        .full_light(full_light)
    );

    // Clock generation
    reg [31:0] counter = 0;
    always begin
        #5 CLK = ~CLK;
        // counter = counter + 1; // 5 ns clock period
    end

    // Test sequence
    initial begin
        // VCD file generation
        $dumpfile("circuit.vcd"); // Name of the VCD file
        $dumpvars(0, tb_circuit);    // Dump all variables in the scope of tb_circuit

        // Initialize signals
        CLK = 0;
        RST = 1; // Set RST to 1 (active high reset)
        enter = 0;
        exit = 0;
        switch = 2'b00;

        // Monitor outputs
        $monitor("Time=%0t | enter=%b | exit=%b | full=%b | full_light=%b | door_open=%b | open_light=%b | switch=%b | capacity=%d | L=%b | F=%b | E=%b", 
                $time, enter, exit, full, full_light, door_open, open_light, switch, capacity, L, F, E);


        // Test sequence focusing on 'enter'
        $display("Step-by-Step Testing with 'enter' Signal");
        
        // Apply reset
        #10 RST = 0; // Deassert reset
        #10 RST = 1; // Assert reset

        // Step-by-step changes in 'enter' signal
        #10 enter = 1; // First entry
        #10 enter = 0; // Pause entry

        #20000000 enter = 1; // Second entry after 12 seconds
        #10 enter = 0; // Pause entry

          #20000000 enter = 1; // Second entry after 12 seconds
        #10 enter = 0; // Pause entry

          #20000000 enter = 1; // Second entry after 12 seconds
        #10 enter = 0; // Pause entry

          #20000000 enter = 1; // Second entry after 12 seconds
        #10 enter = 0; // Pause entry

        #15000000
        switch = 2'b10;
        exit = 1;
        #10 exit = 0;

        // #1000000 enter = 1;
        // #10 enter = 0;
        // #10 enter = 1; // Second entry
        // #10 enter = 0; // Pause entry
        // #10 enter = 1; // Third entry
        // #10 enter = 0; // Pause entry
        // #10 enter = 1; // Fourth entry (capacity should now be full if applicable)
        // #10 enter = 0; // Pause entry

        // // Test scenario: Parking is full, no effect from 'enter'
        // #10 enter = 1;
        // #10 enter = 0;

        // switch = 2'b01;
        // #10 exit = 1;
        // #10 exit = 0;
        // switch = 2'b10;
        // #10 exit = 1;
        // #10 exit = 0;

        // #10 enter = 1;
        // #10 enter = 0;

        // #10 RST = 0;
        // #10 RST = 1;

        // Conclude test
        // $display("End of Step-by-Step Test");
        // $finish;
    end

endmodule
