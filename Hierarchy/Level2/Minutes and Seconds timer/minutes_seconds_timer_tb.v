`timescale 1s/1s

module MinutesSecondsTimer_tb;

    reg CLK;
    reg Load;
    reg Enable;
    reg Clearn; 
    reg [3:0] initial_seconds_units; 
    reg [2:0] initial_seconds_tens; 
    reg [3:0] initial_minutes_units;

    wire [3:0] seconds_units;
    wire [2:0] seconds_tens;
    wire [3:0] minutes_units;
    wire timer_done;

    MinutesSecondsTimer uut (
        .CLK(CLK),
        .Load(Load),
        .Enable(Enable),
        .Clearn(Clearn), 
        .initial_seconds_units(initial_seconds_units), 
        .initial_seconds_tens(initial_seconds_tens),
        .initial_minutes_units(initial_minutes_units),
        .seconds_units(seconds_units),
        .seconds_tens(seconds_tens),
        .minutes_units(minutes_units),
        .timer_done(timer_done)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
    end

    always begin
        CLK = 1;
        #5 CLK = 0;
        #5;
    end

    initial begin
        Load = 1;
        Enable = 0;
        Clearn = 1;

        // Load initial values
        initial_seconds_units = 4'b0111;
        initial_seconds_tens = 3'b101; 
        initial_minutes_units = 4'b1000; 

        #10
        Load = 0;
        Enable = 1;

        #200
        Load = 1;
        Enable = 0;

        #50
        Load = 0;
        Enable = 1;

        #5000
        Clearn = 0;
        #10
        Clearn = 1;

        #6100 $finish;
    end

endmodule
