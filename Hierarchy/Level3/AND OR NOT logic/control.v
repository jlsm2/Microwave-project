module control (
    input wire startn , stopn , clearn, door_closed, timer_done, 
    output wire mag_on
); 
    wire rS, rR;
    wire rQ;
      
    assign rS = (!startn  && door_closed) ? 1 : 0;
    assign rR = (!stopn || timer_done || !door_closed || !clearn) ? 1 : 0;
	
  	sr_latch LSR_ON(.S(rS), .R(rR), .Q(rQ));
  	
  	assign mag_on = rQ;
    
endmodule
