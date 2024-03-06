`timescale 1ns / 1ps

module priority_encoder_4x2_tb();

    reg clk;
    reg enable;
    reg [9:0] number;
    wire [3:0] encoded;

    priority_encoder_4x2 dut (
        .clk(clk),
        .enable(enable),
        .number(number),
        .encoded(encoded)
    );

    always begin
        clk = 0;
        #5;
        clk = 1;
        #5;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;

        enable = 1;
        number = 10'b0000000000;
        #10;

        number = 10'b0100000000;
        #10;
        #15;

        number = 10'b0010000000;
        #10;
        #15;

        number = 10'b0001000000;
        #10;
        #15;

        number = 10'b0000100000;
        #10;
        #15;

        number = 10'b0000010000;
        #10;
        #15;

        number = 10'b0000001000;
        #10;
        #15;

        number = 10'b0000000100;
        #10;
        #15;

        number = 10'b0000000010;
        #10;
        #15;

        number = 10'b0000000001;
        #10;
        #15;

        $finish;
    end

endmodule
