module timer_input_tb;

// Parameters for the test bench
parameter CLK_PERIOD = 10; // 100MHz clock for the sake of the example

// Test bench signals
reg clk;
reg enablen; // Changed from rst to enablen
reg [9:0] switches;
wire [3:0] units_of_seconds;
wire [3:0] units_of_minutes;
wire [3:0] tens_of_seconds;
wire loadn; // Added loadn to test bench

// Instance of the timer_input module
timer_input uut(
    .clk(clk),
    .enablen(enablen), // Changed from rst to enablen
    .switches(switches),
    .units_of_seconds(units_of_seconds),
    .units_of_minutes(units_of_minutes),
    .tens_of_seconds(tens_of_seconds),
    .loadn(loadn) // Added loadn to test bench
);

// Clock generation
initial begin
    clk = 0;
    forever #(CLK_PERIOD / 2) clk = ~clk;
end

// Test stimulus
initial begin
    // Initialize inputs
    enablen = 0; // Changed from rst to enablen
    switches = 10'b0;
    
    // Reset the system
    #(CLK_PERIOD * 10);
    enablen = 1; // Changed from rst to enablen
    #(CLK_PERIOD * 10);
    
    // Test case 1: No input change
    #(CLK_PERIOD * 100);
    
    // Test case 2: Change input to 10
    switches = 10'b0100000000; // 10 in binary
    #(CLK_PERIOD * 100);
    
    // Test case 3: Change input to 50
    switches = 10'b0000000001; // 50 in binary
    #(CLK_PERIOD * 100);
    
    // Test case 4: Change input to 100
    switches = 10'b0010000000; // 100 in binary
    #(CLK_PERIOD * 100);
    
    // Test case 5: Reset the system
    enablen = 0;
  	switches = 10'b0001000000; // 100 in binary
    #(CLK_PERIOD * 100);
  
    enablen = 1;
    #(CLK_PERIOD * 100);
    
  	switches = 10'b0000000000; // 100 in binary
    #(CLK_PERIOD * 100);
    // Complete the simulation
  	switches = 10'b0001000000; // 100 in binary
    #(CLK_PERIOD * 100);
  
  	switches = 10'b0000000000; // 100 in binary
    #(CLK_PERIOD * 100);
  
  	switches = 10'b0001000000; // 100 in binary
    #(CLK_PERIOD * 100);
    $finish;
end


initial begin
    $dumpfile("simulation.vcd"); // Set the VCD filename
    $dumpvars(0, timer_input_tb); // Dump all variables
    $monitor("Time = %t | enablen = %b | switches = %b | units_of_seconds = %b | units_of_minutes = %b | tens_of_seconds = %b | loadn = %b",
             $time, enablen, switches, units_of_seconds, units_of_minutes, tens_of_seconds, loadn);
end
  
endmodule
