module mod10_counter (
    input wire CLK, Reset,
    output reg [3:0] Q
);
    always @ (negedge CLK or posedge Reset) begin
        if (Reset) begin
            Q <= 4'b0000;
        end else if (Q == 4'b1001) begin
            Q <= 4'b0000;
        end else begin
            Q <= Q + 1;
        end
    end
endmodule
