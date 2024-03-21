`timescale 1ns / 1ps

module microwave_tb;

    reg [0:9] switches;
    reg startn, stopn, clearn, door_closed, clk;
    wire magn_on, timerdone, pgt_1Hz;
    wire [6:0] outMin, outTenSec, outSec;

    microwave uut (
        .switches(switches),
        .startn(startn),
        .stopn(stopn),
        .clearn(clearn),
        .door_closed(door_closed),
        .clk(clk),
        .magn_on(magn_on),
        .timerdone(timerdone),
        .pgt_1Hz(pgt_1Hz),
        .outMin(outMin),
        .outTenSec(outTenSec),
        .outSec(outSec)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        switches = 10'b0;
        startn = 1'b0;
        stopn = 1'b0;
        clearn = 1'b0;
        door_closed = 1'b0;
        clk = 1'b0;

        #10 startn = 1'b1;
        #10 stopn = 1'b1;
        #10 clearn = 1'b1;
        #10 door_closed = 1'b1;

        #10 $finish;
    end

endmodule
