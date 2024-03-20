module ComplexAdd(
  input  [31:0] io_op1_re,
  input  [31:0] io_op1_im,
  input  [31:0] io_op2_re,
  input  [31:0] io_op2_im,
  output [31:0] io_res_re,
  output [31:0] io_res_im
);
  assign io_res_re = $signed(io_op1_re) + $signed(io_op2_re); // @[Modules.scala 74:57]
  assign io_res_im = $signed(io_op1_im) + $signed(io_op2_im); // @[Modules.scala 75:57]
endmodule
module ComplexSub(
  input  [31:0] io_op1_re,
  input  [31:0] io_op1_im,
  input  [31:0] io_op2_re,
  input  [31:0] io_op2_im,
  output [31:0] io_res_re,
  output [31:0] io_res_im
);
  assign io_res_re = $signed(io_op1_re) - $signed(io_op2_re); // @[Modules.scala 93:57]
  assign io_res_im = $signed(io_op1_im) - $signed(io_op2_im); // @[Modules.scala 94:57]
endmodule
module ComplexMul(
  input  [31:0] io_op1_re,
  input  [31:0] io_op1_im,
  input  [31:0] io_op2_re,
  input  [31:0] io_op2_im,
  output [31:0] io_res_re,
  output [31:0] io_res_im
);
  wire [63:0] _io_res_re_T_2 = $signed(io_op1_re) * $signed(io_op2_re); // @[Modules.scala 150:59]
  wire [63:0] _io_res_re_T_5 = $signed(io_op1_im) * $signed(io_op2_im); // @[Modules.scala 150:141]
  wire [63:0] _io_res_re_T_8 = $signed(_io_res_re_T_2) - $signed(_io_res_re_T_5); // @[Modules.scala 150:100]
  wire [63:0] _io_res_im_T_2 = $signed(io_op1_re) * $signed(io_op2_im); // @[Modules.scala 151:59]
  wire [63:0] _io_res_im_T_5 = $signed(io_op1_im) * $signed(io_op2_re); // @[Modules.scala 151:141]
  wire [63:0] _io_res_im_T_8 = $signed(_io_res_im_T_2) + $signed(_io_res_im_T_5); // @[Modules.scala 151:100]
  wire [47:0] _GEN_0 = _io_res_re_T_8[63:16]; // @[Modules.scala 150:17]
  wire [47:0] _GEN_2 = _io_res_im_T_8[63:16]; // @[Modules.scala 151:17]
  assign io_res_re = _GEN_0[31:0]; // @[Modules.scala 150:17]
  assign io_res_im = _GEN_2[31:0]; // @[Modules.scala 151:17]
