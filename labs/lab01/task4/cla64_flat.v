// cla64_flat.v
// Flat 64-bit CLA using continuous dataflow assignments with delays.

module cla64_flat(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [63:0] p, g;
  wire [64:0] c;

  assign #(2) p = a ^ b;
  assign #(2) g = a & b;

  assign c[0] = cin;

  // Carry logic loop matching flat expansion equations
  genvar i;
  generate
    for (i = 0; i < 64; i = i + 1) begin : CARRY_GEN
      assign #(2) c[i+1] = g[i] | (p[i] & c[i]);
    end
  endgenerate

  assign #(2) sum = p ^ c[63:0];
  assign cout = c[64];

endmodule