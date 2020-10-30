module top (
    input CLK,
    output PIN_13,
    input PIN_12
);
  reg [7:0] counter = 0;
  reg [7:0] dutycycle = 50;


  always @(posedge CLK)
  begin
    if (counter <100) counter <= counter + 1;
    else counter <= 0;

  end

  assign PIN_13 = (counter<dutycycle) ? 1:0;
endmodule