endmodule
module ButterflyMul(
  input  [31:0] io_in_0_re,
  input  [31:0] io_in_0_im,
  input  [31:0] io_in_1_re,
  input  [31:0] io_in_1_im,
  output [31:0] io_out_0_re,
  output [31:0] io_out_0_im,
  output [31:0] io_out_1_re,
  output [31:0] io_out_1_im,
  input  [31:0] io_wn_0_re,
  input  [31:0] io_wn_0_im
);
  wire [31:0] temp_0_inst_io_op1_re; // @[Modules.scala 81:22]
  wire [31:0] temp_0_inst_io_op1_im; // @[Modules.scala 81:22]
  wire [31:0] temp_0_inst_io_op2_re; // @[Modules.scala 81:22]
  wire [31:0] temp_0_inst_io_op2_im; // @[Modules.scala 81:22]
  wire [31:0] temp_0_inst_io_res_re; // @[Modules.scala 81:22]
  wire [31:0] temp_0_inst_io_res_im; // @[Modules.scala 81:22]
  wire [31:0] temp_1_inst_io_op1_re; // @[Modules.scala 100:22]
  wire [31:0] temp_1_inst_io_op1_im; // @[Modules.scala 100:22]
  wire [31:0] temp_1_inst_io_op2_re; // @[Modules.scala 100:22]
  wire [31:0] temp_1_inst_io_op2_im; // @[Modules.scala 100:22]
  wire [31:0] temp_1_inst_io_res_re; // @[Modules.scala 100:22]
  wire [31:0] temp_1_inst_io_res_im; // @[Modules.scala 100:22]
  wire [31:0] io_out_1_inst_io_op1_re; // @[Modules.scala 158:22]
  wire [31:0] io_out_1_inst_io_op1_im; // @[Modules.scala 158:22]
  wire [31:0] io_out_1_inst_io_op2_re; // @[Modules.scala 158:22]
  wire [31:0] io_out_1_inst_io_op2_im; // @[Modules.scala 158:22]
  wire [31:0] io_out_1_inst_io_res_re; // @[Modules.scala 158:22]
  wire [31:0] io_out_1_inst_io_res_im; // @[Modules.scala 158:22]
  ComplexAdd temp_0_inst ( // @[Modules.scala 81:22]
    .io_op1_re(temp_0_inst_io_op1_re),
    .io_op1_im(temp_0_inst_io_op1_im),
    .io_op2_re(temp_0_inst_io_op2_re),
    .io_op2_im(temp_0_inst_io_op2_im),
    .io_res_re(temp_0_inst_io_res_re),
    .io_res_im(temp_0_inst_io_res_im)
  );
  ComplexSub temp_1_inst ( // @[Modules.scala 100:22]
    .io_op1_re(temp_1_inst_io_op1_re),
    .io_op1_im(temp_1_inst_io_op1_im),
    .io_op2_re(temp_1_inst_io_op2_re),
    .io_op2_im(temp_1_inst_io_op2_im),
    .io_res_re(temp_1_inst_io_res_re),
    .io_res_im(temp_1_inst_io_res_im)
  );
  ComplexMul io_out_1_inst ( // @[Modules.scala 158:22]
    .io_op1_re(io_out_1_inst_io_op1_re),
    .io_op1_im(io_out_1_inst_io_op1_im),
    .io_op2_re(io_out_1_inst_io_op2_re),
    .io_op2_im(io_out_1_inst_io_op2_im),
    .io_res_re(io_out_1_inst_io_res_re),
    .io_res_im(io_out_1_inst_io_res_im)
  );
  assign io_out_0_re = temp_0_inst_io_res_re; // @[Modules.scala 224:21 226:13]
  assign io_out_0_im = temp_0_inst_io_res_im; // @[Modules.scala 224:21 226:13]
  assign io_out_1_re = io_out_1_inst_io_res_re; // @[Modules.scala 267:15]
  assign io_out_1_im = io_out_1_inst_io_res_im; // @[Modules.scala 267:15]
  assign temp_0_inst_io_op1_re = io_in_0_re; // @[Modules.scala 82:17]
  assign temp_0_inst_io_op1_im = io_in_0_im; // @[Modules.scala 82:17]
  assign temp_0_inst_io_op2_re = io_in_1_re; // @[Modules.scala 83:17]
  assign temp_0_inst_io_op2_im = io_in_1_im; // @[Modules.scala 83:17]
  assign temp_1_inst_io_op1_re = io_in_0_re; // @[Modules.scala 101:17]
  assign temp_1_inst_io_op1_im = io_in_0_im; // @[Modules.scala 101:17]
  assign temp_1_inst_io_op2_re = io_in_1_re; // @[Modules.scala 102:17]
  assign temp_1_inst_io_op2_im = io_in_1_im; // @[Modules.scala 102:17]
  assign io_out_1_inst_io_op1_re = temp_1_inst_io_res_re; // @[Modules.scala 224:21 227:13]
  assign io_out_1_inst_io_op1_im = temp_1_inst_io_res_im; // @[Modules.scala 224:21 227:13]
  assign io_out_1_inst_io_op2_re = io_wn_0_re; // @[Modules.scala 160:17]
  assign io_out_1_inst_io_op2_im = io_wn_0_im; // @[Modules.scala 160:17]
