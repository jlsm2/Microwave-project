module counter_0_to_7_non_recycling(
    input clk,
    input rst,
    output reg [2:0] count
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 3'b000;
    end else begin
        if (count == 3'b111) begin
            count <= 3'b111;
        end else begin
            count <= count + 1;
        end
    end
end

endmodule
