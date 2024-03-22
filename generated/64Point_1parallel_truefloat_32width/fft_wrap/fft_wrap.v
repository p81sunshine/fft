module FFT(
  input   clock,
  input   reset,
  input   io_din_valid,
  output  io_busy
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] cnt_0; // @[FFT.scala 110:46]
  wire  busy = cnt_0 != 6'h0; // @[FFT.scala 114:21]
  wire [5:0] _cnt_0_T_2 = cnt_0 + 6'h1; // @[FFT.scala 116:87]
  assign io_busy = cnt_0 != 6'h0; // @[FFT.scala 114:21]
  always @(posedge clock) begin
    if (reset) begin // @[FFT.scala 110:46]
      cnt_0 <= 6'h0; // @[FFT.scala 110:46]
    end else if (io_din_valid | busy) begin // @[FFT.scala 115:30]
      if (cnt_0 == 6'h20) begin // @[FFT.scala 116:18]
        cnt_0 <= 6'h0;
      end else begin
        cnt_0 <= _cnt_0_T_2;
      end
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
  cnt_0 = _RAND_0[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module fft_wrap(
  input          clock,
  input          reset,
  input          io_start,
  output         io_done,
  input  [63:0]  io_pargs,
  input  [63:0]  io_pdata,
  input  [63:0]  io_pres,
  input  [31:0]  io_args_len,
  input  [31:0]  io_data_len,
  output [31:0]  io_ap_return,
  output [63:0]  io_m_axi_gmem_AWADDR,
  output [7:0]   io_m_axi_gmem_AWLEN,
  output [2:0]   io_m_axi_gmem_AWSIZE,
  output [1:0]   io_m_axi_gmem_AWBURST,
  output [1:0]   io_m_axi_gmem_AWLOCK,
  output [3:0]   io_m_axi_gmem_AWREGION,
  output [3:0]   io_m_axi_gmem_AWCACHE,
  output [2:0]   io_m_axi_gmem_AWPROT,
  output [3:0]   io_m_axi_gmem_AWQOS,
  output         io_m_axi_gmem_AWVALID,
  input          io_m_axi_gmem_AWREADY,
  output [255:0] io_m_axi_gmem_WDATA,
  output [31:0]  io_m_axi_gmem_WSTRB,
  output         io_m_axi_gmem_WLAST,
  output         io_m_axi_gmem_WVALID,
  input          io_m_axi_gmem_WREADY,
  input  [1:0]   io_m_axi_gmem_BRESP,
  input          io_m_axi_gmem_BVALID,
  output         io_m_axi_gmem_BREADY,
  output [63:0]  io_m_axi_gmem_ARADDR,
  output [7:0]   io_m_axi_gmem_ARLEN,
  output [2:0]   io_m_axi_gmem_ARSIZE,
  output [1:0]   io_m_axi_gmem_ARBURST,
  output [1:0]   io_m_axi_gmem_ARLOCK,
  output [3:0]   io_m_axi_gmem_ARREGION,
  output [3:0]   io_m_axi_gmem_ARCACHE,
  output [2:0]   io_m_axi_gmem_ARPROT,
  output [3:0]   io_m_axi_gmem_ARQOS,
  output         io_m_axi_gmem_ARVALID,
  input          io_m_axi_gmem_ARREADY,
  input  [255:0] io_m_axi_gmem_RDATA,
  input  [1:0]   io_m_axi_gmem_RRESP,
  input          io_m_axi_gmem_RLAST,
  input          io_m_axi_gmem_RVALID,
  output         io_m_axi_gmem_RREADY
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
`endif // RANDOMIZE_REG_INIT
  wire  FFTtop_u_clock; // @[warp.scala 201:26]
  wire  FFTtop_u_reset; // @[warp.scala 201:26]
  wire  FFTtop_u_io_din_valid; // @[warp.scala 201:26]
  wire  FFTtop_u_io_busy; // @[warp.scala 201:26]
  reg  startreg1; // @[warp.scala 65:32]
  reg [63:0] signal_addr; // @[warp.scala 66:30]
  reg [1:0] state1; // @[warp.scala 75:29]
  wire  _T_13 = io_m_axi_gmem_RVALID & io_m_axi_gmem_RREADY & io_m_axi_gmem_RLAST; // @[warp.scala 90:90]
  wire [1:0] _GEN_2 = io_m_axi_gmem_RVALID & io_m_axi_gmem_RREADY & io_m_axi_gmem_RLAST ? 2'h3 : state1; // @[warp.scala 90:121 75:29 91:39]
  reg [1:0] state2; // @[warp.scala 114:29]
  wire  compute_done = state2 == 2'h3; // @[warp.scala 143:21]
  wire [1:0] _GEN_3 = compute_done ? 2'h0 : state1; // @[warp.scala 75:29 95:51 96:39]
  wire [1:0] _GEN_4 = 2'h3 == state1 ? _GEN_3 : state1; // @[warp.scala 78:23 75:29]
  wire  _T_16 = state1 == 2'h2; // @[warp.scala 101:22]
  reg [31:0] cnt; // @[warp.scala 117:26]
  wire  _T_23 = state1 == 2'h3; // @[warp.scala 121:37]
  wire  _T_42 = cnt == 32'h0; // @[warp.scala 131:164]
  wire [1:0] _GEN_12 = io_m_axi_gmem_AWREADY & io_m_axi_gmem_AWVALID & io_m_axi_gmem_WVALID & io_m_axi_gmem_WREADY & cnt
     == 32'h0 ? 2'h3 : state2; // @[warp.scala 131:172 114:29 132:39]
  wire  _T_45 = state1 == 2'h1; // @[warp.scala 136:37]
  wire [1:0] _GEN_13 = state1 == 2'h1 ? 2'h0 : state2; // @[warp.scala 114:29 136:47 137:39]
  wire [1:0] _GEN_14 = 2'h3 == state2 ? _GEN_13 : state2; // @[warp.scala 119:23 114:29]
  wire  _T_48 = state2 == 2'h0; // @[warp.scala 151:40]
  wire  _T_51 = state2 == 2'h1; // @[warp.scala 157:40]
  wire  _T_53 = state2 == 2'h2; // @[warp.scala 163:21]
  wire [4:0] _io_m_axi_gmem_ARLEN_T_2 = 5'h10 - 5'h1; // @[warp.scala 179:63]
  wire [31:0] _io_m_axi_gmem_ARLEN_T_3 = {{5'd0}, io_args_len[31:5]}; // @[warp.scala 179:79]
  wire [31:0] _io_m_axi_gmem_ARLEN_T_5 = _io_m_axi_gmem_ARLEN_T_3 - 32'h1; // @[warp.scala 179:86]
  wire [31:0] _io_m_axi_gmem_ARLEN_T_6 = _T_23 ? {{27'd0}, _io_m_axi_gmem_ARLEN_T_2} : _io_m_axi_gmem_ARLEN_T_5; // @[warp.scala 179:36]
  reg  last_busy; // @[warp.scala 202:32]
  reg [1:0] state3; // @[warp.scala 204:29]
  reg  din_valid_v; // @[warp.scala 206:34]
  wire  _T_59 = ~din_valid_v; // @[warp.scala 209:34]
  reg [31:0] vec_entry_0; // @[warp.scala 241:32]
  reg [31:0] vec_entry_1; // @[warp.scala 241:32]
  reg [31:0] vec_entry_2; // @[warp.scala 241:32]
  reg [31:0] vec_entry_3; // @[warp.scala 241:32]
  reg [31:0] vec_entry_4; // @[warp.scala 241:32]
  reg [31:0] vec_entry_5; // @[warp.scala 241:32]
  reg [31:0] vec_entry_6; // @[warp.scala 241:32]
  reg [31:0] vec_entry_7; // @[warp.scala 241:32]
  wire [31:0] _cnt_T_1 = cnt - 32'h1; // @[warp.scala 252:28]
  wire [127:0] result_lo = {vec_entry_3,vec_entry_2,vec_entry_1,vec_entry_0}; // @[Cat.scala 33:92]
  wire [127:0] result_hi = {vec_entry_7,vec_entry_6,vec_entry_5,vec_entry_4}; // @[Cat.scala 33:92]
  FFT FFTtop_u ( // @[warp.scala 201:26]
    .clock(FFTtop_u_clock),
    .reset(FFTtop_u_reset),
    .io_din_valid(FFTtop_u_io_din_valid),
    .io_busy(FFTtop_u_io_busy)
  );
  assign io_done = state1 == 2'h0; // @[warp.scala 104:21]
  assign io_ap_return = 32'h0; // @[warp.scala 69:22]
  assign io_m_axi_gmem_AWADDR = io_pres; // @[warp.scala 186:30]
  assign io_m_axi_gmem_AWLEN = 8'h0; // @[warp.scala 189:29]
  assign io_m_axi_gmem_AWSIZE = 3'h5; // @[warp.scala 191:30]
  assign io_m_axi_gmem_AWBURST = 2'h1; // @[warp.scala 187:31]
  assign io_m_axi_gmem_AWLOCK = 2'h0; // @[warp.scala 190:30]
  assign io_m_axi_gmem_AWREGION = 4'h0; // @[warp.scala 194:32]
  assign io_m_axi_gmem_AWCACHE = 4'h0; // @[warp.scala 188:31]
  assign io_m_axi_gmem_AWPROT = 3'h0; // @[warp.scala 192:30]
  assign io_m_axi_gmem_AWQOS = 4'h0; // @[warp.scala 193:29]
  assign io_m_axi_gmem_AWVALID = state2 == 2'h2; // @[warp.scala 163:21]
  assign io_m_axi_gmem_WDATA = {result_hi,result_lo}; // @[Cat.scala 33:92]
  assign io_m_axi_gmem_WSTRB = 32'hffffffff; // @[warp.scala 197:29]
  assign io_m_axi_gmem_WLAST = 1'h1; // @[warp.scala 198:30]
  assign io_m_axi_gmem_WVALID = state2 == 2'h2; // @[warp.scala 163:21]
  assign io_m_axi_gmem_BREADY = 1'h1; // @[warp.scala 149:30]
  assign io_m_axi_gmem_ARADDR = _T_23 ? signal_addr : io_pargs; // @[warp.scala 175:36]
  assign io_m_axi_gmem_ARLEN = _io_m_axi_gmem_ARLEN_T_6[7:0]; // @[warp.scala 179:30]
  assign io_m_axi_gmem_ARSIZE = 3'h5; // @[warp.scala 181:30]
  assign io_m_axi_gmem_ARBURST = 2'h1; // @[warp.scala 176:31]
  assign io_m_axi_gmem_ARLOCK = 2'h0; // @[warp.scala 180:30]
  assign io_m_axi_gmem_ARREGION = 4'h0; // @[warp.scala 184:32]
  assign io_m_axi_gmem_ARCACHE = 4'h0; // @[warp.scala 177:31]
  assign io_m_axi_gmem_ARPROT = 3'h0; // @[warp.scala 182:30]
  assign io_m_axi_gmem_ARQOS = 4'h0; // @[warp.scala 183:29]
  assign io_m_axi_gmem_ARVALID = _T_45 | state2 == 2'h0; // @[warp.scala 151:30]
  assign io_m_axi_gmem_RREADY = _T_16 | state2 == 2'h1; // @[warp.scala 157:30]
  assign FFTtop_u_clock = clock;
  assign FFTtop_u_reset = reset;
  assign FFTtop_u_io_din_valid = din_valid_v; // @[warp.scala 207:31]
  always @(posedge clock) begin
    startreg1 <= reset | io_start; // @[warp.scala 65:{32,32} 70:19]
    if (state1 == 2'h2 & io_m_axi_gmem_RREADY & io_m_axi_gmem_RVALID) begin // @[warp.scala 101:96]
      signal_addr <= io_m_axi_gmem_RDATA[63:0]; // @[warp.scala 102:29]
    end
    if (reset) begin // @[warp.scala 75:29]
      state1 <= 2'h0; // @[warp.scala 75:29]
    end else if (2'h0 == state1) begin // @[warp.scala 78:23]
      if (~startreg1 & io_start) begin // @[warp.scala 80:68]
        state1 <= 2'h1; // @[warp.scala 81:39]
      end
    end else if (2'h1 == state1) begin // @[warp.scala 78:23]
      if (io_m_axi_gmem_ARVALID & io_m_axi_gmem_ARREADY) begin // @[warp.scala 85:93]
        state1 <= 2'h2; // @[warp.scala 86:39]
      end
    end else if (2'h2 == state1) begin // @[warp.scala 78:23]
      state1 <= _GEN_2;
    end else begin
      state1 <= _GEN_4;
    end
    if (reset) begin // @[warp.scala 114:29]
      state2 <= 2'h0; // @[warp.scala 114:29]
    end else if (2'h0 == state2) begin // @[warp.scala 119:23]
      if (state1 == 2'h3 & io_m_axi_gmem_ARVALID & io_m_axi_gmem_ARREADY) begin // @[warp.scala 121:112]
        state2 <= 2'h1; // @[warp.scala 122:39]
      end
    end else if (2'h1 == state2) begin // @[warp.scala 119:23]
      if (_T_13) begin // @[warp.scala 126:125]
        state2 <= 2'h2; // @[warp.scala 127:39]
      end
    end else if (2'h2 == state2) begin // @[warp.scala 119:23]
      state2 <= _GEN_12;
    end else begin
      state2 <= _GEN_14;
    end
    if (reset) begin // @[warp.scala 117:26]
      cnt <= 32'h10; // @[warp.scala 117:26]
    end else if (state3 == 2'h1 & _T_53) begin // @[warp.scala 243:48]
      cnt <= _cnt_T_1; // @[warp.scala 252:21]
    end
    last_busy <= FFTtop_u_io_busy; // @[warp.scala 202:32]
    if (reset) begin // @[warp.scala 204:29]
      state3 <= 2'h0; // @[warp.scala 204:29]
    end else if (2'h0 == state3) begin // @[warp.scala 229:23]
      if (last_busy & ~FFTtop_u_io_busy) begin // @[warp.scala 231:76]
        state3 <= 2'h1; // @[warp.scala 232:40]
      end
    end else if (2'h1 == state3) begin // @[warp.scala 229:23]
      if (_T_42) begin // @[warp.scala 236:42]
        state3 <= 2'h2; // @[warp.scala 237:40]
      end
    end
    if (reset) begin // @[warp.scala 206:34]
      din_valid_v <= 1'h0; // @[warp.scala 206:34]
    end else if (_T_51 & io_m_axi_gmem_RREADY & io_m_axi_gmem_RVALID) begin // @[warp.scala 208:90]
      din_valid_v <= _T_59;
    end
    if (reset) begin // @[warp.scala 241:32]
      vec_entry_0 <= 32'h0; // @[warp.scala 241:32]
    end else if (_T_48) begin // @[warp.scala 257:28]
      vec_entry_0 <= 32'h0; // @[warp.scala 258:30]
    end else if (state3 == 2'h1 & _T_53) begin // @[warp.scala 243:48]
      vec_entry_0 <= io_m_axi_gmem_RDATA[31:0]; // @[warp.scala 244:30]
    end
    if (reset) begin // @[warp.scala 241:32]
      vec_entry_1 <= 32'h0; // @[warp.scala 241:32]
    end else if (_T_48) begin // @[warp.scala 257:28]
      vec_entry_1 <= 32'h0; // @[warp.scala 259:30]
    end else if (state3 == 2'h1 & _T_53) begin // @[warp.scala 243:48]
      vec_entry_1 <= io_m_axi_gmem_RDATA[63:32]; // @[warp.scala 245:30]
    end
    if (reset) begin // @[warp.scala 241:32]
      vec_entry_2 <= 32'h0; // @[warp.scala 241:32]
    end else if (_T_48) begin // @[warp.scala 257:28]
      vec_entry_2 <= 32'h0; // @[warp.scala 260:30]
    end else if (state3 == 2'h1 & _T_53) begin // @[warp.scala 243:48]
      vec_entry_2 <= io_m_axi_gmem_RDATA[95:64]; // @[warp.scala 246:30]
    end
    if (reset) begin // @[warp.scala 241:32]
      vec_entry_3 <= 32'h0; // @[warp.scala 241:32]
    end else if (_T_48) begin // @[warp.scala 257:28]
      vec_entry_3 <= 32'h0; // @[warp.scala 261:30]
    end else if (state3 == 2'h1 & _T_53) begin // @[warp.scala 243:48]
      vec_entry_3 <= io_m_axi_gmem_RDATA[127:96]; // @[warp.scala 247:30]
    end
    if (reset) begin // @[warp.scala 241:32]
      vec_entry_4 <= 32'h0; // @[warp.scala 241:32]
    end else if (_T_48) begin // @[warp.scala 257:28]
      vec_entry_4 <= 32'h0; // @[warp.scala 262:30]
    end else if (state3 == 2'h1 & _T_53) begin // @[warp.scala 243:48]
      vec_entry_4 <= io_m_axi_gmem_RDATA[159:128]; // @[warp.scala 248:30]
    end
    if (reset) begin // @[warp.scala 241:32]
      vec_entry_5 <= 32'h0; // @[warp.scala 241:32]
    end else if (_T_48) begin // @[warp.scala 257:28]
      vec_entry_5 <= 32'h0; // @[warp.scala 263:30]
    end else if (state3 == 2'h1 & _T_53) begin // @[warp.scala 243:48]
      vec_entry_5 <= io_m_axi_gmem_RDATA[191:160]; // @[warp.scala 249:30]
    end
    if (reset) begin // @[warp.scala 241:32]
      vec_entry_6 <= 32'h0; // @[warp.scala 241:32]
    end else if (_T_48) begin // @[warp.scala 257:28]
      vec_entry_6 <= 32'h0; // @[warp.scala 264:30]
    end else if (state3 == 2'h1 & _T_53) begin // @[warp.scala 243:48]
      vec_entry_6 <= io_m_axi_gmem_RDATA[223:192]; // @[warp.scala 250:30]
    end
    if (reset) begin // @[warp.scala 241:32]
      vec_entry_7 <= 32'h0; // @[warp.scala 241:32]
    end else if (_T_48) begin // @[warp.scala 257:28]
      vec_entry_7 <= 32'h0; // @[warp.scala 265:30]
    end else if (state3 == 2'h1 & _T_53) begin // @[warp.scala 243:48]
      vec_entry_7 <= io_m_axi_gmem_RDATA[255:224]; // @[warp.scala 251:30]
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
  startreg1 = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  signal_addr = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  state1 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  state2 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  cnt = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  last_busy = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  state3 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  din_valid_v = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  vec_entry_0 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  vec_entry_1 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  vec_entry_2 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  vec_entry_3 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  vec_entry_4 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  vec_entry_5 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  vec_entry_6 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  vec_entry_7 = _RAND_15[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
