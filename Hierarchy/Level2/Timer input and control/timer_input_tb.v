module timer_input_tb;

parameter CLK_PERIOD = 10;
 
reg clk;
reg enablen; 
reg [9:0] switches;
wire [3:0] units_of_seconds;
wire [3:0] units_of_minutes;
wire [3:0] tens_of_seconds;
wire loadn; 

timer_input uut(
    .clk(clk),
  	.enablen(enablen),
    .switches(switches),
    .units_of_seconds(units_of_seconds),
    .units_of_minutes(units_of_minutes),
    .tens_of_seconds(tens_of_seconds),
    .loadn(loadn)
);

// Clock generation
initial begin
    clk = 0;
    forever #(CLK_PERIOD / 2) clk = ~clk;
end

initial begin

    enablen = 0;
    switches = 10'b0;
    
    #(CLK_PERIOD * 10);
    enablen = 1;
    #(CLK_PERIOD * 10);
    
    #(CLK_PERIOD * 100);
    
    switches = 10'b0100000000;
    #(CLK_PERIOD * 100);
    
    switches = 10'b0000000001; 
    #(CLK_PERIOD * 100);
    
    switches = 10'b0010000000;
    #(CLK_PERIOD * 100);
    
    enablen = 0;
  	switches = 10'b0001000000;
    #(CLK_PERIOD * 100);
  
    enablen = 1;
    #(CLK_PERIOD * 100);
    
  	switches = 10'b0000000000; 
    #(CLK_PERIOD * 100);
  	switches = 10'b0001000000;
    #(CLK_PERIOD * 100);
  
  	switches = 10'b0000000000;
    #(CLK_PERIOD * 100);
  
  	switches = 10'b0001000000;
    #(CLK_PERIOD * 100);
    $finish;
end


initial begin
    $dumpfile("simulation.vcd");
    $dumpvars(0, timer_input_tb);
    $monitor("Time = %t | enablen = %b | switches = %b | units_of_seconds = %b | units_of_minutes = %b | tens_of_seconds = %b | loadn = %b",
             $time, enablen, switches, units_of_seconds, units_of_minutes, tens_of_seconds, loadn);
end
  
endmodule
