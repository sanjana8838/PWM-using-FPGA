// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (
    input CLK,    // 16MHz clock
    output PIN_13,   // User/boot LED next to power LED
    input PIN_12  // USB pull-up resistor
);
    wire clk_enable;
    reg[27:0] counter=0;
    wire tmp1, tmp2, inc;
    reg[3:0] counterPWM = 0;
    reg[3:0] dutycycle = 5; //50% duty cycle
    always @(posedge CLK)
    begin
      counter <= counter+1;
      if(counter>=1)
        counter <=0;
      end
      assign clk_enable = counter == 1 ?1:0;
      dffpwm dff1(CLK, clk_enable, PIN_12, tmp1);
      dffpwm dff2(CLK, clk_enable, tmp1, tmp2);
      assign inc = tmp1 & (~tmp2) & clk_enable;
      always @(posedge CLK)
      begin
        if (inc ==1 && dutycycle <=9)
          dutycycle <= dutycycle + 1;
        else
          dutycycle = 5;
      end
      always @(posedge CLK)
      begin
        counterPWM <= counterPWM + 1;
        if (counterPWM>=9)
          counterPWM <= 0;
      end
      assign PIN_13 = counterPWM < dutycycle ? 1:0;

endmodule

module dffpwm (
  input clk,
  input en,
  input D,
  output reg Q
  );
  always @(posedge clk)
  begin
    if (en==1)
      Q <= D;
  end
endmodule
