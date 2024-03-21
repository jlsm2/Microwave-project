module microwave (
    input wire [0:9] switches,
    input wire startn, stopn, clearn, door_closed, clk,
    output wire magn_on, timerdone, pgt_1Hz,
    output wire [6:0] outMin,
   output wire [6:0] outTenSec,
   output wire [6:0] outSec
);

wire [3:0] units_of_seconds;
wire [3:0] units_of_minutes;
wire [3:0] tens_of_seconds;
wire [3:0] seconds_units;
wire [3:0] minutes_units;
wire [3:0] seconds_tens;
wire loadn;
wire load;

level2_control magnetron (
    .startn(startn),
    .stopn(stopn),
    .clearn(clearn),
    .door_closed(door_closed),
    .timer_done(timerdone),
    .mag_on(magn_on)
);

timer_input t_input (
    .clk(clk),
    .enablen(~magn_on),
   .switches(switches),
   .units_of_seconds(units_of_seconds),
   .units_of_minutes(units_of_minutes),
   .tens_of_seconds(tens_of_seconds),
    .loadn(loadn),
   .pgt_1Hz(pgt_1Hz)
);

assign load = loadn;

minutes_seconds_timer timer(
    .CLK(startn),
    .Load(load),
   .Enable(magn_on),
	.Clearn(clearn),
    .initial_seconds_units(units_of_seconds),
    .initial_seconds_tens(tens_of_seconds),
    .initial_minutes_units(units_of_minutes),
   .seconds_units(seconds_units),
   .seconds_tens(seconds_tens),
   .minutes_units(minutes_units),
   .timer_done(timerdone)
);

decoder seven_segment_timer (
    .Min(minutes_units),
    .TenSec(seconds_tens),
    .Sec(seconds_units),
    .OutMin(outMin),
    .OutTenSec(outTenSec),
    .OutSec(outSec)
);

endmodule
