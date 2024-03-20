`include "mod10_counter.v"
`include "mod6_counter.v"

module MinutesSecondsTimer (
    input wire CLK,
    input wire Load,
    input wire Enable,
    input wire Clearn, 
    input wire [3:0] initial_seconds_units, 
    input wire [2:0] initial_seconds_tens, 
    input wire [3:0] initial_minutes_units, 
    output reg [3:0] seconds_units,
    output reg [2:0] seconds_tens,
    output reg [3:0] minutes_units,
    output reg timer_done
);

reg [3:0] min_counter;
reg [3:0] seconds_units_load; 
reg [2:0] seconds_tens_load; 
reg [3:0] minutes_units_load; 

wire [3:0] sec_units_counter;
wire [2:0] min_counter_output;

mod10_counter mod10 (
    .CLK(CLK),
    .Q(sec_units_counter)
);

mod6_counter mod6 (
    .CLK(CLK),
    .Q(min_counter_output)
);

always @ (posedge CLK) begin
    if (!Clearn) begin
        seconds_units <= 4'b0000;
        seconds_tens <= 3'b000;
        minutes_units <= 4'b0000;
        timer_done <= 1'b0;
    end else if (Load) begin
        seconds_units <= initial_seconds_units; 
        seconds_tens <= initial_seconds_tens; 
        minutes_units <= initial_minutes_units; 
        seconds_units_load <= initial_seconds_units; 
        seconds_tens_load <= initial_seconds_tens; 
        minutes_units_load <= initial_minutes_units;
    end else if (Enable && !(minutes_units == 4'b0000 && seconds_tens == 3'b000 && seconds_units == 4'b0000)) begin
        if (seconds_tens == 3'b000 && seconds_units == 4'b0000) begin
            minutes_units <= minutes_units - 1;
            seconds_tens <= 3'b101;
            seconds_units <= 4'b1001;
        end else if (seconds_units == 4'b0000) begin
            seconds_tens <= seconds_tens - 1;
            seconds_units <= 4'b1001;
        end else begin
            seconds_units <= seconds_units - 1;
        end
    end
    if (minutes_units == 4'b0000 && seconds_tens == 3'b000 && seconds_units == 4'b0000) begin
        timer_done <= 1'b1;
    end else begin
        timer_done <= 1'b0;
    end
end

endmodule
