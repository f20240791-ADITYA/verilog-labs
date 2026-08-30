// cla64_blocked.v
// Blocked 64-bit CLA built from 16 chained cla4 instances.

module cla64_blocked(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [15:0] block_c;

  cla4 b0  (.a(a[3:0]),   .b(b[3:0]),   .cin(cin),         .sum(sum[3:0]),   .cout(block_c[0]));
  cla4 b1  (.a(a[7:4]),   .b(b[7:4]),   .cin(block_c[0]),  .sum(sum[7:4]),   .cout(block_c[1]));
  cla4 b2  (.a(a[11:8]),  .b(b[11:8]),  .cin(block_c[1]),  .sum(sum[11:8]),  .cout(block_c[2]));
  cla4 b3  (.a(a[15:12]), .b(b[15:12]), .cin(block_c[2]),  .sum(sum[15:12]), .cout(block_c[3]));
  cla4 b4  (.a(a[19:16]), .b(b[19:16]), .cin(block_c[3]),  .sum(sum[19:16]), .cout(block_c[4]));
  cla4 b5  (.a(a[23:20]), .b(b[23:20]), .cin(block_c[4]),  .sum(sum[23:20]), .cout(block_c[5]));
  cla4 b6  (.a(a[27:24]), .b(b[27:24]), .cin(block_c[5]),  .sum(sum[27:24]), .cout(block_c[6]));
  cla4 b7  (.a(a[31:28]), .b(b[31:28]), .cin(block_c[6]),  .sum(sum[31:28]), .cout(block_c[7]));
  cla4 b8  (.a(a[35:32]), .b(b[35:32]), .cin(block_c[7]),  .sum(sum[35:32]), .cout(block_c[8]));
  cla4 b9  (.a(a[39:36]), .b(b[39:36]), .cin(block_c[8]),  .sum(sum[39:36]), .cout(block_c[9]));
  cla4 b10 (.a(a[43:40]), .b(b[43:40]), .cin(block_c[9]),  .sum(sum[43:40]), .cout(block_c[10]));
  cla4 b11 (.a(a[47:44]), .b(b[47:44]), .cin(block_c[10]), .sum(sum[47:44]), .cout(block_c[11]));
  cla4 b12 (.a(a[51:48]), .b(b[51:48]), .cin(block_c[11]), .sum(sum[51:48]), .cout(block_c[12]));
  cla4 b13 (.a(a[55:52]), .b(b[55:52]), .cin(block_c[12]), .sum(sum[55:52]), .cout(block_c[13]));
  cla4 b14 (.a(a[59:56]), .b(b[59:56]), .cin(block_c[13]), .sum(sum[59:56]), .cout(block_c[14]));
  cla4 b15 (.a(a[63:60]), .b(b[63:60]), .cin(block_c[14]), .sum(sum[63:60]), .cout(cout));

endmodule