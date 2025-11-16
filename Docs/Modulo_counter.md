# *Modulo Counter*
### *(Source: [Modulo_counter.v](../RTL/Modulo_counter.v))*
## *About*
- Modulo Counter is a sequential circuit that counts from `0` to `SIZE-1` and then wraps back to `0`.<br>
- It has one clock input and an active-low reset input.<br>
- The counter output is automatically sized to fit the range using `$clog2(SIZE)`.<br>

### *Parameter*
- `SIZE` – Maximum count value. Determines the range of the counter (0 to SIZE-1).

## *Instantiation*
To use the `Modulo_counter` module in your design:

```verilog
Modulo_counter #(
  .SIZE(10)   // Counter size (range: 0 to SIZE-1)
) u_mod_counter (
  .clk(clk),       // Clock input
  .reset_n(rst_n), // Active-low reset
  .count(count_out)// Counter output
);
```
Override parameters `SIZE` at instantiation.

### Ports
| Name   | Direction | Width     | Description              |
|--------|-----------|-----------|--------------------------|
| clk     | input     | 1 bit           |	Clock input          |
| reset_n | input     | 1 bit           | Active-low reset     |
|count    | output    | log2(SIZE) bits | Counter output value |

## *Edge Cases & Behavior*
- Reset:<br> When reset_n=0, counter output is set to 0.
- Wrap-around:<br> When counter reaches SIZE-1, it resets back to 0 on the next clock cycle.
- Sequential nature:<br> Counter updates on rising edge of clk or reset. Synthesizable as flip-flops with simple increment logic.
- Parameterization:<br> Output width is automatically adjusted using $clog2(SIZE) to fit the counter range.
