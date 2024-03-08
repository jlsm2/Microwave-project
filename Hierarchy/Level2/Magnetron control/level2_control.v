`include "control.v"

module level2_control (
    input wire startn, stopn, clearn, door_closed, timer_done,
    output wire mag_on
);

control control_inst(
    .startn(startn),
    .stopn(stopn),
    .clearn(clearn),
    .door_closed(door_closed),
    .timer_done(timer_done),
    .mag_on(mag_on)
);

endmodule
