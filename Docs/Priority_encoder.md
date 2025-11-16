# *Priority Encoder*
### *(Source: [Priority_encoder.v](../RTL/Priority_encoder.v))*
## *About*
- Priority Encoder is a combinational circuit that encodes the position of the highest-priority active input.<br>
- Among multiple active inputs, the one with the highest priority (MSB first) determines the output.<br>
- It also provides a `valid` signal to indicate whether any input is active.<br>
- Commonly used in interrupt controllers, arbitration logic, and resource selection.<br>

### *Parameters* (Not parameterized)
- Fixed input size of 8 bits (`in[7:0]`).
- Output size is 3 bits (`out[2:0]`) to represent positions 0–7.

## *Instantiation*
To use the `Priority_encoder` module in your design:

```verilog
Priority_encoder u_prio_enc (
  .in(req),       // 8-bit input request lines
  .out(encoded),  // 3-bit encoded output
  .valid(valid)   // Indicates if any input is active
);
```

### Ports
| Name   | Direction | Width     | Description              |
|--------|-----------|-----------|--------------------------|
| in    | input     | 8 bits     | Input signals; multiple can be active   |
| out   | output    | 3 bits     | Encoded output representing highest active input |
| valid | output    | 1 bit      | Indicates if any input is active (1=valid, 0=none)  |

## *Edge Cases & Behavior*
- No active inputs:<br> If all bits of in are 0, then valid=0 and out=000.
- Multiple active inputs:<br> Highest-priority input (MSB first) determines the output.
- Valid signal:<br> valid=1 when at least one input is active; otherwise valid=0.
- Combinational nature:<br> Purely combinational block. Synthesizable as multiplexers or optimized encoder logic.
