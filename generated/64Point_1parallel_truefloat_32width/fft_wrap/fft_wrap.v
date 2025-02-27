module AddRawFN(
  input         io_subOp,
  input         io_a_isNaN,
  input         io_a_isInf,
  input         io_a_isZero,
  input         io_a_sign,
  input  [9:0]  io_a_sExp,
  input  [24:0] io_a_sig,
  input         io_b_isNaN,
  input         io_b_isInf,
  input         io_b_isZero,
  input         io_b_sign,
  input  [9:0]  io_b_sExp,
  input  [24:0] io_b_sig,
  output        io_invalidExc,
  output        io_rawOut_isNaN,
  output        io_rawOut_isInf,
  output        io_rawOut_isZero,
  output        io_rawOut_sign,
  output [9:0]  io_rawOut_sExp,
  output [26:0] io_rawOut_sig
);
  wire  effSignB = io_b_sign ^ io_subOp; // @[AddRecFN.scala 60:30]
  wire  eqSigns = io_a_sign == effSignB; // @[AddRecFN.scala 61:29]
  wire [9:0] sDiffExps = $signed(io_a_sExp) - $signed(io_b_sExp); // @[AddRecFN.scala 63:31]
  wire  _modNatAlignDist_T = $signed(sDiffExps) < 10'sh0; // @[AddRecFN.scala 64:41]
  wire [9:0] _modNatAlignDist_T_3 = $signed(io_b_sExp) - $signed(io_a_sExp); // @[AddRecFN.scala 64:58]
  wire [9:0] _modNatAlignDist_T_4 = $signed(sDiffExps) < 10'sh0 ? $signed(_modNatAlignDist_T_3) : $signed(sDiffExps); // @[AddRecFN.scala 64:30]
  wire [4:0] modNatAlignDist = _modNatAlignDist_T_4[4:0]; // @[AddRecFN.scala 64:81]
  wire [4:0] _isMaxAlign_T = sDiffExps[9:5]; // @[AddRecFN.scala 66:19]
  wire  _isMaxAlign_T_6 = $signed(_isMaxAlign_T) != -5'sh1 | sDiffExps[4:0] == 5'h0; // @[AddRecFN.scala 67:51]
  wire  isMaxAlign = $signed(_isMaxAlign_T) != 5'sh0 & _isMaxAlign_T_6; // @[AddRecFN.scala 66:45]
  wire [4:0] alignDist = isMaxAlign ? 5'h1f : modNatAlignDist; // @[AddRecFN.scala 68:24]
  wire  _closeSubMags_T = ~eqSigns; // @[AddRecFN.scala 69:24]
  wire  closeSubMags = ~eqSigns & ~isMaxAlign & modNatAlignDist <= 5'h1; // @[AddRecFN.scala 69:48]
  wire  _close_alignedSigA_T = 10'sh0 <= $signed(sDiffExps); // @[AddRecFN.scala 73:18]
  wire [26:0] _close_alignedSigA_T_3 = {io_a_sig, 2'h0}; // @[AddRecFN.scala 73:58]
  wire [26:0] _close_alignedSigA_T_4 = 10'sh0 <= $signed(sDiffExps) & sDiffExps[0] ? _close_alignedSigA_T_3 : 27'h0; // @[AddRecFN.scala 73:12]
  wire [25:0] _close_alignedSigA_T_9 = {io_a_sig, 1'h0}; // @[AddRecFN.scala 74:58]
  wire [25:0] _close_alignedSigA_T_10 = _close_alignedSigA_T & ~sDiffExps[0] ? _close_alignedSigA_T_9 : 26'h0; // @[AddRecFN.scala 74:12]
  wire [26:0] _GEN_0 = {{1'd0}, _close_alignedSigA_T_10}; // @[AddRecFN.scala 73:68]
  wire [26:0] _close_alignedSigA_T_11 = _close_alignedSigA_T_4 | _GEN_0; // @[AddRecFN.scala 73:68]
  wire [24:0] _close_alignedSigA_T_13 = _modNatAlignDist_T ? io_a_sig : 25'h0; // @[AddRecFN.scala 75:12]
  wire [26:0] _GEN_1 = {{2'd0}, _close_alignedSigA_T_13}; // @[AddRecFN.scala 74:68]
  wire [26:0] _close_sSigSum_T = _close_alignedSigA_T_11 | _GEN_1; // @[AddRecFN.scala 76:43]
  wire [25:0] _close_sSigSum_T_2 = {io_b_sig, 1'h0}; // @[AddRecFN.scala 76:66]
  wire [26:0] _GEN_2 = {{1{_close_sSigSum_T_2[25]}},_close_sSigSum_T_2}; // @[AddRecFN.scala 76:50]
  wire [26:0] close_sSigSum = $signed(_close_sSigSum_T) - $signed(_GEN_2); // @[AddRecFN.scala 76:50]
  wire  _close_sigSum_T = $signed(close_sSigSum) < 27'sh0; // @[AddRecFN.scala 77:42]
  wire [26:0] _close_sigSum_T_3 = 27'sh0 - $signed(close_sSigSum); // @[AddRecFN.scala 77:49]
  wire [26:0] _close_sigSum_T_4 = $signed(close_sSigSum) < 27'sh0 ? $signed(_close_sigSum_T_3) : $signed(close_sSigSum); // @[AddRecFN.scala 77:27]
  wire [25:0] close_sigSum = _close_sigSum_T_4[25:0]; // @[AddRecFN.scala 77:79]
  wire  close_reduced2SigSum_reducedVec_0 = |close_sigSum[1:0]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_1 = |close_sigSum[3:2]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_2 = |close_sigSum[5:4]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_3 = |close_sigSum[7:6]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_4 = |close_sigSum[9:8]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_5 = |close_sigSum[11:10]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_6 = |close_sigSum[13:12]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_7 = |close_sigSum[15:14]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_8 = |close_sigSum[17:16]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_9 = |close_sigSum[19:18]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_10 = |close_sigSum[21:20]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_11 = |close_sigSum[23:22]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_12 = |close_sigSum[25:24]; // @[primitives.scala 107:57]
  wire [5:0] close_reduced2SigSum_lo = {close_reduced2SigSum_reducedVec_5,close_reduced2SigSum_reducedVec_4,
    close_reduced2SigSum_reducedVec_3,close_reduced2SigSum_reducedVec_2,close_reduced2SigSum_reducedVec_1,
    close_reduced2SigSum_reducedVec_0}; // @[primitives.scala 108:20]
  wire [12:0] close_reduced2SigSum = {close_reduced2SigSum_reducedVec_12,close_reduced2SigSum_reducedVec_11,
    close_reduced2SigSum_reducedVec_10,close_reduced2SigSum_reducedVec_9,close_reduced2SigSum_reducedVec_8,
    close_reduced2SigSum_reducedVec_7,close_reduced2SigSum_reducedVec_6,close_reduced2SigSum_lo}; // @[primitives.scala 108:20]
  wire [3:0] _close_normDistReduced2_T_13 = close_reduced2SigSum[1] ? 4'hb : 4'hc; // @[Mux.scala 47:70]
  wire [3:0] _close_normDistReduced2_T_14 = close_reduced2SigSum[2] ? 4'ha : _close_normDistReduced2_T_13; // @[Mux.scala 47:70]
  wire [3:0] _close_normDistReduced2_T_15 = close_reduced2SigSum[3] ? 4'h9 : _close_normDistReduced2_T_14; // @[Mux.scala 47:70]
  wire [3:0] _close_normDistReduced2_T_16 = close_reduced2SigSum[4] ? 4'h8 : _close_normDistReduced2_T_15; // @[Mux.scala 47:70]
  wire [3:0] _close_normDistReduced2_T_17 = close_reduced2SigSum[5] ? 4'h7 : _close_normDistReduced2_T_16; // @[Mux.scala 47:70]
  wire [3:0] _close_normDistReduced2_T_18 = close_reduced2SigSum[6] ? 4'h6 : _close_normDistReduced2_T_17; // @[Mux.scala 47:70]
  wire [3:0] _close_normDistReduced2_T_19 = close_reduced2SigSum[7] ? 4'h5 : _close_normDistReduced2_T_18; // @[Mux.scala 47:70]
  wire [3:0] _close_normDistReduced2_T_20 = close_reduced2SigSum[8] ? 4'h4 : _close_normDistReduced2_T_19; // @[Mux.scala 47:70]
  wire [3:0] _close_normDistReduced2_T_21 = close_reduced2SigSum[9] ? 4'h3 : _close_normDistReduced2_T_20; // @[Mux.scala 47:70]
  wire [3:0] _close_normDistReduced2_T_22 = close_reduced2SigSum[10] ? 4'h2 : _close_normDistReduced2_T_21; // @[Mux.scala 47:70]
  wire [3:0] _close_normDistReduced2_T_23 = close_reduced2SigSum[11] ? 4'h1 : _close_normDistReduced2_T_22; // @[Mux.scala 47:70]
  wire [3:0] close_normDistReduced2 = close_reduced2SigSum[12] ? 4'h0 : _close_normDistReduced2_T_23; // @[Mux.scala 47:70]
  wire [4:0] close_nearNormDist = {close_normDistReduced2, 1'h0}; // @[AddRecFN.scala 81:53]
  wire [56:0] _GEN_7 = {{31'd0}, close_sigSum}; // @[AddRecFN.scala 82:38]
  wire [56:0] _close_sigOut_T = _GEN_7 << close_nearNormDist; // @[AddRecFN.scala 82:38]
  wire [57:0] _close_sigOut_T_1 = {_close_sigOut_T, 1'h0}; // @[AddRecFN.scala 82:59]
  wire [26:0] close_sigOut = _close_sigOut_T_1[26:0]; // @[AddRecFN.scala 82:63]
  wire  close_totalCancellation = ~(|close_sigOut[26:25]); // @[AddRecFN.scala 83:35]
  wire  close_notTotalCancellation_signOut = io_a_sign ^ _close_sigSum_T; // @[AddRecFN.scala 84:56]
  wire  far_signOut = _modNatAlignDist_T ? effSignB : io_a_sign; // @[AddRecFN.scala 87:26]
  wire [24:0] _far_sigLarger_T_1 = _modNatAlignDist_T ? io_b_sig : io_a_sig; // @[AddRecFN.scala 88:29]
  wire [23:0] far_sigLarger = _far_sigLarger_T_1[23:0]; // @[AddRecFN.scala 88:66]
  wire [24:0] _far_sigSmaller_T_1 = _modNatAlignDist_T ? io_a_sig : io_b_sig; // @[AddRecFN.scala 89:29]
  wire [23:0] far_sigSmaller = _far_sigSmaller_T_1[23:0]; // @[AddRecFN.scala 89:66]
  wire [28:0] _far_mainAlignedSigSmaller_T = {far_sigSmaller, 5'h0}; // @[AddRecFN.scala 90:52]
  wire [28:0] far_mainAlignedSigSmaller = _far_mainAlignedSigSmaller_T >> alignDist; // @[AddRecFN.scala 90:56]
  wire [25:0] _far_reduced4SigSmaller_T = {far_sigSmaller, 2'h0}; // @[AddRecFN.scala 91:60]
  wire  far_reduced4SigSmaller_reducedVec_0 = |_far_reduced4SigSmaller_T[3:0]; // @[primitives.scala 121:54]
  wire  far_reduced4SigSmaller_reducedVec_1 = |_far_reduced4SigSmaller_T[7:4]; // @[primitives.scala 121:54]
  wire  far_reduced4SigSmaller_reducedVec_2 = |_far_reduced4SigSmaller_T[11:8]; // @[primitives.scala 121:54]
  wire  far_reduced4SigSmaller_reducedVec_3 = |_far_reduced4SigSmaller_T[15:12]; // @[primitives.scala 121:54]
  wire  far_reduced4SigSmaller_reducedVec_4 = |_far_reduced4SigSmaller_T[19:16]; // @[primitives.scala 121:54]
  wire  far_reduced4SigSmaller_reducedVec_5 = |_far_reduced4SigSmaller_T[23:20]; // @[primitives.scala 121:54]
  wire  far_reduced4SigSmaller_reducedVec_6 = |_far_reduced4SigSmaller_T[25:24]; // @[primitives.scala 124:57]
  wire [6:0] far_reduced4SigSmaller = {far_reduced4SigSmaller_reducedVec_6,far_reduced4SigSmaller_reducedVec_5,
    far_reduced4SigSmaller_reducedVec_4,far_reduced4SigSmaller_reducedVec_3,far_reduced4SigSmaller_reducedVec_2,
    far_reduced4SigSmaller_reducedVec_1,far_reduced4SigSmaller_reducedVec_0}; // @[primitives.scala 125:20]
  wire [8:0] far_roundExtraMask_shift = 9'sh100 >>> alignDist[4:2]; // @[primitives.scala 77:58]
  wire [6:0] far_roundExtraMask = {far_roundExtraMask_shift[1],far_roundExtraMask_shift[2],far_roundExtraMask_shift[3],
    far_roundExtraMask_shift[4],far_roundExtraMask_shift[5],far_roundExtraMask_shift[6],far_roundExtraMask_shift[7]}; // @[Cat.scala 33:92]
  wire [6:0] _far_alignedSigSmaller_T_3 = far_reduced4SigSmaller & far_roundExtraMask; // @[AddRecFN.scala 95:76]
  wire  _far_alignedSigSmaller_T_5 = |far_mainAlignedSigSmaller[2:0] | |_far_alignedSigSmaller_T_3; // @[AddRecFN.scala 95:49]
  wire [26:0] far_alignedSigSmaller = {far_mainAlignedSigSmaller[28:3],_far_alignedSigSmaller_T_5}; // @[Cat.scala 33:92]
  wire [26:0] _far_negAlignedSigSmaller_T = ~far_alignedSigSmaller; // @[AddRecFN.scala 97:62]
  wire [27:0] _far_negAlignedSigSmaller_T_1 = {1'h1,_far_negAlignedSigSmaller_T}; // @[Cat.scala 33:92]
  wire [27:0] far_negAlignedSigSmaller = _closeSubMags_T ? _far_negAlignedSigSmaller_T_1 : {{1'd0},
    far_alignedSigSmaller}; // @[AddRecFN.scala 97:39]
  wire [26:0] _far_sigSum_T = {far_sigLarger, 3'h0}; // @[AddRecFN.scala 98:36]
  wire [27:0] _GEN_3 = {{1'd0}, _far_sigSum_T}; // @[AddRecFN.scala 98:41]
  wire [27:0] _far_sigSum_T_2 = _GEN_3 + far_negAlignedSigSmaller; // @[AddRecFN.scala 98:41]
  wire [27:0] _GEN_4 = {{27'd0}, _closeSubMags_T}; // @[AddRecFN.scala 98:68]
  wire [27:0] far_sigSum = _far_sigSum_T_2 + _GEN_4; // @[AddRecFN.scala 98:68]
  wire [26:0] _GEN_5 = {{26'd0}, far_sigSum[0]}; // @[AddRecFN.scala 99:67]
  wire [26:0] _far_sigOut_T_2 = far_sigSum[27:1] | _GEN_5; // @[AddRecFN.scala 99:67]
  wire [27:0] _far_sigOut_T_3 = _closeSubMags_T ? far_sigSum : {{1'd0}, _far_sigOut_T_2}; // @[AddRecFN.scala 99:25]
  wire [26:0] far_sigOut = _far_sigOut_T_3[26:0]; // @[AddRecFN.scala 99:83]
  wire  notSigNaN_invalidExc = io_a_isInf & io_b_isInf & _closeSubMags_T; // @[AddRecFN.scala 102:57]
  wire  notNaN_isInfOut = io_a_isInf | io_b_isInf; // @[AddRecFN.scala 103:38]
  wire  addZeros = io_a_isZero & io_b_isZero; // @[AddRecFN.scala 104:32]
  wire  notNaN_specialCase = notNaN_isInfOut | addZeros; // @[AddRecFN.scala 105:46]
  wire  _notNaN_signOut_T_1 = io_a_isInf & io_a_sign; // @[AddRecFN.scala 109:39]
  wire  _notNaN_signOut_T_2 = eqSigns & io_a_sign | _notNaN_signOut_T_1; // @[AddRecFN.scala 108:63]
  wire  _notNaN_signOut_T_3 = io_b_isInf & effSignB; // @[AddRecFN.scala 110:39]
  wire  _notNaN_signOut_T_4 = _notNaN_signOut_T_2 | _notNaN_signOut_T_3; // @[AddRecFN.scala 109:63]
  wire  _notNaN_signOut_T_9 = ~notNaN_specialCase; // @[AddRecFN.scala 112:10]
  wire  _notNaN_signOut_T_12 = ~notNaN_specialCase & closeSubMags & ~close_totalCancellation; // @[AddRecFN.scala 112:46]
  wire  _notNaN_signOut_T_13 = _notNaN_signOut_T_12 & close_notTotalCancellation_signOut; // @[AddRecFN.scala 113:38]
  wire  _notNaN_signOut_T_14 = _notNaN_signOut_T_4 | _notNaN_signOut_T_13; // @[AddRecFN.scala 111:63]
  wire  _notNaN_signOut_T_18 = _notNaN_signOut_T_9 & ~closeSubMags & far_signOut; // @[AddRecFN.scala 114:47]
  wire [9:0] _common_sExpOut_T_2 = closeSubMags | _modNatAlignDist_T ? $signed(io_b_sExp) : $signed(io_a_sExp); // @[AddRecFN.scala 116:13]
  wire [4:0] _common_sExpOut_T_3 = closeSubMags ? close_nearNormDist : {{4'd0}, _closeSubMags_T}; // @[AddRecFN.scala 117:18]
  wire [5:0] _common_sExpOut_T_4 = {1'b0,$signed(_common_sExpOut_T_3)}; // @[AddRecFN.scala 117:66]
  wire [9:0] _GEN_6 = {{4{_common_sExpOut_T_4[5]}},_common_sExpOut_T_4}; // @[AddRecFN.scala 117:13]
  wire  _io_invalidExc_T_2 = io_a_isNaN & ~io_a_sig[22]; // @[common.scala 82:46]
  wire  _io_invalidExc_T_5 = io_b_isNaN & ~io_b_sig[22]; // @[common.scala 82:46]
  assign io_invalidExc = _io_invalidExc_T_2 | _io_invalidExc_T_5 | notSigNaN_invalidExc; // @[AddRecFN.scala 121:71]
  assign io_rawOut_isNaN = io_a_isNaN | io_b_isNaN; // @[AddRecFN.scala 125:35]
  assign io_rawOut_isInf = io_a_isInf | io_b_isInf; // @[AddRecFN.scala 103:38]
  assign io_rawOut_isZero = addZeros | ~notNaN_isInfOut & closeSubMags & close_totalCancellation; // @[AddRecFN.scala 106:37]
  assign io_rawOut_sign = _notNaN_signOut_T_14 | _notNaN_signOut_T_18; // @[AddRecFN.scala 113:77]
  assign io_rawOut_sExp = $signed(_common_sExpOut_T_2) - $signed(_GEN_6); // @[AddRecFN.scala 117:13]
  assign io_rawOut_sig = closeSubMags ? close_sigOut : far_sigOut; // @[AddRecFN.scala 118:28]
endmodule
module RoundAnyRawFNToRecFN(
  input         io_invalidExc,
  input         io_in_isNaN,
  input         io_in_isInf,
  input         io_in_isZero,
  input         io_in_sign,
  input  [9:0]  io_in_sExp,
  input  [26:0] io_in_sig,
  output [32:0] io_out
);
  wire  doShiftSigDown1 = io_in_sig[26]; // @[RoundAnyRawFNToRecFN.scala 118:61]
  wire [8:0] _roundMask_T_1 = ~io_in_sExp[8:0]; // @[primitives.scala 51:21]
  wire  roundMask_msb = _roundMask_T_1[8]; // @[primitives.scala 57:25]
  wire [7:0] roundMask_lsbs = _roundMask_T_1[7:0]; // @[primitives.scala 58:26]
  wire  roundMask_msb_1 = roundMask_lsbs[7]; // @[primitives.scala 57:25]
  wire [6:0] roundMask_lsbs_1 = roundMask_lsbs[6:0]; // @[primitives.scala 58:26]
  wire  roundMask_msb_2 = roundMask_lsbs_1[6]; // @[primitives.scala 57:25]
  wire [5:0] roundMask_lsbs_2 = roundMask_lsbs_1[5:0]; // @[primitives.scala 58:26]
  wire [64:0] roundMask_shift = 65'sh10000000000000000 >>> roundMask_lsbs_2; // @[primitives.scala 77:58]
  wire [15:0] _GEN_0 = {{8'd0}, roundMask_shift[57:50]}; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_T_7 = _GEN_0 & 16'hff; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_T_9 = {roundMask_shift[49:42], 8'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _roundMask_T_11 = _roundMask_T_9 & 16'hff00; // @[Bitwise.scala 108:80]
  wire [15:0] _roundMask_T_12 = _roundMask_T_7 | _roundMask_T_11; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_1 = {{4'd0}, _roundMask_T_12[15:4]}; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_T_17 = _GEN_1 & 16'hf0f; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_T_19 = {_roundMask_T_12[11:0], 4'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _roundMask_T_21 = _roundMask_T_19 & 16'hf0f0; // @[Bitwise.scala 108:80]
  wire [15:0] _roundMask_T_22 = _roundMask_T_17 | _roundMask_T_21; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_2 = {{2'd0}, _roundMask_T_22[15:2]}; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_T_27 = _GEN_2 & 16'h3333; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_T_29 = {_roundMask_T_22[13:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _roundMask_T_31 = _roundMask_T_29 & 16'hcccc; // @[Bitwise.scala 108:80]
  wire [15:0] _roundMask_T_32 = _roundMask_T_27 | _roundMask_T_31; // @[Bitwise.scala 108:39]
  wire [15:0] _GEN_3 = {{1'd0}, _roundMask_T_32[15:1]}; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_T_37 = _GEN_3 & 16'h5555; // @[Bitwise.scala 108:31]
  wire [15:0] _roundMask_T_39 = {_roundMask_T_32[14:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [15:0] _roundMask_T_41 = _roundMask_T_39 & 16'haaaa; // @[Bitwise.scala 108:80]
  wire [15:0] _roundMask_T_42 = _roundMask_T_37 | _roundMask_T_41; // @[Bitwise.scala 108:39]
  wire [21:0] _roundMask_T_59 = {_roundMask_T_42,roundMask_shift[58],roundMask_shift[59],roundMask_shift[60],
    roundMask_shift[61],roundMask_shift[62],roundMask_shift[63]}; // @[Cat.scala 33:92]
  wire [21:0] _roundMask_T_60 = ~_roundMask_T_59; // @[primitives.scala 74:36]
  wire [21:0] _roundMask_T_61 = roundMask_msb_2 ? 22'h0 : _roundMask_T_60; // @[primitives.scala 74:21]
  wire [21:0] _roundMask_T_62 = ~_roundMask_T_61; // @[primitives.scala 74:17]
  wire [24:0] _roundMask_T_63 = {_roundMask_T_62,3'h7}; // @[Cat.scala 33:92]
  wire [2:0] _roundMask_T_70 = {roundMask_shift[0],roundMask_shift[1],roundMask_shift[2]}; // @[Cat.scala 33:92]
  wire [2:0] _roundMask_T_71 = roundMask_msb_2 ? _roundMask_T_70 : 3'h0; // @[primitives.scala 61:24]
  wire [24:0] _roundMask_T_72 = roundMask_msb_1 ? _roundMask_T_63 : {{22'd0}, _roundMask_T_71}; // @[primitives.scala 66:24]
  wire [24:0] _roundMask_T_73 = roundMask_msb ? _roundMask_T_72 : 25'h0; // @[primitives.scala 61:24]
  wire [24:0] _GEN_4 = {{24'd0}, doShiftSigDown1}; // @[RoundAnyRawFNToRecFN.scala 157:23]
  wire [24:0] _roundMask_T_74 = _roundMask_T_73 | _GEN_4; // @[RoundAnyRawFNToRecFN.scala 157:23]
  wire [26:0] roundMask = {_roundMask_T_74,2'h3}; // @[Cat.scala 33:92]
  wire [26:0] shiftedRoundMask = {1'h0,roundMask[26:1]}; // @[Cat.scala 33:92]
  wire [26:0] _roundPosMask_T = ~shiftedRoundMask; // @[RoundAnyRawFNToRecFN.scala 161:28]
  wire [26:0] roundPosMask = _roundPosMask_T & roundMask; // @[RoundAnyRawFNToRecFN.scala 161:46]
  wire [26:0] _roundPosBit_T = io_in_sig & roundPosMask; // @[RoundAnyRawFNToRecFN.scala 162:40]
  wire  roundPosBit = |_roundPosBit_T; // @[RoundAnyRawFNToRecFN.scala 162:56]
  wire [26:0] _anyRoundExtra_T = io_in_sig & shiftedRoundMask; // @[RoundAnyRawFNToRecFN.scala 163:42]
  wire  anyRoundExtra = |_anyRoundExtra_T; // @[RoundAnyRawFNToRecFN.scala 163:62]
  wire [26:0] _roundedSig_T = io_in_sig | roundMask; // @[RoundAnyRawFNToRecFN.scala 172:32]
  wire [25:0] _roundedSig_T_2 = _roundedSig_T[26:2] + 25'h1; // @[RoundAnyRawFNToRecFN.scala 172:49]
  wire  _roundedSig_T_4 = ~anyRoundExtra; // @[RoundAnyRawFNToRecFN.scala 174:30]
  wire [25:0] _roundedSig_T_7 = roundPosBit & _roundedSig_T_4 ? roundMask[26:1] : 26'h0; // @[RoundAnyRawFNToRecFN.scala 173:25]
  wire [25:0] _roundedSig_T_8 = ~_roundedSig_T_7; // @[RoundAnyRawFNToRecFN.scala 173:21]
  wire [25:0] _roundedSig_T_9 = _roundedSig_T_2 & _roundedSig_T_8; // @[RoundAnyRawFNToRecFN.scala 172:61]
  wire [26:0] _roundedSig_T_10 = ~roundMask; // @[RoundAnyRawFNToRecFN.scala 178:32]
  wire [26:0] _roundedSig_T_11 = io_in_sig & _roundedSig_T_10; // @[RoundAnyRawFNToRecFN.scala 178:30]
  wire [25:0] _roundedSig_T_16 = {{1'd0}, _roundedSig_T_11[26:2]}; // @[RoundAnyRawFNToRecFN.scala 178:47]
  wire [25:0] roundedSig = roundPosBit ? _roundedSig_T_9 : _roundedSig_T_16; // @[RoundAnyRawFNToRecFN.scala 171:16]
  wire [2:0] _sRoundedExp_T_1 = {1'b0,$signed(roundedSig[25:24])}; // @[RoundAnyRawFNToRecFN.scala 183:69]
  wire [9:0] _GEN_5 = {{7{_sRoundedExp_T_1[2]}},_sRoundedExp_T_1}; // @[RoundAnyRawFNToRecFN.scala 183:40]
  wire [10:0] sRoundedExp = $signed(io_in_sExp) + $signed(_GEN_5); // @[RoundAnyRawFNToRecFN.scala 183:40]
  wire [8:0] common_expOut = sRoundedExp[8:0]; // @[RoundAnyRawFNToRecFN.scala 185:37]
  wire [22:0] common_fractOut = doShiftSigDown1 ? roundedSig[23:1] : roundedSig[22:0]; // @[RoundAnyRawFNToRecFN.scala 187:16]
  wire [3:0] _common_overflow_T = sRoundedExp[10:7]; // @[RoundAnyRawFNToRecFN.scala 194:30]
  wire  common_overflow = $signed(_common_overflow_T) >= 4'sh3; // @[RoundAnyRawFNToRecFN.scala 194:50]
  wire  common_totalUnderflow = $signed(sRoundedExp) < 11'sh6b; // @[RoundAnyRawFNToRecFN.scala 198:31]
  wire  isNaNOut = io_invalidExc | io_in_isNaN; // @[RoundAnyRawFNToRecFN.scala 233:34]
  wire  commonCase = ~isNaNOut & ~io_in_isInf & ~io_in_isZero; // @[RoundAnyRawFNToRecFN.scala 235:61]
  wire  overflow = commonCase & common_overflow; // @[RoundAnyRawFNToRecFN.scala 236:32]
  wire  notNaN_isInfOut = io_in_isInf | overflow; // @[RoundAnyRawFNToRecFN.scala 246:32]
  wire  signOut = isNaNOut ? 1'h0 : io_in_sign; // @[RoundAnyRawFNToRecFN.scala 248:22]
  wire [8:0] _expOut_T_1 = io_in_isZero | common_totalUnderflow ? 9'h1c0 : 9'h0; // @[RoundAnyRawFNToRecFN.scala 251:18]
  wire [8:0] _expOut_T_2 = ~_expOut_T_1; // @[RoundAnyRawFNToRecFN.scala 251:14]
  wire [8:0] _expOut_T_3 = common_expOut & _expOut_T_2; // @[RoundAnyRawFNToRecFN.scala 250:24]
  wire [8:0] _expOut_T_11 = notNaN_isInfOut ? 9'h40 : 9'h0; // @[RoundAnyRawFNToRecFN.scala 263:18]
  wire [8:0] _expOut_T_12 = ~_expOut_T_11; // @[RoundAnyRawFNToRecFN.scala 263:14]
  wire [8:0] _expOut_T_13 = _expOut_T_3 & _expOut_T_12; // @[RoundAnyRawFNToRecFN.scala 262:17]
  wire [8:0] _expOut_T_18 = notNaN_isInfOut ? 9'h180 : 9'h0; // @[RoundAnyRawFNToRecFN.scala 275:16]
  wire [8:0] _expOut_T_19 = _expOut_T_13 | _expOut_T_18; // @[RoundAnyRawFNToRecFN.scala 274:15]
  wire [8:0] _expOut_T_20 = isNaNOut ? 9'h1c0 : 9'h0; // @[RoundAnyRawFNToRecFN.scala 276:16]
  wire [8:0] expOut = _expOut_T_19 | _expOut_T_20; // @[RoundAnyRawFNToRecFN.scala 275:77]
  wire [22:0] _fractOut_T_2 = isNaNOut ? 23'h400000 : 23'h0; // @[RoundAnyRawFNToRecFN.scala 279:16]
  wire [22:0] fractOut = isNaNOut | io_in_isZero | common_totalUnderflow ? _fractOut_T_2 : common_fractOut; // @[RoundAnyRawFNToRecFN.scala 278:12]
  wire [9:0] io_out_hi = {signOut,expOut}; // @[Cat.scala 33:92]
  assign io_out = {io_out_hi,fractOut}; // @[Cat.scala 33:92]
endmodule
module RoundRawFNToRecFN(
  input         io_invalidExc,
  input         io_in_isNaN,
  input         io_in_isInf,
  input         io_in_isZero,
  input         io_in_sign,
  input  [9:0]  io_in_sExp,
  input  [26:0] io_in_sig,
  output [32:0] io_out
);
  wire  roundAnyRawFNToRecFN_io_invalidExc; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire  roundAnyRawFNToRecFN_io_in_isNaN; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire  roundAnyRawFNToRecFN_io_in_isInf; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire  roundAnyRawFNToRecFN_io_in_isZero; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire  roundAnyRawFNToRecFN_io_in_sign; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire [9:0] roundAnyRawFNToRecFN_io_in_sExp; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire [26:0] roundAnyRawFNToRecFN_io_in_sig; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire [32:0] roundAnyRawFNToRecFN_io_out; // @[RoundAnyRawFNToRecFN.scala 307:15]
  RoundAnyRawFNToRecFN roundAnyRawFNToRecFN ( // @[RoundAnyRawFNToRecFN.scala 307:15]
    .io_invalidExc(roundAnyRawFNToRecFN_io_invalidExc),
    .io_in_isNaN(roundAnyRawFNToRecFN_io_in_isNaN),
    .io_in_isInf(roundAnyRawFNToRecFN_io_in_isInf),
    .io_in_isZero(roundAnyRawFNToRecFN_io_in_isZero),
    .io_in_sign(roundAnyRawFNToRecFN_io_in_sign),
    .io_in_sExp(roundAnyRawFNToRecFN_io_in_sExp),
    .io_in_sig(roundAnyRawFNToRecFN_io_in_sig),
    .io_out(roundAnyRawFNToRecFN_io_out)
  );
  assign io_out = roundAnyRawFNToRecFN_io_out; // @[RoundAnyRawFNToRecFN.scala 315:23]
  assign roundAnyRawFNToRecFN_io_invalidExc = io_invalidExc; // @[RoundAnyRawFNToRecFN.scala 310:44]
  assign roundAnyRawFNToRecFN_io_in_isNaN = io_in_isNaN; // @[RoundAnyRawFNToRecFN.scala 312:44]
  assign roundAnyRawFNToRecFN_io_in_isInf = io_in_isInf; // @[RoundAnyRawFNToRecFN.scala 312:44]
  assign roundAnyRawFNToRecFN_io_in_isZero = io_in_isZero; // @[RoundAnyRawFNToRecFN.scala 312:44]
  assign roundAnyRawFNToRecFN_io_in_sign = io_in_sign; // @[RoundAnyRawFNToRecFN.scala 312:44]
  assign roundAnyRawFNToRecFN_io_in_sExp = io_in_sExp; // @[RoundAnyRawFNToRecFN.scala 312:44]
  assign roundAnyRawFNToRecFN_io_in_sig = io_in_sig; // @[RoundAnyRawFNToRecFN.scala 312:44]
endmodule
module AddRecFN(
  input         io_subOp,
  input  [32:0] io_a,
  input  [32:0] io_b,
  output [32:0] io_out
);
  wire  addRawFN__io_subOp; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_a_isNaN; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_a_isInf; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_a_isZero; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_a_sign; // @[AddRecFN.scala 147:26]
  wire [9:0] addRawFN__io_a_sExp; // @[AddRecFN.scala 147:26]
  wire [24:0] addRawFN__io_a_sig; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_b_isNaN; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_b_isInf; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_b_isZero; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_b_sign; // @[AddRecFN.scala 147:26]
  wire [9:0] addRawFN__io_b_sExp; // @[AddRecFN.scala 147:26]
  wire [24:0] addRawFN__io_b_sig; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_invalidExc; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_rawOut_isNaN; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_rawOut_isInf; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_rawOut_isZero; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_rawOut_sign; // @[AddRecFN.scala 147:26]
  wire [9:0] addRawFN__io_rawOut_sExp; // @[AddRecFN.scala 147:26]
  wire [26:0] addRawFN__io_rawOut_sig; // @[AddRecFN.scala 147:26]
  wire  roundRawFNToRecFN_io_invalidExc; // @[AddRecFN.scala 157:15]
  wire  roundRawFNToRecFN_io_in_isNaN; // @[AddRecFN.scala 157:15]
  wire  roundRawFNToRecFN_io_in_isInf; // @[AddRecFN.scala 157:15]
  wire  roundRawFNToRecFN_io_in_isZero; // @[AddRecFN.scala 157:15]
  wire  roundRawFNToRecFN_io_in_sign; // @[AddRecFN.scala 157:15]
  wire [9:0] roundRawFNToRecFN_io_in_sExp; // @[AddRecFN.scala 157:15]
  wire [26:0] roundRawFNToRecFN_io_in_sig; // @[AddRecFN.scala 157:15]
  wire [32:0] roundRawFNToRecFN_io_out; // @[AddRecFN.scala 157:15]
  wire [8:0] addRawFN_io_a_exp = io_a[31:23]; // @[rawFloatFromRecFN.scala 50:21]
  wire  addRawFN_io_a_isZero = addRawFN_io_a_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  wire  addRawFN_io_a_isSpecial = addRawFN_io_a_exp[8:7] == 2'h3; // @[rawFloatFromRecFN.scala 52:54]
  wire  _addRawFN_io_a_out_sig_T = ~addRawFN_io_a_isZero; // @[rawFloatFromRecFN.scala 60:39]
  wire [1:0] addRawFN_io_a_out_sig_hi = {1'h0,_addRawFN_io_a_out_sig_T}; // @[Cat.scala 33:92]
  wire [8:0] addRawFN_io_b_exp = io_b[31:23]; // @[rawFloatFromRecFN.scala 50:21]
  wire  addRawFN_io_b_isZero = addRawFN_io_b_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  wire  addRawFN_io_b_isSpecial = addRawFN_io_b_exp[8:7] == 2'h3; // @[rawFloatFromRecFN.scala 52:54]
  wire  _addRawFN_io_b_out_sig_T = ~addRawFN_io_b_isZero; // @[rawFloatFromRecFN.scala 60:39]
  wire [1:0] addRawFN_io_b_out_sig_hi = {1'h0,_addRawFN_io_b_out_sig_T}; // @[Cat.scala 33:92]
  AddRawFN addRawFN_ ( // @[AddRecFN.scala 147:26]
    .io_subOp(addRawFN__io_subOp),
    .io_a_isNaN(addRawFN__io_a_isNaN),
    .io_a_isInf(addRawFN__io_a_isInf),
    .io_a_isZero(addRawFN__io_a_isZero),
    .io_a_sign(addRawFN__io_a_sign),
    .io_a_sExp(addRawFN__io_a_sExp),
    .io_a_sig(addRawFN__io_a_sig),
    .io_b_isNaN(addRawFN__io_b_isNaN),
    .io_b_isInf(addRawFN__io_b_isInf),
    .io_b_isZero(addRawFN__io_b_isZero),
    .io_b_sign(addRawFN__io_b_sign),
    .io_b_sExp(addRawFN__io_b_sExp),
    .io_b_sig(addRawFN__io_b_sig),
    .io_invalidExc(addRawFN__io_invalidExc),
    .io_rawOut_isNaN(addRawFN__io_rawOut_isNaN),
    .io_rawOut_isInf(addRawFN__io_rawOut_isInf),
    .io_rawOut_isZero(addRawFN__io_rawOut_isZero),
    .io_rawOut_sign(addRawFN__io_rawOut_sign),
    .io_rawOut_sExp(addRawFN__io_rawOut_sExp),
    .io_rawOut_sig(addRawFN__io_rawOut_sig)
  );
  RoundRawFNToRecFN roundRawFNToRecFN ( // @[AddRecFN.scala 157:15]
    .io_invalidExc(roundRawFNToRecFN_io_invalidExc),
    .io_in_isNaN(roundRawFNToRecFN_io_in_isNaN),
    .io_in_isInf(roundRawFNToRecFN_io_in_isInf),
    .io_in_isZero(roundRawFNToRecFN_io_in_isZero),
    .io_in_sign(roundRawFNToRecFN_io_in_sign),
    .io_in_sExp(roundRawFNToRecFN_io_in_sExp),
    .io_in_sig(roundRawFNToRecFN_io_in_sig),
    .io_out(roundRawFNToRecFN_io_out)
  );
  assign io_out = roundRawFNToRecFN_io_out; // @[AddRecFN.scala 163:23]
  assign addRawFN__io_subOp = io_subOp; // @[AddRecFN.scala 149:30]
  assign addRawFN__io_a_isNaN = addRawFN_io_a_isSpecial & addRawFN_io_a_exp[6]; // @[rawFloatFromRecFN.scala 55:33]
  assign addRawFN__io_a_isInf = addRawFN_io_a_isSpecial & ~addRawFN_io_a_exp[6]; // @[rawFloatFromRecFN.scala 56:33]
  assign addRawFN__io_a_isZero = addRawFN_io_a_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  assign addRawFN__io_a_sign = io_a[32]; // @[rawFloatFromRecFN.scala 58:25]
  assign addRawFN__io_a_sExp = {1'b0,$signed(addRawFN_io_a_exp)}; // @[rawFloatFromRecFN.scala 59:27]
  assign addRawFN__io_a_sig = {addRawFN_io_a_out_sig_hi,io_a[22:0]}; // @[Cat.scala 33:92]
  assign addRawFN__io_b_isNaN = addRawFN_io_b_isSpecial & addRawFN_io_b_exp[6]; // @[rawFloatFromRecFN.scala 55:33]
  assign addRawFN__io_b_isInf = addRawFN_io_b_isSpecial & ~addRawFN_io_b_exp[6]; // @[rawFloatFromRecFN.scala 56:33]
  assign addRawFN__io_b_isZero = addRawFN_io_b_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  assign addRawFN__io_b_sign = io_b[32]; // @[rawFloatFromRecFN.scala 58:25]
  assign addRawFN__io_b_sExp = {1'b0,$signed(addRawFN_io_b_exp)}; // @[rawFloatFromRecFN.scala 59:27]
  assign addRawFN__io_b_sig = {addRawFN_io_b_out_sig_hi,io_b[22:0]}; // @[Cat.scala 33:92]
  assign roundRawFNToRecFN_io_invalidExc = addRawFN__io_invalidExc; // @[AddRecFN.scala 158:39]
  assign roundRawFNToRecFN_io_in_isNaN = addRawFN__io_rawOut_isNaN; // @[AddRecFN.scala 160:39]
  assign roundRawFNToRecFN_io_in_isInf = addRawFN__io_rawOut_isInf; // @[AddRecFN.scala 160:39]
  assign roundRawFNToRecFN_io_in_isZero = addRawFN__io_rawOut_isZero; // @[AddRecFN.scala 160:39]
  assign roundRawFNToRecFN_io_in_sign = addRawFN__io_rawOut_sign; // @[AddRecFN.scala 160:39]
  assign roundRawFNToRecFN_io_in_sExp = addRawFN__io_rawOut_sExp; // @[AddRecFN.scala 160:39]
  assign roundRawFNToRecFN_io_in_sig = addRawFN__io_rawOut_sig; // @[AddRecFN.scala 160:39]
endmodule
module FloatAdd(
  input  [32:0] io_op1,
  input  [32:0] io_op2,
  output [32:0] io_res
);
  wire  float_adder_io_subOp; // @[Float.scala 14:27]
  wire [32:0] float_adder_io_a; // @[Float.scala 14:27]
  wire [32:0] float_adder_io_b; // @[Float.scala 14:27]
  wire [32:0] float_adder_io_out; // @[Float.scala 14:27]
  AddRecFN float_adder ( // @[Float.scala 14:27]
    .io_subOp(float_adder_io_subOp),
    .io_a(float_adder_io_a),
    .io_b(float_adder_io_b),
    .io_out(float_adder_io_out)
  );
  assign io_res = float_adder_io_out; // @[Float.scala 20:10]
  assign float_adder_io_subOp = 1'h0; // @[Float.scala 15:24]
  assign float_adder_io_a = io_op1; // @[Float.scala 16:20]
  assign float_adder_io_b = io_op2; // @[Float.scala 17:20]
endmodule
module ComplexAdd(
  input  [32:0] io_op1_re,
  input  [32:0] io_op1_im,
  input  [32:0] io_op2_re,
  input  [32:0] io_op2_im,
  output [32:0] io_res_re,
  output [32:0] io_res_im
);
  wire [32:0] io_res_re_inst_io_op1; // @[Float.scala 25:22]
  wire [32:0] io_res_re_inst_io_op2; // @[Float.scala 25:22]
  wire [32:0] io_res_re_inst_io_res; // @[Float.scala 25:22]
  wire [32:0] io_res_im_inst_io_op1; // @[Float.scala 25:22]
  wire [32:0] io_res_im_inst_io_op2; // @[Float.scala 25:22]
  wire [32:0] io_res_im_inst_io_res; // @[Float.scala 25:22]
  FloatAdd io_res_re_inst ( // @[Float.scala 25:22]
    .io_op1(io_res_re_inst_io_op1),
    .io_op2(io_res_re_inst_io_op2),
    .io_res(io_res_re_inst_io_res)
  );
  FloatAdd io_res_im_inst ( // @[Float.scala 25:22]
    .io_op1(io_res_im_inst_io_op1),
    .io_op2(io_res_im_inst_io_op2),
    .io_res(io_res_im_inst_io_res)
  );
  assign io_res_re = io_res_re_inst_io_res; // @[Modules.scala 71:15]
  assign io_res_im = io_res_im_inst_io_res; // @[Modules.scala 72:15]
  assign io_res_re_inst_io_op1 = io_op1_re; // @[Float.scala 26:17]
  assign io_res_re_inst_io_op2 = io_op2_re; // @[Float.scala 27:17]
  assign io_res_im_inst_io_op1 = io_op1_im; // @[Float.scala 26:17]
  assign io_res_im_inst_io_op2 = io_op2_im; // @[Float.scala 27:17]
endmodule
module FloatSub(
  input  [32:0] io_op1,
  input  [32:0] io_op2,
  output [32:0] io_res
);
  wire  float_adder_io_subOp; // @[Float.scala 34:27]
  wire [32:0] float_adder_io_a; // @[Float.scala 34:27]
  wire [32:0] float_adder_io_b; // @[Float.scala 34:27]
  wire [32:0] float_adder_io_out; // @[Float.scala 34:27]
  AddRecFN float_adder ( // @[Float.scala 34:27]
    .io_subOp(float_adder_io_subOp),
    .io_a(float_adder_io_a),
    .io_b(float_adder_io_b),
    .io_out(float_adder_io_out)
  );
  assign io_res = float_adder_io_out; // @[Float.scala 40:10]
  assign float_adder_io_subOp = 1'h1; // @[Float.scala 35:24]
  assign float_adder_io_a = io_op1; // @[Float.scala 36:20]
  assign float_adder_io_b = io_op2; // @[Float.scala 37:20]
endmodule
module ComplexSub(
  input  [32:0] io_op1_re,
  input  [32:0] io_op1_im,
  input  [32:0] io_op2_re,
  input  [32:0] io_op2_im,
  output [32:0] io_res_re,
  output [32:0] io_res_im
);
  wire [32:0] io_res_re_inst_io_op1; // @[Float.scala 45:22]
  wire [32:0] io_res_re_inst_io_op2; // @[Float.scala 45:22]
  wire [32:0] io_res_re_inst_io_res; // @[Float.scala 45:22]
  wire [32:0] io_res_im_inst_io_op1; // @[Float.scala 45:22]
  wire [32:0] io_res_im_inst_io_op2; // @[Float.scala 45:22]
  wire [32:0] io_res_im_inst_io_res; // @[Float.scala 45:22]
  FloatSub io_res_re_inst ( // @[Float.scala 45:22]
    .io_op1(io_res_re_inst_io_op1),
    .io_op2(io_res_re_inst_io_op2),
    .io_res(io_res_re_inst_io_res)
  );
  FloatSub io_res_im_inst ( // @[Float.scala 45:22]
    .io_op1(io_res_im_inst_io_op1),
    .io_op2(io_res_im_inst_io_op2),
    .io_res(io_res_im_inst_io_res)
  );
  assign io_res_re = io_res_re_inst_io_res; // @[Modules.scala 90:15]
  assign io_res_im = io_res_im_inst_io_res; // @[Modules.scala 91:15]
  assign io_res_re_inst_io_op1 = io_op1_re; // @[Float.scala 46:17]
  assign io_res_re_inst_io_op2 = io_op2_re; // @[Float.scala 47:17]
  assign io_res_im_inst_io_op1 = io_op1_im; // @[Float.scala 46:17]
  assign io_res_im_inst_io_op2 = io_op2_im; // @[Float.scala 47:17]
endmodule
module MulFullRawFN(
  input         io_a_isNaN,
  input         io_a_isInf,
  input         io_a_isZero,
  input         io_a_sign,
  input  [9:0]  io_a_sExp,
  input  [24:0] io_a_sig,
  input         io_b_isNaN,
  input         io_b_isInf,
  input         io_b_isZero,
  input         io_b_sign,
  input  [9:0]  io_b_sExp,
  input  [24:0] io_b_sig,
  output        io_invalidExc,
  output        io_rawOut_isNaN,
  output        io_rawOut_isInf,
  output        io_rawOut_isZero,
  output        io_rawOut_sign,
  output [9:0]  io_rawOut_sExp,
  output [47:0] io_rawOut_sig
);
  wire  notSigNaN_invalidExc = io_a_isInf & io_b_isZero | io_a_isZero & io_b_isInf; // @[MulRecFN.scala 58:60]
  wire [9:0] _common_sExpOut_T_2 = $signed(io_a_sExp) + $signed(io_b_sExp); // @[MulRecFN.scala 62:36]
  wire [49:0] _common_sigOut_T = io_a_sig * io_b_sig; // @[MulRecFN.scala 63:35]
  wire  _io_invalidExc_T_2 = io_a_isNaN & ~io_a_sig[22]; // @[common.scala 82:46]
  wire  _io_invalidExc_T_5 = io_b_isNaN & ~io_b_sig[22]; // @[common.scala 82:46]
  assign io_invalidExc = _io_invalidExc_T_2 | _io_invalidExc_T_5 | notSigNaN_invalidExc; // @[MulRecFN.scala 66:71]
  assign io_rawOut_isNaN = io_a_isNaN | io_b_isNaN; // @[MulRecFN.scala 70:35]
  assign io_rawOut_isInf = io_a_isInf | io_b_isInf; // @[MulRecFN.scala 59:38]
  assign io_rawOut_isZero = io_a_isZero | io_b_isZero; // @[MulRecFN.scala 60:40]
  assign io_rawOut_sign = io_a_sign ^ io_b_sign; // @[MulRecFN.scala 61:36]
  assign io_rawOut_sExp = $signed(_common_sExpOut_T_2) - 10'sh100; // @[MulRecFN.scala 62:48]
  assign io_rawOut_sig = _common_sigOut_T[47:0]; // @[MulRecFN.scala 63:46]
endmodule
module MulRawFN(
  input         io_a_isNaN,
  input         io_a_isInf,
  input         io_a_isZero,
  input         io_a_sign,
  input  [9:0]  io_a_sExp,
  input  [24:0] io_a_sig,
  input         io_b_isNaN,
  input         io_b_isInf,
  input         io_b_isZero,
  input         io_b_sign,
  input  [9:0]  io_b_sExp,
  input  [24:0] io_b_sig,
  output        io_invalidExc,
  output        io_rawOut_isNaN,
  output        io_rawOut_isInf,
  output        io_rawOut_isZero,
  output        io_rawOut_sign,
  output [9:0]  io_rawOut_sExp,
  output [26:0] io_rawOut_sig
);
  wire  mulFullRaw_io_a_isNaN; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_a_isInf; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_a_isZero; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_a_sign; // @[MulRecFN.scala 84:28]
  wire [9:0] mulFullRaw_io_a_sExp; // @[MulRecFN.scala 84:28]
  wire [24:0] mulFullRaw_io_a_sig; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_b_isNaN; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_b_isInf; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_b_isZero; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_b_sign; // @[MulRecFN.scala 84:28]
  wire [9:0] mulFullRaw_io_b_sExp; // @[MulRecFN.scala 84:28]
  wire [24:0] mulFullRaw_io_b_sig; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_invalidExc; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_rawOut_isNaN; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_rawOut_isInf; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_rawOut_isZero; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_rawOut_sign; // @[MulRecFN.scala 84:28]
  wire [9:0] mulFullRaw_io_rawOut_sExp; // @[MulRecFN.scala 84:28]
  wire [47:0] mulFullRaw_io_rawOut_sig; // @[MulRecFN.scala 84:28]
  wire  _io_rawOut_sig_T_2 = |mulFullRaw_io_rawOut_sig[21:0]; // @[MulRecFN.scala 93:55]
  MulFullRawFN mulFullRaw ( // @[MulRecFN.scala 84:28]
    .io_a_isNaN(mulFullRaw_io_a_isNaN),
    .io_a_isInf(mulFullRaw_io_a_isInf),
    .io_a_isZero(mulFullRaw_io_a_isZero),
    .io_a_sign(mulFullRaw_io_a_sign),
    .io_a_sExp(mulFullRaw_io_a_sExp),
    .io_a_sig(mulFullRaw_io_a_sig),
    .io_b_isNaN(mulFullRaw_io_b_isNaN),
    .io_b_isInf(mulFullRaw_io_b_isInf),
    .io_b_isZero(mulFullRaw_io_b_isZero),
    .io_b_sign(mulFullRaw_io_b_sign),
    .io_b_sExp(mulFullRaw_io_b_sExp),
    .io_b_sig(mulFullRaw_io_b_sig),
    .io_invalidExc(mulFullRaw_io_invalidExc),
    .io_rawOut_isNaN(mulFullRaw_io_rawOut_isNaN),
    .io_rawOut_isInf(mulFullRaw_io_rawOut_isInf),
    .io_rawOut_isZero(mulFullRaw_io_rawOut_isZero),
    .io_rawOut_sign(mulFullRaw_io_rawOut_sign),
    .io_rawOut_sExp(mulFullRaw_io_rawOut_sExp),
    .io_rawOut_sig(mulFullRaw_io_rawOut_sig)
  );
  assign io_invalidExc = mulFullRaw_io_invalidExc; // @[MulRecFN.scala 89:19]
  assign io_rawOut_isNaN = mulFullRaw_io_rawOut_isNaN; // @[MulRecFN.scala 90:15]
  assign io_rawOut_isInf = mulFullRaw_io_rawOut_isInf; // @[MulRecFN.scala 90:15]
  assign io_rawOut_isZero = mulFullRaw_io_rawOut_isZero; // @[MulRecFN.scala 90:15]
  assign io_rawOut_sign = mulFullRaw_io_rawOut_sign; // @[MulRecFN.scala 90:15]
  assign io_rawOut_sExp = mulFullRaw_io_rawOut_sExp; // @[MulRecFN.scala 90:15]
  assign io_rawOut_sig = {mulFullRaw_io_rawOut_sig[47:22],_io_rawOut_sig_T_2}; // @[Cat.scala 33:92]
  assign mulFullRaw_io_a_isNaN = io_a_isNaN; // @[MulRecFN.scala 86:21]
  assign mulFullRaw_io_a_isInf = io_a_isInf; // @[MulRecFN.scala 86:21]
  assign mulFullRaw_io_a_isZero = io_a_isZero; // @[MulRecFN.scala 86:21]
  assign mulFullRaw_io_a_sign = io_a_sign; // @[MulRecFN.scala 86:21]
  assign mulFullRaw_io_a_sExp = io_a_sExp; // @[MulRecFN.scala 86:21]
  assign mulFullRaw_io_a_sig = io_a_sig; // @[MulRecFN.scala 86:21]
  assign mulFullRaw_io_b_isNaN = io_b_isNaN; // @[MulRecFN.scala 87:21]
  assign mulFullRaw_io_b_isInf = io_b_isInf; // @[MulRecFN.scala 87:21]
  assign mulFullRaw_io_b_isZero = io_b_isZero; // @[MulRecFN.scala 87:21]
  assign mulFullRaw_io_b_sign = io_b_sign; // @[MulRecFN.scala 87:21]
  assign mulFullRaw_io_b_sExp = io_b_sExp; // @[MulRecFN.scala 87:21]
  assign mulFullRaw_io_b_sig = io_b_sig; // @[MulRecFN.scala 87:21]
endmodule
module MulRecFN(
  input  [32:0] io_a,
  input  [32:0] io_b,
  output [32:0] io_out
);
  wire  mulRawFN__io_a_isNaN; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_a_isInf; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_a_isZero; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_a_sign; // @[MulRecFN.scala 113:26]
  wire [9:0] mulRawFN__io_a_sExp; // @[MulRecFN.scala 113:26]
  wire [24:0] mulRawFN__io_a_sig; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_b_isNaN; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_b_isInf; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_b_isZero; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_b_sign; // @[MulRecFN.scala 113:26]
  wire [9:0] mulRawFN__io_b_sExp; // @[MulRecFN.scala 113:26]
  wire [24:0] mulRawFN__io_b_sig; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_invalidExc; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_rawOut_isNaN; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_rawOut_isInf; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_rawOut_isZero; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_rawOut_sign; // @[MulRecFN.scala 113:26]
  wire [9:0] mulRawFN__io_rawOut_sExp; // @[MulRecFN.scala 113:26]
  wire [26:0] mulRawFN__io_rawOut_sig; // @[MulRecFN.scala 113:26]
  wire  roundRawFNToRecFN_io_invalidExc; // @[MulRecFN.scala 121:15]
  wire  roundRawFNToRecFN_io_in_isNaN; // @[MulRecFN.scala 121:15]
  wire  roundRawFNToRecFN_io_in_isInf; // @[MulRecFN.scala 121:15]
  wire  roundRawFNToRecFN_io_in_isZero; // @[MulRecFN.scala 121:15]
  wire  roundRawFNToRecFN_io_in_sign; // @[MulRecFN.scala 121:15]
  wire [9:0] roundRawFNToRecFN_io_in_sExp; // @[MulRecFN.scala 121:15]
  wire [26:0] roundRawFNToRecFN_io_in_sig; // @[MulRecFN.scala 121:15]
  wire [32:0] roundRawFNToRecFN_io_out; // @[MulRecFN.scala 121:15]
  wire [8:0] mulRawFN_io_a_exp = io_a[31:23]; // @[rawFloatFromRecFN.scala 50:21]
  wire  mulRawFN_io_a_isZero = mulRawFN_io_a_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  wire  mulRawFN_io_a_isSpecial = mulRawFN_io_a_exp[8:7] == 2'h3; // @[rawFloatFromRecFN.scala 52:54]
  wire  _mulRawFN_io_a_out_sig_T = ~mulRawFN_io_a_isZero; // @[rawFloatFromRecFN.scala 60:39]
  wire [1:0] mulRawFN_io_a_out_sig_hi = {1'h0,_mulRawFN_io_a_out_sig_T}; // @[Cat.scala 33:92]
  wire [8:0] mulRawFN_io_b_exp = io_b[31:23]; // @[rawFloatFromRecFN.scala 50:21]
  wire  mulRawFN_io_b_isZero = mulRawFN_io_b_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  wire  mulRawFN_io_b_isSpecial = mulRawFN_io_b_exp[8:7] == 2'h3; // @[rawFloatFromRecFN.scala 52:54]
  wire  _mulRawFN_io_b_out_sig_T = ~mulRawFN_io_b_isZero; // @[rawFloatFromRecFN.scala 60:39]
  wire [1:0] mulRawFN_io_b_out_sig_hi = {1'h0,_mulRawFN_io_b_out_sig_T}; // @[Cat.scala 33:92]
  MulRawFN mulRawFN_ ( // @[MulRecFN.scala 113:26]
    .io_a_isNaN(mulRawFN__io_a_isNaN),
    .io_a_isInf(mulRawFN__io_a_isInf),
    .io_a_isZero(mulRawFN__io_a_isZero),
    .io_a_sign(mulRawFN__io_a_sign),
    .io_a_sExp(mulRawFN__io_a_sExp),
    .io_a_sig(mulRawFN__io_a_sig),
    .io_b_isNaN(mulRawFN__io_b_isNaN),
    .io_b_isInf(mulRawFN__io_b_isInf),
    .io_b_isZero(mulRawFN__io_b_isZero),
    .io_b_sign(mulRawFN__io_b_sign),
    .io_b_sExp(mulRawFN__io_b_sExp),
    .io_b_sig(mulRawFN__io_b_sig),
    .io_invalidExc(mulRawFN__io_invalidExc),
    .io_rawOut_isNaN(mulRawFN__io_rawOut_isNaN),
    .io_rawOut_isInf(mulRawFN__io_rawOut_isInf),
    .io_rawOut_isZero(mulRawFN__io_rawOut_isZero),
    .io_rawOut_sign(mulRawFN__io_rawOut_sign),
    .io_rawOut_sExp(mulRawFN__io_rawOut_sExp),
    .io_rawOut_sig(mulRawFN__io_rawOut_sig)
  );
  RoundRawFNToRecFN roundRawFNToRecFN ( // @[MulRecFN.scala 121:15]
    .io_invalidExc(roundRawFNToRecFN_io_invalidExc),
    .io_in_isNaN(roundRawFNToRecFN_io_in_isNaN),
    .io_in_isInf(roundRawFNToRecFN_io_in_isInf),
    .io_in_isZero(roundRawFNToRecFN_io_in_isZero),
    .io_in_sign(roundRawFNToRecFN_io_in_sign),
    .io_in_sExp(roundRawFNToRecFN_io_in_sExp),
    .io_in_sig(roundRawFNToRecFN_io_in_sig),
    .io_out(roundRawFNToRecFN_io_out)
  );
  assign io_out = roundRawFNToRecFN_io_out; // @[MulRecFN.scala 127:23]
  assign mulRawFN__io_a_isNaN = mulRawFN_io_a_isSpecial & mulRawFN_io_a_exp[6]; // @[rawFloatFromRecFN.scala 55:33]
  assign mulRawFN__io_a_isInf = mulRawFN_io_a_isSpecial & ~mulRawFN_io_a_exp[6]; // @[rawFloatFromRecFN.scala 56:33]
  assign mulRawFN__io_a_isZero = mulRawFN_io_a_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  assign mulRawFN__io_a_sign = io_a[32]; // @[rawFloatFromRecFN.scala 58:25]
  assign mulRawFN__io_a_sExp = {1'b0,$signed(mulRawFN_io_a_exp)}; // @[rawFloatFromRecFN.scala 59:27]
  assign mulRawFN__io_a_sig = {mulRawFN_io_a_out_sig_hi,io_a[22:0]}; // @[Cat.scala 33:92]
  assign mulRawFN__io_b_isNaN = mulRawFN_io_b_isSpecial & mulRawFN_io_b_exp[6]; // @[rawFloatFromRecFN.scala 55:33]
  assign mulRawFN__io_b_isInf = mulRawFN_io_b_isSpecial & ~mulRawFN_io_b_exp[6]; // @[rawFloatFromRecFN.scala 56:33]
  assign mulRawFN__io_b_isZero = mulRawFN_io_b_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  assign mulRawFN__io_b_sign = io_b[32]; // @[rawFloatFromRecFN.scala 58:25]
  assign mulRawFN__io_b_sExp = {1'b0,$signed(mulRawFN_io_b_exp)}; // @[rawFloatFromRecFN.scala 59:27]
  assign mulRawFN__io_b_sig = {mulRawFN_io_b_out_sig_hi,io_b[22:0]}; // @[Cat.scala 33:92]
  assign roundRawFNToRecFN_io_invalidExc = mulRawFN__io_invalidExc; // @[MulRecFN.scala 122:39]
  assign roundRawFNToRecFN_io_in_isNaN = mulRawFN__io_rawOut_isNaN; // @[MulRecFN.scala 124:39]
  assign roundRawFNToRecFN_io_in_isInf = mulRawFN__io_rawOut_isInf; // @[MulRecFN.scala 124:39]
  assign roundRawFNToRecFN_io_in_isZero = mulRawFN__io_rawOut_isZero; // @[MulRecFN.scala 124:39]
  assign roundRawFNToRecFN_io_in_sign = mulRawFN__io_rawOut_sign; // @[MulRecFN.scala 124:39]
  assign roundRawFNToRecFN_io_in_sExp = mulRawFN__io_rawOut_sExp; // @[MulRecFN.scala 124:39]
  assign roundRawFNToRecFN_io_in_sig = mulRawFN__io_rawOut_sig; // @[MulRecFN.scala 124:39]
endmodule
module FloatMul(
  input  [32:0] io_op1,
  input  [32:0] io_op2,
  output [32:0] io_res
);
  wire [32:0] float_adder_io_a; // @[Float.scala 54:27]
  wire [32:0] float_adder_io_b; // @[Float.scala 54:27]
  wire [32:0] float_adder_io_out; // @[Float.scala 54:27]
  MulRecFN float_adder ( // @[Float.scala 54:27]
    .io_a(float_adder_io_a),
    .io_b(float_adder_io_b),
    .io_out(float_adder_io_out)
  );
  assign io_res = float_adder_io_out; // @[Float.scala 59:10]
  assign float_adder_io_a = io_op1; // @[Float.scala 55:20]
  assign float_adder_io_b = io_op2; // @[Float.scala 56:20]
endmodule
module ComplexMul(
  input  [32:0] io_op1_re,
  input  [32:0] io_op1_im,
  input  [32:0] io_op2_re,
  input  [32:0] io_op2_im,
  output [32:0] io_res_re,
  output [32:0] io_res_im
);
  wire [32:0] io_res_re_inst_io_op1; // @[Float.scala 64:22]
  wire [32:0] io_res_re_inst_io_op2; // @[Float.scala 64:22]
  wire [32:0] io_res_re_inst_io_res; // @[Float.scala 64:22]
  wire [32:0] io_res_re_inst_1_io_op1; // @[Float.scala 64:22]
  wire [32:0] io_res_re_inst_1_io_op2; // @[Float.scala 64:22]
  wire [32:0] io_res_re_inst_1_io_res; // @[Float.scala 64:22]
  wire [32:0] io_res_re_inst_2_io_op1; // @[Float.scala 45:22]
  wire [32:0] io_res_re_inst_2_io_op2; // @[Float.scala 45:22]
  wire [32:0] io_res_re_inst_2_io_res; // @[Float.scala 45:22]
  wire [32:0] io_res_im_inst_io_op1; // @[Float.scala 64:22]
  wire [32:0] io_res_im_inst_io_op2; // @[Float.scala 64:22]
  wire [32:0] io_res_im_inst_io_res; // @[Float.scala 64:22]
  wire [32:0] io_res_im_inst_1_io_op1; // @[Float.scala 64:22]
  wire [32:0] io_res_im_inst_1_io_op2; // @[Float.scala 64:22]
  wire [32:0] io_res_im_inst_1_io_res; // @[Float.scala 64:22]
  wire [32:0] io_res_im_inst_2_io_op1; // @[Float.scala 25:22]
  wire [32:0] io_res_im_inst_2_io_op2; // @[Float.scala 25:22]
  wire [32:0] io_res_im_inst_2_io_res; // @[Float.scala 25:22]
  FloatMul io_res_re_inst ( // @[Float.scala 64:22]
    .io_op1(io_res_re_inst_io_op1),
    .io_op2(io_res_re_inst_io_op2),
    .io_res(io_res_re_inst_io_res)
  );
  FloatMul io_res_re_inst_1 ( // @[Float.scala 64:22]
    .io_op1(io_res_re_inst_1_io_op1),
    .io_op2(io_res_re_inst_1_io_op2),
    .io_res(io_res_re_inst_1_io_res)
  );
  FloatSub io_res_re_inst_2 ( // @[Float.scala 45:22]
    .io_op1(io_res_re_inst_2_io_op1),
    .io_op2(io_res_re_inst_2_io_op2),
    .io_res(io_res_re_inst_2_io_res)
  );
  FloatMul io_res_im_inst ( // @[Float.scala 64:22]
    .io_op1(io_res_im_inst_io_op1),
    .io_op2(io_res_im_inst_io_op2),
    .io_res(io_res_im_inst_io_res)
  );
  FloatMul io_res_im_inst_1 ( // @[Float.scala 64:22]
    .io_op1(io_res_im_inst_1_io_op1),
    .io_op2(io_res_im_inst_1_io_op2),
    .io_res(io_res_im_inst_1_io_res)
  );
  FloatAdd io_res_im_inst_2 ( // @[Float.scala 25:22]
    .io_op1(io_res_im_inst_2_io_op1),
    .io_op2(io_res_im_inst_2_io_op2),
    .io_res(io_res_im_inst_2_io_res)
  );
  assign io_res_re = io_res_re_inst_2_io_res; // @[Modules.scala 139:17]
  assign io_res_im = io_res_im_inst_2_io_res; // @[Modules.scala 140:17]
  assign io_res_re_inst_io_op1 = io_op1_re; // @[Float.scala 65:17]
  assign io_res_re_inst_io_op2 = io_op2_re; // @[Float.scala 66:17]
  assign io_res_re_inst_1_io_op1 = io_op1_im; // @[Float.scala 65:17]
  assign io_res_re_inst_1_io_op2 = io_op2_im; // @[Float.scala 66:17]
  assign io_res_re_inst_2_io_op1 = io_res_re_inst_io_res; // @[Float.scala 46:17]
  assign io_res_re_inst_2_io_op2 = io_res_re_inst_1_io_res; // @[Float.scala 47:17]
  assign io_res_im_inst_io_op1 = io_op1_re; // @[Float.scala 65:17]
  assign io_res_im_inst_io_op2 = io_op2_im; // @[Float.scala 66:17]
  assign io_res_im_inst_1_io_op1 = io_op1_im; // @[Float.scala 65:17]
  assign io_res_im_inst_1_io_op2 = io_op2_re; // @[Float.scala 66:17]
  assign io_res_im_inst_2_io_op1 = io_res_im_inst_io_res; // @[Float.scala 26:17]
  assign io_res_im_inst_2_io_op2 = io_res_im_inst_1_io_res; // @[Float.scala 27:17]
endmodule
module ButterflyMul(
  input  [32:0] io_in_0_re,
  input  [32:0] io_in_0_im,
  input  [32:0] io_in_1_re,
  input  [32:0] io_in_1_im,
  output [32:0] io_out_0_re,
  output [32:0] io_out_0_im,
  output [32:0] io_out_1_re,
  output [32:0] io_out_1_im,
  input  [32:0] io_wn_0_re,
  input  [32:0] io_wn_0_im
);
  wire [32:0] temp_0_inst_io_op1_re; // @[Modules.scala 81:22]
  wire [32:0] temp_0_inst_io_op1_im; // @[Modules.scala 81:22]
  wire [32:0] temp_0_inst_io_op2_re; // @[Modules.scala 81:22]
  wire [32:0] temp_0_inst_io_op2_im; // @[Modules.scala 81:22]
  wire [32:0] temp_0_inst_io_res_re; // @[Modules.scala 81:22]
  wire [32:0] temp_0_inst_io_res_im; // @[Modules.scala 81:22]
  wire [32:0] temp_1_inst_io_op1_re; // @[Modules.scala 100:22]
  wire [32:0] temp_1_inst_io_op1_im; // @[Modules.scala 100:22]
  wire [32:0] temp_1_inst_io_op2_re; // @[Modules.scala 100:22]
  wire [32:0] temp_1_inst_io_op2_im; // @[Modules.scala 100:22]
  wire [32:0] temp_1_inst_io_res_re; // @[Modules.scala 100:22]
  wire [32:0] temp_1_inst_io_res_im; // @[Modules.scala 100:22]
  wire [32:0] io_out_1_inst_io_op1_re; // @[Modules.scala 158:22]
  wire [32:0] io_out_1_inst_io_op1_im; // @[Modules.scala 158:22]
  wire [32:0] io_out_1_inst_io_op2_re; // @[Modules.scala 158:22]
  wire [32:0] io_out_1_inst_io_op2_im; // @[Modules.scala 158:22]
  wire [32:0] io_out_1_inst_io_res_re; // @[Modules.scala 158:22]
  wire [32:0] io_out_1_inst_io_res_im; // @[Modules.scala 158:22]
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
  input  [32:0] io_in_0_re,
  input  [32:0] io_in_0_im,
  input  [32:0] io_in_1_re,
  input  [32:0] io_in_1_im,
  output [32:0] io_out_0_re,
  output [32:0] io_out_0_im,
  output [32:0] io_out_1_re,
  output [32:0] io_out_1_im
);
  wire [32:0] io_out_0_inst_io_op1_re; // @[Modules.scala 81:22]
  wire [32:0] io_out_0_inst_io_op1_im; // @[Modules.scala 81:22]
  wire [32:0] io_out_0_inst_io_op2_re; // @[Modules.scala 81:22]
  wire [32:0] io_out_0_inst_io_op2_im; // @[Modules.scala 81:22]
  wire [32:0] io_out_0_inst_io_res_re; // @[Modules.scala 81:22]
  wire [32:0] io_out_0_inst_io_res_im; // @[Modules.scala 81:22]
  wire [32:0] io_out_1_inst_io_op1_re; // @[Modules.scala 100:22]
  wire [32:0] io_out_1_inst_io_op1_im; // @[Modules.scala 100:22]
  wire [32:0] io_out_1_inst_io_op2_re; // @[Modules.scala 100:22]
  wire [32:0] io_out_1_inst_io_op2_im; // @[Modules.scala 100:22]
  wire [32:0] io_out_1_inst_io_res_re; // @[Modules.scala 100:22]
  wire [32:0] io_out_1_inst_io_res_im; // @[Modules.scala 100:22]
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
module Exchange(
  input  [32:0] io_in_0_0_re,
  input  [32:0] io_in_0_0_im,
  input  [32:0] io_in_0_1_re,
  input  [32:0] io_in_0_1_im,
  input  [32:0] io_in_1_0_re,
  input  [32:0] io_in_1_0_im,
  input  [32:0] io_in_1_1_re,
  input  [32:0] io_in_1_1_im,
  output [32:0] io_out_0_0_re,
  output [32:0] io_out_0_0_im,
  output [32:0] io_out_0_1_re,
  output [32:0] io_out_0_1_im,
  output [32:0] io_out_1_0_re,
  output [32:0] io_out_1_0_im,
  output [32:0] io_out_1_1_re,
  output [32:0] io_out_1_1_im
);
  assign io_out_0_0_re = io_in_0_0_re; // @[Modules.scala 324:20]
  assign io_out_0_0_im = io_in_0_0_im; // @[Modules.scala 324:20]
  assign io_out_0_1_re = io_in_1_0_re; // @[Modules.scala 324:20]
  assign io_out_0_1_im = io_in_1_0_im; // @[Modules.scala 324:20]
  assign io_out_1_0_re = io_in_0_1_re; // @[Modules.scala 324:20]
  assign io_out_1_0_im = io_in_0_1_im; // @[Modules.scala 324:20]
  assign io_out_1_1_re = io_in_1_1_re; // @[Modules.scala 324:20]
  assign io_out_1_1_im = io_in_1_1_im; // @[Modules.scala 324:20]
endmodule
module Switch(
  input         clock,
  input  [32:0] io_in_0_re,
  input  [32:0] io_in_0_im,
  input  [32:0] io_in_1_re,
  input  [32:0] io_in_1_im,
  output [32:0] io_out_0_re,
  output [32:0] io_out_0_im,
  output [32:0] io_out_1_re,
  output [32:0] io_out_1_im,
  input         io_sel
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [63:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [63:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [63:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [63:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [32:0] swdata_1_r_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_im; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_1_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_1_im; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_2_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_2_im; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_3_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_3_im; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_4_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_4_im; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_5_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_5_im; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_6_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_6_im; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_7_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_7_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_1_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_1_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_2_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_2_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_3_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_3_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_4_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_4_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_5_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_5_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_6_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_6_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_7_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_7_im; // @[Reg.scala 19:16]
  assign io_out_0_re = io_out_0_r_7_re; // @[Modules.scala 306:38]
  assign io_out_0_im = io_out_0_r_7_im; // @[Modules.scala 306:38]
  assign io_out_1_re = io_sel ? io_in_0_re : swdata_1_r_7_re; // @[Modules.scala 306:{38,38}]
  assign io_out_1_im = io_sel ? io_in_0_im : swdata_1_r_7_im; // @[Modules.scala 306:{38,38}]
  always @(posedge clock) begin
    swdata_1_r_re <= io_in_1_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_im <= io_in_1_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_1_re <= swdata_1_r_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_1_im <= swdata_1_r_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_2_re <= swdata_1_r_1_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_2_im <= swdata_1_r_1_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_3_re <= swdata_1_r_2_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_3_im <= swdata_1_r_2_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_4_re <= swdata_1_r_3_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_4_im <= swdata_1_r_3_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_5_re <= swdata_1_r_4_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_5_im <= swdata_1_r_4_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_6_re <= swdata_1_r_5_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_6_im <= swdata_1_r_5_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_7_re <= swdata_1_r_6_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_7_im <= swdata_1_r_6_im; // @[Reg.scala 19:16 20:{18,22}]
    if (io_sel) begin // @[Reg.scala 20:22]
      io_out_0_r_re <= swdata_1_r_7_re; // @[Reg.scala 20:22]
    end else begin
      io_out_0_r_re <= io_in_0_re;
    end
    if (io_sel) begin // @[Reg.scala 20:22]
      io_out_0_r_im <= swdata_1_r_7_im; // @[Reg.scala 20:22]
    end else begin
      io_out_0_r_im <= io_in_0_im;
    end
    io_out_0_r_1_re <= io_out_0_r_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_1_im <= io_out_0_r_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_2_re <= io_out_0_r_1_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_2_im <= io_out_0_r_1_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_3_re <= io_out_0_r_2_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_3_im <= io_out_0_r_2_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_4_re <= io_out_0_r_3_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_4_im <= io_out_0_r_3_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_5_re <= io_out_0_r_4_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_5_im <= io_out_0_r_4_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_6_re <= io_out_0_r_5_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_6_im <= io_out_0_r_5_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_7_re <= io_out_0_r_6_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_7_im <= io_out_0_r_6_im; // @[Reg.scala 19:16 20:{18,22}]
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
  _RAND_0 = {2{`RANDOM}};
  swdata_1_r_re = _RAND_0[32:0];
  _RAND_1 = {2{`RANDOM}};
  swdata_1_r_im = _RAND_1[32:0];
  _RAND_2 = {2{`RANDOM}};
  swdata_1_r_1_re = _RAND_2[32:0];
  _RAND_3 = {2{`RANDOM}};
  swdata_1_r_1_im = _RAND_3[32:0];
  _RAND_4 = {2{`RANDOM}};
  swdata_1_r_2_re = _RAND_4[32:0];
  _RAND_5 = {2{`RANDOM}};
  swdata_1_r_2_im = _RAND_5[32:0];
  _RAND_6 = {2{`RANDOM}};
  swdata_1_r_3_re = _RAND_6[32:0];
  _RAND_7 = {2{`RANDOM}};
  swdata_1_r_3_im = _RAND_7[32:0];
  _RAND_8 = {2{`RANDOM}};
  swdata_1_r_4_re = _RAND_8[32:0];
  _RAND_9 = {2{`RANDOM}};
  swdata_1_r_4_im = _RAND_9[32:0];
  _RAND_10 = {2{`RANDOM}};
  swdata_1_r_5_re = _RAND_10[32:0];
  _RAND_11 = {2{`RANDOM}};
  swdata_1_r_5_im = _RAND_11[32:0];
  _RAND_12 = {2{`RANDOM}};
  swdata_1_r_6_re = _RAND_12[32:0];
  _RAND_13 = {2{`RANDOM}};
  swdata_1_r_6_im = _RAND_13[32:0];
  _RAND_14 = {2{`RANDOM}};
  swdata_1_r_7_re = _RAND_14[32:0];
  _RAND_15 = {2{`RANDOM}};
  swdata_1_r_7_im = _RAND_15[32:0];
  _RAND_16 = {2{`RANDOM}};
  io_out_0_r_re = _RAND_16[32:0];
  _RAND_17 = {2{`RANDOM}};
  io_out_0_r_im = _RAND_17[32:0];
  _RAND_18 = {2{`RANDOM}};
  io_out_0_r_1_re = _RAND_18[32:0];
  _RAND_19 = {2{`RANDOM}};
  io_out_0_r_1_im = _RAND_19[32:0];
  _RAND_20 = {2{`RANDOM}};
  io_out_0_r_2_re = _RAND_20[32:0];
  _RAND_21 = {2{`RANDOM}};
  io_out_0_r_2_im = _RAND_21[32:0];
  _RAND_22 = {2{`RANDOM}};
  io_out_0_r_3_re = _RAND_22[32:0];
  _RAND_23 = {2{`RANDOM}};
  io_out_0_r_3_im = _RAND_23[32:0];
  _RAND_24 = {2{`RANDOM}};
  io_out_0_r_4_re = _RAND_24[32:0];
  _RAND_25 = {2{`RANDOM}};
  io_out_0_r_4_im = _RAND_25[32:0];
  _RAND_26 = {2{`RANDOM}};
  io_out_0_r_5_re = _RAND_26[32:0];
  _RAND_27 = {2{`RANDOM}};
  io_out_0_r_5_im = _RAND_27[32:0];
  _RAND_28 = {2{`RANDOM}};
  io_out_0_r_6_re = _RAND_28[32:0];
  _RAND_29 = {2{`RANDOM}};
  io_out_0_r_6_im = _RAND_29[32:0];
  _RAND_30 = {2{`RANDOM}};
  io_out_0_r_7_re = _RAND_30[32:0];
  _RAND_31 = {2{`RANDOM}};
  io_out_0_r_7_im = _RAND_31[32:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Switch_2(
  input         clock,
  input  [32:0] io_in_0_re,
  input  [32:0] io_in_0_im,
  input  [32:0] io_in_1_re,
  input  [32:0] io_in_1_im,
  output [32:0] io_out_0_re,
  output [32:0] io_out_0_im,
  output [32:0] io_out_1_re,
  output [32:0] io_out_1_im,
  input         io_sel
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
`endif // RANDOMIZE_REG_INIT
  reg [32:0] swdata_1_r_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_im; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_1_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_1_im; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_2_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_2_im; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_3_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_3_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_1_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_1_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_2_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_2_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_3_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_3_im; // @[Reg.scala 19:16]
  assign io_out_0_re = io_out_0_r_3_re; // @[Modules.scala 306:38]
  assign io_out_0_im = io_out_0_r_3_im; // @[Modules.scala 306:38]
  assign io_out_1_re = io_sel ? io_in_0_re : swdata_1_r_3_re; // @[Modules.scala 306:{38,38}]
  assign io_out_1_im = io_sel ? io_in_0_im : swdata_1_r_3_im; // @[Modules.scala 306:{38,38}]
  always @(posedge clock) begin
    swdata_1_r_re <= io_in_1_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_im <= io_in_1_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_1_re <= swdata_1_r_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_1_im <= swdata_1_r_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_2_re <= swdata_1_r_1_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_2_im <= swdata_1_r_1_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_3_re <= swdata_1_r_2_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_3_im <= swdata_1_r_2_im; // @[Reg.scala 19:16 20:{18,22}]
    if (io_sel) begin // @[Reg.scala 20:22]
      io_out_0_r_re <= swdata_1_r_3_re; // @[Reg.scala 20:22]
    end else begin
      io_out_0_r_re <= io_in_0_re;
    end
    if (io_sel) begin // @[Reg.scala 20:22]
      io_out_0_r_im <= swdata_1_r_3_im; // @[Reg.scala 20:22]
    end else begin
      io_out_0_r_im <= io_in_0_im;
    end
    io_out_0_r_1_re <= io_out_0_r_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_1_im <= io_out_0_r_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_2_re <= io_out_0_r_1_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_2_im <= io_out_0_r_1_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_3_re <= io_out_0_r_2_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_3_im <= io_out_0_r_2_im; // @[Reg.scala 19:16 20:{18,22}]
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
  _RAND_0 = {2{`RANDOM}};
  swdata_1_r_re = _RAND_0[32:0];
  _RAND_1 = {2{`RANDOM}};
  swdata_1_r_im = _RAND_1[32:0];
  _RAND_2 = {2{`RANDOM}};
  swdata_1_r_1_re = _RAND_2[32:0];
  _RAND_3 = {2{`RANDOM}};
  swdata_1_r_1_im = _RAND_3[32:0];
  _RAND_4 = {2{`RANDOM}};
  swdata_1_r_2_re = _RAND_4[32:0];
  _RAND_5 = {2{`RANDOM}};
  swdata_1_r_2_im = _RAND_5[32:0];
  _RAND_6 = {2{`RANDOM}};
  swdata_1_r_3_re = _RAND_6[32:0];
  _RAND_7 = {2{`RANDOM}};
  swdata_1_r_3_im = _RAND_7[32:0];
  _RAND_8 = {2{`RANDOM}};
  io_out_0_r_re = _RAND_8[32:0];
  _RAND_9 = {2{`RANDOM}};
  io_out_0_r_im = _RAND_9[32:0];
  _RAND_10 = {2{`RANDOM}};
  io_out_0_r_1_re = _RAND_10[32:0];
  _RAND_11 = {2{`RANDOM}};
  io_out_0_r_1_im = _RAND_11[32:0];
  _RAND_12 = {2{`RANDOM}};
  io_out_0_r_2_re = _RAND_12[32:0];
  _RAND_13 = {2{`RANDOM}};
  io_out_0_r_2_im = _RAND_13[32:0];
  _RAND_14 = {2{`RANDOM}};
  io_out_0_r_3_re = _RAND_14[32:0];
  _RAND_15 = {2{`RANDOM}};
  io_out_0_r_3_im = _RAND_15[32:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Switch_4(
  input         clock,
  input  [32:0] io_in_0_re,
  input  [32:0] io_in_0_im,
  input  [32:0] io_in_1_re,
  input  [32:0] io_in_1_im,
  output [32:0] io_out_0_re,
  output [32:0] io_out_0_im,
  output [32:0] io_out_1_re,
  output [32:0] io_out_1_im,
  input         io_sel
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [32:0] swdata_1_r_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_im; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_1_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_1_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_1_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_1_im; // @[Reg.scala 19:16]
  assign io_out_0_re = io_out_0_r_1_re; // @[Modules.scala 306:38]
  assign io_out_0_im = io_out_0_r_1_im; // @[Modules.scala 306:38]
  assign io_out_1_re = io_sel ? io_in_0_re : swdata_1_r_1_re; // @[Modules.scala 306:{38,38}]
  assign io_out_1_im = io_sel ? io_in_0_im : swdata_1_r_1_im; // @[Modules.scala 306:{38,38}]
  always @(posedge clock) begin
    swdata_1_r_re <= io_in_1_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_im <= io_in_1_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_1_re <= swdata_1_r_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_1_im <= swdata_1_r_im; // @[Reg.scala 19:16 20:{18,22}]
    if (io_sel) begin // @[Reg.scala 20:22]
      io_out_0_r_re <= swdata_1_r_1_re; // @[Reg.scala 20:22]
    end else begin
      io_out_0_r_re <= io_in_0_re;
    end
    if (io_sel) begin // @[Reg.scala 20:22]
      io_out_0_r_im <= swdata_1_r_1_im; // @[Reg.scala 20:22]
    end else begin
      io_out_0_r_im <= io_in_0_im;
    end
    io_out_0_r_1_re <= io_out_0_r_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_1_im <= io_out_0_r_im; // @[Reg.scala 19:16 20:{18,22}]
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
  _RAND_0 = {2{`RANDOM}};
  swdata_1_r_re = _RAND_0[32:0];
  _RAND_1 = {2{`RANDOM}};
  swdata_1_r_im = _RAND_1[32:0];
  _RAND_2 = {2{`RANDOM}};
  swdata_1_r_1_re = _RAND_2[32:0];
  _RAND_3 = {2{`RANDOM}};
  swdata_1_r_1_im = _RAND_3[32:0];
  _RAND_4 = {2{`RANDOM}};
  io_out_0_r_re = _RAND_4[32:0];
  _RAND_5 = {2{`RANDOM}};
  io_out_0_r_im = _RAND_5[32:0];
  _RAND_6 = {2{`RANDOM}};
  io_out_0_r_1_re = _RAND_6[32:0];
  _RAND_7 = {2{`RANDOM}};
  io_out_0_r_1_im = _RAND_7[32:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Switch_6(
  input         clock,
  input  [32:0] io_in_0_re,
  input  [32:0] io_in_0_im,
  input  [32:0] io_in_1_re,
  input  [32:0] io_in_1_im,
  output [32:0] io_out_0_re,
  output [32:0] io_out_0_im,
  output [32:0] io_out_1_re,
  output [32:0] io_out_1_im,
  input         io_sel
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [32:0] swdata_1_r_re; // @[Reg.scala 19:16]
  reg [32:0] swdata_1_r_im; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_re; // @[Reg.scala 19:16]
  reg [32:0] io_out_0_r_im; // @[Reg.scala 19:16]
  assign io_out_0_re = io_out_0_r_re; // @[Modules.scala 306:38]
  assign io_out_0_im = io_out_0_r_im; // @[Modules.scala 306:38]
  assign io_out_1_re = io_sel ? io_in_0_re : swdata_1_r_re; // @[Modules.scala 306:{38,38}]
  assign io_out_1_im = io_sel ? io_in_0_im : swdata_1_r_im; // @[Modules.scala 306:{38,38}]
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
  _RAND_0 = {2{`RANDOM}};
  swdata_1_r_re = _RAND_0[32:0];
  _RAND_1 = {2{`RANDOM}};
  swdata_1_r_im = _RAND_1[32:0];
  _RAND_2 = {2{`RANDOM}};
  io_out_0_r_re = _RAND_2[32:0];
  _RAND_3 = {2{`RANDOM}};
  io_out_0_r_im = _RAND_3[32:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ComplexRecode(
  input  [31:0] io_in_re,
  input  [31:0] io_in_im,
  output [32:0] io_out_re,
  output [32:0] io_out_im
);
  wire  io_out_re_rawIn_sign = io_in_re[31]; // @[rawFloatFromFN.scala 46:22]
  wire [7:0] io_out_re_rawIn_expIn = io_in_re[30:23]; // @[rawFloatFromFN.scala 47:23]
  wire [22:0] io_out_re_rawIn_fractIn = io_in_re[22:0]; // @[rawFloatFromFN.scala 48:25]
  wire  io_out_re_rawIn_isZeroExpIn = io_out_re_rawIn_expIn == 8'h0; // @[rawFloatFromFN.scala 50:34]
  wire  io_out_re_rawIn_isZeroFractIn = io_out_re_rawIn_fractIn == 23'h0; // @[rawFloatFromFN.scala 51:38]
  wire [4:0] _io_out_re_rawIn_normDist_T_23 = io_out_re_rawIn_fractIn[1] ? 5'h15 : 5'h16; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_24 = io_out_re_rawIn_fractIn[2] ? 5'h14 : _io_out_re_rawIn_normDist_T_23; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_25 = io_out_re_rawIn_fractIn[3] ? 5'h13 : _io_out_re_rawIn_normDist_T_24; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_26 = io_out_re_rawIn_fractIn[4] ? 5'h12 : _io_out_re_rawIn_normDist_T_25; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_27 = io_out_re_rawIn_fractIn[5] ? 5'h11 : _io_out_re_rawIn_normDist_T_26; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_28 = io_out_re_rawIn_fractIn[6] ? 5'h10 : _io_out_re_rawIn_normDist_T_27; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_29 = io_out_re_rawIn_fractIn[7] ? 5'hf : _io_out_re_rawIn_normDist_T_28; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_30 = io_out_re_rawIn_fractIn[8] ? 5'he : _io_out_re_rawIn_normDist_T_29; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_31 = io_out_re_rawIn_fractIn[9] ? 5'hd : _io_out_re_rawIn_normDist_T_30; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_32 = io_out_re_rawIn_fractIn[10] ? 5'hc : _io_out_re_rawIn_normDist_T_31; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_33 = io_out_re_rawIn_fractIn[11] ? 5'hb : _io_out_re_rawIn_normDist_T_32; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_34 = io_out_re_rawIn_fractIn[12] ? 5'ha : _io_out_re_rawIn_normDist_T_33; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_35 = io_out_re_rawIn_fractIn[13] ? 5'h9 : _io_out_re_rawIn_normDist_T_34; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_36 = io_out_re_rawIn_fractIn[14] ? 5'h8 : _io_out_re_rawIn_normDist_T_35; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_37 = io_out_re_rawIn_fractIn[15] ? 5'h7 : _io_out_re_rawIn_normDist_T_36; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_38 = io_out_re_rawIn_fractIn[16] ? 5'h6 : _io_out_re_rawIn_normDist_T_37; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_39 = io_out_re_rawIn_fractIn[17] ? 5'h5 : _io_out_re_rawIn_normDist_T_38; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_40 = io_out_re_rawIn_fractIn[18] ? 5'h4 : _io_out_re_rawIn_normDist_T_39; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_41 = io_out_re_rawIn_fractIn[19] ? 5'h3 : _io_out_re_rawIn_normDist_T_40; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_42 = io_out_re_rawIn_fractIn[20] ? 5'h2 : _io_out_re_rawIn_normDist_T_41; // @[Mux.scala 47:70]
  wire [4:0] _io_out_re_rawIn_normDist_T_43 = io_out_re_rawIn_fractIn[21] ? 5'h1 : _io_out_re_rawIn_normDist_T_42; // @[Mux.scala 47:70]
  wire [4:0] io_out_re_rawIn_normDist = io_out_re_rawIn_fractIn[22] ? 5'h0 : _io_out_re_rawIn_normDist_T_43; // @[Mux.scala 47:70]
  wire [53:0] _GEN_8 = {{31'd0}, io_out_re_rawIn_fractIn}; // @[rawFloatFromFN.scala 54:36]
  wire [53:0] _io_out_re_rawIn_subnormFract_T = _GEN_8 << io_out_re_rawIn_normDist; // @[rawFloatFromFN.scala 54:36]
  wire [22:0] io_out_re_rawIn_subnormFract = {_io_out_re_rawIn_subnormFract_T[21:0], 1'h0}; // @[rawFloatFromFN.scala 54:64]
  wire [8:0] _GEN_0 = {{4'd0}, io_out_re_rawIn_normDist}; // @[rawFloatFromFN.scala 57:26]
  wire [8:0] _io_out_re_rawIn_adjustedExp_T = _GEN_0 ^ 9'h1ff; // @[rawFloatFromFN.scala 57:26]
  wire [8:0] _io_out_re_rawIn_adjustedExp_T_1 = io_out_re_rawIn_isZeroExpIn ? _io_out_re_rawIn_adjustedExp_T : {{1'd0},
    io_out_re_rawIn_expIn}; // @[rawFloatFromFN.scala 56:16]
  wire [1:0] _io_out_re_rawIn_adjustedExp_T_2 = io_out_re_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 60:27]
  wire [7:0] _GEN_1 = {{6'd0}, _io_out_re_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 60:22]
  wire [7:0] _io_out_re_rawIn_adjustedExp_T_3 = 8'h80 | _GEN_1; // @[rawFloatFromFN.scala 60:22]
  wire [8:0] _GEN_2 = {{1'd0}, _io_out_re_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 59:15]
  wire [8:0] io_out_re_rawIn_adjustedExp = _io_out_re_rawIn_adjustedExp_T_1 + _GEN_2; // @[rawFloatFromFN.scala 59:15]
  wire  io_out_re_rawIn_isZero = io_out_re_rawIn_isZeroExpIn & io_out_re_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 62:34]
  wire  io_out_re_rawIn_isSpecial = io_out_re_rawIn_adjustedExp[8:7] == 2'h3; // @[rawFloatFromFN.scala 63:62]
  wire  io_out_re_rawIn__isNaN = io_out_re_rawIn_isSpecial & ~io_out_re_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 66:33]
  wire [9:0] io_out_re_rawIn__sExp = {1'b0,$signed(io_out_re_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 70:48]
  wire  _io_out_re_rawIn_out_sig_T = ~io_out_re_rawIn_isZero; // @[rawFloatFromFN.scala 72:29]
  wire [22:0] _io_out_re_rawIn_out_sig_T_1 = io_out_re_rawIn_isZeroExpIn ? io_out_re_rawIn_subnormFract :
    io_out_re_rawIn_fractIn; // @[rawFloatFromFN.scala 72:42]
  wire [24:0] io_out_re_rawIn__sig = {1'h0,_io_out_re_rawIn_out_sig_T,_io_out_re_rawIn_out_sig_T_1}; // @[Cat.scala 33:92]
  wire [2:0] _io_out_re_T_1 = io_out_re_rawIn_isZero ? 3'h0 : io_out_re_rawIn__sExp[8:6]; // @[recFNFromFN.scala 48:16]
  wire [2:0] _GEN_3 = {{2'd0}, io_out_re_rawIn__isNaN}; // @[recFNFromFN.scala 48:79]
  wire [2:0] _io_out_re_T_3 = _io_out_re_T_1 | _GEN_3; // @[recFNFromFN.scala 48:79]
  wire [28:0] io_out_re_lo = {io_out_re_rawIn__sExp[5:0],io_out_re_rawIn__sig[22:0]}; // @[Cat.scala 33:92]
  wire [3:0] io_out_re_hi = {io_out_re_rawIn_sign,_io_out_re_T_3}; // @[Cat.scala 33:92]
  wire  io_out_im_rawIn_sign = io_in_im[31]; // @[rawFloatFromFN.scala 46:22]
  wire [7:0] io_out_im_rawIn_expIn = io_in_im[30:23]; // @[rawFloatFromFN.scala 47:23]
  wire [22:0] io_out_im_rawIn_fractIn = io_in_im[22:0]; // @[rawFloatFromFN.scala 48:25]
  wire  io_out_im_rawIn_isZeroExpIn = io_out_im_rawIn_expIn == 8'h0; // @[rawFloatFromFN.scala 50:34]
  wire  io_out_im_rawIn_isZeroFractIn = io_out_im_rawIn_fractIn == 23'h0; // @[rawFloatFromFN.scala 51:38]
  wire [4:0] _io_out_im_rawIn_normDist_T_23 = io_out_im_rawIn_fractIn[1] ? 5'h15 : 5'h16; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_24 = io_out_im_rawIn_fractIn[2] ? 5'h14 : _io_out_im_rawIn_normDist_T_23; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_25 = io_out_im_rawIn_fractIn[3] ? 5'h13 : _io_out_im_rawIn_normDist_T_24; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_26 = io_out_im_rawIn_fractIn[4] ? 5'h12 : _io_out_im_rawIn_normDist_T_25; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_27 = io_out_im_rawIn_fractIn[5] ? 5'h11 : _io_out_im_rawIn_normDist_T_26; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_28 = io_out_im_rawIn_fractIn[6] ? 5'h10 : _io_out_im_rawIn_normDist_T_27; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_29 = io_out_im_rawIn_fractIn[7] ? 5'hf : _io_out_im_rawIn_normDist_T_28; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_30 = io_out_im_rawIn_fractIn[8] ? 5'he : _io_out_im_rawIn_normDist_T_29; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_31 = io_out_im_rawIn_fractIn[9] ? 5'hd : _io_out_im_rawIn_normDist_T_30; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_32 = io_out_im_rawIn_fractIn[10] ? 5'hc : _io_out_im_rawIn_normDist_T_31; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_33 = io_out_im_rawIn_fractIn[11] ? 5'hb : _io_out_im_rawIn_normDist_T_32; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_34 = io_out_im_rawIn_fractIn[12] ? 5'ha : _io_out_im_rawIn_normDist_T_33; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_35 = io_out_im_rawIn_fractIn[13] ? 5'h9 : _io_out_im_rawIn_normDist_T_34; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_36 = io_out_im_rawIn_fractIn[14] ? 5'h8 : _io_out_im_rawIn_normDist_T_35; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_37 = io_out_im_rawIn_fractIn[15] ? 5'h7 : _io_out_im_rawIn_normDist_T_36; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_38 = io_out_im_rawIn_fractIn[16] ? 5'h6 : _io_out_im_rawIn_normDist_T_37; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_39 = io_out_im_rawIn_fractIn[17] ? 5'h5 : _io_out_im_rawIn_normDist_T_38; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_40 = io_out_im_rawIn_fractIn[18] ? 5'h4 : _io_out_im_rawIn_normDist_T_39; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_41 = io_out_im_rawIn_fractIn[19] ? 5'h3 : _io_out_im_rawIn_normDist_T_40; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_42 = io_out_im_rawIn_fractIn[20] ? 5'h2 : _io_out_im_rawIn_normDist_T_41; // @[Mux.scala 47:70]
  wire [4:0] _io_out_im_rawIn_normDist_T_43 = io_out_im_rawIn_fractIn[21] ? 5'h1 : _io_out_im_rawIn_normDist_T_42; // @[Mux.scala 47:70]
  wire [4:0] io_out_im_rawIn_normDist = io_out_im_rawIn_fractIn[22] ? 5'h0 : _io_out_im_rawIn_normDist_T_43; // @[Mux.scala 47:70]
  wire [53:0] _GEN_9 = {{31'd0}, io_out_im_rawIn_fractIn}; // @[rawFloatFromFN.scala 54:36]
  wire [53:0] _io_out_im_rawIn_subnormFract_T = _GEN_9 << io_out_im_rawIn_normDist; // @[rawFloatFromFN.scala 54:36]
  wire [22:0] io_out_im_rawIn_subnormFract = {_io_out_im_rawIn_subnormFract_T[21:0], 1'h0}; // @[rawFloatFromFN.scala 54:64]
  wire [8:0] _GEN_4 = {{4'd0}, io_out_im_rawIn_normDist}; // @[rawFloatFromFN.scala 57:26]
  wire [8:0] _io_out_im_rawIn_adjustedExp_T = _GEN_4 ^ 9'h1ff; // @[rawFloatFromFN.scala 57:26]
  wire [8:0] _io_out_im_rawIn_adjustedExp_T_1 = io_out_im_rawIn_isZeroExpIn ? _io_out_im_rawIn_adjustedExp_T : {{1'd0},
    io_out_im_rawIn_expIn}; // @[rawFloatFromFN.scala 56:16]
  wire [1:0] _io_out_im_rawIn_adjustedExp_T_2 = io_out_im_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 60:27]
  wire [7:0] _GEN_5 = {{6'd0}, _io_out_im_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 60:22]
  wire [7:0] _io_out_im_rawIn_adjustedExp_T_3 = 8'h80 | _GEN_5; // @[rawFloatFromFN.scala 60:22]
  wire [8:0] _GEN_6 = {{1'd0}, _io_out_im_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 59:15]
  wire [8:0] io_out_im_rawIn_adjustedExp = _io_out_im_rawIn_adjustedExp_T_1 + _GEN_6; // @[rawFloatFromFN.scala 59:15]
  wire  io_out_im_rawIn_isZero = io_out_im_rawIn_isZeroExpIn & io_out_im_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 62:34]
  wire  io_out_im_rawIn_isSpecial = io_out_im_rawIn_adjustedExp[8:7] == 2'h3; // @[rawFloatFromFN.scala 63:62]
  wire  io_out_im_rawIn__isNaN = io_out_im_rawIn_isSpecial & ~io_out_im_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 66:33]
  wire [9:0] io_out_im_rawIn__sExp = {1'b0,$signed(io_out_im_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 70:48]
  wire  _io_out_im_rawIn_out_sig_T = ~io_out_im_rawIn_isZero; // @[rawFloatFromFN.scala 72:29]
  wire [22:0] _io_out_im_rawIn_out_sig_T_1 = io_out_im_rawIn_isZeroExpIn ? io_out_im_rawIn_subnormFract :
    io_out_im_rawIn_fractIn; // @[rawFloatFromFN.scala 72:42]
  wire [24:0] io_out_im_rawIn__sig = {1'h0,_io_out_im_rawIn_out_sig_T,_io_out_im_rawIn_out_sig_T_1}; // @[Cat.scala 33:92]
  wire [2:0] _io_out_im_T_1 = io_out_im_rawIn_isZero ? 3'h0 : io_out_im_rawIn__sExp[8:6]; // @[recFNFromFN.scala 48:16]
  wire [2:0] _GEN_7 = {{2'd0}, io_out_im_rawIn__isNaN}; // @[recFNFromFN.scala 48:79]
  wire [2:0] _io_out_im_T_3 = _io_out_im_T_1 | _GEN_7; // @[recFNFromFN.scala 48:79]
  wire [28:0] io_out_im_lo = {io_out_im_rawIn__sExp[5:0],io_out_im_rawIn__sig[22:0]}; // @[Cat.scala 33:92]
  wire [3:0] io_out_im_hi = {io_out_im_rawIn_sign,_io_out_im_T_3}; // @[Cat.scala 33:92]
  assign io_out_re = {io_out_re_hi,io_out_re_lo}; // @[Cat.scala 33:92]
  assign io_out_im = {io_out_im_hi,io_out_im_lo}; // @[Cat.scala 33:92]
endmodule
module ComplexDecode(
  input  [32:0] io_in_re,
  input  [32:0] io_in_im,
  output [31:0] io_out_re,
  output [31:0] io_out_im
);
  wire [8:0] io_out_re_rawIn_exp = io_in_re[31:23]; // @[rawFloatFromRecFN.scala 50:21]
  wire  io_out_re_rawIn_isZero = io_out_re_rawIn_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  wire  io_out_re_rawIn_isSpecial = io_out_re_rawIn_exp[8:7] == 2'h3; // @[rawFloatFromRecFN.scala 52:54]
  wire  io_out_re_rawIn__isNaN = io_out_re_rawIn_isSpecial & io_out_re_rawIn_exp[6]; // @[rawFloatFromRecFN.scala 55:33]
  wire  io_out_re_rawIn__isInf = io_out_re_rawIn_isSpecial & ~io_out_re_rawIn_exp[6]; // @[rawFloatFromRecFN.scala 56:33]
  wire  io_out_re_rawIn__sign = io_in_re[32]; // @[rawFloatFromRecFN.scala 58:25]
  wire [9:0] io_out_re_rawIn__sExp = {1'b0,$signed(io_out_re_rawIn_exp)}; // @[rawFloatFromRecFN.scala 59:27]
  wire  _io_out_re_rawIn_out_sig_T = ~io_out_re_rawIn_isZero; // @[rawFloatFromRecFN.scala 60:39]
  wire [24:0] io_out_re_rawIn__sig = {1'h0,_io_out_re_rawIn_out_sig_T,io_in_re[22:0]}; // @[Cat.scala 33:92]
  wire  io_out_re_isSubnormal = $signed(io_out_re_rawIn__sExp) < 10'sh82; // @[fNFromRecFN.scala 50:39]
  wire [4:0] io_out_re_denormShiftDist = 5'h1 - io_out_re_rawIn__sExp[4:0]; // @[fNFromRecFN.scala 51:39]
  wire [23:0] _io_out_re_denormFract_T_1 = io_out_re_rawIn__sig[24:1] >> io_out_re_denormShiftDist; // @[fNFromRecFN.scala 52:42]
  wire [22:0] io_out_re_denormFract = _io_out_re_denormFract_T_1[22:0]; // @[fNFromRecFN.scala 52:60]
  wire [7:0] _io_out_re_expOut_T_2 = io_out_re_rawIn__sExp[7:0] - 8'h81; // @[fNFromRecFN.scala 57:45]
  wire [7:0] _io_out_re_expOut_T_3 = io_out_re_isSubnormal ? 8'h0 : _io_out_re_expOut_T_2; // @[fNFromRecFN.scala 55:16]
  wire  _io_out_re_expOut_T_4 = io_out_re_rawIn__isNaN | io_out_re_rawIn__isInf; // @[fNFromRecFN.scala 59:44]
  wire [7:0] _io_out_re_expOut_T_6 = _io_out_re_expOut_T_4 ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] io_out_re_expOut = _io_out_re_expOut_T_3 | _io_out_re_expOut_T_6; // @[fNFromRecFN.scala 59:15]
  wire [22:0] _io_out_re_fractOut_T_1 = io_out_re_rawIn__isInf ? 23'h0 : io_out_re_rawIn__sig[22:0]; // @[fNFromRecFN.scala 63:20]
  wire [22:0] io_out_re_fractOut = io_out_re_isSubnormal ? io_out_re_denormFract : _io_out_re_fractOut_T_1; // @[fNFromRecFN.scala 61:16]
  wire [8:0] io_out_re_hi = {io_out_re_rawIn__sign,io_out_re_expOut}; // @[Cat.scala 33:92]
  wire [8:0] io_out_im_rawIn_exp = io_in_im[31:23]; // @[rawFloatFromRecFN.scala 50:21]
  wire  io_out_im_rawIn_isZero = io_out_im_rawIn_exp[8:6] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  wire  io_out_im_rawIn_isSpecial = io_out_im_rawIn_exp[8:7] == 2'h3; // @[rawFloatFromRecFN.scala 52:54]
  wire  io_out_im_rawIn__isNaN = io_out_im_rawIn_isSpecial & io_out_im_rawIn_exp[6]; // @[rawFloatFromRecFN.scala 55:33]
  wire  io_out_im_rawIn__isInf = io_out_im_rawIn_isSpecial & ~io_out_im_rawIn_exp[6]; // @[rawFloatFromRecFN.scala 56:33]
  wire  io_out_im_rawIn__sign = io_in_im[32]; // @[rawFloatFromRecFN.scala 58:25]
  wire [9:0] io_out_im_rawIn__sExp = {1'b0,$signed(io_out_im_rawIn_exp)}; // @[rawFloatFromRecFN.scala 59:27]
  wire  _io_out_im_rawIn_out_sig_T = ~io_out_im_rawIn_isZero; // @[rawFloatFromRecFN.scala 60:39]
  wire [24:0] io_out_im_rawIn__sig = {1'h0,_io_out_im_rawIn_out_sig_T,io_in_im[22:0]}; // @[Cat.scala 33:92]
  wire  io_out_im_isSubnormal = $signed(io_out_im_rawIn__sExp) < 10'sh82; // @[fNFromRecFN.scala 50:39]
  wire [4:0] io_out_im_denormShiftDist = 5'h1 - io_out_im_rawIn__sExp[4:0]; // @[fNFromRecFN.scala 51:39]
  wire [23:0] _io_out_im_denormFract_T_1 = io_out_im_rawIn__sig[24:1] >> io_out_im_denormShiftDist; // @[fNFromRecFN.scala 52:42]
  wire [22:0] io_out_im_denormFract = _io_out_im_denormFract_T_1[22:0]; // @[fNFromRecFN.scala 52:60]
  wire [7:0] _io_out_im_expOut_T_2 = io_out_im_rawIn__sExp[7:0] - 8'h81; // @[fNFromRecFN.scala 57:45]
  wire [7:0] _io_out_im_expOut_T_3 = io_out_im_isSubnormal ? 8'h0 : _io_out_im_expOut_T_2; // @[fNFromRecFN.scala 55:16]
  wire  _io_out_im_expOut_T_4 = io_out_im_rawIn__isNaN | io_out_im_rawIn__isInf; // @[fNFromRecFN.scala 59:44]
  wire [7:0] _io_out_im_expOut_T_6 = _io_out_im_expOut_T_4 ? 8'hff : 8'h0; // @[Bitwise.scala 77:12]
  wire [7:0] io_out_im_expOut = _io_out_im_expOut_T_3 | _io_out_im_expOut_T_6; // @[fNFromRecFN.scala 59:15]
  wire [22:0] _io_out_im_fractOut_T_1 = io_out_im_rawIn__isInf ? 23'h0 : io_out_im_rawIn__sig[22:0]; // @[fNFromRecFN.scala 63:20]
  wire [22:0] io_out_im_fractOut = io_out_im_isSubnormal ? io_out_im_denormFract : _io_out_im_fractOut_T_1; // @[fNFromRecFN.scala 61:16]
  wire [8:0] io_out_im_hi = {io_out_im_rawIn__sign,io_out_im_expOut}; // @[Cat.scala 33:92]
  assign io_out_re = {io_out_re_hi,io_out_re_fractOut}; // @[Cat.scala 33:92]
  assign io_out_im = {io_out_im_hi,io_out_im_fractOut}; // @[Cat.scala 33:92]
endmodule
module FFT(
  input         clock,
  input         reset,
  input  [31:0] io_dIn_0_re,
  input  [31:0] io_dIn_0_im,
  input  [31:0] io_dIn_1_re,
  input  [31:0] io_dIn_1_im,
  input  [31:0] io_dIn_2_re,
  input  [31:0] io_dIn_2_im,
  input  [31:0] io_dIn_3_re,
  input  [31:0] io_dIn_3_im,
  output [31:0] io_dOut_0_re,
  output [31:0] io_dOut_0_im,
  output [31:0] io_dOut_1_re,
  output [31:0] io_dOut_1_im,
  output [31:0] io_dOut_2_re,
  output [31:0] io_dOut_2_im,
  output [31:0] io_dOut_3_re,
  output [31:0] io_dOut_3_im,
  input         io_din_valid,
  output        io_busy
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
`endif // RANDOMIZE_REG_INIT
  wire [32:0] inst_io_in_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_io_in_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_io_in_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_io_in_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_io_out_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_io_out_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_io_out_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_io_out_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_io_wn_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_io_wn_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_1_io_in_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_1_io_in_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_1_io_in_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_1_io_in_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_1_io_out_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_1_io_out_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_1_io_out_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_1_io_out_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_1_io_wn_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_1_io_wn_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_2_io_in_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_2_io_in_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_2_io_in_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_2_io_in_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_2_io_out_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_2_io_out_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_2_io_out_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_2_io_out_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_2_io_wn_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_2_io_wn_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_3_io_in_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_3_io_in_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_3_io_in_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_3_io_in_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_3_io_out_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_3_io_out_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_3_io_out_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_3_io_out_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_3_io_wn_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_3_io_wn_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_4_io_in_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_4_io_in_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_4_io_in_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_4_io_in_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_4_io_out_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_4_io_out_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_4_io_out_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_4_io_out_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_4_io_wn_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_4_io_wn_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_5_io_in_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_5_io_in_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_5_io_in_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_5_io_in_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_5_io_out_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_5_io_out_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_5_io_out_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_5_io_out_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_5_io_wn_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_5_io_wn_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_6_io_in_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_6_io_in_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_6_io_in_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_6_io_in_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_6_io_out_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_6_io_out_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_6_io_out_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_6_io_out_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_6_io_wn_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_6_io_wn_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_7_io_in_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_7_io_in_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_7_io_in_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_7_io_in_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_7_io_out_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_7_io_out_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_7_io_out_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_7_io_out_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_7_io_wn_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_7_io_wn_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_8_io_in_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_8_io_in_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_8_io_in_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_8_io_in_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_8_io_out_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_8_io_out_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_8_io_out_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_8_io_out_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_8_io_wn_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_8_io_wn_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_9_io_in_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_9_io_in_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_9_io_in_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_9_io_in_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_9_io_out_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_9_io_out_0_im; // @[Modules.scala 287:22]
  wire [32:0] inst_9_io_out_1_re; // @[Modules.scala 287:22]
  wire [32:0] inst_9_io_out_1_im; // @[Modules.scala 287:22]
  wire [32:0] inst_9_io_wn_0_re; // @[Modules.scala 287:22]
  wire [32:0] inst_9_io_wn_0_im; // @[Modules.scala 287:22]
  wire [32:0] dataotemp_inst_io_in_0_re; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_io_in_0_im; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_io_in_1_re; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_io_in_1_im; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_io_out_0_re; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_io_out_0_im; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_io_out_1_re; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_io_out_1_im; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_1_io_in_0_re; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_1_io_in_0_im; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_1_io_in_1_re; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_1_io_in_1_im; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_1_io_out_0_re; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_1_io_out_0_im; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_1_io_out_1_re; // @[Modules.scala 213:22]
  wire [32:0] dataotemp_inst_1_io_out_1_im; // @[Modules.scala 213:22]
  wire [32:0] exdata_inst_io_in_0_0_re; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_in_0_0_im; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_in_0_1_re; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_in_0_1_im; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_in_1_0_re; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_in_1_0_im; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_in_1_1_re; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_in_1_1_im; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_out_0_0_re; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_out_0_0_im; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_out_0_1_re; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_out_0_1_im; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_out_1_0_re; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_out_1_0_im; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_out_1_1_re; // @[Modules.scala 331:22]
  wire [32:0] exdata_inst_io_out_1_1_im; // @[Modules.scala 331:22]
  wire  inst_10_clock; // @[Modules.scala 311:22]
  wire [32:0] inst_10_io_in_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_10_io_in_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_10_io_in_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_10_io_in_1_im; // @[Modules.scala 311:22]
  wire [32:0] inst_10_io_out_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_10_io_out_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_10_io_out_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_10_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_10_io_sel; // @[Modules.scala 311:22]
  wire  inst_11_clock; // @[Modules.scala 311:22]
  wire [32:0] inst_11_io_in_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_11_io_in_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_11_io_in_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_11_io_in_1_im; // @[Modules.scala 311:22]
  wire [32:0] inst_11_io_out_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_11_io_out_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_11_io_out_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_11_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_11_io_sel; // @[Modules.scala 311:22]
  wire  inst_12_clock; // @[Modules.scala 311:22]
  wire [32:0] inst_12_io_in_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_12_io_in_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_12_io_in_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_12_io_in_1_im; // @[Modules.scala 311:22]
  wire [32:0] inst_12_io_out_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_12_io_out_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_12_io_out_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_12_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_12_io_sel; // @[Modules.scala 311:22]
  wire  inst_13_clock; // @[Modules.scala 311:22]
  wire [32:0] inst_13_io_in_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_13_io_in_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_13_io_in_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_13_io_in_1_im; // @[Modules.scala 311:22]
  wire [32:0] inst_13_io_out_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_13_io_out_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_13_io_out_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_13_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_13_io_sel; // @[Modules.scala 311:22]
  wire  inst_14_clock; // @[Modules.scala 311:22]
  wire [32:0] inst_14_io_in_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_14_io_in_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_14_io_in_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_14_io_in_1_im; // @[Modules.scala 311:22]
  wire [32:0] inst_14_io_out_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_14_io_out_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_14_io_out_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_14_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_14_io_sel; // @[Modules.scala 311:22]
  wire  inst_15_clock; // @[Modules.scala 311:22]
  wire [32:0] inst_15_io_in_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_15_io_in_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_15_io_in_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_15_io_in_1_im; // @[Modules.scala 311:22]
  wire [32:0] inst_15_io_out_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_15_io_out_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_15_io_out_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_15_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_15_io_sel; // @[Modules.scala 311:22]
  wire  inst_16_clock; // @[Modules.scala 311:22]
  wire [32:0] inst_16_io_in_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_16_io_in_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_16_io_in_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_16_io_in_1_im; // @[Modules.scala 311:22]
  wire [32:0] inst_16_io_out_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_16_io_out_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_16_io_out_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_16_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_16_io_sel; // @[Modules.scala 311:22]
  wire  inst_17_clock; // @[Modules.scala 311:22]
  wire [32:0] inst_17_io_in_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_17_io_in_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_17_io_in_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_17_io_in_1_im; // @[Modules.scala 311:22]
  wire [32:0] inst_17_io_out_0_re; // @[Modules.scala 311:22]
  wire [32:0] inst_17_io_out_0_im; // @[Modules.scala 311:22]
  wire [32:0] inst_17_io_out_1_re; // @[Modules.scala 311:22]
  wire [32:0] inst_17_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_17_io_sel; // @[Modules.scala 311:22]
  wire [31:0] inst_18_io_in_re; // @[Modules.scala 40:22]
  wire [31:0] inst_18_io_in_im; // @[Modules.scala 40:22]
  wire [32:0] inst_18_io_out_re; // @[Modules.scala 40:22]
  wire [32:0] inst_18_io_out_im; // @[Modules.scala 40:22]
  wire [31:0] inst_19_io_in_re; // @[Modules.scala 40:22]
  wire [31:0] inst_19_io_in_im; // @[Modules.scala 40:22]
  wire [32:0] inst_19_io_out_re; // @[Modules.scala 40:22]
  wire [32:0] inst_19_io_out_im; // @[Modules.scala 40:22]
  wire [31:0] inst_20_io_in_re; // @[Modules.scala 40:22]
  wire [31:0] inst_20_io_in_im; // @[Modules.scala 40:22]
  wire [32:0] inst_20_io_out_re; // @[Modules.scala 40:22]
  wire [32:0] inst_20_io_out_im; // @[Modules.scala 40:22]
  wire [31:0] inst_21_io_in_re; // @[Modules.scala 40:22]
  wire [31:0] inst_21_io_in_im; // @[Modules.scala 40:22]
  wire [32:0] inst_21_io_out_re; // @[Modules.scala 40:22]
  wire [32:0] inst_21_io_out_im; // @[Modules.scala 40:22]
  wire [32:0] inst_22_io_in_re; // @[Modules.scala 56:22]
  wire [32:0] inst_22_io_in_im; // @[Modules.scala 56:22]
  wire [31:0] inst_22_io_out_re; // @[Modules.scala 56:22]
  wire [31:0] inst_22_io_out_im; // @[Modules.scala 56:22]
  wire [32:0] inst_23_io_in_re; // @[Modules.scala 56:22]
  wire [32:0] inst_23_io_in_im; // @[Modules.scala 56:22]
  wire [31:0] inst_23_io_out_re; // @[Modules.scala 56:22]
  wire [31:0] inst_23_io_out_im; // @[Modules.scala 56:22]
  wire [32:0] inst_24_io_in_re; // @[Modules.scala 56:22]
  wire [32:0] inst_24_io_in_im; // @[Modules.scala 56:22]
  wire [31:0] inst_24_io_out_re; // @[Modules.scala 56:22]
  wire [31:0] inst_24_io_out_im; // @[Modules.scala 56:22]
  wire [32:0] inst_25_io_in_re; // @[Modules.scala 56:22]
  wire [32:0] inst_25_io_in_im; // @[Modules.scala 56:22]
  wire [31:0] inst_25_io_out_re; // @[Modules.scala 56:22]
  wire [31:0] inst_25_io_out_im; // @[Modules.scala 56:22]
  reg [5:0] cnt_0; // @[FFT.scala 110:46]
  reg [5:0] cnt_1; // @[FFT.scala 110:46]
  wire  busy = cnt_0 != 6'h0; // @[FFT.scala 114:21]
  wire [5:0] _cnt_0_T_2 = cnt_0 + 6'h1; // @[FFT.scala 116:87]
  wire [6:0] _wnList_T = {{1'd0}, cnt_0}; // @[FFT.scala 135:96]
  wire [9:0] wnList_res_re_rawIn__sExp = {1'b0,$signed(9'h100)}; // @[rawFloatFromFN.scala 70:48]
  wire [32:0] _wnList_res_re_T_7 = {1'h0,wnList_res_re_rawIn__sExp[8:6],wnList_res_re_rawIn__sExp[5:0],23'h0}; // @[Cat.scala 33:92]
  wire [9:0] wnList_res_re_rawIn_1_sExp = {1'b0,$signed(9'hff)}; // @[rawFloatFromFN.scala 70:48]
  wire [32:0] _wnList_res_re_T_15 = {1'h0,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h7ec46d}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_23 = {1'h0,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h7b14be}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_31 = {1'h0,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h74fa0b}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_39 = {1'h0,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h6c835e}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_47 = {1'h0,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h61c598}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_55 = {1'h0,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h54db31}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_63 = {1'h0,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h45e403}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_71 = {1'h0,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h3504f3}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_79 = {1'h0,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h226799}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_87 = {1'h0,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'he39da}; // @[Cat.scala 33:92]
  wire [9:0] wnList_res_re_rawIn_11_sExp = {1'b0,$signed(9'hfe)}; // @[rawFloatFromFN.scala 70:48]
  wire [32:0] _wnList_res_re_T_95 = {1'h0,wnList_res_re_rawIn_11_sExp[8:6],wnList_res_re_rawIn_11_sExp[5:0],23'h715aea}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_103 = {1'h0,wnList_res_re_rawIn_11_sExp[8:6],wnList_res_re_rawIn_11_sExp[5:0],23'h43ef15}
    ; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_111 = {1'h0,wnList_res_re_rawIn_11_sExp[8:6],wnList_res_re_rawIn_11_sExp[5:0],23'h14a031}
    ; // @[Cat.scala 33:92]
  wire [9:0] wnList_res_re_rawIn_14_sExp = {1'b0,$signed(9'hfd)}; // @[rawFloatFromFN.scala 70:48]
  wire [32:0] _wnList_res_re_T_119 = {1'h0,wnList_res_re_rawIn_14_sExp[8:6],wnList_res_re_rawIn_14_sExp[5:0],23'h47c5c2}
    ; // @[Cat.scala 33:92]
  wire [9:0] wnList_res_re_rawIn_15_sExp = {1'b0,$signed(9'hfc)}; // @[rawFloatFromFN.scala 70:48]
  wire [32:0] _wnList_res_re_T_127 = {1'h0,wnList_res_re_rawIn_15_sExp[8:6],wnList_res_re_rawIn_15_sExp[5:0],23'h48bd36}
    ; // @[Cat.scala 33:92]
  wire [9:0] wnList_res_re_rawIn_16_sExp = {1'b0,$signed(9'hca)}; // @[rawFloatFromFN.scala 70:48]
  wire [32:0] _wnList_res_re_T_135 = {1'h0,wnList_res_re_rawIn_16_sExp[8:6],wnList_res_re_rawIn_16_sExp[5:0],23'hd3132}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_143 = {1'h1,wnList_res_re_rawIn_15_sExp[8:6],wnList_res_re_rawIn_15_sExp[5:0],23'h48bd36}
    ; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_151 = {1'h1,wnList_res_re_rawIn_14_sExp[8:6],wnList_res_re_rawIn_14_sExp[5:0],23'h47c5c2}
    ; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_159 = {1'h1,wnList_res_re_rawIn_11_sExp[8:6],wnList_res_re_rawIn_11_sExp[5:0],23'h14a031}
    ; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_167 = {1'h1,wnList_res_re_rawIn_11_sExp[8:6],wnList_res_re_rawIn_11_sExp[5:0],23'h43ef15}
    ; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_175 = {1'h1,wnList_res_re_rawIn_11_sExp[8:6],wnList_res_re_rawIn_11_sExp[5:0],23'h715aea}
    ; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_183 = {1'h1,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'he39da}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_191 = {1'h1,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h226799}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_199 = {1'h1,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h3504f3}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_207 = {1'h1,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h45e403}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_215 = {1'h1,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h54db31}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_223 = {1'h1,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h61c598}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_231 = {1'h1,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h6c835e}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_239 = {1'h1,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h74fa0b}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_247 = {1'h1,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h7b14be}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_re_T_255 = {1'h1,wnList_res_re_rawIn_1_sExp[8:6],wnList_res_re_rawIn_1_sExp[5:0],23'h7ec46d}; // @[Cat.scala 33:92]
  wire [32:0] _GEN_2 = 5'h1 == _wnList_T[4:0] ? _wnList_res_re_T_15 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_3 = 5'h2 == _wnList_T[4:0] ? _wnList_res_re_T_23 : _GEN_2; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_4 = 5'h3 == _wnList_T[4:0] ? _wnList_res_re_T_31 : _GEN_3; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_5 = 5'h4 == _wnList_T[4:0] ? _wnList_res_re_T_39 : _GEN_4; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_6 = 5'h5 == _wnList_T[4:0] ? _wnList_res_re_T_47 : _GEN_5; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_7 = 5'h6 == _wnList_T[4:0] ? _wnList_res_re_T_55 : _GEN_6; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_8 = 5'h7 == _wnList_T[4:0] ? _wnList_res_re_T_63 : _GEN_7; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_9 = 5'h8 == _wnList_T[4:0] ? _wnList_res_re_T_71 : _GEN_8; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_10 = 5'h9 == _wnList_T[4:0] ? _wnList_res_re_T_79 : _GEN_9; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_11 = 5'ha == _wnList_T[4:0] ? _wnList_res_re_T_87 : _GEN_10; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_12 = 5'hb == _wnList_T[4:0] ? _wnList_res_re_T_95 : _GEN_11; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_13 = 5'hc == _wnList_T[4:0] ? _wnList_res_re_T_103 : _GEN_12; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_14 = 5'hd == _wnList_T[4:0] ? _wnList_res_re_T_111 : _GEN_13; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_15 = 5'he == _wnList_T[4:0] ? _wnList_res_re_T_119 : _GEN_14; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_16 = 5'hf == _wnList_T[4:0] ? _wnList_res_re_T_127 : _GEN_15; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_17 = 5'h10 == _wnList_T[4:0] ? _wnList_res_re_T_135 : _GEN_16; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_18 = 5'h11 == _wnList_T[4:0] ? _wnList_res_re_T_143 : _GEN_17; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_19 = 5'h12 == _wnList_T[4:0] ? _wnList_res_re_T_151 : _GEN_18; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_20 = 5'h13 == _wnList_T[4:0] ? _wnList_res_re_T_159 : _GEN_19; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_21 = 5'h14 == _wnList_T[4:0] ? _wnList_res_re_T_167 : _GEN_20; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_22 = 5'h15 == _wnList_T[4:0] ? _wnList_res_re_T_175 : _GEN_21; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_23 = 5'h16 == _wnList_T[4:0] ? _wnList_res_re_T_183 : _GEN_22; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_24 = 5'h17 == _wnList_T[4:0] ? _wnList_res_re_T_191 : _GEN_23; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_25 = 5'h18 == _wnList_T[4:0] ? _wnList_res_re_T_199 : _GEN_24; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_26 = 5'h19 == _wnList_T[4:0] ? _wnList_res_re_T_207 : _GEN_25; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_27 = 5'h1a == _wnList_T[4:0] ? _wnList_res_re_T_215 : _GEN_26; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_28 = 5'h1b == _wnList_T[4:0] ? _wnList_res_re_T_223 : _GEN_27; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_29 = 5'h1c == _wnList_T[4:0] ? _wnList_res_re_T_231 : _GEN_28; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_30 = 5'h1d == _wnList_T[4:0] ? _wnList_res_re_T_239 : _GEN_29; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_31 = 5'h1e == _wnList_T[4:0] ? _wnList_res_re_T_247 : _GEN_30; // @[FFT.scala 104:{12,12}]
  wire [9:0] wnList_res_im_rawIn__sExp = {1'b0,$signed(9'h6b)}; // @[rawFloatFromFN.scala 70:48]
  wire [32:0] _wnList_res_im_T_7 = {4'h8,wnList_res_im_rawIn__sExp[5:0],23'h0}; // @[Cat.scala 33:92]
  wire [32:0] _wnList_res_im_T_135 = {1'h1,wnList_res_re_rawIn__sExp[8:6],wnList_res_re_rawIn__sExp[5:0],23'h0}; // @[Cat.scala 33:92]
  wire [32:0] _GEN_34 = 5'h1 == _wnList_T[4:0] ? _wnList_res_re_T_143 : _wnList_res_im_T_7; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_35 = 5'h2 == _wnList_T[4:0] ? _wnList_res_re_T_151 : _GEN_34; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_36 = 5'h3 == _wnList_T[4:0] ? _wnList_res_re_T_159 : _GEN_35; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_37 = 5'h4 == _wnList_T[4:0] ? _wnList_res_re_T_167 : _GEN_36; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_38 = 5'h5 == _wnList_T[4:0] ? _wnList_res_re_T_175 : _GEN_37; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_39 = 5'h6 == _wnList_T[4:0] ? _wnList_res_re_T_183 : _GEN_38; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_40 = 5'h7 == _wnList_T[4:0] ? _wnList_res_re_T_191 : _GEN_39; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_41 = 5'h8 == _wnList_T[4:0] ? _wnList_res_re_T_199 : _GEN_40; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_42 = 5'h9 == _wnList_T[4:0] ? _wnList_res_re_T_207 : _GEN_41; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_43 = 5'ha == _wnList_T[4:0] ? _wnList_res_re_T_215 : _GEN_42; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_44 = 5'hb == _wnList_T[4:0] ? _wnList_res_re_T_223 : _GEN_43; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_45 = 5'hc == _wnList_T[4:0] ? _wnList_res_re_T_231 : _GEN_44; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_46 = 5'hd == _wnList_T[4:0] ? _wnList_res_re_T_239 : _GEN_45; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_47 = 5'he == _wnList_T[4:0] ? _wnList_res_re_T_247 : _GEN_46; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_48 = 5'hf == _wnList_T[4:0] ? _wnList_res_re_T_255 : _GEN_47; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_49 = 5'h10 == _wnList_T[4:0] ? _wnList_res_im_T_135 : _GEN_48; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_50 = 5'h11 == _wnList_T[4:0] ? _wnList_res_re_T_255 : _GEN_49; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_51 = 5'h12 == _wnList_T[4:0] ? _wnList_res_re_T_247 : _GEN_50; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_52 = 5'h13 == _wnList_T[4:0] ? _wnList_res_re_T_239 : _GEN_51; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_53 = 5'h14 == _wnList_T[4:0] ? _wnList_res_re_T_231 : _GEN_52; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_54 = 5'h15 == _wnList_T[4:0] ? _wnList_res_re_T_223 : _GEN_53; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_55 = 5'h16 == _wnList_T[4:0] ? _wnList_res_re_T_215 : _GEN_54; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_56 = 5'h17 == _wnList_T[4:0] ? _wnList_res_re_T_207 : _GEN_55; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_57 = 5'h18 == _wnList_T[4:0] ? _wnList_res_re_T_199 : _GEN_56; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_58 = 5'h19 == _wnList_T[4:0] ? _wnList_res_re_T_191 : _GEN_57; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_59 = 5'h1a == _wnList_T[4:0] ? _wnList_res_re_T_183 : _GEN_58; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_60 = 5'h1b == _wnList_T[4:0] ? _wnList_res_re_T_175 : _GEN_59; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_61 = 5'h1c == _wnList_T[4:0] ? _wnList_res_re_T_167 : _GEN_60; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_62 = 5'h1d == _wnList_T[4:0] ? _wnList_res_re_T_159 : _GEN_61; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_63 = 5'h1e == _wnList_T[4:0] ? _wnList_res_re_T_151 : _GEN_62; // @[FFT.scala 105:{12,12}]
  wire [5:0] _wnList_T_3 = 6'h10 + cnt_0; // @[FFT.scala 135:96]
  wire [32:0] _GEN_66 = 5'h1 == _wnList_T_3[4:0] ? _wnList_res_re_T_15 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_67 = 5'h2 == _wnList_T_3[4:0] ? _wnList_res_re_T_23 : _GEN_66; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_68 = 5'h3 == _wnList_T_3[4:0] ? _wnList_res_re_T_31 : _GEN_67; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_69 = 5'h4 == _wnList_T_3[4:0] ? _wnList_res_re_T_39 : _GEN_68; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_70 = 5'h5 == _wnList_T_3[4:0] ? _wnList_res_re_T_47 : _GEN_69; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_71 = 5'h6 == _wnList_T_3[4:0] ? _wnList_res_re_T_55 : _GEN_70; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_72 = 5'h7 == _wnList_T_3[4:0] ? _wnList_res_re_T_63 : _GEN_71; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_73 = 5'h8 == _wnList_T_3[4:0] ? _wnList_res_re_T_71 : _GEN_72; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_74 = 5'h9 == _wnList_T_3[4:0] ? _wnList_res_re_T_79 : _GEN_73; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_75 = 5'ha == _wnList_T_3[4:0] ? _wnList_res_re_T_87 : _GEN_74; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_76 = 5'hb == _wnList_T_3[4:0] ? _wnList_res_re_T_95 : _GEN_75; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_77 = 5'hc == _wnList_T_3[4:0] ? _wnList_res_re_T_103 : _GEN_76; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_78 = 5'hd == _wnList_T_3[4:0] ? _wnList_res_re_T_111 : _GEN_77; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_79 = 5'he == _wnList_T_3[4:0] ? _wnList_res_re_T_119 : _GEN_78; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_80 = 5'hf == _wnList_T_3[4:0] ? _wnList_res_re_T_127 : _GEN_79; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_81 = 5'h10 == _wnList_T_3[4:0] ? _wnList_res_re_T_135 : _GEN_80; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_82 = 5'h11 == _wnList_T_3[4:0] ? _wnList_res_re_T_143 : _GEN_81; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_83 = 5'h12 == _wnList_T_3[4:0] ? _wnList_res_re_T_151 : _GEN_82; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_84 = 5'h13 == _wnList_T_3[4:0] ? _wnList_res_re_T_159 : _GEN_83; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_85 = 5'h14 == _wnList_T_3[4:0] ? _wnList_res_re_T_167 : _GEN_84; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_86 = 5'h15 == _wnList_T_3[4:0] ? _wnList_res_re_T_175 : _GEN_85; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_87 = 5'h16 == _wnList_T_3[4:0] ? _wnList_res_re_T_183 : _GEN_86; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_88 = 5'h17 == _wnList_T_3[4:0] ? _wnList_res_re_T_191 : _GEN_87; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_89 = 5'h18 == _wnList_T_3[4:0] ? _wnList_res_re_T_199 : _GEN_88; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_90 = 5'h19 == _wnList_T_3[4:0] ? _wnList_res_re_T_207 : _GEN_89; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_91 = 5'h1a == _wnList_T_3[4:0] ? _wnList_res_re_T_215 : _GEN_90; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_92 = 5'h1b == _wnList_T_3[4:0] ? _wnList_res_re_T_223 : _GEN_91; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_93 = 5'h1c == _wnList_T_3[4:0] ? _wnList_res_re_T_231 : _GEN_92; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_94 = 5'h1d == _wnList_T_3[4:0] ? _wnList_res_re_T_239 : _GEN_93; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_95 = 5'h1e == _wnList_T_3[4:0] ? _wnList_res_re_T_247 : _GEN_94; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_98 = 5'h1 == _wnList_T_3[4:0] ? _wnList_res_re_T_143 : _wnList_res_im_T_7; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_99 = 5'h2 == _wnList_T_3[4:0] ? _wnList_res_re_T_151 : _GEN_98; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_100 = 5'h3 == _wnList_T_3[4:0] ? _wnList_res_re_T_159 : _GEN_99; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_101 = 5'h4 == _wnList_T_3[4:0] ? _wnList_res_re_T_167 : _GEN_100; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_102 = 5'h5 == _wnList_T_3[4:0] ? _wnList_res_re_T_175 : _GEN_101; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_103 = 5'h6 == _wnList_T_3[4:0] ? _wnList_res_re_T_183 : _GEN_102; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_104 = 5'h7 == _wnList_T_3[4:0] ? _wnList_res_re_T_191 : _GEN_103; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_105 = 5'h8 == _wnList_T_3[4:0] ? _wnList_res_re_T_199 : _GEN_104; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_106 = 5'h9 == _wnList_T_3[4:0] ? _wnList_res_re_T_207 : _GEN_105; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_107 = 5'ha == _wnList_T_3[4:0] ? _wnList_res_re_T_215 : _GEN_106; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_108 = 5'hb == _wnList_T_3[4:0] ? _wnList_res_re_T_223 : _GEN_107; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_109 = 5'hc == _wnList_T_3[4:0] ? _wnList_res_re_T_231 : _GEN_108; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_110 = 5'hd == _wnList_T_3[4:0] ? _wnList_res_re_T_239 : _GEN_109; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_111 = 5'he == _wnList_T_3[4:0] ? _wnList_res_re_T_247 : _GEN_110; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_112 = 5'hf == _wnList_T_3[4:0] ? _wnList_res_re_T_255 : _GEN_111; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_113 = 5'h10 == _wnList_T_3[4:0] ? _wnList_res_im_T_135 : _GEN_112; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_114 = 5'h11 == _wnList_T_3[4:0] ? _wnList_res_re_T_255 : _GEN_113; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_115 = 5'h12 == _wnList_T_3[4:0] ? _wnList_res_re_T_247 : _GEN_114; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_116 = 5'h13 == _wnList_T_3[4:0] ? _wnList_res_re_T_239 : _GEN_115; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_117 = 5'h14 == _wnList_T_3[4:0] ? _wnList_res_re_T_231 : _GEN_116; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_118 = 5'h15 == _wnList_T_3[4:0] ? _wnList_res_re_T_223 : _GEN_117; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_119 = 5'h16 == _wnList_T_3[4:0] ? _wnList_res_re_T_215 : _GEN_118; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_120 = 5'h17 == _wnList_T_3[4:0] ? _wnList_res_re_T_207 : _GEN_119; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_121 = 5'h18 == _wnList_T_3[4:0] ? _wnList_res_re_T_199 : _GEN_120; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_122 = 5'h19 == _wnList_T_3[4:0] ? _wnList_res_re_T_191 : _GEN_121; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_123 = 5'h1a == _wnList_T_3[4:0] ? _wnList_res_re_T_183 : _GEN_122; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_124 = 5'h1b == _wnList_T_3[4:0] ? _wnList_res_re_T_175 : _GEN_123; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_125 = 5'h1c == _wnList_T_3[4:0] ? _wnList_res_re_T_167 : _GEN_124; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_126 = 5'h1d == _wnList_T_3[4:0] ? _wnList_res_re_T_159 : _GEN_125; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_127 = 5'h1e == _wnList_T_3[4:0] ? _wnList_res_re_T_151 : _GEN_126; // @[FFT.scala 105:{12,12}]
  wire [3:0] wnCtrl = cnt_1[3:0]; // @[FFT.scala 131:23]
  wire [4:0] _wnList_T_4 = {{1'd0}, wnCtrl}; // @[FFT.scala 135:96]
  wire [32:0] _GEN_130 = 4'h1 == _wnList_T_4[3:0] ? _wnList_res_re_T_23 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_131 = 4'h2 == _wnList_T_4[3:0] ? _wnList_res_re_T_39 : _GEN_130; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_132 = 4'h3 == _wnList_T_4[3:0] ? _wnList_res_re_T_55 : _GEN_131; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_133 = 4'h4 == _wnList_T_4[3:0] ? _wnList_res_re_T_71 : _GEN_132; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_134 = 4'h5 == _wnList_T_4[3:0] ? _wnList_res_re_T_87 : _GEN_133; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_135 = 4'h6 == _wnList_T_4[3:0] ? _wnList_res_re_T_103 : _GEN_134; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_136 = 4'h7 == _wnList_T_4[3:0] ? _wnList_res_re_T_119 : _GEN_135; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_137 = 4'h8 == _wnList_T_4[3:0] ? _wnList_res_re_T_135 : _GEN_136; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_138 = 4'h9 == _wnList_T_4[3:0] ? _wnList_res_re_T_151 : _GEN_137; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_139 = 4'ha == _wnList_T_4[3:0] ? _wnList_res_re_T_167 : _GEN_138; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_140 = 4'hb == _wnList_T_4[3:0] ? _wnList_res_re_T_183 : _GEN_139; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_141 = 4'hc == _wnList_T_4[3:0] ? _wnList_res_re_T_199 : _GEN_140; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_142 = 4'hd == _wnList_T_4[3:0] ? _wnList_res_re_T_215 : _GEN_141; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_143 = 4'he == _wnList_T_4[3:0] ? _wnList_res_re_T_231 : _GEN_142; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_146 = 4'h1 == _wnList_T_4[3:0] ? _wnList_res_re_T_151 : _wnList_res_im_T_7; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_147 = 4'h2 == _wnList_T_4[3:0] ? _wnList_res_re_T_167 : _GEN_146; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_148 = 4'h3 == _wnList_T_4[3:0] ? _wnList_res_re_T_183 : _GEN_147; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_149 = 4'h4 == _wnList_T_4[3:0] ? _wnList_res_re_T_199 : _GEN_148; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_150 = 4'h5 == _wnList_T_4[3:0] ? _wnList_res_re_T_215 : _GEN_149; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_151 = 4'h6 == _wnList_T_4[3:0] ? _wnList_res_re_T_231 : _GEN_150; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_152 = 4'h7 == _wnList_T_4[3:0] ? _wnList_res_re_T_247 : _GEN_151; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_153 = 4'h8 == _wnList_T_4[3:0] ? _wnList_res_im_T_135 : _GEN_152; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_154 = 4'h9 == _wnList_T_4[3:0] ? _wnList_res_re_T_247 : _GEN_153; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_155 = 4'ha == _wnList_T_4[3:0] ? _wnList_res_re_T_231 : _GEN_154; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_156 = 4'hb == _wnList_T_4[3:0] ? _wnList_res_re_T_215 : _GEN_155; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_157 = 4'hc == _wnList_T_4[3:0] ? _wnList_res_re_T_199 : _GEN_156; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_158 = 4'hd == _wnList_T_4[3:0] ? _wnList_res_re_T_183 : _GEN_157; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_159 = 4'he == _wnList_T_4[3:0] ? _wnList_res_re_T_167 : _GEN_158; // @[FFT.scala 105:{12,12}]
  wire [2:0] wnCtrl_1 = cnt_1[2:0]; // @[FFT.scala 131:23]
  wire [3:0] _wnList_T_8 = {{1'd0}, wnCtrl_1}; // @[FFT.scala 135:96]
  wire [32:0] _GEN_194 = 3'h1 == _wnList_T_8[2:0] ? _wnList_res_re_T_39 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_195 = 3'h2 == _wnList_T_8[2:0] ? _wnList_res_re_T_71 : _GEN_194; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_196 = 3'h3 == _wnList_T_8[2:0] ? _wnList_res_re_T_103 : _GEN_195; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_197 = 3'h4 == _wnList_T_8[2:0] ? _wnList_res_re_T_135 : _GEN_196; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_198 = 3'h5 == _wnList_T_8[2:0] ? _wnList_res_re_T_167 : _GEN_197; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_199 = 3'h6 == _wnList_T_8[2:0] ? _wnList_res_re_T_199 : _GEN_198; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_202 = 3'h1 == _wnList_T_8[2:0] ? _wnList_res_re_T_167 : _wnList_res_im_T_7; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_203 = 3'h2 == _wnList_T_8[2:0] ? _wnList_res_re_T_199 : _GEN_202; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_204 = 3'h3 == _wnList_T_8[2:0] ? _wnList_res_re_T_231 : _GEN_203; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_205 = 3'h4 == _wnList_T_8[2:0] ? _wnList_res_im_T_135 : _GEN_204; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_206 = 3'h5 == _wnList_T_8[2:0] ? _wnList_res_re_T_231 : _GEN_205; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_207 = 3'h6 == _wnList_T_8[2:0] ? _wnList_res_re_T_199 : _GEN_206; // @[FFT.scala 105:{12,12}]
  wire [1:0] wnCtrl_2 = cnt_1[1:0]; // @[FFT.scala 131:23]
  wire [2:0] _wnList_T_12 = {{1'd0}, wnCtrl_2}; // @[FFT.scala 135:96]
  wire [32:0] _GEN_226 = 2'h1 == _wnList_T_12[1:0] ? _wnList_res_re_T_71 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_227 = 2'h2 == _wnList_T_12[1:0] ? _wnList_res_re_T_135 : _GEN_226; // @[FFT.scala 104:{12,12}]
  wire [32:0] _GEN_230 = 2'h1 == _wnList_T_12[1:0] ? _wnList_res_re_T_199 : _wnList_res_im_T_7; // @[FFT.scala 105:{12,12}]
  wire [32:0] _GEN_231 = 2'h2 == _wnList_T_12[1:0] ? _wnList_res_im_T_135 : _GEN_230; // @[FFT.scala 105:{12,12}]
  wire  wnCtrl_3 = cnt_1[0]; // @[FFT.scala 131:23]
  wire [1:0] _wnList_T_16 = {{1'd0}, wnCtrl_3}; // @[FFT.scala 135:96]
  reg [32:0] REG__0_re; // @[FFT.scala 157:67]
  reg [32:0] REG__0_im; // @[FFT.scala 157:67]
  reg [32:0] REG__1_re; // @[FFT.scala 157:67]
  reg [32:0] REG__1_im; // @[FFT.scala 157:67]
  reg [32:0] REG_1_0_re; // @[FFT.scala 157:67]
  reg [32:0] REG_1_0_im; // @[FFT.scala 157:67]
  reg [32:0] REG_1_1_re; // @[FFT.scala 157:67]
  reg [32:0] REG_1_1_im; // @[FFT.scala 157:67]
  wire [63:0] _T_1 = {io_dIn_0_re,io_dIn_0_im}; // @[FFT.scala 170:91]
  wire [63:0] _T_4 = {io_dIn_1_re,io_dIn_1_im}; // @[FFT.scala 170:91]
  wire [63:0] _T_7 = {io_dIn_2_re,io_dIn_2_im}; // @[FFT.scala 170:91]
  wire [63:0] _T_10 = {io_dIn_3_re,io_dIn_3_im}; // @[FFT.scala 170:91]
  wire [32:0] datao_0_re = dataotemp_inst_io_out_0_re; // @[FFT.scala 124:22 141:9]
  wire [32:0] datao_0_im = dataotemp_inst_io_out_0_im; // @[FFT.scala 124:22 141:9]
  wire [65:0] _T_13 = {datao_0_re,datao_0_im}; // @[FFT.scala 181:96]
  reg [31:0] REG_2_re; // @[FFT.scala 181:64]
  reg [31:0] REG_2_im; // @[FFT.scala 181:64]
  wire [32:0] datao_1_re = dataotemp_inst_io_out_1_re; // @[FFT.scala 124:22 141:9]
  wire [32:0] datao_1_im = dataotemp_inst_io_out_1_im; // @[FFT.scala 124:22 141:9]
  wire [65:0] _T_16 = {datao_1_re,datao_1_im}; // @[FFT.scala 181:96]
  reg [31:0] REG_3_re; // @[FFT.scala 181:64]
  reg [31:0] REG_3_im; // @[FFT.scala 181:64]
  wire [32:0] datao_2_re = dataotemp_inst_1_io_out_0_re; // @[FFT.scala 124:22 141:9]
  wire [32:0] datao_2_im = dataotemp_inst_1_io_out_0_im; // @[FFT.scala 124:22 141:9]
  wire [65:0] _T_19 = {datao_2_re,datao_2_im}; // @[FFT.scala 181:96]
  reg [31:0] REG_4_re; // @[FFT.scala 181:64]
  reg [31:0] REG_4_im; // @[FFT.scala 181:64]
  wire [32:0] datao_3_re = dataotemp_inst_1_io_out_1_re; // @[FFT.scala 124:22 141:9]
  wire [32:0] datao_3_im = dataotemp_inst_1_io_out_1_im; // @[FFT.scala 124:22 141:9]
  wire [65:0] _T_22 = {datao_3_re,datao_3_im}; // @[FFT.scala 181:96]
  reg [31:0] REG_5_re; // @[FFT.scala 181:64]
  reg [31:0] REG_5_im; // @[FFT.scala 181:64]
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
  ButterflyMul inst_1 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_1_io_in_0_re),
    .io_in_0_im(inst_1_io_in_0_im),
    .io_in_1_re(inst_1_io_in_1_re),
    .io_in_1_im(inst_1_io_in_1_im),
    .io_out_0_re(inst_1_io_out_0_re),
    .io_out_0_im(inst_1_io_out_0_im),
    .io_out_1_re(inst_1_io_out_1_re),
    .io_out_1_im(inst_1_io_out_1_im),
    .io_wn_0_re(inst_1_io_wn_0_re),
    .io_wn_0_im(inst_1_io_wn_0_im)
  );
  ButterflyMul inst_2 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_2_io_in_0_re),
    .io_in_0_im(inst_2_io_in_0_im),
    .io_in_1_re(inst_2_io_in_1_re),
    .io_in_1_im(inst_2_io_in_1_im),
    .io_out_0_re(inst_2_io_out_0_re),
    .io_out_0_im(inst_2_io_out_0_im),
    .io_out_1_re(inst_2_io_out_1_re),
    .io_out_1_im(inst_2_io_out_1_im),
    .io_wn_0_re(inst_2_io_wn_0_re),
    .io_wn_0_im(inst_2_io_wn_0_im)
  );
  ButterflyMul inst_3 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_3_io_in_0_re),
    .io_in_0_im(inst_3_io_in_0_im),
    .io_in_1_re(inst_3_io_in_1_re),
    .io_in_1_im(inst_3_io_in_1_im),
    .io_out_0_re(inst_3_io_out_0_re),
    .io_out_0_im(inst_3_io_out_0_im),
    .io_out_1_re(inst_3_io_out_1_re),
    .io_out_1_im(inst_3_io_out_1_im),
    .io_wn_0_re(inst_3_io_wn_0_re),
    .io_wn_0_im(inst_3_io_wn_0_im)
  );
  ButterflyMul inst_4 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_4_io_in_0_re),
    .io_in_0_im(inst_4_io_in_0_im),
    .io_in_1_re(inst_4_io_in_1_re),
    .io_in_1_im(inst_4_io_in_1_im),
    .io_out_0_re(inst_4_io_out_0_re),
    .io_out_0_im(inst_4_io_out_0_im),
    .io_out_1_re(inst_4_io_out_1_re),
    .io_out_1_im(inst_4_io_out_1_im),
    .io_wn_0_re(inst_4_io_wn_0_re),
    .io_wn_0_im(inst_4_io_wn_0_im)
  );
  ButterflyMul inst_5 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_5_io_in_0_re),
    .io_in_0_im(inst_5_io_in_0_im),
    .io_in_1_re(inst_5_io_in_1_re),
    .io_in_1_im(inst_5_io_in_1_im),
    .io_out_0_re(inst_5_io_out_0_re),
    .io_out_0_im(inst_5_io_out_0_im),
    .io_out_1_re(inst_5_io_out_1_re),
    .io_out_1_im(inst_5_io_out_1_im),
    .io_wn_0_re(inst_5_io_wn_0_re),
    .io_wn_0_im(inst_5_io_wn_0_im)
  );
  ButterflyMul inst_6 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_6_io_in_0_re),
    .io_in_0_im(inst_6_io_in_0_im),
    .io_in_1_re(inst_6_io_in_1_re),
    .io_in_1_im(inst_6_io_in_1_im),
    .io_out_0_re(inst_6_io_out_0_re),
    .io_out_0_im(inst_6_io_out_0_im),
    .io_out_1_re(inst_6_io_out_1_re),
    .io_out_1_im(inst_6_io_out_1_im),
    .io_wn_0_re(inst_6_io_wn_0_re),
    .io_wn_0_im(inst_6_io_wn_0_im)
  );
  ButterflyMul inst_7 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_7_io_in_0_re),
    .io_in_0_im(inst_7_io_in_0_im),
    .io_in_1_re(inst_7_io_in_1_re),
    .io_in_1_im(inst_7_io_in_1_im),
    .io_out_0_re(inst_7_io_out_0_re),
    .io_out_0_im(inst_7_io_out_0_im),
    .io_out_1_re(inst_7_io_out_1_re),
    .io_out_1_im(inst_7_io_out_1_im),
    .io_wn_0_re(inst_7_io_wn_0_re),
    .io_wn_0_im(inst_7_io_wn_0_im)
  );
  ButterflyMul inst_8 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_8_io_in_0_re),
    .io_in_0_im(inst_8_io_in_0_im),
    .io_in_1_re(inst_8_io_in_1_re),
    .io_in_1_im(inst_8_io_in_1_im),
    .io_out_0_re(inst_8_io_out_0_re),
    .io_out_0_im(inst_8_io_out_0_im),
    .io_out_1_re(inst_8_io_out_1_re),
    .io_out_1_im(inst_8_io_out_1_im),
    .io_wn_0_re(inst_8_io_wn_0_re),
    .io_wn_0_im(inst_8_io_wn_0_im)
  );
  ButterflyMul inst_9 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_9_io_in_0_re),
    .io_in_0_im(inst_9_io_in_0_im),
    .io_in_1_re(inst_9_io_in_1_re),
    .io_in_1_im(inst_9_io_in_1_im),
    .io_out_0_re(inst_9_io_out_0_re),
    .io_out_0_im(inst_9_io_out_0_im),
    .io_out_1_re(inst_9_io_out_1_re),
    .io_out_1_im(inst_9_io_out_1_im),
    .io_wn_0_re(inst_9_io_wn_0_re),
    .io_wn_0_im(inst_9_io_wn_0_im)
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
  ButterflyAdd dataotemp_inst_1 ( // @[Modules.scala 213:22]
    .io_in_0_re(dataotemp_inst_1_io_in_0_re),
    .io_in_0_im(dataotemp_inst_1_io_in_0_im),
    .io_in_1_re(dataotemp_inst_1_io_in_1_re),
    .io_in_1_im(dataotemp_inst_1_io_in_1_im),
    .io_out_0_re(dataotemp_inst_1_io_out_0_re),
    .io_out_0_im(dataotemp_inst_1_io_out_0_im),
    .io_out_1_re(dataotemp_inst_1_io_out_1_re),
    .io_out_1_im(dataotemp_inst_1_io_out_1_im)
  );
  Exchange exdata_inst ( // @[Modules.scala 331:22]
    .io_in_0_0_re(exdata_inst_io_in_0_0_re),
    .io_in_0_0_im(exdata_inst_io_in_0_0_im),
    .io_in_0_1_re(exdata_inst_io_in_0_1_re),
    .io_in_0_1_im(exdata_inst_io_in_0_1_im),
    .io_in_1_0_re(exdata_inst_io_in_1_0_re),
    .io_in_1_0_im(exdata_inst_io_in_1_0_im),
    .io_in_1_1_re(exdata_inst_io_in_1_1_re),
    .io_in_1_1_im(exdata_inst_io_in_1_1_im),
    .io_out_0_0_re(exdata_inst_io_out_0_0_re),
    .io_out_0_0_im(exdata_inst_io_out_0_0_im),
    .io_out_0_1_re(exdata_inst_io_out_0_1_re),
    .io_out_0_1_im(exdata_inst_io_out_0_1_im),
    .io_out_1_0_re(exdata_inst_io_out_1_0_re),
    .io_out_1_0_im(exdata_inst_io_out_1_0_im),
    .io_out_1_1_re(exdata_inst_io_out_1_1_re),
    .io_out_1_1_im(exdata_inst_io_out_1_1_im)
  );
  Switch inst_10 ( // @[Modules.scala 311:22]
    .clock(inst_10_clock),
    .io_in_0_re(inst_10_io_in_0_re),
    .io_in_0_im(inst_10_io_in_0_im),
    .io_in_1_re(inst_10_io_in_1_re),
    .io_in_1_im(inst_10_io_in_1_im),
    .io_out_0_re(inst_10_io_out_0_re),
    .io_out_0_im(inst_10_io_out_0_im),
    .io_out_1_re(inst_10_io_out_1_re),
    .io_out_1_im(inst_10_io_out_1_im),
    .io_sel(inst_10_io_sel)
  );
  Switch inst_11 ( // @[Modules.scala 311:22]
    .clock(inst_11_clock),
    .io_in_0_re(inst_11_io_in_0_re),
    .io_in_0_im(inst_11_io_in_0_im),
    .io_in_1_re(inst_11_io_in_1_re),
    .io_in_1_im(inst_11_io_in_1_im),
    .io_out_0_re(inst_11_io_out_0_re),
    .io_out_0_im(inst_11_io_out_0_im),
    .io_out_1_re(inst_11_io_out_1_re),
    .io_out_1_im(inst_11_io_out_1_im),
    .io_sel(inst_11_io_sel)
  );
  Switch_2 inst_12 ( // @[Modules.scala 311:22]
    .clock(inst_12_clock),
    .io_in_0_re(inst_12_io_in_0_re),
    .io_in_0_im(inst_12_io_in_0_im),
    .io_in_1_re(inst_12_io_in_1_re),
    .io_in_1_im(inst_12_io_in_1_im),
    .io_out_0_re(inst_12_io_out_0_re),
    .io_out_0_im(inst_12_io_out_0_im),
    .io_out_1_re(inst_12_io_out_1_re),
    .io_out_1_im(inst_12_io_out_1_im),
    .io_sel(inst_12_io_sel)
  );
  Switch_2 inst_13 ( // @[Modules.scala 311:22]
    .clock(inst_13_clock),
    .io_in_0_re(inst_13_io_in_0_re),
    .io_in_0_im(inst_13_io_in_0_im),
    .io_in_1_re(inst_13_io_in_1_re),
    .io_in_1_im(inst_13_io_in_1_im),
    .io_out_0_re(inst_13_io_out_0_re),
    .io_out_0_im(inst_13_io_out_0_im),
    .io_out_1_re(inst_13_io_out_1_re),
    .io_out_1_im(inst_13_io_out_1_im),
    .io_sel(inst_13_io_sel)
  );
  Switch_4 inst_14 ( // @[Modules.scala 311:22]
    .clock(inst_14_clock),
    .io_in_0_re(inst_14_io_in_0_re),
    .io_in_0_im(inst_14_io_in_0_im),
    .io_in_1_re(inst_14_io_in_1_re),
    .io_in_1_im(inst_14_io_in_1_im),
    .io_out_0_re(inst_14_io_out_0_re),
    .io_out_0_im(inst_14_io_out_0_im),
    .io_out_1_re(inst_14_io_out_1_re),
    .io_out_1_im(inst_14_io_out_1_im),
    .io_sel(inst_14_io_sel)
  );
  Switch_4 inst_15 ( // @[Modules.scala 311:22]
    .clock(inst_15_clock),
    .io_in_0_re(inst_15_io_in_0_re),
    .io_in_0_im(inst_15_io_in_0_im),
    .io_in_1_re(inst_15_io_in_1_re),
    .io_in_1_im(inst_15_io_in_1_im),
    .io_out_0_re(inst_15_io_out_0_re),
    .io_out_0_im(inst_15_io_out_0_im),
    .io_out_1_re(inst_15_io_out_1_re),
    .io_out_1_im(inst_15_io_out_1_im),
    .io_sel(inst_15_io_sel)
  );
  Switch_6 inst_16 ( // @[Modules.scala 311:22]
    .clock(inst_16_clock),
    .io_in_0_re(inst_16_io_in_0_re),
    .io_in_0_im(inst_16_io_in_0_im),
    .io_in_1_re(inst_16_io_in_1_re),
    .io_in_1_im(inst_16_io_in_1_im),
    .io_out_0_re(inst_16_io_out_0_re),
    .io_out_0_im(inst_16_io_out_0_im),
    .io_out_1_re(inst_16_io_out_1_re),
    .io_out_1_im(inst_16_io_out_1_im),
    .io_sel(inst_16_io_sel)
  );
  Switch_6 inst_17 ( // @[Modules.scala 311:22]
    .clock(inst_17_clock),
    .io_in_0_re(inst_17_io_in_0_re),
    .io_in_0_im(inst_17_io_in_0_im),
    .io_in_1_re(inst_17_io_in_1_re),
    .io_in_1_im(inst_17_io_in_1_im),
    .io_out_0_re(inst_17_io_out_0_re),
    .io_out_0_im(inst_17_io_out_0_im),
    .io_out_1_re(inst_17_io_out_1_re),
    .io_out_1_im(inst_17_io_out_1_im),
    .io_sel(inst_17_io_sel)
  );
  ComplexRecode inst_18 ( // @[Modules.scala 40:22]
    .io_in_re(inst_18_io_in_re),
    .io_in_im(inst_18_io_in_im),
    .io_out_re(inst_18_io_out_re),
    .io_out_im(inst_18_io_out_im)
  );
  ComplexRecode inst_19 ( // @[Modules.scala 40:22]
    .io_in_re(inst_19_io_in_re),
    .io_in_im(inst_19_io_in_im),
    .io_out_re(inst_19_io_out_re),
    .io_out_im(inst_19_io_out_im)
  );
  ComplexRecode inst_20 ( // @[Modules.scala 40:22]
    .io_in_re(inst_20_io_in_re),
    .io_in_im(inst_20_io_in_im),
    .io_out_re(inst_20_io_out_re),
    .io_out_im(inst_20_io_out_im)
  );
  ComplexRecode inst_21 ( // @[Modules.scala 40:22]
    .io_in_re(inst_21_io_in_re),
    .io_in_im(inst_21_io_in_im),
    .io_out_re(inst_21_io_out_re),
    .io_out_im(inst_21_io_out_im)
  );
  ComplexDecode inst_22 ( // @[Modules.scala 56:22]
    .io_in_re(inst_22_io_in_re),
    .io_in_im(inst_22_io_in_im),
    .io_out_re(inst_22_io_out_re),
    .io_out_im(inst_22_io_out_im)
  );
  ComplexDecode inst_23 ( // @[Modules.scala 56:22]
    .io_in_re(inst_23_io_in_re),
    .io_in_im(inst_23_io_in_im),
    .io_out_re(inst_23_io_out_re),
    .io_out_im(inst_23_io_out_im)
  );
  ComplexDecode inst_24 ( // @[Modules.scala 56:22]
    .io_in_re(inst_24_io_in_re),
    .io_in_im(inst_24_io_in_im),
    .io_out_re(inst_24_io_out_re),
    .io_out_im(inst_24_io_out_im)
  );
  ComplexDecode inst_25 ( // @[Modules.scala 56:22]
    .io_in_re(inst_25_io_in_re),
    .io_in_im(inst_25_io_in_im),
    .io_out_re(inst_25_io_out_re),
    .io_out_im(inst_25_io_out_im)
  );
  assign io_dOut_0_re = REG_2_re; // @[FFT.scala 181:13]
  assign io_dOut_0_im = REG_2_im; // @[FFT.scala 181:13]
  assign io_dOut_1_re = REG_3_re; // @[FFT.scala 181:13]
  assign io_dOut_1_im = REG_3_im; // @[FFT.scala 181:13]
  assign io_dOut_2_re = REG_4_re; // @[FFT.scala 181:13]
  assign io_dOut_2_im = REG_4_im; // @[FFT.scala 181:13]
  assign io_dOut_3_re = REG_5_re; // @[FFT.scala 181:13]
  assign io_dOut_3_im = REG_5_im; // @[FFT.scala 181:13]
  assign io_busy = cnt_0 != 6'h0; // @[FFT.scala 114:21]
  assign inst_io_in_0_re = inst_18_io_out_re; // @[FFT.scala 122:65 170:19]
  assign inst_io_in_0_im = inst_18_io_out_im; // @[FFT.scala 122:65 170:19]
  assign inst_io_in_1_re = inst_19_io_out_re; // @[FFT.scala 122:65 170:19]
  assign inst_io_in_1_im = inst_19_io_out_im; // @[FFT.scala 122:65 170:19]
  assign inst_io_wn_0_re = 5'h1f == _wnList_T[4:0] ? _wnList_res_re_T_255 : _GEN_31; // @[FFT.scala 104:{12,12}]
  assign inst_io_wn_0_im = 5'h1f == _wnList_T[4:0] ? _wnList_res_re_T_143 : _GEN_63; // @[FFT.scala 105:{12,12}]
  assign inst_1_io_in_0_re = inst_20_io_out_re; // @[FFT.scala 122:65 170:19]
  assign inst_1_io_in_0_im = inst_20_io_out_im; // @[FFT.scala 122:65 170:19]
  assign inst_1_io_in_1_re = inst_21_io_out_re; // @[FFT.scala 122:65 170:19]
  assign inst_1_io_in_1_im = inst_21_io_out_im; // @[FFT.scala 122:65 170:19]
  assign inst_1_io_wn_0_re = 5'h1f == _wnList_T_3[4:0] ? _wnList_res_re_T_255 : _GEN_95; // @[FFT.scala 104:{12,12}]
  assign inst_1_io_wn_0_im = 5'h1f == _wnList_T_3[4:0] ? _wnList_res_re_T_143 : _GEN_127; // @[FFT.scala 105:{12,12}]
  assign inst_2_io_in_0_re = REG__0_re; // @[FFT.scala 122:65 157:57]
  assign inst_2_io_in_0_im = REG__0_im; // @[FFT.scala 122:65 157:57]
  assign inst_2_io_in_1_re = REG__1_re; // @[FFT.scala 122:65 157:57]
  assign inst_2_io_in_1_im = REG__1_im; // @[FFT.scala 122:65 157:57]
  assign inst_2_io_wn_0_re = 4'hf == _wnList_T_4[3:0] ? _wnList_res_re_T_247 : _GEN_143; // @[FFT.scala 104:{12,12}]
  assign inst_2_io_wn_0_im = 4'hf == _wnList_T_4[3:0] ? _wnList_res_re_T_151 : _GEN_159; // @[FFT.scala 105:{12,12}]
  assign inst_3_io_in_0_re = REG_1_0_re; // @[FFT.scala 122:65 157:57]
  assign inst_3_io_in_0_im = REG_1_0_im; // @[FFT.scala 122:65 157:57]
  assign inst_3_io_in_1_re = REG_1_1_re; // @[FFT.scala 122:65 157:57]
  assign inst_3_io_in_1_im = REG_1_1_im; // @[FFT.scala 122:65 157:57]
  assign inst_3_io_wn_0_re = 4'hf == _wnList_T_4[3:0] ? _wnList_res_re_T_247 : _GEN_143; // @[FFT.scala 104:{12,12}]
  assign inst_3_io_wn_0_im = 4'hf == _wnList_T_4[3:0] ? _wnList_res_re_T_151 : _GEN_159; // @[FFT.scala 105:{12,12}]
  assign inst_4_io_in_0_re = inst_10_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_4_io_in_0_im = inst_10_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_4_io_in_1_re = inst_10_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_4_io_in_1_im = inst_10_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_4_io_wn_0_re = 3'h7 == _wnList_T_8[2:0] ? _wnList_res_re_T_231 : _GEN_199; // @[FFT.scala 104:{12,12}]
  assign inst_4_io_wn_0_im = 3'h7 == _wnList_T_8[2:0] ? _wnList_res_re_T_167 : _GEN_207; // @[FFT.scala 105:{12,12}]
  assign inst_5_io_in_0_re = inst_11_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_5_io_in_0_im = inst_11_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_5_io_in_1_re = inst_11_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_5_io_in_1_im = inst_11_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_5_io_wn_0_re = 3'h7 == _wnList_T_8[2:0] ? _wnList_res_re_T_231 : _GEN_199; // @[FFT.scala 104:{12,12}]
  assign inst_5_io_wn_0_im = 3'h7 == _wnList_T_8[2:0] ? _wnList_res_re_T_167 : _GEN_207; // @[FFT.scala 105:{12,12}]
  assign inst_6_io_in_0_re = inst_12_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_6_io_in_0_im = inst_12_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_6_io_in_1_re = inst_12_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_6_io_in_1_im = inst_12_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_6_io_wn_0_re = 2'h3 == _wnList_T_12[1:0] ? _wnList_res_re_T_199 : _GEN_227; // @[FFT.scala 104:{12,12}]
  assign inst_6_io_wn_0_im = 2'h3 == _wnList_T_12[1:0] ? _wnList_res_re_T_199 : _GEN_231; // @[FFT.scala 105:{12,12}]
  assign inst_7_io_in_0_re = inst_13_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_7_io_in_0_im = inst_13_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_7_io_in_1_re = inst_13_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_7_io_in_1_im = inst_13_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_7_io_wn_0_re = 2'h3 == _wnList_T_12[1:0] ? _wnList_res_re_T_199 : _GEN_227; // @[FFT.scala 104:{12,12}]
  assign inst_7_io_wn_0_im = 2'h3 == _wnList_T_12[1:0] ? _wnList_res_re_T_199 : _GEN_231; // @[FFT.scala 105:{12,12}]
  assign inst_8_io_in_0_re = inst_14_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_8_io_in_0_im = inst_14_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_8_io_in_1_re = inst_14_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_8_io_in_1_im = inst_14_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_8_io_wn_0_re = _wnList_T_16[0] ? _wnList_res_re_T_135 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  assign inst_8_io_wn_0_im = _wnList_T_16[0] ? _wnList_res_im_T_135 : _wnList_res_im_T_7; // @[FFT.scala 105:{12,12}]
  assign inst_9_io_in_0_re = inst_15_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_9_io_in_0_im = inst_15_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_9_io_in_1_re = inst_15_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_9_io_in_1_im = inst_15_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_9_io_wn_0_re = _wnList_T_16[0] ? _wnList_res_re_T_135 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  assign inst_9_io_wn_0_im = _wnList_T_16[0] ? _wnList_res_im_T_135 : _wnList_res_im_T_7; // @[FFT.scala 105:{12,12}]
  assign dataotemp_inst_io_in_0_re = inst_16_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_io_in_0_im = inst_16_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_io_in_1_re = inst_16_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_io_in_1_im = inst_16_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_1_io_in_0_re = inst_17_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_1_io_in_0_im = inst_17_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_1_io_in_1_re = inst_17_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_1_io_in_1_im = inst_17_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign exdata_inst_io_in_0_0_re = inst_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_0_0_im = inst_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_0_1_re = inst_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_0_1_im = inst_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_1_0_re = inst_1_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_1_0_im = inst_1_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_1_1_re = inst_1_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_1_1_im = inst_1_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_10_clock = clock;
  assign inst_10_io_in_0_re = inst_2_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_10_io_in_0_im = inst_2_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_10_io_in_1_re = inst_2_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_10_io_in_1_im = inst_2_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_10_io_sel = cnt_1[3]; // @[FFT.scala 163:31]
  assign inst_11_clock = clock;
  assign inst_11_io_in_0_re = inst_3_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_11_io_in_0_im = inst_3_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_11_io_in_1_re = inst_3_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_11_io_in_1_im = inst_3_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_11_io_sel = cnt_1[3]; // @[FFT.scala 163:31]
  assign inst_12_clock = clock;
  assign inst_12_io_in_0_re = inst_4_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_12_io_in_0_im = inst_4_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_12_io_in_1_re = inst_4_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_12_io_in_1_im = inst_4_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_12_io_sel = cnt_1[2]; // @[FFT.scala 163:31]
  assign inst_13_clock = clock;
  assign inst_13_io_in_0_re = inst_5_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_13_io_in_0_im = inst_5_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_13_io_in_1_re = inst_5_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_13_io_in_1_im = inst_5_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_13_io_sel = cnt_1[2]; // @[FFT.scala 163:31]
  assign inst_14_clock = clock;
  assign inst_14_io_in_0_re = inst_6_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_14_io_in_0_im = inst_6_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_14_io_in_1_re = inst_6_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_14_io_in_1_im = inst_6_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_14_io_sel = cnt_1[1]; // @[FFT.scala 163:31]
  assign inst_15_clock = clock;
  assign inst_15_io_in_0_re = inst_7_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_15_io_in_0_im = inst_7_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_15_io_in_1_re = inst_7_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_15_io_in_1_im = inst_7_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_15_io_sel = cnt_1[1]; // @[FFT.scala 163:31]
  assign inst_16_clock = clock;
  assign inst_16_io_in_0_re = inst_8_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_16_io_in_0_im = inst_8_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_16_io_in_1_re = inst_8_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_16_io_in_1_im = inst_8_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_16_io_sel = cnt_1[0]; // @[FFT.scala 163:31]
  assign inst_17_clock = clock;
  assign inst_17_io_in_0_re = inst_9_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_17_io_in_0_im = inst_9_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_17_io_in_1_re = inst_9_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_17_io_in_1_im = inst_9_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_17_io_sel = cnt_1[0]; // @[FFT.scala 163:31]
  assign inst_18_io_in_re = _T_1[63:32]; // @[FFT.scala 170:91]
  assign inst_18_io_in_im = _T_1[31:0]; // @[FFT.scala 170:91]
  assign inst_19_io_in_re = _T_4[63:32]; // @[FFT.scala 170:91]
  assign inst_19_io_in_im = _T_4[31:0]; // @[FFT.scala 170:91]
  assign inst_20_io_in_re = _T_7[63:32]; // @[FFT.scala 170:91]
  assign inst_20_io_in_im = _T_7[31:0]; // @[FFT.scala 170:91]
  assign inst_21_io_in_re = _T_10[63:32]; // @[FFT.scala 170:91]
  assign inst_21_io_in_im = _T_10[31:0]; // @[FFT.scala 170:91]
  assign inst_22_io_in_re = _T_13[65:33]; // @[FFT.scala 181:96]
  assign inst_22_io_in_im = _T_13[32:0]; // @[FFT.scala 181:96]
  assign inst_23_io_in_re = _T_16[65:33]; // @[FFT.scala 181:96]
  assign inst_23_io_in_im = _T_16[32:0]; // @[FFT.scala 181:96]
  assign inst_24_io_in_re = _T_19[65:33]; // @[FFT.scala 181:96]
  assign inst_24_io_in_im = _T_19[32:0]; // @[FFT.scala 181:96]
  assign inst_25_io_in_re = _T_22[65:33]; // @[FFT.scala 181:96]
  assign inst_25_io_in_im = _T_22[32:0]; // @[FFT.scala 181:96]
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
    if (reset) begin // @[FFT.scala 110:46]
      cnt_1 <= 6'h0; // @[FFT.scala 110:46]
    end else begin
      cnt_1 <= cnt_0; // @[FFT.scala 112:16]
    end
    REG__0_re <= exdata_inst_io_out_0_0_re; // @[FFT.scala 157:67]
    REG__0_im <= exdata_inst_io_out_0_0_im; // @[FFT.scala 157:67]
    REG__1_re <= exdata_inst_io_out_0_1_re; // @[FFT.scala 157:67]
    REG__1_im <= exdata_inst_io_out_0_1_im; // @[FFT.scala 157:67]
    REG_1_0_re <= exdata_inst_io_out_1_0_re; // @[FFT.scala 157:67]
    REG_1_0_im <= exdata_inst_io_out_1_0_im; // @[FFT.scala 157:67]
    REG_1_1_re <= exdata_inst_io_out_1_1_re; // @[FFT.scala 157:67]
    REG_1_1_im <= exdata_inst_io_out_1_1_im; // @[FFT.scala 157:67]
    REG_2_re <= inst_22_io_out_re; // @[FFT.scala 181:64]
    REG_2_im <= inst_22_io_out_im; // @[FFT.scala 181:64]
    REG_3_re <= inst_23_io_out_re; // @[FFT.scala 181:64]
    REG_3_im <= inst_23_io_out_im; // @[FFT.scala 181:64]
    REG_4_re <= inst_24_io_out_re; // @[FFT.scala 181:64]
    REG_4_im <= inst_24_io_out_im; // @[FFT.scala 181:64]
    REG_5_re <= inst_25_io_out_re; // @[FFT.scala 181:64]
    REG_5_im <= inst_25_io_out_im; // @[FFT.scala 181:64]
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
  _RAND_1 = {1{`RANDOM}};
  cnt_1 = _RAND_1[5:0];
  _RAND_2 = {2{`RANDOM}};
  REG__0_re = _RAND_2[32:0];
  _RAND_3 = {2{`RANDOM}};
  REG__0_im = _RAND_3[32:0];
  _RAND_4 = {2{`RANDOM}};
  REG__1_re = _RAND_4[32:0];
  _RAND_5 = {2{`RANDOM}};
  REG__1_im = _RAND_5[32:0];
  _RAND_6 = {2{`RANDOM}};
  REG_1_0_re = _RAND_6[32:0];
  _RAND_7 = {2{`RANDOM}};
  REG_1_0_im = _RAND_7[32:0];
  _RAND_8 = {2{`RANDOM}};
  REG_1_1_re = _RAND_8[32:0];
  _RAND_9 = {2{`RANDOM}};
  REG_1_1_im = _RAND_9[32:0];
  _RAND_10 = {1{`RANDOM}};
  REG_2_re = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  REG_2_im = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  REG_3_re = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  REG_3_im = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  REG_4_re = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  REG_4_im = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  REG_5_re = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  REG_5_im = _RAND_17[31:0];
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
  wire  FFTtop_u_clock; // @[warp.scala 177:26]
  wire  FFTtop_u_reset; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dIn_0_re; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dIn_0_im; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dIn_1_re; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dIn_1_im; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dIn_2_re; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dIn_2_im; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dIn_3_re; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dIn_3_im; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dOut_0_re; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dOut_0_im; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dOut_1_re; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dOut_1_im; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dOut_2_re; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dOut_2_im; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dOut_3_re; // @[warp.scala 177:26]
  wire [31:0] FFTtop_u_io_dOut_3_im; // @[warp.scala 177:26]
  wire  FFTtop_u_io_din_valid; // @[warp.scala 177:26]
  wire  FFTtop_u_io_busy; // @[warp.scala 177:26]
  reg  startreg1; // @[warp.scala 92:32]
  reg [63:0] signal_addr; // @[warp.scala 93:30]
  reg [1:0] state1; // @[warp.scala 102:29]
  wire  _T_13 = io_m_axi_gmem_RVALID & io_m_axi_gmem_RREADY & io_m_axi_gmem_RLAST; // @[warp.scala 118:90]
  wire [1:0] _GEN_2 = io_m_axi_gmem_RVALID & io_m_axi_gmem_RREADY & io_m_axi_gmem_RLAST ? 2'h3 : state1; // @[warp.scala 118:121 102:29 119:39]
  reg [1:0] state2; // @[warp.scala 148:29]
  wire  compute_done = state2 == 2'h3; // @[warp.scala 207:21]
  wire [1:0] _GEN_3 = compute_done ? 2'h0 : state1; // @[warp.scala 102:29 123:51 124:39]
  wire [1:0] _GEN_4 = 2'h3 == state1 ? _GEN_3 : state1; // @[warp.scala 105:23 102:29]
  wire  _T_16 = state1 == 2'h2; // @[warp.scala 129:22]
  reg [1:0] state3; // @[warp.scala 143:29]
  reg [31:0] cnt; // @[warp.scala 151:26]
  wire  _T_23 = state1 == 2'h3; // @[warp.scala 155:37]
  wire [1:0] _GEN_12 = state3 == 2'h2 ? 2'h3 : state2; // @[warp.scala 148:29 165:46 166:39]
  wire  _T_37 = state1 == 2'h1; // @[warp.scala 170:37]
  wire [1:0] _GEN_13 = state1 == 2'h1 ? 2'h0 : state2; // @[warp.scala 148:29 170:47 171:39]
  wire [1:0] _GEN_14 = 2'h3 == state2 ? _GEN_13 : state2; // @[warp.scala 153:23 148:29]
  reg  last_busy; // @[warp.scala 178:32]
  wire  res_r = last_busy & ~FFTtop_u_io_busy; // @[warp.scala 184:37]
  wire  _res_valid_T_1 = state3 == 2'h1; // @[warp.scala 186:47]
  wire  res_valid = res_r | state3 == 2'h1; // @[warp.scala 186:37]
  wire [1:0] _GEN_20 = compute_done ? 2'h0 : state3; // @[warp.scala 143:29 200:45 201:40]
  wire  _T_48 = state2 == 2'h0; // @[warp.scala 215:40]
  wire  _T_51 = state2 == 2'h1; // @[warp.scala 221:40]
  wire  _T_53 = state2 == 2'h2; // @[warp.scala 227:21]
  wire [4:0] _io_m_axi_gmem_ARLEN_T_2 = 5'h10 - 5'h1; // @[warp.scala 243:63]
  wire [4:0] _io_m_axi_gmem_ARLEN_T_3 = _T_23 ? _io_m_axi_gmem_ARLEN_T_2 : 5'h0; // @[warp.scala 243:36]
  reg  wlast; // @[warp.scala 262:28]
  reg [31:0] vec_entry_0; // @[warp.scala 291:32]
  reg [31:0] vec_entry_1; // @[warp.scala 291:32]
  reg [31:0] vec_entry_2; // @[warp.scala 291:32]
  reg [31:0] vec_entry_3; // @[warp.scala 291:32]
  reg [31:0] vec_entry_4; // @[warp.scala 291:32]
  reg [31:0] vec_entry_5; // @[warp.scala 291:32]
  reg [31:0] vec_entry_6; // @[warp.scala 291:32]
  reg [31:0] vec_entry_7; // @[warp.scala 291:32]
  wire [31:0] _cnt_T_1 = cnt - 32'h1; // @[warp.scala 303:28]
  wire  _T_63 = cnt == 32'h2; // @[warp.scala 306:18]
  wire [127:0] result_lo = {vec_entry_3,vec_entry_2,vec_entry_1,vec_entry_0}; // @[Cat.scala 33:92]
  wire [127:0] result_hi = {vec_entry_7,vec_entry_6,vec_entry_5,vec_entry_4}; // @[Cat.scala 33:92]
  FFT FFTtop_u ( // @[warp.scala 177:26]
    .clock(FFTtop_u_clock),
    .reset(FFTtop_u_reset),
    .io_dIn_0_re(FFTtop_u_io_dIn_0_re),
    .io_dIn_0_im(FFTtop_u_io_dIn_0_im),
    .io_dIn_1_re(FFTtop_u_io_dIn_1_re),
    .io_dIn_1_im(FFTtop_u_io_dIn_1_im),
    .io_dIn_2_re(FFTtop_u_io_dIn_2_re),
    .io_dIn_2_im(FFTtop_u_io_dIn_2_im),
    .io_dIn_3_re(FFTtop_u_io_dIn_3_re),
    .io_dIn_3_im(FFTtop_u_io_dIn_3_im),
    .io_dOut_0_re(FFTtop_u_io_dOut_0_re),
    .io_dOut_0_im(FFTtop_u_io_dOut_0_im),
    .io_dOut_1_re(FFTtop_u_io_dOut_1_re),
    .io_dOut_1_im(FFTtop_u_io_dOut_1_im),
    .io_dOut_2_re(FFTtop_u_io_dOut_2_re),
    .io_dOut_2_im(FFTtop_u_io_dOut_2_im),
    .io_dOut_3_re(FFTtop_u_io_dOut_3_re),
    .io_dOut_3_im(FFTtop_u_io_dOut_3_im),
    .io_din_valid(FFTtop_u_io_din_valid),
    .io_busy(FFTtop_u_io_busy)
  );
  assign io_done = state1 == 2'h0; // @[warp.scala 132:21]
  assign io_ap_return = 32'h0; // @[warp.scala 96:22]
  assign io_m_axi_gmem_AWADDR = io_pres; // @[warp.scala 250:30]
  assign io_m_axi_gmem_AWLEN = 8'h0; // @[warp.scala 253:29]
  assign io_m_axi_gmem_AWSIZE = 3'h5; // @[warp.scala 255:30]
  assign io_m_axi_gmem_AWBURST = 2'h1; // @[warp.scala 251:31]
  assign io_m_axi_gmem_AWLOCK = 2'h0; // @[warp.scala 254:30]
  assign io_m_axi_gmem_AWREGION = 4'h0; // @[warp.scala 258:32]
  assign io_m_axi_gmem_AWCACHE = 4'h0; // @[warp.scala 252:31]
  assign io_m_axi_gmem_AWPROT = 3'h0; // @[warp.scala 256:30]
  assign io_m_axi_gmem_AWQOS = 4'h0; // @[warp.scala 257:29]
  assign io_m_axi_gmem_AWVALID = state2 == 2'h2 & _res_valid_T_1; // @[warp.scala 227:28]
  assign io_m_axi_gmem_WDATA = {result_hi,result_lo}; // @[Cat.scala 33:92]
  assign io_m_axi_gmem_WSTRB = 32'hffffffff; // @[warp.scala 261:29]
  assign io_m_axi_gmem_WLAST = wlast; // @[warp.scala 263:30]
  assign io_m_axi_gmem_WVALID = state2 == 2'h2 & _res_valid_T_1; // @[warp.scala 227:28]
  assign io_m_axi_gmem_BREADY = 1'h1; // @[warp.scala 213:30]
  assign io_m_axi_gmem_ARADDR = _T_23 ? signal_addr : io_pargs; // @[warp.scala 239:36]
  assign io_m_axi_gmem_ARLEN = {{3'd0}, _io_m_axi_gmem_ARLEN_T_3}; // @[warp.scala 243:30]
  assign io_m_axi_gmem_ARSIZE = 3'h5; // @[warp.scala 245:30]
  assign io_m_axi_gmem_ARBURST = 2'h1; // @[warp.scala 240:31]
  assign io_m_axi_gmem_ARLOCK = 2'h0; // @[warp.scala 244:30]
  assign io_m_axi_gmem_ARREGION = 4'h0; // @[warp.scala 248:32]
  assign io_m_axi_gmem_ARCACHE = 4'h0; // @[warp.scala 241:31]
  assign io_m_axi_gmem_ARPROT = 3'h0; // @[warp.scala 246:30]
  assign io_m_axi_gmem_ARQOS = 4'h0; // @[warp.scala 247:29]
  assign io_m_axi_gmem_ARVALID = _T_37 | state2 == 2'h0; // @[warp.scala 215:30]
  assign io_m_axi_gmem_RREADY = _T_16 | state2 == 2'h1; // @[warp.scala 221:30]
  assign FFTtop_u_clock = clock;
  assign FFTtop_u_reset = reset;
  assign FFTtop_u_io_dIn_0_re = io_m_axi_gmem_RDATA[31:0]; // @[warp.scala 279:53]
  assign FFTtop_u_io_dIn_0_im = io_m_axi_gmem_RDATA[63:32]; // @[warp.scala 280:53]
  assign FFTtop_u_io_dIn_1_re = io_m_axi_gmem_RDATA[95:64]; // @[warp.scala 281:53]
  assign FFTtop_u_io_dIn_1_im = io_m_axi_gmem_RDATA[127:96]; // @[warp.scala 282:53]
  assign FFTtop_u_io_dIn_2_re = io_m_axi_gmem_RDATA[95:64]; // @[warp.scala 283:53]
  assign FFTtop_u_io_dIn_2_im = io_m_axi_gmem_RDATA[127:96]; // @[warp.scala 284:53]
  assign FFTtop_u_io_dIn_3_re = io_m_axi_gmem_RDATA[95:64]; // @[warp.scala 285:53]
  assign FFTtop_u_io_dIn_3_im = io_m_axi_gmem_RDATA[127:96]; // @[warp.scala 286:53]
  assign FFTtop_u_io_din_valid = _T_51 & io_m_axi_gmem_RREADY & io_m_axi_gmem_RVALID; // @[warp.scala 272:74]
  always @(posedge clock) begin
    startreg1 <= reset | io_start; // @[warp.scala 92:{32,32} 97:19]
    if (state1 == 2'h2 & io_m_axi_gmem_RREADY & io_m_axi_gmem_RVALID) begin // @[warp.scala 129:96]
      signal_addr <= io_m_axi_gmem_RDATA[63:0]; // @[warp.scala 130:29]
    end
    if (reset) begin // @[warp.scala 102:29]
      state1 <= 2'h0; // @[warp.scala 102:29]
    end else if (2'h0 == state1) begin // @[warp.scala 105:23]
      if (~startreg1 & io_start) begin // @[warp.scala 107:68]
        state1 <= 2'h1; // @[warp.scala 108:39]
      end
    end else if (2'h1 == state1) begin // @[warp.scala 105:23]
      if (io_m_axi_gmem_ARVALID & io_m_axi_gmem_ARREADY) begin // @[warp.scala 112:93]
        state1 <= 2'h2; // @[warp.scala 113:39]
      end
    end else if (2'h2 == state1) begin // @[warp.scala 105:23]
      state1 <= _GEN_2;
    end else begin
      state1 <= _GEN_4;
    end
    if (reset) begin // @[warp.scala 148:29]
      state2 <= 2'h0; // @[warp.scala 148:29]
    end else if (2'h0 == state2) begin // @[warp.scala 153:23]
      if (state1 == 2'h3 & io_m_axi_gmem_ARVALID & io_m_axi_gmem_ARREADY) begin // @[warp.scala 155:112]
        state2 <= 2'h1; // @[warp.scala 156:39]
      end
    end else if (2'h1 == state2) begin // @[warp.scala 153:23]
      if (_T_13) begin // @[warp.scala 160:125]
        state2 <= 2'h2; // @[warp.scala 161:39]
      end
    end else if (2'h2 == state2) begin // @[warp.scala 153:23]
      state2 <= _GEN_12;
    end else begin
      state2 <= _GEN_14;
    end
    if (reset) begin // @[warp.scala 143:29]
      state3 <= 2'h0; // @[warp.scala 143:29]
    end else if (2'h0 == state3) begin // @[warp.scala 188:23]
      if (res_r) begin // @[warp.scala 190:76]
        state3 <= 2'h1; // @[warp.scala 191:40]
      end
    end else if (2'h1 == state3) begin // @[warp.scala 188:23]
      if (cnt == 32'h1) begin // @[warp.scala 195:42]
        state3 <= 2'h2; // @[warp.scala 196:40]
      end
    end else if (2'h2 == state3) begin // @[warp.scala 188:23]
      state3 <= _GEN_20;
    end
    if (reset) begin // @[warp.scala 151:26]
      cnt <= 32'h10; // @[warp.scala 151:26]
    end else if (res_valid & _T_53) begin // @[warp.scala 294:52]
      cnt <= _cnt_T_1; // @[warp.scala 303:21]
    end
    last_busy <= FFTtop_u_io_busy; // @[warp.scala 178:32]
    if (reset) begin // @[warp.scala 262:28]
      wlast <= 1'h0; // @[warp.scala 262:28]
    end else begin
      wlast <= _T_63;
    end
    if (reset) begin // @[warp.scala 291:32]
      vec_entry_0 <= 32'h0; // @[warp.scala 291:32]
    end else if (_T_48) begin // @[warp.scala 313:28]
      vec_entry_0 <= 32'h0; // @[warp.scala 314:30]
    end else if (res_valid & _T_53) begin // @[warp.scala 294:52]
      vec_entry_0 <= FFTtop_u_io_dOut_0_re; // @[warp.scala 295:30]
    end
    if (reset) begin // @[warp.scala 291:32]
      vec_entry_1 <= 32'h0; // @[warp.scala 291:32]
    end else if (_T_48) begin // @[warp.scala 313:28]
      vec_entry_1 <= 32'h0; // @[warp.scala 315:30]
    end else if (res_valid & _T_53) begin // @[warp.scala 294:52]
      vec_entry_1 <= FFTtop_u_io_dOut_0_im; // @[warp.scala 296:30]
    end
    if (reset) begin // @[warp.scala 291:32]
      vec_entry_2 <= 32'h0; // @[warp.scala 291:32]
    end else if (_T_48) begin // @[warp.scala 313:28]
      vec_entry_2 <= 32'h0; // @[warp.scala 316:30]
    end else if (res_valid & _T_53) begin // @[warp.scala 294:52]
      vec_entry_2 <= FFTtop_u_io_dOut_1_re; // @[warp.scala 297:30]
    end
    if (reset) begin // @[warp.scala 291:32]
      vec_entry_3 <= 32'h0; // @[warp.scala 291:32]
    end else if (_T_48) begin // @[warp.scala 313:28]
      vec_entry_3 <= 32'h0; // @[warp.scala 317:30]
    end else if (res_valid & _T_53) begin // @[warp.scala 294:52]
      vec_entry_3 <= FFTtop_u_io_dOut_1_im; // @[warp.scala 298:30]
    end
    if (reset) begin // @[warp.scala 291:32]
      vec_entry_4 <= 32'h0; // @[warp.scala 291:32]
    end else if (_T_48) begin // @[warp.scala 313:28]
      vec_entry_4 <= 32'h0; // @[warp.scala 318:30]
    end else if (res_valid & _T_53) begin // @[warp.scala 294:52]
      vec_entry_4 <= FFTtop_u_io_dOut_2_re; // @[warp.scala 299:30]
    end
    if (reset) begin // @[warp.scala 291:32]
      vec_entry_5 <= 32'h0; // @[warp.scala 291:32]
    end else if (_T_48) begin // @[warp.scala 313:28]
      vec_entry_5 <= 32'h0; // @[warp.scala 319:30]
    end else if (res_valid & _T_53) begin // @[warp.scala 294:52]
      vec_entry_5 <= FFTtop_u_io_dOut_2_im; // @[warp.scala 300:30]
    end
    if (reset) begin // @[warp.scala 291:32]
      vec_entry_6 <= 32'h0; // @[warp.scala 291:32]
    end else if (_T_48) begin // @[warp.scala 313:28]
      vec_entry_6 <= 32'h0; // @[warp.scala 320:30]
    end else if (res_valid & _T_53) begin // @[warp.scala 294:52]
      vec_entry_6 <= FFTtop_u_io_dOut_3_re; // @[warp.scala 301:30]
    end
    if (reset) begin // @[warp.scala 291:32]
      vec_entry_7 <= 32'h0; // @[warp.scala 291:32]
    end else if (_T_48) begin // @[warp.scala 313:28]
      vec_entry_7 <= 32'h0; // @[warp.scala 321:30]
    end else if (res_valid & _T_53) begin // @[warp.scala 294:52]
      vec_entry_7 <= FFTtop_u_io_dOut_3_im; // @[warp.scala 302:30]
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
  state3 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  cnt = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  last_busy = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  wlast = _RAND_7[0:0];
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
