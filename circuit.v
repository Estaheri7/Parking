module circuit(enter, exit, switch, CLK, RST, full, door_open, 
capacity, 
F, E, 
L);
    input enter, exit, CLK, RST;
    input [1:0] switch;
    output full, door_open;
    output [2:0] capacity;
    output [1:0] L;
    output [3:0] F, E;

    wire open_enter, open_exit, make_entry;

    assign open_enter = door_open | enter;
    assign open_exit = door_open & exit;

    fsm mainbody(enter, exit, CLK, RST, capacity, full, door_open);

    two_to_one_mux letin(open_exit, open_enter, make_entry);

    wire [1:0] spot;
    two_bit_to_one_mux eore(open_exit, switch, L, spot);

    wire En = E[0] | E[1] | E[2] | E[3] | exit;
    min_finder mf(E, L);

    spots_register sr(En, make_entry, CLK, RST, spot, F, E);
endmodule