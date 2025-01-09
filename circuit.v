module circuit(enter_nd, exit_nd, switch, CLK, RST, full, door_open, 
                capacity, 
                E, L,
                open_light, full_light, segments_L, selector
    );
    input enter_nd, exit_nd, CLK, RST;
    input [1:0] switch;
    output full, door_open, open_light, full_light;
    output [2:0] capacity;
    output [1:0] L;
    output [3:0] E;
    output [7:0] segments_L;
    output [4:0] selector;
	 
	 wire enter, exit, RST;
	 
	 debouncer db(~enter_nd, CLK, RST, enter);
	 debouncer db1(~exit_nd, CLK, RST, exit);

    wire open_enter, open_exit, make_entry;

    assign open_enter = door_open | enter;
    assign open_exit = door_open & exit;

    fsm mainbody(enter, exit, CLK, RST, switch, E, capacity, full, door_open);

    two_to_one_mux letin(open_exit, open_enter, make_entry);

    wire [1:0] spot;
    two_bit_to_one_mux eore(open_exit, switch, L, spot);

    wire En = E[0] | E[1] | E[2] | E[3] | exit;
    min_finder mf(E, L);

	 digitsMUX dm(CLK, L, capacity, E, selector, segments_L);
    spots_register sr(En, make_entry, CLK, RST, spot, E);
    full_blink fb(full, CLK, full_light);
    open_door_blink odb(door_open, CLK, open_light);
endmodule