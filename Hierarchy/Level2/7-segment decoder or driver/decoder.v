module decoder(
    input wire [3:0] TenMin,
    input wire [3:0] Min,
    input wire [3:0] TenSec,
    input wire [3:0] Sec,
    output reg [6:0] OutTenMin,
    output reg [6:0] OutMin,
    output reg [6:0] OutTenSec,
    output reg [6:0] OutSec
);

always @* begin
    case (TenMin)
        4'b0000 : OutTenMin = 7'b0000001;
        4'b0001 : OutTenMin = 7'b1001111;
        4'b0010 : OutTenMin = 7'b0010010;
        4'b0011 : OutTenMin = 7'b0000110;
        4'b0100 : OutTenMin = 7'b1001100;
        4'b0101 : OutTenMin = 7'b0100100;
        4'b0110 : OutTenMin = 7'b0100000;
        4'b0111 : OutTenMin = 7'b0001101;
        4'b1000 : OutTenMin = 7'b0000000;
        4'b1001 : OutTenMin = 7'b0000100;
    endcase

    case (Min)
        4'b0000 : OutMin = 7'b0000001;
        4'b0001 : OutMin = 7'b1001111;
        4'b0010 : OutMin = 7'b0010010;
        4'b0011 : OutMin = 7'b0000110;
        4'b0100 : OutMin = 7'b1001100;
        4'b0101 : OutMin = 7'b0100100;
        4'b0110 : OutMin = 7'b0100000;
        4'b0111 : OutMin = 7'b0001101;
        4'b1000 : OutMin = 7'b0000000;
        4'b1001 : OutMin = 7'b0000100;
    endcase

    case (TenSec)
        4'b0000 : OutTenSec = 7'b0000001;
        4'b0001 : OutTenSec = 7'b1001111;
        4'b0010 : OutTenSec = 7'b0010010;
        4'b0011 : OutTenSec = 7'b0000110;
        4'b0100 : OutTenSec = 7'b1001100;
        4'b0101 : OutTenSec = 7'b0100100;
        4'b0110 : OutTenSec = 7'b0100000;
        4'b0111 : OutTenSec = 7'b0001101;
        4'b1000 : OutTenSec = 7'b0000000;
        4'b1001 : OutTenSec = 7'b0000100;
    endcase

    case (Sec)
        4'b0000 : OutSec = 7'b0000001;
        4'b0001 : OutSec = 7'b1001111;
        4'b0010 : OutSec = 7'b0010010;
        4'b0011 : OutSec = 7'b0000110;
        4'b0100 : OutSec = 7'b1001100;
        4'b0101 : OutSec = 7'b0100100;
        4'b0110 : OutSec = 7'b0100000;
        4'b0111 : OutSec = 7'b0001101;
        4'b1000 : OutSec = 7'b0000000;
        4'b1001 : OutSec = 7'b0000100;
    endcase
end

endmodule
