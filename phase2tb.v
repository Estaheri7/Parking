module phase2;   
    reg enter, CLK, exit, RST;
    reg [1:0] switch;
    wire full, door_open;
    wire [2:0] capacity;
    wire [1:0] L;
    wire [3:0] F, E;
    wire [63:0] spot0_time, spot1_time, spot2_time, spot3_time;
    wire open_light, full_light;

    circuit uut (
        .enter(enter),
        .exit(exit),
        .switch(switch),
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

  
  initial begin  
    CLK = 0;  
    forever #5 CLK = ~CLK;
  end  

  integer output_file;  
  integer input_file;  
  integer r;  
  reg [3:0] data;  

  initial begin   
        $dumpfile("phase2.vcd");
        $dumpvars(0, phase2);

    output_file = $fopen("output.txt", "w");  
    if (output_file == 0) begin  
      $display("Error: Could not open output file.");  
      $finish;  
    end  
  
    input_file = $fopen("input.txt", "r");  
    if (input_file == 0) begin  
      $display("Error: Could not open input file.");  
      $finish;  
    end  

    RST = 0;   
    enter = 0;  
    exit = 0;  
    switch = 2'b00;  
 
    while (!$feof(input_file)) begin    
      r = $fscanf(input_file, "%b\n", data);  
      RST = 1;
      enter = data[3];        
      exit = data[2];          
      switch = data[1:0];  
      #10;    
      
      $fwrite(output_file, "enter: [%b], exit: [%b], switch: [%b] -> F[%b], [capacity, Location]: [%d,%d], full:%b, door_open:%b\n",   
                enter, exit, switch, F, capacity, L, full, door_open);
    end  
    $fclose(input_file);  
    $fclose(output_file);  
    
    #10000 $finish;  
  end  

endmodule