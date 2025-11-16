module Barrel_shifter_tb;
  parameter WIDTH = 12;

  // DUT signals
  logic [WIDTH-1:0] data_in;
  logic [$clog2(WIDTH)-1:0] shift_amt;
  logic dir;
  logic [WIDTH-1:0] data_out;

  // DUT instantiation
  Barrel_shifter #(.WIDTH(WIDTH)) dut (
    .data_in(data_in),
    .dir(dir),
    .shift_amt(shift_amt),
    .data_out(data_out)
  );

  // Stimulus
  initial begin
    data_in = 12'b010111001110;   // 12-bit input (fixed length)
    dir     = 0;                  // shift left
    shift_amt = 4;                // shift by 4 positions
    #10;

    $display("Input=%0b, Shift=%0d, DUT=%0b, Expected=%0b",
             data_in, shift_amt, data_out, data_in << shift_amt);

    $finish;
  end
endmodule
