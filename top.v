// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (
    input CLK,    // 16MHz clock
    output PIN_13,   // User/boot LED next to power LED
    input PIN_12  // USB pull-up resistor
);
  reg [7:0] counter = 0;
  reg [7:0] dutycyle=20;
  always @(posedge CLK)
  begin
    if (counter <100) counter <= counter + 1;
    else counter <= 0;
  end
  always @(posedge CLK)
  begin
    if (PIN_12 == 1 && dutycycle<=90) dutycycle = dutycycle + 10;
    else dutycycle = 20;
  end
  assign PIN_13 = (counter<50) ? 1:0;
endmodule