endmodule
module ButterflyAdd(
  input  [31:0] io_in_0_re,
  input  [31:0] io_in_0_im,
  input  [31:0] io_in_1_re,
  input  [31:0] io_in_1_im,
  output [31:0] io_out_0_re,
  output [31:0] io_out_0_im,
  output [31:0] io_out_1_re,
  output [31:0] io_out_1_im
);
  wire [31:0] io_out_0_inst_io_op1_re; // @[Modules.scala 81:22]
  wire [31:0] io_out_0_inst_io_op1_im; // @[Modules.scala 81:22]
  wire [31:0] io_out_0_inst_io_op2_re; // @[Modules.scala 81:22]
  wire [31:0] io_out_0_inst_io_op2_im; // @[Modules.scala 81:22]
  wire [31:0] io_out_0_inst_io_res_re; // @[Modules.scala 81:22]
  wire [31:0] io_out_0_inst_io_res_im; // @[Modules.scala 81:22]
  wire [31:0] io_out_1_inst_io_op1_re; // @[Modules.scala 100:22]
  wire [31:0] io_out_1_inst_io_op1_im; // @[Modules.scala 100:22]
  wire [31:0] io_out_1_inst_io_op2_re; // @[Modules.scala 100:22]
  wire [31:0] io_out_1_inst_io_op2_im; // @[Modules.scala 100:22]
  wire [31:0] io_out_1_inst_io_res_re; // @[Modules.scala 100:22]
  wire [31:0] io_out_1_inst_io_res_im; // @[Modules.scala 100:22]
  ComplexAdd io_out_0_inst ( // @[Modules.scala 81:22]
    .io_op1_re(io_out_0_inst_io_op1_re),
    .io_op1_im(io_out_0_inst_io_op1_im),
    .io_op2_re(io_out_0_inst_io_op2_re),
    .io_op2_im(io_out_0_inst_io_op2_im),
    .io_res_re(io_out_0_inst_io_res_re),
    .io_res_im(io_out_0_inst_io_res_im)
  );
  ComplexSub io_out_1_inst ( // @[Modules.scala 100:22]
    .io_op1_re(io_out_1_inst_io_op1_re),
    .io_op1_im(io_out_1_inst_io_op1_im),
    .io_op2_re(io_out_1_inst_io_op2_re),
    .io_op2_im(io_out_1_inst_io_op2_im),
    .io_res_re(io_out_1_inst_io_res_re),
    .io_res_im(io_out_1_inst_io_res_im)
  );
  assign io_out_0_re = io_out_0_inst_io_res_re; // @[Modules.scala 170:15]
  assign io_out_0_im = io_out_0_inst_io_res_im; // @[Modules.scala 170:15]
  assign io_out_1_re = io_out_1_inst_io_res_re; // @[Modules.scala 171:15]
  assign io_out_1_im = io_out_1_inst_io_res_im; // @[Modules.scala 171:15]
  assign io_out_0_inst_io_op1_re = io_in_0_re; // @[Modules.scala 82:17]
  assign io_out_0_inst_io_op1_im = io_in_0_im; // @[Modules.scala 82:17]
  assign io_out_0_inst_io_op2_re = io_in_1_re; // @[Modules.scala 83:17]
  assign io_out_0_inst_io_op2_im = io_in_1_im; // @[Modules.scala 83:17]
  assign io_out_1_inst_io_op1_re = io_in_0_re; // @[Modules.scala 101:17]
  assign io_out_1_inst_io_op1_im = io_in_0_im; // @[Modules.scala 101:17]
  assign io_out_1_inst_io_op2_re = io_in_1_re; // @[Modules.scala 102:17]
  assign io_out_1_inst_io_op2_im = io_in_1_im; // @[Modules.scala 102:17]
