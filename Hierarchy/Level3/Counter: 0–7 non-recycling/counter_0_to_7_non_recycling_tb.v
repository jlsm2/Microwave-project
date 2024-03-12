`timescale 1ns / 1ps

module counter_0_to_7_non_recycling_tb;

    reg clk;
    reg rst;
    wire [2:0] count;

    counter_0_to_7_non_recycling counter_inst (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;
    end
	
  	initial begin
      	$dumpfile("dump.vcd");
        $dumpvars();
    end
  	
    initial begin
        $monitor("Time=%t, Count=%b", $time, count);
        #50;
        rst = 1;
        #10;
        rst = 0;
        #100;
        $finish;
    end

endmodule
	
	
