// cla64_hier.v
// Hierarchical 64-Bit Carry-Lookahead Adder with Second-Level Lookahead Unit

module cla64_hier (
    output [63:0] sum,
    output        cout,
    input  [63:0] a,
    input  [63:0] b,
    input         cin
);
    wire [15:0] P_blk, G_blk;
    wire [16:0] C_blk;

    assign C_blk[0] = cin;

    // -------------------------------------------------------------------------
    // 1. Generate Block-Level Propagate (P_blk) and Generate (G_blk) Signals
    //    and instantiate 16 4-bit CLA blocks
    // -------------------------------------------------------------------------
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : BLOCK_GEN
            wire [3:0] p, g;

            // Bit-level prop and gen (delay = 2)
            assign #(2) p = a[i*4 +: 4] ^ b[i*4 +: 4];
            assign #(2) g = a[i*4 +: 4] & b[i*4 +: 4];

            // Block-level Group Propagate and Group Generate logic
            assign #(2) P_blk[i] = &p;
            assign #(2) G_blk[i] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);

            // 4-bit CLA block instance receiving carry directly from 2nd-level unit
            cla4 block_inst (
                .a   (a[i*4 +: 4]),
                .b   (b[i*4 +: 4]),
                .cin (C_blk[i]),
                .sum (sum[i*4 +: 4]),
                .cout() // Carry-out is handled by the 2nd-level lookahead tree below
            );
        end
    endgenerate

    // -------------------------------------------------------------------------
    // 2. Second-Level Lookahead Carry Generator across all 16 Blocks
    // -------------------------------------------------------------------------
    generate
        for (i = 0; i < 16; i = i + 1) begin : SECOND_LEVEL_CLA
            assign #(2) C_blk[i+1] = G_blk[i] | (P_blk[i] & C_blk[i]);
        end
    endgenerate

    assign cout = C_blk[16];

endmodule