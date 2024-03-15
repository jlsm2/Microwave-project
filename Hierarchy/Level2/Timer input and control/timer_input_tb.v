`include "timer_input.v"

module MicrowaveTimer_tb;

// Parameters for the test bench
parameter CLK_PERIOD = 10; // 100MHz clock for the sake of the example

// Test bench signals
reg clk;
reg rst;
reg [9:0] switches;
wire [3:0] units_of_seconds;
wire [3:0] units_of_minutes;
wire [3:0] tens_of_seconds;
wire [3:0] encoded_input; // Add encoded_input to test bench

// Instance of the MicrowaveTimer module
MicrowaveTimer uut(
    .clk(clk),
    .rst(rst),
    .switches(switches),
    .units_of_seconds(units_of_seconds),
    .units_of_minutes(units_of_minutes),
    .tens_of_seconds(tens_of_seconds)
);

// Instance of the priority_encoder_4x2 module
priority_encoder_4x2 encoder (
    .enable(1),
    .number(switches),
    .clk(clk),
    .encoded(encoded_input)
);

// Clock generation
initial begin
    clk = 0;
    forever #(CLK_PERIOD / 2) clk = ~clk;
end

// Test stimulus
initial begin
    // Initialize inputs
    rst = 1;
    switches = 10'b0;
    
    // Reset the system
    #(CLK_PERIOD * 10);
    rst = 0;
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
    rst = 1;
    #(CLK_PERIOD * 50);
    rst = 0;
    #(CLK_PERIOD * 100);
    
    // Complete the simulation
    $finish;
end

// Optionally, monitor changes to certain signals
initial begin
    $dumpfile("simulation.vcd"); // Set the VCD filename
    $dumpvars(0, MicrowaveTimer_tb); // Dump all variables
    $monitor("Time = %t | rst = %b | switches = %b | encoded_input = %b | units_of_seconds = %b | units_of_minutes = %b | tens_of_seconds = %b",
             $time, rst, switches, encoded_input, units_of_seconds, units_of_minutes, tens_of_seconds);
end
  
endmodule