endmodule
module Switch(
  input         clock,
  input  [31:0] io_in_0_re,
  input  [31:0] io_in_0_im,
  input  [31:0] io_in_1_re,
  input  [31:0] io_in_1_im,
  output [31:0] io_out_0_re,
  output [31:0] io_out_0_im,
  output [31:0] io_out_1_re,
  output [31:0] io_out_1_im,
  input         io_sel
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] swdata_1_r_re; // @[Reg.scala 19:16]
  reg [31:0] swdata_1_r_im; // @[Reg.scala 19:16]
  reg [31:0] io_out_0_r_re; // @[Reg.scala 19:16]
  reg [31:0] io_out_0_r_im; // @[Reg.scala 19:16]
  assign io_out_0_re = io_out_0_r_re; // @[Modules.scala 306:38]
  assign io_out_0_im = io_out_0_r_im; // @[Modules.scala 306:38]
  assign io_out_1_re = io_sel ? $signed(io_in_0_re) : $signed(swdata_1_r_re); // @[Modules.scala 306:{38,38}]
  assign io_out_1_im = io_sel ? $signed(io_in_0_im) : $signed(swdata_1_r_im); // @[Modules.scala 306:{38,38}]
  always @(posedge clock) begin
    swdata_1_r_re <= io_in_1_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_im <= io_in_1_im; // @[Reg.scala 19:16 20:{18,22}]
    if (io_sel) begin // @[Reg.scala 20:22]
      io_out_0_r_re <= swdata_1_r_re; // @[Reg.scala 20:22]
    end else begin
      io_out_0_r_re <= io_in_0_re;
    end
    if (io_sel) begin // @[Reg.scala 20:22]
      io_out_0_r_im <= swdata_1_r_im; // @[Reg.scala 20:22]
    end else begin
      io_out_0_r_im <= io_in_0_im;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  swdata_1_r_re = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  swdata_1_r_im = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  io_out_0_r_re = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  io_out_0_r_im = _RAND_3[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FFT(
  input         clock,
  input         reset,
  input  [31:0] io_dIn_0_re,
  input  [31:0] io_dIn_0_im,
  input  [31:0] io_dIn_1_re,
  input  [31:0] io_dIn_1_im,
  output [31:0] io_dOut_0_re,
  output [31:0] io_dOut_0_im,
  output [31:0] io_dOut_1_re,
  output [31:0] io_dOut_1_im,
  input         io_din_valid,
  output        io_dout_valid,
  output        io_busy
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] inst_io_in_0_re; // @[Modules.scala 287:22]
  wire [31:0] inst_io_in_0_im; // @[Modules.scala 287:22]
  wire [31:0] inst_io_in_1_re; // @[Modules.scala 287:22]
  wire [31:0] inst_io_in_1_im; // @[Modules.scala 287:22]
  wire [31:0] inst_io_out_0_re; // @[Modules.scala 287:22]
  wire [31:0] inst_io_out_0_im; // @[Modules.scala 287:22]
  wire [31:0] inst_io_out_1_re; // @[Modules.scala 287:22]
  wire [31:0] inst_io_out_1_im; // @[Modules.scala 287:22]
  wire [31:0] inst_io_wn_0_re; // @[Modules.scala 287:22]
  wire [31:0] inst_io_wn_0_im; // @[Modules.scala 287:22]
  wire [31:0] dataotemp_inst_io_in_0_re; // @[Modules.scala 213:22]
  wire [31:0] dataotemp_inst_io_in_0_im; // @[Modules.scala 213:22]
  wire [31:0] dataotemp_inst_io_in_1_re; // @[Modules.scala 213:22]
  wire [31:0] dataotemp_inst_io_in_1_im; // @[Modules.scala 213:22]
  wire [31:0] dataotemp_inst_io_out_0_re; // @[Modules.scala 213:22]
  wire [31:0] dataotemp_inst_io_out_0_im; // @[Modules.scala 213:22]
  wire [31:0] dataotemp_inst_io_out_1_re; // @[Modules.scala 213:22]
  wire [31:0] dataotemp_inst_io_out_1_im; // @[Modules.scala 213:22]
  wire  inst_1_clock; // @[Modules.scala 311:22]
  wire [31:0] inst_1_io_in_0_re; // @[Modules.scala 311:22]
  wire [31:0] inst_1_io_in_0_im; // @[Modules.scala 311:22]
  wire [31:0] inst_1_io_in_1_re; // @[Modules.scala 311:22]
  wire [31:0] inst_1_io_in_1_im; // @[Modules.scala 311:22]
  wire [31:0] inst_1_io_out_0_re; // @[Modules.scala 311:22]
  wire [31:0] inst_1_io_out_0_im; // @[Modules.scala 311:22]
  wire [31:0] inst_1_io_out_1_re; // @[Modules.scala 311:22]
  wire [31:0] inst_1_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_1_io_sel; // @[Modules.scala 311:22]
  reg [2:0] cnt_0; // @[FFT.scala 110:46]
  wire  busy = cnt_0 != 3'h0; // @[FFT.scala 114:21]
  wire [2:0] _cnt_0_T_2 = cnt_0 + 3'h1; // @[FFT.scala 116:87]
  wire  wnCtrl = cnt_0[0]; // @[FFT.scala 131:23]
  wire [1:0] _wnList_T = {{1'd0}, wnCtrl}; // @[FFT.scala 135:148]
  reg [2:0] io_dout_valid_REG; // @[FFT.scala 179:27]
  reg [31:0] REG_0_re; // @[FFT.scala 184:23]
  reg [31:0] REG_0_im; // @[FFT.scala 184:23]
  reg [31:0] REG_1_re; // @[FFT.scala 184:23]
  reg [31:0] REG_1_im; // @[FFT.scala 184:23]
  ButterflyMul inst ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_io_in_0_re),
    .io_in_0_im(inst_io_in_0_im),
    .io_in_1_re(inst_io_in_1_re),
    .io_in_1_im(inst_io_in_1_im),
    .io_out_0_re(inst_io_out_0_re),
    .io_out_0_im(inst_io_out_0_im),
    .io_out_1_re(inst_io_out_1_re),
    .io_out_1_im(inst_io_out_1_im),
    .io_wn_0_re(inst_io_wn_0_re),
    .io_wn_0_im(inst_io_wn_0_im)
  );
  ButterflyAdd dataotemp_inst ( // @[Modules.scala 213:22]
    .io_in_0_re(dataotemp_inst_io_in_0_re),
    .io_in_0_im(dataotemp_inst_io_in_0_im),
    .io_in_1_re(dataotemp_inst_io_in_1_re),
    .io_in_1_im(dataotemp_inst_io_in_1_im),
    .io_out_0_re(dataotemp_inst_io_out_0_re),
    .io_out_0_im(dataotemp_inst_io_out_0_im),
    .io_out_1_re(dataotemp_inst_io_out_1_re),
    .io_out_1_im(dataotemp_inst_io_out_1_im)
  );
  Switch inst_1 ( // @[Modules.scala 311:22]
    .clock(inst_1_clock),
    .io_in_0_re(inst_1_io_in_0_re),
    .io_in_0_im(inst_1_io_in_0_im),
    .io_in_1_re(inst_1_io_in_1_re),
    .io_in_1_im(inst_1_io_in_1_im),
    .io_out_0_re(inst_1_io_out_0_re),
    .io_out_0_im(inst_1_io_out_0_im),
    .io_out_1_re(inst_1_io_out_1_re),
    .io_out_1_im(inst_1_io_out_1_im),
    .io_sel(inst_1_io_sel)
  );
  assign io_dOut_0_re = REG_0_re; // @[FFT.scala 184:13]
  assign io_dOut_0_im = REG_0_im; // @[FFT.scala 184:13]
  assign io_dOut_1_re = REG_1_re; // @[FFT.scala 184:13]
  assign io_dOut_1_im = REG_1_im; // @[FFT.scala 184:13]
  assign io_dout_valid = io_dout_valid_REG == 3'h1; // @[FFT.scala 179:36]
  assign io_busy = cnt_0 != 3'h0; // @[FFT.scala 114:21]
  assign inst_io_in_0_re = io_dIn_0_re; // @[FFT.scala 122:65 175:19]
  assign inst_io_in_0_im = io_dIn_0_im; // @[FFT.scala 122:65 175:19]
  assign inst_io_in_1_re = io_dIn_1_re; // @[FFT.scala 122:65 175:19]
  assign inst_io_in_1_im = io_dIn_1_im; // @[FFT.scala 122:65 175:19]
  assign inst_io_wn_0_re = _wnList_T[0] ? $signed(32'sh0) : $signed(32'sh10000); // @[FFT.scala 72:{12,12}]
  assign inst_io_wn_0_im = _wnList_T[0] ? $signed(-32'sh10000) : $signed(32'sh0); // @[FFT.scala 73:{12,12}]
  assign dataotemp_inst_io_in_0_re = inst_1_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_io_in_0_im = inst_1_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_io_in_1_re = inst_1_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_io_in_1_im = inst_1_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_1_clock = clock;
  assign inst_1_io_in_0_re = inst_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_1_io_in_0_im = inst_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_1_io_in_1_re = inst_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_1_io_in_1_im = inst_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_1_io_sel = cnt_0[0]; // @[FFT.scala 163:31]
  always @(posedge clock) begin
    if (reset) begin // @[FFT.scala 110:46]
      cnt_0 <= 3'h0; // @[FFT.scala 110:46]
    end else if (io_din_valid | busy) begin // @[FFT.scala 115:30]
      if (cnt_0 == 3'h3) begin // @[FFT.scala 116:18]
        cnt_0 <= 3'h0;
      end else begin
        cnt_0 <= _cnt_0_T_2;
      end
    end
    io_dout_valid_REG <= cnt_0; // @[FFT.scala 179:27]
    REG_0_re <= dataotemp_inst_io_out_0_re; // @[FFT.scala 124:22 141:9]
    REG_0_im <= dataotemp_inst_io_out_0_im; // @[FFT.scala 124:22 141:9]
    REG_1_re <= dataotemp_inst_io_out_1_re; // @[FFT.scala 124:22 141:9]
    REG_1_im <= dataotemp_inst_io_out_1_im; // @[FFT.scala 124:22 141:9]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cnt_0 = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  io_dout_valid_REG = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  REG_0_re = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  REG_0_im = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  REG_1_re = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  REG_1_im = _RAND_5[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FFTtop(
  input         clock,
  input         reset,
  input  [31:0] io_dIn_0_re,
  input  [31:0] io_dIn_0_im,
  input  [31:0] io_dIn_1_re,
  input  [31:0] io_dIn_1_im,
  output [31:0] io_dOut_0_re,
  output [31:0] io_dOut_0_im,
  output [31:0] io_dOut_1_re,
  output [31:0] io_dOut_1_im,
  input         io_din_valid,
  output        io_dout_valid,
  output        io_busy
);
  wire  fft_clock; // @[Top.scala 15:19]
  wire  fft_reset; // @[Top.scala 15:19]
  wire [31:0] fft_io_dIn_0_re; // @[Top.scala 15:19]
  wire [31:0] fft_io_dIn_0_im; // @[Top.scala 15:19]
  wire [31:0] fft_io_dIn_1_re; // @[Top.scala 15:19]
  wire [31:0] fft_io_dIn_1_im; // @[Top.scala 15:19]
  wire [31:0] fft_io_dOut_0_re; // @[Top.scala 15:19]
  wire [31:0] fft_io_dOut_0_im; // @[Top.scala 15:19]
  wire [31:0] fft_io_dOut_1_re; // @[Top.scala 15:19]
  wire [31:0] fft_io_dOut_1_im; // @[Top.scala 15:19]
  wire  fft_io_din_valid; // @[Top.scala 15:19]
  wire  fft_io_dout_valid; // @[Top.scala 15:19]
  wire  fft_io_busy; // @[Top.scala 15:19]
  FFT fft ( // @[Top.scala 15:19]
    .clock(fft_clock),
    .reset(fft_reset),
    .io_dIn_0_re(fft_io_dIn_0_re),
    .io_dIn_0_im(fft_io_dIn_0_im),
    .io_dIn_1_re(fft_io_dIn_1_re),
    .io_dIn_1_im(fft_io_dIn_1_im),
    .io_dOut_0_re(fft_io_dOut_0_re),
    .io_dOut_0_im(fft_io_dOut_0_im),
    .io_dOut_1_re(fft_io_dOut_1_re),
    .io_dOut_1_im(fft_io_dOut_1_im),
    .io_din_valid(fft_io_din_valid),
    .io_dout_valid(fft_io_dout_valid),
    .io_busy(fft_io_busy)
  );
  assign io_dOut_0_re = fft_io_dOut_0_re; // @[Top.scala 27:13]
  assign io_dOut_0_im = fft_io_dOut_0_im; // @[Top.scala 27:13]
  assign io_dOut_1_re = fft_io_dOut_1_re; // @[Top.scala 27:13]
  assign io_dOut_1_im = fft_io_dOut_1_im; // @[Top.scala 27:13]
  assign io_dout_valid = fft_io_dout_valid; // @[Top.scala 28:19]
  assign io_busy = fft_io_busy; // @[Top.scala 29:13]
  assign fft_clock = clock;
  assign fft_reset = reset;
  assign fft_io_dIn_0_re = io_dIn_0_re; // @[Top.scala 16:14]
  assign fft_io_dIn_0_im = io_dIn_0_im; // @[Top.scala 16:14]
  assign fft_io_dIn_1_re = io_dIn_1_re; // @[Top.scala 16:14]
  assign fft_io_dIn_1_im = io_dIn_1_im; // @[Top.scala 16:14]
  assign fft_io_din_valid = io_din_valid; // @[Top.scala 17:20]
endmodule
