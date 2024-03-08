`timescale 1ns/1ns
`include "decoder.v"

module decoder_tb;

    reg [3:0] TenMin_TB, Min_TB, TenSec_TB, Sec_TB;
    wire [6:0] OutTenMin_TB, OutMin_TB, OutTenSec_TB, OutSec_TB;

    decoder DUT (
        .TenMin(TenMin_TB),
        .Min(Min_TB),
        .TenSec(TenSec_TB),
        .Sec(Sec_TB),
        .OutTenMin(OutTenMin_TB),
        .OutMin(OutMin_TB),
        .OutTenSec(OutTenSec_TB),
        .OutSec(OutSec_TB)
    );

    initial begin
        $dumpfile("decoder_tb.vcd");
        $dumpvars(0, decoder_tb);

        TenMin_TB = 4'b0000; Min_TB = 4'b0000; TenSec_TB = 4'b0000; Sec_TB = 4'b0000;
        #5 TenMin_TB = 4'b0001; Min_TB = 4'b0001; TenSec_TB = 4'b0001; Sec_TB = 4'b0001;
        #5 TenMin_TB = 4'b0010; Min_TB = 4'b0010; TenSec_TB = 4'b0010; Sec_TB = 4'b0010;
        #5 TenMin_TB = 4'b0011; Min_TB = 4'b0011; TenSec_TB = 4'b0011; Sec_TB = 4'b0011;
        #5 TenMin_TB = 4'b0100; Min_TB = 4'b0100; TenSec_TB = 4'b0100; Sec_TB = 4'b0100;
        #5 TenMin_TB = 4'b0101; Min_TB = 4'b0101; TenSec_TB = 4'b0101; Sec_TB = 4'b0101;
        #5 TenMin_TB = 4'b0110; Min_TB = 4'b0110; TenSec_TB = 4'b0110; Sec_TB = 4'b0110;
        #5 TenMin_TB = 4'b0111; Min_TB = 4'b0111; TenSec_TB = 4'b0111; Sec_TB = 4'b0111;
        #5 TenMin_TB = 4'b1000; Min_TB = 4'b1000; TenSec_TB = 4'b1000; Sec_TB = 4'b1000;
        #5 TenMin_TB = 4'b1001; Min_TB = 4'b1001; TenSec_TB = 4'b1001; Sec_TB = 4'b1001;

    end

endmodule
