module AddRawFN(
  input         io_subOp,
  input         io_a_isNaN,
  input         io_a_isInf,
  input         io_a_isZero,
  input         io_a_sign,
  input  [6:0]  io_a_sExp,
  input  [11:0] io_a_sig,
  input         io_b_isNaN,
  input         io_b_isInf,
  input         io_b_isZero,
  input         io_b_sign,
  input  [6:0]  io_b_sExp,
  input  [11:0] io_b_sig,
  output        io_invalidExc,
  output        io_rawOut_isNaN,
  output        io_rawOut_isInf,
  output        io_rawOut_isZero,
  output        io_rawOut_sign,
  output [6:0]  io_rawOut_sExp,
  output [13:0] io_rawOut_sig
);
  wire  effSignB = io_b_sign ^ io_subOp; // @[AddRecFN.scala 60:30]
  wire  eqSigns = io_a_sign == effSignB; // @[AddRecFN.scala 61:29]
  wire [6:0] sDiffExps = $signed(io_a_sExp) - $signed(io_b_sExp); // @[AddRecFN.scala 63:31]
  wire  _modNatAlignDist_T = $signed(sDiffExps) < 7'sh0; // @[AddRecFN.scala 64:41]
  wire [6:0] _modNatAlignDist_T_3 = $signed(io_b_sExp) - $signed(io_a_sExp); // @[AddRecFN.scala 64:58]
  wire [6:0] _modNatAlignDist_T_4 = $signed(sDiffExps) < 7'sh0 ? $signed(_modNatAlignDist_T_3) : $signed(sDiffExps); // @[AddRecFN.scala 64:30]
  wire [3:0] modNatAlignDist = _modNatAlignDist_T_4[3:0]; // @[AddRecFN.scala 64:81]
  wire [2:0] _isMaxAlign_T = sDiffExps[6:4]; // @[AddRecFN.scala 66:19]
  wire  _isMaxAlign_T_6 = $signed(_isMaxAlign_T) != -3'sh1 | sDiffExps[3:0] == 4'h0; // @[AddRecFN.scala 67:51]
  wire  isMaxAlign = $signed(_isMaxAlign_T) != 3'sh0 & _isMaxAlign_T_6; // @[AddRecFN.scala 66:45]
  wire [3:0] alignDist = isMaxAlign ? 4'hf : modNatAlignDist; // @[AddRecFN.scala 68:24]
  wire  _closeSubMags_T = ~eqSigns; // @[AddRecFN.scala 69:24]
  wire  closeSubMags = ~eqSigns & ~isMaxAlign & modNatAlignDist <= 4'h1; // @[AddRecFN.scala 69:48]
  wire  _close_alignedSigA_T = 7'sh0 <= $signed(sDiffExps); // @[AddRecFN.scala 73:18]
  wire [13:0] _close_alignedSigA_T_3 = {io_a_sig, 2'h0}; // @[AddRecFN.scala 73:58]
  wire [13:0] _close_alignedSigA_T_4 = 7'sh0 <= $signed(sDiffExps) & sDiffExps[0] ? _close_alignedSigA_T_3 : 14'h0; // @[AddRecFN.scala 73:12]
  wire [12:0] _close_alignedSigA_T_9 = {io_a_sig, 1'h0}; // @[AddRecFN.scala 74:58]
  wire [12:0] _close_alignedSigA_T_10 = _close_alignedSigA_T & ~sDiffExps[0] ? _close_alignedSigA_T_9 : 13'h0; // @[AddRecFN.scala 74:12]
  wire [13:0] _GEN_0 = {{1'd0}, _close_alignedSigA_T_10}; // @[AddRecFN.scala 73:68]
  wire [13:0] _close_alignedSigA_T_11 = _close_alignedSigA_T_4 | _GEN_0; // @[AddRecFN.scala 73:68]
  wire [11:0] _close_alignedSigA_T_13 = _modNatAlignDist_T ? io_a_sig : 12'h0; // @[AddRecFN.scala 75:12]
  wire [13:0] _GEN_1 = {{2'd0}, _close_alignedSigA_T_13}; // @[AddRecFN.scala 74:68]
  wire [13:0] _close_sSigSum_T = _close_alignedSigA_T_11 | _GEN_1; // @[AddRecFN.scala 76:43]
  wire [12:0] _close_sSigSum_T_2 = {io_b_sig, 1'h0}; // @[AddRecFN.scala 76:66]
  wire [13:0] _GEN_2 = {{1{_close_sSigSum_T_2[12]}},_close_sSigSum_T_2}; // @[AddRecFN.scala 76:50]
  wire [13:0] close_sSigSum = $signed(_close_sSigSum_T) - $signed(_GEN_2); // @[AddRecFN.scala 76:50]
  wire  _close_sigSum_T = $signed(close_sSigSum) < 14'sh0; // @[AddRecFN.scala 77:42]
  wire [13:0] _close_sigSum_T_3 = 14'sh0 - $signed(close_sSigSum); // @[AddRecFN.scala 77:49]
  wire [13:0] _close_sigSum_T_4 = $signed(close_sSigSum) < 14'sh0 ? $signed(_close_sigSum_T_3) : $signed(close_sSigSum); // @[AddRecFN.scala 77:27]
  wire [12:0] close_sigSum = _close_sigSum_T_4[12:0]; // @[AddRecFN.scala 77:79]
  wire [13:0] close_adjustedSigSum = {close_sigSum, 1'h0}; // @[AddRecFN.scala 78:44]
  wire  close_reduced2SigSum_reducedVec_0 = |close_adjustedSigSum[1:0]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_1 = |close_adjustedSigSum[3:2]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_2 = |close_adjustedSigSum[5:4]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_3 = |close_adjustedSigSum[7:6]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_4 = |close_adjustedSigSum[9:8]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_5 = |close_adjustedSigSum[11:10]; // @[primitives.scala 104:54]
  wire  close_reduced2SigSum_reducedVec_6 = |close_adjustedSigSum[13:12]; // @[primitives.scala 107:57]
  wire [6:0] close_reduced2SigSum = {close_reduced2SigSum_reducedVec_6,close_reduced2SigSum_reducedVec_5,
    close_reduced2SigSum_reducedVec_4,close_reduced2SigSum_reducedVec_3,close_reduced2SigSum_reducedVec_2,
    close_reduced2SigSum_reducedVec_1,close_reduced2SigSum_reducedVec_0}; // @[primitives.scala 108:20]
  wire [2:0] _close_normDistReduced2_T_7 = close_reduced2SigSum[1] ? 3'h5 : 3'h6; // @[Mux.scala 47:70]
  wire [2:0] _close_normDistReduced2_T_8 = close_reduced2SigSum[2] ? 3'h4 : _close_normDistReduced2_T_7; // @[Mux.scala 47:70]
  wire [2:0] _close_normDistReduced2_T_9 = close_reduced2SigSum[3] ? 3'h3 : _close_normDistReduced2_T_8; // @[Mux.scala 47:70]
  wire [2:0] _close_normDistReduced2_T_10 = close_reduced2SigSum[4] ? 3'h2 : _close_normDistReduced2_T_9; // @[Mux.scala 47:70]
  wire [2:0] _close_normDistReduced2_T_11 = close_reduced2SigSum[5] ? 3'h1 : _close_normDistReduced2_T_10; // @[Mux.scala 47:70]
  wire [2:0] close_normDistReduced2 = close_reduced2SigSum[6] ? 3'h0 : _close_normDistReduced2_T_11; // @[Mux.scala 47:70]
  wire [3:0] close_nearNormDist = {close_normDistReduced2, 1'h0}; // @[AddRecFN.scala 81:53]
  wire [27:0] _GEN_7 = {{15'd0}, close_sigSum}; // @[AddRecFN.scala 82:38]
  wire [27:0] _close_sigOut_T = _GEN_7 << close_nearNormDist; // @[AddRecFN.scala 82:38]
  wire [28:0] _close_sigOut_T_1 = {_close_sigOut_T, 1'h0}; // @[AddRecFN.scala 82:59]
  wire [13:0] close_sigOut = _close_sigOut_T_1[13:0]; // @[AddRecFN.scala 82:63]
  wire  close_totalCancellation = ~(|close_sigOut[13:12]); // @[AddRecFN.scala 83:35]
  wire  close_notTotalCancellation_signOut = io_a_sign ^ _close_sigSum_T; // @[AddRecFN.scala 84:56]
  wire  far_signOut = _modNatAlignDist_T ? effSignB : io_a_sign; // @[AddRecFN.scala 87:26]
  wire [11:0] _far_sigLarger_T_1 = _modNatAlignDist_T ? io_b_sig : io_a_sig; // @[AddRecFN.scala 88:29]
  wire [10:0] far_sigLarger = _far_sigLarger_T_1[10:0]; // @[AddRecFN.scala 88:66]
  wire [11:0] _far_sigSmaller_T_1 = _modNatAlignDist_T ? io_a_sig : io_b_sig; // @[AddRecFN.scala 89:29]
  wire [10:0] far_sigSmaller = _far_sigSmaller_T_1[10:0]; // @[AddRecFN.scala 89:66]
  wire [15:0] _far_mainAlignedSigSmaller_T = {far_sigSmaller, 5'h0}; // @[AddRecFN.scala 90:52]
  wire [15:0] far_mainAlignedSigSmaller = _far_mainAlignedSigSmaller_T >> alignDist; // @[AddRecFN.scala 90:56]
  wire [12:0] _far_reduced4SigSmaller_T = {far_sigSmaller, 2'h0}; // @[AddRecFN.scala 91:60]
  wire  far_reduced4SigSmaller_reducedVec_0 = |_far_reduced4SigSmaller_T[3:0]; // @[primitives.scala 121:54]
  wire  far_reduced4SigSmaller_reducedVec_1 = |_far_reduced4SigSmaller_T[7:4]; // @[primitives.scala 121:54]
  wire  far_reduced4SigSmaller_reducedVec_2 = |_far_reduced4SigSmaller_T[11:8]; // @[primitives.scala 121:54]
  wire  far_reduced4SigSmaller_reducedVec_3 = |_far_reduced4SigSmaller_T[12]; // @[primitives.scala 124:57]
  wire [3:0] far_reduced4SigSmaller = {far_reduced4SigSmaller_reducedVec_3,far_reduced4SigSmaller_reducedVec_2,
    far_reduced4SigSmaller_reducedVec_1,far_reduced4SigSmaller_reducedVec_0}; // @[primitives.scala 125:20]
  wire [4:0] far_roundExtraMask_shift = 5'sh10 >>> alignDist[3:2]; // @[primitives.scala 77:58]
  wire [3:0] far_roundExtraMask = {far_roundExtraMask_shift[0],far_roundExtraMask_shift[1],far_roundExtraMask_shift[2],
    far_roundExtraMask_shift[3]}; // @[Cat.scala 33:92]
  wire [3:0] _far_alignedSigSmaller_T_3 = far_reduced4SigSmaller & far_roundExtraMask; // @[AddRecFN.scala 95:76]
  wire  _far_alignedSigSmaller_T_5 = |far_mainAlignedSigSmaller[2:0] | |_far_alignedSigSmaller_T_3; // @[AddRecFN.scala 95:49]
  wire [13:0] far_alignedSigSmaller = {far_mainAlignedSigSmaller[15:3],_far_alignedSigSmaller_T_5}; // @[Cat.scala 33:92]
  wire [13:0] _far_negAlignedSigSmaller_T = ~far_alignedSigSmaller; // @[AddRecFN.scala 97:62]
  wire [14:0] _far_negAlignedSigSmaller_T_1 = {1'h1,_far_negAlignedSigSmaller_T}; // @[Cat.scala 33:92]
  wire [14:0] far_negAlignedSigSmaller = _closeSubMags_T ? _far_negAlignedSigSmaller_T_1 : {{1'd0},
    far_alignedSigSmaller}; // @[AddRecFN.scala 97:39]
  wire [13:0] _far_sigSum_T = {far_sigLarger, 3'h0}; // @[AddRecFN.scala 98:36]
  wire [14:0] _GEN_3 = {{1'd0}, _far_sigSum_T}; // @[AddRecFN.scala 98:41]
  wire [14:0] _far_sigSum_T_2 = _GEN_3 + far_negAlignedSigSmaller; // @[AddRecFN.scala 98:41]
  wire [14:0] _GEN_4 = {{14'd0}, _closeSubMags_T}; // @[AddRecFN.scala 98:68]
  wire [14:0] far_sigSum = _far_sigSum_T_2 + _GEN_4; // @[AddRecFN.scala 98:68]
  wire [13:0] _GEN_5 = {{13'd0}, far_sigSum[0]}; // @[AddRecFN.scala 99:67]
  wire [13:0] _far_sigOut_T_2 = far_sigSum[14:1] | _GEN_5; // @[AddRecFN.scala 99:67]
  wire [14:0] _far_sigOut_T_3 = _closeSubMags_T ? far_sigSum : {{1'd0}, _far_sigOut_T_2}; // @[AddRecFN.scala 99:25]
  wire [13:0] far_sigOut = _far_sigOut_T_3[13:0]; // @[AddRecFN.scala 99:83]
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
  wire [6:0] _common_sExpOut_T_2 = closeSubMags | _modNatAlignDist_T ? $signed(io_b_sExp) : $signed(io_a_sExp); // @[AddRecFN.scala 116:13]
  wire [3:0] _common_sExpOut_T_3 = closeSubMags ? close_nearNormDist : {{3'd0}, _closeSubMags_T}; // @[AddRecFN.scala 117:18]
  wire [4:0] _common_sExpOut_T_4 = {1'b0,$signed(_common_sExpOut_T_3)}; // @[AddRecFN.scala 117:66]
  wire [6:0] _GEN_6 = {{2{_common_sExpOut_T_4[4]}},_common_sExpOut_T_4}; // @[AddRecFN.scala 117:13]
  wire  _io_invalidExc_T_2 = io_a_isNaN & ~io_a_sig[9]; // @[common.scala 82:46]
  wire  _io_invalidExc_T_5 = io_b_isNaN & ~io_b_sig[9]; // @[common.scala 82:46]
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
  input  [6:0]  io_in_sExp,
  input  [13:0] io_in_sig,
  output [16:0] io_out
);
  wire  doShiftSigDown1 = io_in_sig[13]; // @[RoundAnyRawFNToRecFN.scala 118:61]
  wire [5:0] _roundMask_T_1 = ~io_in_sExp[5:0]; // @[primitives.scala 51:21]
  wire [64:0] roundMask_shift = 65'sh10000000000000000 >>> _roundMask_T_1; // @[primitives.scala 77:58]
  wire [7:0] _GEN_0 = {{4'd0}, roundMask_shift[14:11]}; // @[Bitwise.scala 108:31]
  wire [7:0] _roundMask_T_7 = _GEN_0 & 8'hf; // @[Bitwise.scala 108:31]
  wire [7:0] _roundMask_T_9 = {roundMask_shift[10:7], 4'h0}; // @[Bitwise.scala 108:70]
  wire [7:0] _roundMask_T_11 = _roundMask_T_9 & 8'hf0; // @[Bitwise.scala 108:80]
  wire [7:0] _roundMask_T_12 = _roundMask_T_7 | _roundMask_T_11; // @[Bitwise.scala 108:39]
  wire [7:0] _GEN_1 = {{2'd0}, _roundMask_T_12[7:2]}; // @[Bitwise.scala 108:31]
  wire [7:0] _roundMask_T_17 = _GEN_1 & 8'h33; // @[Bitwise.scala 108:31]
  wire [7:0] _roundMask_T_19 = {_roundMask_T_12[5:0], 2'h0}; // @[Bitwise.scala 108:70]
  wire [7:0] _roundMask_T_21 = _roundMask_T_19 & 8'hcc; // @[Bitwise.scala 108:80]
  wire [7:0] _roundMask_T_22 = _roundMask_T_17 | _roundMask_T_21; // @[Bitwise.scala 108:39]
  wire [7:0] _GEN_2 = {{1'd0}, _roundMask_T_22[7:1]}; // @[Bitwise.scala 108:31]
  wire [7:0] _roundMask_T_27 = _GEN_2 & 8'h55; // @[Bitwise.scala 108:31]
  wire [7:0] _roundMask_T_29 = {_roundMask_T_22[6:0], 1'h0}; // @[Bitwise.scala 108:70]
  wire [7:0] _roundMask_T_31 = _roundMask_T_29 & 8'haa; // @[Bitwise.scala 108:80]
  wire [7:0] _roundMask_T_32 = _roundMask_T_27 | _roundMask_T_31; // @[Bitwise.scala 108:39]
  wire [11:0] _roundMask_T_43 = {_roundMask_T_32,roundMask_shift[15],roundMask_shift[16],roundMask_shift[17],
    roundMask_shift[18]}; // @[Cat.scala 33:92]
  wire [11:0] _GEN_3 = {{11'd0}, doShiftSigDown1}; // @[RoundAnyRawFNToRecFN.scala 157:23]
  wire [11:0] _roundMask_T_44 = _roundMask_T_43 | _GEN_3; // @[RoundAnyRawFNToRecFN.scala 157:23]
  wire [13:0] roundMask = {_roundMask_T_44,2'h3}; // @[Cat.scala 33:92]
  wire [13:0] shiftedRoundMask = {1'h0,roundMask[13:1]}; // @[Cat.scala 33:92]
  wire [13:0] _roundPosMask_T = ~shiftedRoundMask; // @[RoundAnyRawFNToRecFN.scala 161:28]
  wire [13:0] roundPosMask = _roundPosMask_T & roundMask; // @[RoundAnyRawFNToRecFN.scala 161:46]
  wire [13:0] _roundPosBit_T = io_in_sig & roundPosMask; // @[RoundAnyRawFNToRecFN.scala 162:40]
  wire  roundPosBit = |_roundPosBit_T; // @[RoundAnyRawFNToRecFN.scala 162:56]
  wire [13:0] _anyRoundExtra_T = io_in_sig & shiftedRoundMask; // @[RoundAnyRawFNToRecFN.scala 163:42]
  wire  anyRoundExtra = |_anyRoundExtra_T; // @[RoundAnyRawFNToRecFN.scala 163:62]
  wire [13:0] _roundedSig_T = io_in_sig | roundMask; // @[RoundAnyRawFNToRecFN.scala 172:32]
  wire [12:0] _roundedSig_T_2 = _roundedSig_T[13:2] + 12'h1; // @[RoundAnyRawFNToRecFN.scala 172:49]
  wire  _roundedSig_T_4 = ~anyRoundExtra; // @[RoundAnyRawFNToRecFN.scala 174:30]
  wire [12:0] _roundedSig_T_7 = roundPosBit & _roundedSig_T_4 ? roundMask[13:1] : 13'h0; // @[RoundAnyRawFNToRecFN.scala 173:25]
  wire [12:0] _roundedSig_T_8 = ~_roundedSig_T_7; // @[RoundAnyRawFNToRecFN.scala 173:21]
  wire [12:0] _roundedSig_T_9 = _roundedSig_T_2 & _roundedSig_T_8; // @[RoundAnyRawFNToRecFN.scala 172:61]
  wire [13:0] _roundedSig_T_10 = ~roundMask; // @[RoundAnyRawFNToRecFN.scala 178:32]
  wire [13:0] _roundedSig_T_11 = io_in_sig & _roundedSig_T_10; // @[RoundAnyRawFNToRecFN.scala 178:30]
  wire [12:0] _roundedSig_T_16 = {{1'd0}, _roundedSig_T_11[13:2]}; // @[RoundAnyRawFNToRecFN.scala 178:47]
  wire [12:0] roundedSig = roundPosBit ? _roundedSig_T_9 : _roundedSig_T_16; // @[RoundAnyRawFNToRecFN.scala 171:16]
  wire [2:0] _sRoundedExp_T_1 = {1'b0,$signed(roundedSig[12:11])}; // @[RoundAnyRawFNToRecFN.scala 183:69]
  wire [6:0] _GEN_4 = {{4{_sRoundedExp_T_1[2]}},_sRoundedExp_T_1}; // @[RoundAnyRawFNToRecFN.scala 183:40]
  wire [7:0] sRoundedExp = $signed(io_in_sExp) + $signed(_GEN_4); // @[RoundAnyRawFNToRecFN.scala 183:40]
  wire [5:0] common_expOut = sRoundedExp[5:0]; // @[RoundAnyRawFNToRecFN.scala 185:37]
  wire [9:0] common_fractOut = doShiftSigDown1 ? roundedSig[10:1] : roundedSig[9:0]; // @[RoundAnyRawFNToRecFN.scala 187:16]
  wire [3:0] _common_overflow_T = sRoundedExp[7:4]; // @[RoundAnyRawFNToRecFN.scala 194:30]
  wire  common_overflow = $signed(_common_overflow_T) >= 4'sh3; // @[RoundAnyRawFNToRecFN.scala 194:50]
  wire  common_totalUnderflow = $signed(sRoundedExp) < 8'sh8; // @[RoundAnyRawFNToRecFN.scala 198:31]
  wire  isNaNOut = io_invalidExc | io_in_isNaN; // @[RoundAnyRawFNToRecFN.scala 233:34]
  wire  commonCase = ~isNaNOut & ~io_in_isInf & ~io_in_isZero; // @[RoundAnyRawFNToRecFN.scala 235:61]
  wire  overflow = commonCase & common_overflow; // @[RoundAnyRawFNToRecFN.scala 236:32]
  wire  notNaN_isInfOut = io_in_isInf | overflow; // @[RoundAnyRawFNToRecFN.scala 246:32]
  wire  signOut = isNaNOut ? 1'h0 : io_in_sign; // @[RoundAnyRawFNToRecFN.scala 248:22]
  wire [5:0] _expOut_T_1 = io_in_isZero | common_totalUnderflow ? 6'h38 : 6'h0; // @[RoundAnyRawFNToRecFN.scala 251:18]
  wire [5:0] _expOut_T_2 = ~_expOut_T_1; // @[RoundAnyRawFNToRecFN.scala 251:14]
  wire [5:0] _expOut_T_3 = common_expOut & _expOut_T_2; // @[RoundAnyRawFNToRecFN.scala 250:24]
  wire [5:0] _expOut_T_11 = notNaN_isInfOut ? 6'h8 : 6'h0; // @[RoundAnyRawFNToRecFN.scala 263:18]
  wire [5:0] _expOut_T_12 = ~_expOut_T_11; // @[RoundAnyRawFNToRecFN.scala 263:14]
  wire [5:0] _expOut_T_13 = _expOut_T_3 & _expOut_T_12; // @[RoundAnyRawFNToRecFN.scala 262:17]
  wire [5:0] _expOut_T_18 = notNaN_isInfOut ? 6'h30 : 6'h0; // @[RoundAnyRawFNToRecFN.scala 275:16]
  wire [5:0] _expOut_T_19 = _expOut_T_13 | _expOut_T_18; // @[RoundAnyRawFNToRecFN.scala 274:15]
  wire [5:0] _expOut_T_20 = isNaNOut ? 6'h38 : 6'h0; // @[RoundAnyRawFNToRecFN.scala 276:16]
  wire [5:0] expOut = _expOut_T_19 | _expOut_T_20; // @[RoundAnyRawFNToRecFN.scala 275:77]
  wire [9:0] _fractOut_T_2 = isNaNOut ? 10'h200 : 10'h0; // @[RoundAnyRawFNToRecFN.scala 279:16]
  wire [9:0] fractOut = isNaNOut | io_in_isZero | common_totalUnderflow ? _fractOut_T_2 : common_fractOut; // @[RoundAnyRawFNToRecFN.scala 278:12]
  wire [6:0] io_out_hi = {signOut,expOut}; // @[Cat.scala 33:92]
  assign io_out = {io_out_hi,fractOut}; // @[Cat.scala 33:92]
endmodule
module RoundRawFNToRecFN(
  input         io_invalidExc,
  input         io_in_isNaN,
  input         io_in_isInf,
  input         io_in_isZero,
  input         io_in_sign,
  input  [6:0]  io_in_sExp,
  input  [13:0] io_in_sig,
  output [16:0] io_out
);
  wire  roundAnyRawFNToRecFN_io_invalidExc; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire  roundAnyRawFNToRecFN_io_in_isNaN; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire  roundAnyRawFNToRecFN_io_in_isInf; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire  roundAnyRawFNToRecFN_io_in_isZero; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire  roundAnyRawFNToRecFN_io_in_sign; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire [6:0] roundAnyRawFNToRecFN_io_in_sExp; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire [13:0] roundAnyRawFNToRecFN_io_in_sig; // @[RoundAnyRawFNToRecFN.scala 307:15]
  wire [16:0] roundAnyRawFNToRecFN_io_out; // @[RoundAnyRawFNToRecFN.scala 307:15]
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
  input  [16:0] io_a,
  input  [16:0] io_b,
  output [16:0] io_out
);
  wire  addRawFN__io_subOp; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_a_isNaN; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_a_isInf; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_a_isZero; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_a_sign; // @[AddRecFN.scala 147:26]
  wire [6:0] addRawFN__io_a_sExp; // @[AddRecFN.scala 147:26]
  wire [11:0] addRawFN__io_a_sig; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_b_isNaN; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_b_isInf; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_b_isZero; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_b_sign; // @[AddRecFN.scala 147:26]
  wire [6:0] addRawFN__io_b_sExp; // @[AddRecFN.scala 147:26]
  wire [11:0] addRawFN__io_b_sig; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_invalidExc; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_rawOut_isNaN; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_rawOut_isInf; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_rawOut_isZero; // @[AddRecFN.scala 147:26]
  wire  addRawFN__io_rawOut_sign; // @[AddRecFN.scala 147:26]
  wire [6:0] addRawFN__io_rawOut_sExp; // @[AddRecFN.scala 147:26]
  wire [13:0] addRawFN__io_rawOut_sig; // @[AddRecFN.scala 147:26]
  wire  roundRawFNToRecFN_io_invalidExc; // @[AddRecFN.scala 157:15]
  wire  roundRawFNToRecFN_io_in_isNaN; // @[AddRecFN.scala 157:15]
  wire  roundRawFNToRecFN_io_in_isInf; // @[AddRecFN.scala 157:15]
  wire  roundRawFNToRecFN_io_in_isZero; // @[AddRecFN.scala 157:15]
  wire  roundRawFNToRecFN_io_in_sign; // @[AddRecFN.scala 157:15]
  wire [6:0] roundRawFNToRecFN_io_in_sExp; // @[AddRecFN.scala 157:15]
  wire [13:0] roundRawFNToRecFN_io_in_sig; // @[AddRecFN.scala 157:15]
  wire [16:0] roundRawFNToRecFN_io_out; // @[AddRecFN.scala 157:15]
  wire [5:0] addRawFN_io_a_exp = io_a[15:10]; // @[rawFloatFromRecFN.scala 50:21]
  wire  addRawFN_io_a_isZero = addRawFN_io_a_exp[5:3] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  wire  addRawFN_io_a_isSpecial = addRawFN_io_a_exp[5:4] == 2'h3; // @[rawFloatFromRecFN.scala 52:54]
  wire  _addRawFN_io_a_out_sig_T = ~addRawFN_io_a_isZero; // @[rawFloatFromRecFN.scala 60:39]
  wire [1:0] addRawFN_io_a_out_sig_hi = {1'h0,_addRawFN_io_a_out_sig_T}; // @[Cat.scala 33:92]
  wire [5:0] addRawFN_io_b_exp = io_b[15:10]; // @[rawFloatFromRecFN.scala 50:21]
  wire  addRawFN_io_b_isZero = addRawFN_io_b_exp[5:3] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  wire  addRawFN_io_b_isSpecial = addRawFN_io_b_exp[5:4] == 2'h3; // @[rawFloatFromRecFN.scala 52:54]
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
  assign addRawFN__io_a_isNaN = addRawFN_io_a_isSpecial & addRawFN_io_a_exp[3]; // @[rawFloatFromRecFN.scala 55:33]
  assign addRawFN__io_a_isInf = addRawFN_io_a_isSpecial & ~addRawFN_io_a_exp[3]; // @[rawFloatFromRecFN.scala 56:33]
  assign addRawFN__io_a_isZero = addRawFN_io_a_exp[5:3] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  assign addRawFN__io_a_sign = io_a[16]; // @[rawFloatFromRecFN.scala 58:25]
  assign addRawFN__io_a_sExp = {1'b0,$signed(addRawFN_io_a_exp)}; // @[rawFloatFromRecFN.scala 59:27]
  assign addRawFN__io_a_sig = {addRawFN_io_a_out_sig_hi,io_a[9:0]}; // @[Cat.scala 33:92]
  assign addRawFN__io_b_isNaN = addRawFN_io_b_isSpecial & addRawFN_io_b_exp[3]; // @[rawFloatFromRecFN.scala 55:33]
  assign addRawFN__io_b_isInf = addRawFN_io_b_isSpecial & ~addRawFN_io_b_exp[3]; // @[rawFloatFromRecFN.scala 56:33]
  assign addRawFN__io_b_isZero = addRawFN_io_b_exp[5:3] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  assign addRawFN__io_b_sign = io_b[16]; // @[rawFloatFromRecFN.scala 58:25]
  assign addRawFN__io_b_sExp = {1'b0,$signed(addRawFN_io_b_exp)}; // @[rawFloatFromRecFN.scala 59:27]
  assign addRawFN__io_b_sig = {addRawFN_io_b_out_sig_hi,io_b[9:0]}; // @[Cat.scala 33:92]
  assign roundRawFNToRecFN_io_invalidExc = addRawFN__io_invalidExc; // @[AddRecFN.scala 158:39]
  assign roundRawFNToRecFN_io_in_isNaN = addRawFN__io_rawOut_isNaN; // @[AddRecFN.scala 160:39]
  assign roundRawFNToRecFN_io_in_isInf = addRawFN__io_rawOut_isInf; // @[AddRecFN.scala 160:39]
  assign roundRawFNToRecFN_io_in_isZero = addRawFN__io_rawOut_isZero; // @[AddRecFN.scala 160:39]
  assign roundRawFNToRecFN_io_in_sign = addRawFN__io_rawOut_sign; // @[AddRecFN.scala 160:39]
  assign roundRawFNToRecFN_io_in_sExp = addRawFN__io_rawOut_sExp; // @[AddRecFN.scala 160:39]
  assign roundRawFNToRecFN_io_in_sig = addRawFN__io_rawOut_sig; // @[AddRecFN.scala 160:39]
endmodule
module FloatAdd(
  input  [16:0] io_op1,
  input  [16:0] io_op2,
  output [16:0] io_res
);
  wire  float_adder_io_subOp; // @[Float.scala 14:27]
  wire [16:0] float_adder_io_a; // @[Float.scala 14:27]
  wire [16:0] float_adder_io_b; // @[Float.scala 14:27]
  wire [16:0] float_adder_io_out; // @[Float.scala 14:27]
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
  input  [16:0] io_op1_re,
  input  [16:0] io_op1_im,
  input  [16:0] io_op2_re,
  input  [16:0] io_op2_im,
  output [16:0] io_res_re,
  output [16:0] io_res_im
);
  wire [16:0] io_res_re_inst_io_op1; // @[Float.scala 25:22]
  wire [16:0] io_res_re_inst_io_op2; // @[Float.scala 25:22]
  wire [16:0] io_res_re_inst_io_res; // @[Float.scala 25:22]
  wire [16:0] io_res_im_inst_io_op1; // @[Float.scala 25:22]
  wire [16:0] io_res_im_inst_io_op2; // @[Float.scala 25:22]
  wire [16:0] io_res_im_inst_io_res; // @[Float.scala 25:22]
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
  input  [16:0] io_op1,
  input  [16:0] io_op2,
  output [16:0] io_res
);
  wire  float_adder_io_subOp; // @[Float.scala 34:27]
  wire [16:0] float_adder_io_a; // @[Float.scala 34:27]
  wire [16:0] float_adder_io_b; // @[Float.scala 34:27]
  wire [16:0] float_adder_io_out; // @[Float.scala 34:27]
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
  input  [16:0] io_op1_re,
  input  [16:0] io_op1_im,
  input  [16:0] io_op2_re,
  input  [16:0] io_op2_im,
  output [16:0] io_res_re,
  output [16:0] io_res_im
);
  wire [16:0] io_res_re_inst_io_op1; // @[Float.scala 45:22]
  wire [16:0] io_res_re_inst_io_op2; // @[Float.scala 45:22]
  wire [16:0] io_res_re_inst_io_res; // @[Float.scala 45:22]
  wire [16:0] io_res_im_inst_io_op1; // @[Float.scala 45:22]
  wire [16:0] io_res_im_inst_io_op2; // @[Float.scala 45:22]
  wire [16:0] io_res_im_inst_io_res; // @[Float.scala 45:22]
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
  input  [6:0]  io_a_sExp,
  input  [11:0] io_a_sig,
  input         io_b_isNaN,
  input         io_b_isInf,
  input         io_b_isZero,
  input         io_b_sign,
  input  [6:0]  io_b_sExp,
  input  [11:0] io_b_sig,
  output        io_invalidExc,
  output        io_rawOut_isNaN,
  output        io_rawOut_isInf,
  output        io_rawOut_isZero,
  output        io_rawOut_sign,
  output [6:0]  io_rawOut_sExp,
  output [21:0] io_rawOut_sig
);
  wire  notSigNaN_invalidExc = io_a_isInf & io_b_isZero | io_a_isZero & io_b_isInf; // @[MulRecFN.scala 58:60]
  wire [6:0] _common_sExpOut_T_2 = $signed(io_a_sExp) + $signed(io_b_sExp); // @[MulRecFN.scala 62:36]
  wire [23:0] _common_sigOut_T = io_a_sig * io_b_sig; // @[MulRecFN.scala 63:35]
  wire  _io_invalidExc_T_2 = io_a_isNaN & ~io_a_sig[9]; // @[common.scala 82:46]
  wire  _io_invalidExc_T_5 = io_b_isNaN & ~io_b_sig[9]; // @[common.scala 82:46]
  assign io_invalidExc = _io_invalidExc_T_2 | _io_invalidExc_T_5 | notSigNaN_invalidExc; // @[MulRecFN.scala 66:71]
  assign io_rawOut_isNaN = io_a_isNaN | io_b_isNaN; // @[MulRecFN.scala 70:35]
  assign io_rawOut_isInf = io_a_isInf | io_b_isInf; // @[MulRecFN.scala 59:38]
  assign io_rawOut_isZero = io_a_isZero | io_b_isZero; // @[MulRecFN.scala 60:40]
  assign io_rawOut_sign = io_a_sign ^ io_b_sign; // @[MulRecFN.scala 61:36]
  assign io_rawOut_sExp = $signed(_common_sExpOut_T_2) - 7'sh20; // @[MulRecFN.scala 62:48]
  assign io_rawOut_sig = _common_sigOut_T[21:0]; // @[MulRecFN.scala 63:46]
endmodule
module MulRawFN(
  input         io_a_isNaN,
  input         io_a_isInf,
  input         io_a_isZero,
  input         io_a_sign,
  input  [6:0]  io_a_sExp,
  input  [11:0] io_a_sig,
  input         io_b_isNaN,
  input         io_b_isInf,
  input         io_b_isZero,
  input         io_b_sign,
  input  [6:0]  io_b_sExp,
  input  [11:0] io_b_sig,
  output        io_invalidExc,
  output        io_rawOut_isNaN,
  output        io_rawOut_isInf,
  output        io_rawOut_isZero,
  output        io_rawOut_sign,
  output [6:0]  io_rawOut_sExp,
  output [13:0] io_rawOut_sig
);
  wire  mulFullRaw_io_a_isNaN; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_a_isInf; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_a_isZero; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_a_sign; // @[MulRecFN.scala 84:28]
  wire [6:0] mulFullRaw_io_a_sExp; // @[MulRecFN.scala 84:28]
  wire [11:0] mulFullRaw_io_a_sig; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_b_isNaN; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_b_isInf; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_b_isZero; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_b_sign; // @[MulRecFN.scala 84:28]
  wire [6:0] mulFullRaw_io_b_sExp; // @[MulRecFN.scala 84:28]
  wire [11:0] mulFullRaw_io_b_sig; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_invalidExc; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_rawOut_isNaN; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_rawOut_isInf; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_rawOut_isZero; // @[MulRecFN.scala 84:28]
  wire  mulFullRaw_io_rawOut_sign; // @[MulRecFN.scala 84:28]
  wire [6:0] mulFullRaw_io_rawOut_sExp; // @[MulRecFN.scala 84:28]
  wire [21:0] mulFullRaw_io_rawOut_sig; // @[MulRecFN.scala 84:28]
  wire  _io_rawOut_sig_T_2 = |mulFullRaw_io_rawOut_sig[8:0]; // @[MulRecFN.scala 93:55]
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
  assign io_rawOut_sig = {mulFullRaw_io_rawOut_sig[21:9],_io_rawOut_sig_T_2}; // @[Cat.scala 33:92]
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
  input  [16:0] io_a,
  input  [16:0] io_b,
  output [16:0] io_out
);
  wire  mulRawFN__io_a_isNaN; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_a_isInf; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_a_isZero; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_a_sign; // @[MulRecFN.scala 113:26]
  wire [6:0] mulRawFN__io_a_sExp; // @[MulRecFN.scala 113:26]
  wire [11:0] mulRawFN__io_a_sig; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_b_isNaN; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_b_isInf; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_b_isZero; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_b_sign; // @[MulRecFN.scala 113:26]
  wire [6:0] mulRawFN__io_b_sExp; // @[MulRecFN.scala 113:26]
  wire [11:0] mulRawFN__io_b_sig; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_invalidExc; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_rawOut_isNaN; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_rawOut_isInf; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_rawOut_isZero; // @[MulRecFN.scala 113:26]
  wire  mulRawFN__io_rawOut_sign; // @[MulRecFN.scala 113:26]
  wire [6:0] mulRawFN__io_rawOut_sExp; // @[MulRecFN.scala 113:26]
  wire [13:0] mulRawFN__io_rawOut_sig; // @[MulRecFN.scala 113:26]
  wire  roundRawFNToRecFN_io_invalidExc; // @[MulRecFN.scala 121:15]
  wire  roundRawFNToRecFN_io_in_isNaN; // @[MulRecFN.scala 121:15]
  wire  roundRawFNToRecFN_io_in_isInf; // @[MulRecFN.scala 121:15]
  wire  roundRawFNToRecFN_io_in_isZero; // @[MulRecFN.scala 121:15]
  wire  roundRawFNToRecFN_io_in_sign; // @[MulRecFN.scala 121:15]
  wire [6:0] roundRawFNToRecFN_io_in_sExp; // @[MulRecFN.scala 121:15]
  wire [13:0] roundRawFNToRecFN_io_in_sig; // @[MulRecFN.scala 121:15]
  wire [16:0] roundRawFNToRecFN_io_out; // @[MulRecFN.scala 121:15]
  wire [5:0] mulRawFN_io_a_exp = io_a[15:10]; // @[rawFloatFromRecFN.scala 50:21]
  wire  mulRawFN_io_a_isZero = mulRawFN_io_a_exp[5:3] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  wire  mulRawFN_io_a_isSpecial = mulRawFN_io_a_exp[5:4] == 2'h3; // @[rawFloatFromRecFN.scala 52:54]
  wire  _mulRawFN_io_a_out_sig_T = ~mulRawFN_io_a_isZero; // @[rawFloatFromRecFN.scala 60:39]
  wire [1:0] mulRawFN_io_a_out_sig_hi = {1'h0,_mulRawFN_io_a_out_sig_T}; // @[Cat.scala 33:92]
  wire [5:0] mulRawFN_io_b_exp = io_b[15:10]; // @[rawFloatFromRecFN.scala 50:21]
  wire  mulRawFN_io_b_isZero = mulRawFN_io_b_exp[5:3] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  wire  mulRawFN_io_b_isSpecial = mulRawFN_io_b_exp[5:4] == 2'h3; // @[rawFloatFromRecFN.scala 52:54]
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
  assign mulRawFN__io_a_isNaN = mulRawFN_io_a_isSpecial & mulRawFN_io_a_exp[3]; // @[rawFloatFromRecFN.scala 55:33]
  assign mulRawFN__io_a_isInf = mulRawFN_io_a_isSpecial & ~mulRawFN_io_a_exp[3]; // @[rawFloatFromRecFN.scala 56:33]
  assign mulRawFN__io_a_isZero = mulRawFN_io_a_exp[5:3] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  assign mulRawFN__io_a_sign = io_a[16]; // @[rawFloatFromRecFN.scala 58:25]
  assign mulRawFN__io_a_sExp = {1'b0,$signed(mulRawFN_io_a_exp)}; // @[rawFloatFromRecFN.scala 59:27]
  assign mulRawFN__io_a_sig = {mulRawFN_io_a_out_sig_hi,io_a[9:0]}; // @[Cat.scala 33:92]
  assign mulRawFN__io_b_isNaN = mulRawFN_io_b_isSpecial & mulRawFN_io_b_exp[3]; // @[rawFloatFromRecFN.scala 55:33]
  assign mulRawFN__io_b_isInf = mulRawFN_io_b_isSpecial & ~mulRawFN_io_b_exp[3]; // @[rawFloatFromRecFN.scala 56:33]
  assign mulRawFN__io_b_isZero = mulRawFN_io_b_exp[5:3] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  assign mulRawFN__io_b_sign = io_b[16]; // @[rawFloatFromRecFN.scala 58:25]
  assign mulRawFN__io_b_sExp = {1'b0,$signed(mulRawFN_io_b_exp)}; // @[rawFloatFromRecFN.scala 59:27]
  assign mulRawFN__io_b_sig = {mulRawFN_io_b_out_sig_hi,io_b[9:0]}; // @[Cat.scala 33:92]
  assign roundRawFNToRecFN_io_invalidExc = mulRawFN__io_invalidExc; // @[MulRecFN.scala 122:39]
  assign roundRawFNToRecFN_io_in_isNaN = mulRawFN__io_rawOut_isNaN; // @[MulRecFN.scala 124:39]
  assign roundRawFNToRecFN_io_in_isInf = mulRawFN__io_rawOut_isInf; // @[MulRecFN.scala 124:39]
  assign roundRawFNToRecFN_io_in_isZero = mulRawFN__io_rawOut_isZero; // @[MulRecFN.scala 124:39]
  assign roundRawFNToRecFN_io_in_sign = mulRawFN__io_rawOut_sign; // @[MulRecFN.scala 124:39]
  assign roundRawFNToRecFN_io_in_sExp = mulRawFN__io_rawOut_sExp; // @[MulRecFN.scala 124:39]
  assign roundRawFNToRecFN_io_in_sig = mulRawFN__io_rawOut_sig; // @[MulRecFN.scala 124:39]
endmodule
module FloatMul(
  input  [16:0] io_op1,
  input  [16:0] io_op2,
  output [16:0] io_res
);
  wire [16:0] float_adder_io_a; // @[Float.scala 54:27]
  wire [16:0] float_adder_io_b; // @[Float.scala 54:27]
  wire [16:0] float_adder_io_out; // @[Float.scala 54:27]
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
  input  [16:0] io_op1_re,
  input  [16:0] io_op1_im,
  input  [16:0] io_op2_re,
  input  [16:0] io_op2_im,
  output [16:0] io_res_re,
  output [16:0] io_res_im
);
  wire [16:0] io_res_re_inst_io_op1; // @[Float.scala 64:22]
  wire [16:0] io_res_re_inst_io_op2; // @[Float.scala 64:22]
  wire [16:0] io_res_re_inst_io_res; // @[Float.scala 64:22]
  wire [16:0] io_res_re_inst_1_io_op1; // @[Float.scala 64:22]
  wire [16:0] io_res_re_inst_1_io_op2; // @[Float.scala 64:22]
  wire [16:0] io_res_re_inst_1_io_res; // @[Float.scala 64:22]
  wire [16:0] io_res_re_inst_2_io_op1; // @[Float.scala 45:22]
  wire [16:0] io_res_re_inst_2_io_op2; // @[Float.scala 45:22]
  wire [16:0] io_res_re_inst_2_io_res; // @[Float.scala 45:22]
  wire [16:0] io_res_im_inst_io_op1; // @[Float.scala 64:22]
  wire [16:0] io_res_im_inst_io_op2; // @[Float.scala 64:22]
  wire [16:0] io_res_im_inst_io_res; // @[Float.scala 64:22]
  wire [16:0] io_res_im_inst_1_io_op1; // @[Float.scala 64:22]
  wire [16:0] io_res_im_inst_1_io_op2; // @[Float.scala 64:22]
  wire [16:0] io_res_im_inst_1_io_res; // @[Float.scala 64:22]
  wire [16:0] io_res_im_inst_2_io_op1; // @[Float.scala 25:22]
  wire [16:0] io_res_im_inst_2_io_op2; // @[Float.scala 25:22]
  wire [16:0] io_res_im_inst_2_io_res; // @[Float.scala 25:22]
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
  input  [16:0] io_in_0_re,
  input  [16:0] io_in_0_im,
  input  [16:0] io_in_1_re,
  input  [16:0] io_in_1_im,
  output [16:0] io_out_0_re,
  output [16:0] io_out_0_im,
  output [16:0] io_out_1_re,
  output [16:0] io_out_1_im,
  input  [16:0] io_wn_0_re,
  input  [16:0] io_wn_0_im
);
  wire [16:0] temp_0_inst_io_op1_re; // @[Modules.scala 81:22]
  wire [16:0] temp_0_inst_io_op1_im; // @[Modules.scala 81:22]
  wire [16:0] temp_0_inst_io_op2_re; // @[Modules.scala 81:22]
  wire [16:0] temp_0_inst_io_op2_im; // @[Modules.scala 81:22]
  wire [16:0] temp_0_inst_io_res_re; // @[Modules.scala 81:22]
  wire [16:0] temp_0_inst_io_res_im; // @[Modules.scala 81:22]
  wire [16:0] temp_1_inst_io_op1_re; // @[Modules.scala 100:22]
  wire [16:0] temp_1_inst_io_op1_im; // @[Modules.scala 100:22]
  wire [16:0] temp_1_inst_io_op2_re; // @[Modules.scala 100:22]
  wire [16:0] temp_1_inst_io_op2_im; // @[Modules.scala 100:22]
  wire [16:0] temp_1_inst_io_res_re; // @[Modules.scala 100:22]
  wire [16:0] temp_1_inst_io_res_im; // @[Modules.scala 100:22]
  wire [16:0] io_out_1_inst_io_op1_re; // @[Modules.scala 158:22]
  wire [16:0] io_out_1_inst_io_op1_im; // @[Modules.scala 158:22]
  wire [16:0] io_out_1_inst_io_op2_re; // @[Modules.scala 158:22]
  wire [16:0] io_out_1_inst_io_op2_im; // @[Modules.scala 158:22]
  wire [16:0] io_out_1_inst_io_res_re; // @[Modules.scala 158:22]
  wire [16:0] io_out_1_inst_io_res_im; // @[Modules.scala 158:22]
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
  input  [16:0] io_in_0_re,
  input  [16:0] io_in_0_im,
  input  [16:0] io_in_1_re,
  input  [16:0] io_in_1_im,
  output [16:0] io_out_0_re,
  output [16:0] io_out_0_im,
  output [16:0] io_out_1_re,
  output [16:0] io_out_1_im
);
  wire [16:0] io_out_0_inst_io_op1_re; // @[Modules.scala 81:22]
  wire [16:0] io_out_0_inst_io_op1_im; // @[Modules.scala 81:22]
  wire [16:0] io_out_0_inst_io_op2_re; // @[Modules.scala 81:22]
  wire [16:0] io_out_0_inst_io_op2_im; // @[Modules.scala 81:22]
  wire [16:0] io_out_0_inst_io_res_re; // @[Modules.scala 81:22]
  wire [16:0] io_out_0_inst_io_res_im; // @[Modules.scala 81:22]
  wire [16:0] io_out_1_inst_io_op1_re; // @[Modules.scala 100:22]
  wire [16:0] io_out_1_inst_io_op1_im; // @[Modules.scala 100:22]
  wire [16:0] io_out_1_inst_io_op2_re; // @[Modules.scala 100:22]
  wire [16:0] io_out_1_inst_io_op2_im; // @[Modules.scala 100:22]
  wire [16:0] io_out_1_inst_io_res_re; // @[Modules.scala 100:22]
  wire [16:0] io_out_1_inst_io_res_im; // @[Modules.scala 100:22]
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
  input  [16:0] io_in_0_0_re,
  input  [16:0] io_in_0_0_im,
  input  [16:0] io_in_0_1_re,
  input  [16:0] io_in_0_1_im,
  input  [16:0] io_in_1_0_re,
  input  [16:0] io_in_1_0_im,
  input  [16:0] io_in_1_1_re,
  input  [16:0] io_in_1_1_im,
  output [16:0] io_out_0_0_re,
  output [16:0] io_out_0_0_im,
  output [16:0] io_out_0_1_re,
  output [16:0] io_out_0_1_im,
  output [16:0] io_out_1_0_re,
  output [16:0] io_out_1_0_im,
  output [16:0] io_out_1_1_re,
  output [16:0] io_out_1_1_im
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
  input  [16:0] io_in_0_re,
  input  [16:0] io_in_0_im,
  input  [16:0] io_in_1_re,
  input  [16:0] io_in_1_im,
  output [16:0] io_out_0_re,
  output [16:0] io_out_0_im,
  output [16:0] io_out_1_re,
  output [16:0] io_out_1_im,
  input         io_sel
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
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
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
`endif // RANDOMIZE_REG_INIT
  reg [16:0] swdata_1_r_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_1_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_1_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_2_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_2_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_3_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_3_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_4_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_4_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_5_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_5_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_6_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_6_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_7_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_7_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_8_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_8_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_9_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_9_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_10_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_10_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_11_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_11_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_12_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_12_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_13_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_13_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_14_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_14_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_15_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_15_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_1_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_1_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_2_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_2_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_3_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_3_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_4_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_4_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_5_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_5_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_6_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_6_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_7_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_7_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_8_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_8_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_9_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_9_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_10_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_10_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_11_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_11_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_12_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_12_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_13_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_13_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_14_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_14_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_15_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_15_im; // @[Reg.scala 19:16]
  assign io_out_0_re = io_out_0_r_15_re; // @[Modules.scala 306:38]
  assign io_out_0_im = io_out_0_r_15_im; // @[Modules.scala 306:38]
  assign io_out_1_re = io_sel ? io_in_0_re : swdata_1_r_15_re; // @[Modules.scala 306:{38,38}]
  assign io_out_1_im = io_sel ? io_in_0_im : swdata_1_r_15_im; // @[Modules.scala 306:{38,38}]
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
    swdata_1_r_8_re <= swdata_1_r_7_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_8_im <= swdata_1_r_7_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_9_re <= swdata_1_r_8_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_9_im <= swdata_1_r_8_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_10_re <= swdata_1_r_9_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_10_im <= swdata_1_r_9_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_11_re <= swdata_1_r_10_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_11_im <= swdata_1_r_10_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_12_re <= swdata_1_r_11_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_12_im <= swdata_1_r_11_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_13_re <= swdata_1_r_12_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_13_im <= swdata_1_r_12_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_14_re <= swdata_1_r_13_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_14_im <= swdata_1_r_13_im; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_15_re <= swdata_1_r_14_re; // @[Reg.scala 19:16 20:{18,22}]
    swdata_1_r_15_im <= swdata_1_r_14_im; // @[Reg.scala 19:16 20:{18,22}]
    if (io_sel) begin // @[Reg.scala 20:22]
      io_out_0_r_re <= swdata_1_r_15_re; // @[Reg.scala 20:22]
    end else begin
      io_out_0_r_re <= io_in_0_re;
    end
    if (io_sel) begin // @[Reg.scala 20:22]
      io_out_0_r_im <= swdata_1_r_15_im; // @[Reg.scala 20:22]
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
    io_out_0_r_8_re <= io_out_0_r_7_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_8_im <= io_out_0_r_7_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_9_re <= io_out_0_r_8_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_9_im <= io_out_0_r_8_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_10_re <= io_out_0_r_9_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_10_im <= io_out_0_r_9_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_11_re <= io_out_0_r_10_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_11_im <= io_out_0_r_10_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_12_re <= io_out_0_r_11_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_12_im <= io_out_0_r_11_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_13_re <= io_out_0_r_12_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_13_im <= io_out_0_r_12_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_14_re <= io_out_0_r_13_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_14_im <= io_out_0_r_13_im; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_15_re <= io_out_0_r_14_re; // @[Reg.scala 19:16 20:{18,22}]
    io_out_0_r_15_im <= io_out_0_r_14_im; // @[Reg.scala 19:16 20:{18,22}]
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
  swdata_1_r_re = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  swdata_1_r_im = _RAND_1[16:0];
  _RAND_2 = {1{`RANDOM}};
  swdata_1_r_1_re = _RAND_2[16:0];
  _RAND_3 = {1{`RANDOM}};
  swdata_1_r_1_im = _RAND_3[16:0];
  _RAND_4 = {1{`RANDOM}};
  swdata_1_r_2_re = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  swdata_1_r_2_im = _RAND_5[16:0];
  _RAND_6 = {1{`RANDOM}};
  swdata_1_r_3_re = _RAND_6[16:0];
  _RAND_7 = {1{`RANDOM}};
  swdata_1_r_3_im = _RAND_7[16:0];
  _RAND_8 = {1{`RANDOM}};
  swdata_1_r_4_re = _RAND_8[16:0];
  _RAND_9 = {1{`RANDOM}};
  swdata_1_r_4_im = _RAND_9[16:0];
  _RAND_10 = {1{`RANDOM}};
  swdata_1_r_5_re = _RAND_10[16:0];
  _RAND_11 = {1{`RANDOM}};
  swdata_1_r_5_im = _RAND_11[16:0];
  _RAND_12 = {1{`RANDOM}};
  swdata_1_r_6_re = _RAND_12[16:0];
  _RAND_13 = {1{`RANDOM}};
  swdata_1_r_6_im = _RAND_13[16:0];
  _RAND_14 = {1{`RANDOM}};
  swdata_1_r_7_re = _RAND_14[16:0];
  _RAND_15 = {1{`RANDOM}};
  swdata_1_r_7_im = _RAND_15[16:0];
  _RAND_16 = {1{`RANDOM}};
  swdata_1_r_8_re = _RAND_16[16:0];
  _RAND_17 = {1{`RANDOM}};
  swdata_1_r_8_im = _RAND_17[16:0];
  _RAND_18 = {1{`RANDOM}};
  swdata_1_r_9_re = _RAND_18[16:0];
  _RAND_19 = {1{`RANDOM}};
  swdata_1_r_9_im = _RAND_19[16:0];
  _RAND_20 = {1{`RANDOM}};
  swdata_1_r_10_re = _RAND_20[16:0];
  _RAND_21 = {1{`RANDOM}};
  swdata_1_r_10_im = _RAND_21[16:0];
  _RAND_22 = {1{`RANDOM}};
  swdata_1_r_11_re = _RAND_22[16:0];
  _RAND_23 = {1{`RANDOM}};
  swdata_1_r_11_im = _RAND_23[16:0];
  _RAND_24 = {1{`RANDOM}};
  swdata_1_r_12_re = _RAND_24[16:0];
  _RAND_25 = {1{`RANDOM}};
  swdata_1_r_12_im = _RAND_25[16:0];
  _RAND_26 = {1{`RANDOM}};
  swdata_1_r_13_re = _RAND_26[16:0];
  _RAND_27 = {1{`RANDOM}};
  swdata_1_r_13_im = _RAND_27[16:0];
  _RAND_28 = {1{`RANDOM}};
  swdata_1_r_14_re = _RAND_28[16:0];
  _RAND_29 = {1{`RANDOM}};
  swdata_1_r_14_im = _RAND_29[16:0];
  _RAND_30 = {1{`RANDOM}};
  swdata_1_r_15_re = _RAND_30[16:0];
  _RAND_31 = {1{`RANDOM}};
  swdata_1_r_15_im = _RAND_31[16:0];
  _RAND_32 = {1{`RANDOM}};
  io_out_0_r_re = _RAND_32[16:0];
  _RAND_33 = {1{`RANDOM}};
  io_out_0_r_im = _RAND_33[16:0];
  _RAND_34 = {1{`RANDOM}};
  io_out_0_r_1_re = _RAND_34[16:0];
  _RAND_35 = {1{`RANDOM}};
  io_out_0_r_1_im = _RAND_35[16:0];
  _RAND_36 = {1{`RANDOM}};
  io_out_0_r_2_re = _RAND_36[16:0];
  _RAND_37 = {1{`RANDOM}};
  io_out_0_r_2_im = _RAND_37[16:0];
  _RAND_38 = {1{`RANDOM}};
  io_out_0_r_3_re = _RAND_38[16:0];
  _RAND_39 = {1{`RANDOM}};
  io_out_0_r_3_im = _RAND_39[16:0];
  _RAND_40 = {1{`RANDOM}};
  io_out_0_r_4_re = _RAND_40[16:0];
  _RAND_41 = {1{`RANDOM}};
  io_out_0_r_4_im = _RAND_41[16:0];
  _RAND_42 = {1{`RANDOM}};
  io_out_0_r_5_re = _RAND_42[16:0];
  _RAND_43 = {1{`RANDOM}};
  io_out_0_r_5_im = _RAND_43[16:0];
  _RAND_44 = {1{`RANDOM}};
  io_out_0_r_6_re = _RAND_44[16:0];
  _RAND_45 = {1{`RANDOM}};
  io_out_0_r_6_im = _RAND_45[16:0];
  _RAND_46 = {1{`RANDOM}};
  io_out_0_r_7_re = _RAND_46[16:0];
  _RAND_47 = {1{`RANDOM}};
  io_out_0_r_7_im = _RAND_47[16:0];
  _RAND_48 = {1{`RANDOM}};
  io_out_0_r_8_re = _RAND_48[16:0];
  _RAND_49 = {1{`RANDOM}};
  io_out_0_r_8_im = _RAND_49[16:0];
  _RAND_50 = {1{`RANDOM}};
  io_out_0_r_9_re = _RAND_50[16:0];
  _RAND_51 = {1{`RANDOM}};
  io_out_0_r_9_im = _RAND_51[16:0];
  _RAND_52 = {1{`RANDOM}};
  io_out_0_r_10_re = _RAND_52[16:0];
  _RAND_53 = {1{`RANDOM}};
  io_out_0_r_10_im = _RAND_53[16:0];
  _RAND_54 = {1{`RANDOM}};
  io_out_0_r_11_re = _RAND_54[16:0];
  _RAND_55 = {1{`RANDOM}};
  io_out_0_r_11_im = _RAND_55[16:0];
  _RAND_56 = {1{`RANDOM}};
  io_out_0_r_12_re = _RAND_56[16:0];
  _RAND_57 = {1{`RANDOM}};
  io_out_0_r_12_im = _RAND_57[16:0];
  _RAND_58 = {1{`RANDOM}};
  io_out_0_r_13_re = _RAND_58[16:0];
  _RAND_59 = {1{`RANDOM}};
  io_out_0_r_13_im = _RAND_59[16:0];
  _RAND_60 = {1{`RANDOM}};
  io_out_0_r_14_re = _RAND_60[16:0];
  _RAND_61 = {1{`RANDOM}};
  io_out_0_r_14_im = _RAND_61[16:0];
  _RAND_62 = {1{`RANDOM}};
  io_out_0_r_15_re = _RAND_62[16:0];
  _RAND_63 = {1{`RANDOM}};
  io_out_0_r_15_im = _RAND_63[16:0];
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
  input  [16:0] io_in_0_re,
  input  [16:0] io_in_0_im,
  input  [16:0] io_in_1_re,
  input  [16:0] io_in_1_im,
  output [16:0] io_out_0_re,
  output [16:0] io_out_0_im,
  output [16:0] io_out_1_re,
  output [16:0] io_out_1_im,
  input         io_sel
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
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
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [16:0] swdata_1_r_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_1_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_1_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_2_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_2_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_3_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_3_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_4_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_4_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_5_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_5_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_6_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_6_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_7_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_7_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_1_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_1_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_2_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_2_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_3_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_3_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_4_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_4_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_5_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_5_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_6_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_6_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_7_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_7_im; // @[Reg.scala 19:16]
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
  _RAND_0 = {1{`RANDOM}};
  swdata_1_r_re = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  swdata_1_r_im = _RAND_1[16:0];
  _RAND_2 = {1{`RANDOM}};
  swdata_1_r_1_re = _RAND_2[16:0];
  _RAND_3 = {1{`RANDOM}};
  swdata_1_r_1_im = _RAND_3[16:0];
  _RAND_4 = {1{`RANDOM}};
  swdata_1_r_2_re = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  swdata_1_r_2_im = _RAND_5[16:0];
  _RAND_6 = {1{`RANDOM}};
  swdata_1_r_3_re = _RAND_6[16:0];
  _RAND_7 = {1{`RANDOM}};
  swdata_1_r_3_im = _RAND_7[16:0];
  _RAND_8 = {1{`RANDOM}};
  swdata_1_r_4_re = _RAND_8[16:0];
  _RAND_9 = {1{`RANDOM}};
  swdata_1_r_4_im = _RAND_9[16:0];
  _RAND_10 = {1{`RANDOM}};
  swdata_1_r_5_re = _RAND_10[16:0];
  _RAND_11 = {1{`RANDOM}};
  swdata_1_r_5_im = _RAND_11[16:0];
  _RAND_12 = {1{`RANDOM}};
  swdata_1_r_6_re = _RAND_12[16:0];
  _RAND_13 = {1{`RANDOM}};
  swdata_1_r_6_im = _RAND_13[16:0];
  _RAND_14 = {1{`RANDOM}};
  swdata_1_r_7_re = _RAND_14[16:0];
  _RAND_15 = {1{`RANDOM}};
  swdata_1_r_7_im = _RAND_15[16:0];
  _RAND_16 = {1{`RANDOM}};
  io_out_0_r_re = _RAND_16[16:0];
  _RAND_17 = {1{`RANDOM}};
  io_out_0_r_im = _RAND_17[16:0];
  _RAND_18 = {1{`RANDOM}};
  io_out_0_r_1_re = _RAND_18[16:0];
  _RAND_19 = {1{`RANDOM}};
  io_out_0_r_1_im = _RAND_19[16:0];
  _RAND_20 = {1{`RANDOM}};
  io_out_0_r_2_re = _RAND_20[16:0];
  _RAND_21 = {1{`RANDOM}};
  io_out_0_r_2_im = _RAND_21[16:0];
  _RAND_22 = {1{`RANDOM}};
  io_out_0_r_3_re = _RAND_22[16:0];
  _RAND_23 = {1{`RANDOM}};
  io_out_0_r_3_im = _RAND_23[16:0];
  _RAND_24 = {1{`RANDOM}};
  io_out_0_r_4_re = _RAND_24[16:0];
  _RAND_25 = {1{`RANDOM}};
  io_out_0_r_4_im = _RAND_25[16:0];
  _RAND_26 = {1{`RANDOM}};
  io_out_0_r_5_re = _RAND_26[16:0];
  _RAND_27 = {1{`RANDOM}};
  io_out_0_r_5_im = _RAND_27[16:0];
  _RAND_28 = {1{`RANDOM}};
  io_out_0_r_6_re = _RAND_28[16:0];
  _RAND_29 = {1{`RANDOM}};
  io_out_0_r_6_im = _RAND_29[16:0];
  _RAND_30 = {1{`RANDOM}};
  io_out_0_r_7_re = _RAND_30[16:0];
  _RAND_31 = {1{`RANDOM}};
  io_out_0_r_7_im = _RAND_31[16:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Switch_8(
  input         clock,
  input  [16:0] io_in_0_re,
  input  [16:0] io_in_0_im,
  input  [16:0] io_in_1_re,
  input  [16:0] io_in_1_im,
  output [16:0] io_out_0_re,
  output [16:0] io_out_0_im,
  output [16:0] io_out_1_re,
  output [16:0] io_out_1_im,
  input         io_sel
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
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
  reg [16:0] swdata_1_r_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_1_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_1_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_2_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_2_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_3_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_3_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_1_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_1_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_2_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_2_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_3_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_3_im; // @[Reg.scala 19:16]
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
  _RAND_0 = {1{`RANDOM}};
  swdata_1_r_re = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  swdata_1_r_im = _RAND_1[16:0];
  _RAND_2 = {1{`RANDOM}};
  swdata_1_r_1_re = _RAND_2[16:0];
  _RAND_3 = {1{`RANDOM}};
  swdata_1_r_1_im = _RAND_3[16:0];
  _RAND_4 = {1{`RANDOM}};
  swdata_1_r_2_re = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  swdata_1_r_2_im = _RAND_5[16:0];
  _RAND_6 = {1{`RANDOM}};
  swdata_1_r_3_re = _RAND_6[16:0];
  _RAND_7 = {1{`RANDOM}};
  swdata_1_r_3_im = _RAND_7[16:0];
  _RAND_8 = {1{`RANDOM}};
  io_out_0_r_re = _RAND_8[16:0];
  _RAND_9 = {1{`RANDOM}};
  io_out_0_r_im = _RAND_9[16:0];
  _RAND_10 = {1{`RANDOM}};
  io_out_0_r_1_re = _RAND_10[16:0];
  _RAND_11 = {1{`RANDOM}};
  io_out_0_r_1_im = _RAND_11[16:0];
  _RAND_12 = {1{`RANDOM}};
  io_out_0_r_2_re = _RAND_12[16:0];
  _RAND_13 = {1{`RANDOM}};
  io_out_0_r_2_im = _RAND_13[16:0];
  _RAND_14 = {1{`RANDOM}};
  io_out_0_r_3_re = _RAND_14[16:0];
  _RAND_15 = {1{`RANDOM}};
  io_out_0_r_3_im = _RAND_15[16:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Switch_12(
  input         clock,
  input  [16:0] io_in_0_re,
  input  [16:0] io_in_0_im,
  input  [16:0] io_in_1_re,
  input  [16:0] io_in_1_im,
  output [16:0] io_out_0_re,
  output [16:0] io_out_0_im,
  output [16:0] io_out_1_re,
  output [16:0] io_out_1_im,
  input         io_sel
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [16:0] swdata_1_r_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_im; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_1_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_1_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_1_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_1_im; // @[Reg.scala 19:16]
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
  _RAND_0 = {1{`RANDOM}};
  swdata_1_r_re = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  swdata_1_r_im = _RAND_1[16:0];
  _RAND_2 = {1{`RANDOM}};
  swdata_1_r_1_re = _RAND_2[16:0];
  _RAND_3 = {1{`RANDOM}};
  swdata_1_r_1_im = _RAND_3[16:0];
  _RAND_4 = {1{`RANDOM}};
  io_out_0_r_re = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  io_out_0_r_im = _RAND_5[16:0];
  _RAND_6 = {1{`RANDOM}};
  io_out_0_r_1_re = _RAND_6[16:0];
  _RAND_7 = {1{`RANDOM}};
  io_out_0_r_1_im = _RAND_7[16:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Switch_16(
  input         clock,
  input  [16:0] io_in_0_re,
  input  [16:0] io_in_0_im,
  input  [16:0] io_in_1_re,
  input  [16:0] io_in_1_im,
  output [16:0] io_out_0_re,
  output [16:0] io_out_0_im,
  output [16:0] io_out_1_re,
  output [16:0] io_out_1_im,
  input         io_sel
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [16:0] swdata_1_r_re; // @[Reg.scala 19:16]
  reg [16:0] swdata_1_r_im; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_re; // @[Reg.scala 19:16]
  reg [16:0] io_out_0_r_im; // @[Reg.scala 19:16]
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
  _RAND_0 = {1{`RANDOM}};
  swdata_1_r_re = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  swdata_1_r_im = _RAND_1[16:0];
  _RAND_2 = {1{`RANDOM}};
  io_out_0_r_re = _RAND_2[16:0];
  _RAND_3 = {1{`RANDOM}};
  io_out_0_r_im = _RAND_3[16:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ComplexRecode(
  input  [15:0] io_in_re,
  input  [15:0] io_in_im,
  output [16:0] io_out_re,
  output [16:0] io_out_im
);
  wire  io_out_re_rawIn_sign = io_in_re[15]; // @[rawFloatFromFN.scala 46:22]
  wire [4:0] io_out_re_rawIn_expIn = io_in_re[14:10]; // @[rawFloatFromFN.scala 47:23]
  wire [9:0] io_out_re_rawIn_fractIn = io_in_re[9:0]; // @[rawFloatFromFN.scala 48:25]
  wire  io_out_re_rawIn_isZeroExpIn = io_out_re_rawIn_expIn == 5'h0; // @[rawFloatFromFN.scala 50:34]
  wire  io_out_re_rawIn_isZeroFractIn = io_out_re_rawIn_fractIn == 10'h0; // @[rawFloatFromFN.scala 51:38]
  wire [3:0] _io_out_re_rawIn_normDist_T_10 = io_out_re_rawIn_fractIn[1] ? 4'h8 : 4'h9; // @[Mux.scala 47:70]
  wire [3:0] _io_out_re_rawIn_normDist_T_11 = io_out_re_rawIn_fractIn[2] ? 4'h7 : _io_out_re_rawIn_normDist_T_10; // @[Mux.scala 47:70]
  wire [3:0] _io_out_re_rawIn_normDist_T_12 = io_out_re_rawIn_fractIn[3] ? 4'h6 : _io_out_re_rawIn_normDist_T_11; // @[Mux.scala 47:70]
  wire [3:0] _io_out_re_rawIn_normDist_T_13 = io_out_re_rawIn_fractIn[4] ? 4'h5 : _io_out_re_rawIn_normDist_T_12; // @[Mux.scala 47:70]
  wire [3:0] _io_out_re_rawIn_normDist_T_14 = io_out_re_rawIn_fractIn[5] ? 4'h4 : _io_out_re_rawIn_normDist_T_13; // @[Mux.scala 47:70]
  wire [3:0] _io_out_re_rawIn_normDist_T_15 = io_out_re_rawIn_fractIn[6] ? 4'h3 : _io_out_re_rawIn_normDist_T_14; // @[Mux.scala 47:70]
  wire [3:0] _io_out_re_rawIn_normDist_T_16 = io_out_re_rawIn_fractIn[7] ? 4'h2 : _io_out_re_rawIn_normDist_T_15; // @[Mux.scala 47:70]
  wire [3:0] _io_out_re_rawIn_normDist_T_17 = io_out_re_rawIn_fractIn[8] ? 4'h1 : _io_out_re_rawIn_normDist_T_16; // @[Mux.scala 47:70]
  wire [3:0] io_out_re_rawIn_normDist = io_out_re_rawIn_fractIn[9] ? 4'h0 : _io_out_re_rawIn_normDist_T_17; // @[Mux.scala 47:70]
  wire [24:0] _GEN_8 = {{15'd0}, io_out_re_rawIn_fractIn}; // @[rawFloatFromFN.scala 54:36]
  wire [24:0] _io_out_re_rawIn_subnormFract_T = _GEN_8 << io_out_re_rawIn_normDist; // @[rawFloatFromFN.scala 54:36]
  wire [9:0] io_out_re_rawIn_subnormFract = {_io_out_re_rawIn_subnormFract_T[8:0], 1'h0}; // @[rawFloatFromFN.scala 54:64]
  wire [5:0] _GEN_0 = {{2'd0}, io_out_re_rawIn_normDist}; // @[rawFloatFromFN.scala 57:26]
  wire [5:0] _io_out_re_rawIn_adjustedExp_T = _GEN_0 ^ 6'h3f; // @[rawFloatFromFN.scala 57:26]
  wire [5:0] _io_out_re_rawIn_adjustedExp_T_1 = io_out_re_rawIn_isZeroExpIn ? _io_out_re_rawIn_adjustedExp_T : {{1'd0},
    io_out_re_rawIn_expIn}; // @[rawFloatFromFN.scala 56:16]
  wire [1:0] _io_out_re_rawIn_adjustedExp_T_2 = io_out_re_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 60:27]
  wire [4:0] _GEN_1 = {{3'd0}, _io_out_re_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 60:22]
  wire [4:0] _io_out_re_rawIn_adjustedExp_T_3 = 5'h10 | _GEN_1; // @[rawFloatFromFN.scala 60:22]
  wire [5:0] _GEN_2 = {{1'd0}, _io_out_re_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 59:15]
  wire [5:0] io_out_re_rawIn_adjustedExp = _io_out_re_rawIn_adjustedExp_T_1 + _GEN_2; // @[rawFloatFromFN.scala 59:15]
  wire  io_out_re_rawIn_isZero = io_out_re_rawIn_isZeroExpIn & io_out_re_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 62:34]
  wire  io_out_re_rawIn_isSpecial = io_out_re_rawIn_adjustedExp[5:4] == 2'h3; // @[rawFloatFromFN.scala 63:62]
  wire  io_out_re_rawIn__isNaN = io_out_re_rawIn_isSpecial & ~io_out_re_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 66:33]
  wire [6:0] io_out_re_rawIn__sExp = {1'b0,$signed(io_out_re_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 70:48]
  wire  _io_out_re_rawIn_out_sig_T = ~io_out_re_rawIn_isZero; // @[rawFloatFromFN.scala 72:29]
  wire [9:0] _io_out_re_rawIn_out_sig_T_1 = io_out_re_rawIn_isZeroExpIn ? io_out_re_rawIn_subnormFract :
    io_out_re_rawIn_fractIn; // @[rawFloatFromFN.scala 72:42]
  wire [11:0] io_out_re_rawIn__sig = {1'h0,_io_out_re_rawIn_out_sig_T,_io_out_re_rawIn_out_sig_T_1}; // @[Cat.scala 33:92]
  wire [2:0] _io_out_re_T_1 = io_out_re_rawIn_isZero ? 3'h0 : io_out_re_rawIn__sExp[5:3]; // @[recFNFromFN.scala 48:16]
  wire [2:0] _GEN_3 = {{2'd0}, io_out_re_rawIn__isNaN}; // @[recFNFromFN.scala 48:79]
  wire [2:0] _io_out_re_T_3 = _io_out_re_T_1 | _GEN_3; // @[recFNFromFN.scala 48:79]
  wire [12:0] io_out_re_lo = {io_out_re_rawIn__sExp[2:0],io_out_re_rawIn__sig[9:0]}; // @[Cat.scala 33:92]
  wire [3:0] io_out_re_hi = {io_out_re_rawIn_sign,_io_out_re_T_3}; // @[Cat.scala 33:92]
  wire  io_out_im_rawIn_sign = io_in_im[15]; // @[rawFloatFromFN.scala 46:22]
  wire [4:0] io_out_im_rawIn_expIn = io_in_im[14:10]; // @[rawFloatFromFN.scala 47:23]
  wire [9:0] io_out_im_rawIn_fractIn = io_in_im[9:0]; // @[rawFloatFromFN.scala 48:25]
  wire  io_out_im_rawIn_isZeroExpIn = io_out_im_rawIn_expIn == 5'h0; // @[rawFloatFromFN.scala 50:34]
  wire  io_out_im_rawIn_isZeroFractIn = io_out_im_rawIn_fractIn == 10'h0; // @[rawFloatFromFN.scala 51:38]
  wire [3:0] _io_out_im_rawIn_normDist_T_10 = io_out_im_rawIn_fractIn[1] ? 4'h8 : 4'h9; // @[Mux.scala 47:70]
  wire [3:0] _io_out_im_rawIn_normDist_T_11 = io_out_im_rawIn_fractIn[2] ? 4'h7 : _io_out_im_rawIn_normDist_T_10; // @[Mux.scala 47:70]
  wire [3:0] _io_out_im_rawIn_normDist_T_12 = io_out_im_rawIn_fractIn[3] ? 4'h6 : _io_out_im_rawIn_normDist_T_11; // @[Mux.scala 47:70]
  wire [3:0] _io_out_im_rawIn_normDist_T_13 = io_out_im_rawIn_fractIn[4] ? 4'h5 : _io_out_im_rawIn_normDist_T_12; // @[Mux.scala 47:70]
  wire [3:0] _io_out_im_rawIn_normDist_T_14 = io_out_im_rawIn_fractIn[5] ? 4'h4 : _io_out_im_rawIn_normDist_T_13; // @[Mux.scala 47:70]
  wire [3:0] _io_out_im_rawIn_normDist_T_15 = io_out_im_rawIn_fractIn[6] ? 4'h3 : _io_out_im_rawIn_normDist_T_14; // @[Mux.scala 47:70]
  wire [3:0] _io_out_im_rawIn_normDist_T_16 = io_out_im_rawIn_fractIn[7] ? 4'h2 : _io_out_im_rawIn_normDist_T_15; // @[Mux.scala 47:70]
  wire [3:0] _io_out_im_rawIn_normDist_T_17 = io_out_im_rawIn_fractIn[8] ? 4'h1 : _io_out_im_rawIn_normDist_T_16; // @[Mux.scala 47:70]
  wire [3:0] io_out_im_rawIn_normDist = io_out_im_rawIn_fractIn[9] ? 4'h0 : _io_out_im_rawIn_normDist_T_17; // @[Mux.scala 47:70]
  wire [24:0] _GEN_9 = {{15'd0}, io_out_im_rawIn_fractIn}; // @[rawFloatFromFN.scala 54:36]
  wire [24:0] _io_out_im_rawIn_subnormFract_T = _GEN_9 << io_out_im_rawIn_normDist; // @[rawFloatFromFN.scala 54:36]
  wire [9:0] io_out_im_rawIn_subnormFract = {_io_out_im_rawIn_subnormFract_T[8:0], 1'h0}; // @[rawFloatFromFN.scala 54:64]
  wire [5:0] _GEN_4 = {{2'd0}, io_out_im_rawIn_normDist}; // @[rawFloatFromFN.scala 57:26]
  wire [5:0] _io_out_im_rawIn_adjustedExp_T = _GEN_4 ^ 6'h3f; // @[rawFloatFromFN.scala 57:26]
  wire [5:0] _io_out_im_rawIn_adjustedExp_T_1 = io_out_im_rawIn_isZeroExpIn ? _io_out_im_rawIn_adjustedExp_T : {{1'd0},
    io_out_im_rawIn_expIn}; // @[rawFloatFromFN.scala 56:16]
  wire [1:0] _io_out_im_rawIn_adjustedExp_T_2 = io_out_im_rawIn_isZeroExpIn ? 2'h2 : 2'h1; // @[rawFloatFromFN.scala 60:27]
  wire [4:0] _GEN_5 = {{3'd0}, _io_out_im_rawIn_adjustedExp_T_2}; // @[rawFloatFromFN.scala 60:22]
  wire [4:0] _io_out_im_rawIn_adjustedExp_T_3 = 5'h10 | _GEN_5; // @[rawFloatFromFN.scala 60:22]
  wire [5:0] _GEN_6 = {{1'd0}, _io_out_im_rawIn_adjustedExp_T_3}; // @[rawFloatFromFN.scala 59:15]
  wire [5:0] io_out_im_rawIn_adjustedExp = _io_out_im_rawIn_adjustedExp_T_1 + _GEN_6; // @[rawFloatFromFN.scala 59:15]
  wire  io_out_im_rawIn_isZero = io_out_im_rawIn_isZeroExpIn & io_out_im_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 62:34]
  wire  io_out_im_rawIn_isSpecial = io_out_im_rawIn_adjustedExp[5:4] == 2'h3; // @[rawFloatFromFN.scala 63:62]
  wire  io_out_im_rawIn__isNaN = io_out_im_rawIn_isSpecial & ~io_out_im_rawIn_isZeroFractIn; // @[rawFloatFromFN.scala 66:33]
  wire [6:0] io_out_im_rawIn__sExp = {1'b0,$signed(io_out_im_rawIn_adjustedExp)}; // @[rawFloatFromFN.scala 70:48]
  wire  _io_out_im_rawIn_out_sig_T = ~io_out_im_rawIn_isZero; // @[rawFloatFromFN.scala 72:29]
  wire [9:0] _io_out_im_rawIn_out_sig_T_1 = io_out_im_rawIn_isZeroExpIn ? io_out_im_rawIn_subnormFract :
    io_out_im_rawIn_fractIn; // @[rawFloatFromFN.scala 72:42]
  wire [11:0] io_out_im_rawIn__sig = {1'h0,_io_out_im_rawIn_out_sig_T,_io_out_im_rawIn_out_sig_T_1}; // @[Cat.scala 33:92]
  wire [2:0] _io_out_im_T_1 = io_out_im_rawIn_isZero ? 3'h0 : io_out_im_rawIn__sExp[5:3]; // @[recFNFromFN.scala 48:16]
  wire [2:0] _GEN_7 = {{2'd0}, io_out_im_rawIn__isNaN}; // @[recFNFromFN.scala 48:79]
  wire [2:0] _io_out_im_T_3 = _io_out_im_T_1 | _GEN_7; // @[recFNFromFN.scala 48:79]
  wire [12:0] io_out_im_lo = {io_out_im_rawIn__sExp[2:0],io_out_im_rawIn__sig[9:0]}; // @[Cat.scala 33:92]
  wire [3:0] io_out_im_hi = {io_out_im_rawIn_sign,_io_out_im_T_3}; // @[Cat.scala 33:92]
  assign io_out_re = {io_out_re_hi,io_out_re_lo}; // @[Cat.scala 33:92]
  assign io_out_im = {io_out_im_hi,io_out_im_lo}; // @[Cat.scala 33:92]
endmodule
module ComplexDecode(
  input  [16:0] io_in_re,
  input  [16:0] io_in_im,
  output [15:0] io_out_re,
  output [15:0] io_out_im
);
  wire [5:0] io_out_re_rawIn_exp = io_in_re[15:10]; // @[rawFloatFromRecFN.scala 50:21]
  wire  io_out_re_rawIn_isZero = io_out_re_rawIn_exp[5:3] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  wire  io_out_re_rawIn_isSpecial = io_out_re_rawIn_exp[5:4] == 2'h3; // @[rawFloatFromRecFN.scala 52:54]
  wire  io_out_re_rawIn__isNaN = io_out_re_rawIn_isSpecial & io_out_re_rawIn_exp[3]; // @[rawFloatFromRecFN.scala 55:33]
  wire  io_out_re_rawIn__isInf = io_out_re_rawIn_isSpecial & ~io_out_re_rawIn_exp[3]; // @[rawFloatFromRecFN.scala 56:33]
  wire  io_out_re_rawIn__sign = io_in_re[16]; // @[rawFloatFromRecFN.scala 58:25]
  wire [6:0] io_out_re_rawIn__sExp = {1'b0,$signed(io_out_re_rawIn_exp)}; // @[rawFloatFromRecFN.scala 59:27]
  wire  _io_out_re_rawIn_out_sig_T = ~io_out_re_rawIn_isZero; // @[rawFloatFromRecFN.scala 60:39]
  wire [11:0] io_out_re_rawIn__sig = {1'h0,_io_out_re_rawIn_out_sig_T,io_in_re[9:0]}; // @[Cat.scala 33:92]
  wire  io_out_re_isSubnormal = $signed(io_out_re_rawIn__sExp) < 7'sh12; // @[fNFromRecFN.scala 50:39]
  wire [3:0] io_out_re_denormShiftDist = 4'h1 - io_out_re_rawIn__sExp[3:0]; // @[fNFromRecFN.scala 51:39]
  wire [10:0] _io_out_re_denormFract_T_1 = io_out_re_rawIn__sig[11:1] >> io_out_re_denormShiftDist; // @[fNFromRecFN.scala 52:42]
  wire [9:0] io_out_re_denormFract = _io_out_re_denormFract_T_1[9:0]; // @[fNFromRecFN.scala 52:60]
  wire [4:0] _io_out_re_expOut_T_2 = io_out_re_rawIn__sExp[4:0] - 5'h11; // @[fNFromRecFN.scala 57:45]
  wire [4:0] _io_out_re_expOut_T_3 = io_out_re_isSubnormal ? 5'h0 : _io_out_re_expOut_T_2; // @[fNFromRecFN.scala 55:16]
  wire  _io_out_re_expOut_T_4 = io_out_re_rawIn__isNaN | io_out_re_rawIn__isInf; // @[fNFromRecFN.scala 59:44]
  wire [4:0] _io_out_re_expOut_T_6 = _io_out_re_expOut_T_4 ? 5'h1f : 5'h0; // @[Bitwise.scala 77:12]
  wire [4:0] io_out_re_expOut = _io_out_re_expOut_T_3 | _io_out_re_expOut_T_6; // @[fNFromRecFN.scala 59:15]
  wire [9:0] _io_out_re_fractOut_T_1 = io_out_re_rawIn__isInf ? 10'h0 : io_out_re_rawIn__sig[9:0]; // @[fNFromRecFN.scala 63:20]
  wire [9:0] io_out_re_fractOut = io_out_re_isSubnormal ? io_out_re_denormFract : _io_out_re_fractOut_T_1; // @[fNFromRecFN.scala 61:16]
  wire [5:0] io_out_re_hi = {io_out_re_rawIn__sign,io_out_re_expOut}; // @[Cat.scala 33:92]
  wire [5:0] io_out_im_rawIn_exp = io_in_im[15:10]; // @[rawFloatFromRecFN.scala 50:21]
  wire  io_out_im_rawIn_isZero = io_out_im_rawIn_exp[5:3] == 3'h0; // @[rawFloatFromRecFN.scala 51:54]
  wire  io_out_im_rawIn_isSpecial = io_out_im_rawIn_exp[5:4] == 2'h3; // @[rawFloatFromRecFN.scala 52:54]
  wire  io_out_im_rawIn__isNaN = io_out_im_rawIn_isSpecial & io_out_im_rawIn_exp[3]; // @[rawFloatFromRecFN.scala 55:33]
  wire  io_out_im_rawIn__isInf = io_out_im_rawIn_isSpecial & ~io_out_im_rawIn_exp[3]; // @[rawFloatFromRecFN.scala 56:33]
  wire  io_out_im_rawIn__sign = io_in_im[16]; // @[rawFloatFromRecFN.scala 58:25]
  wire [6:0] io_out_im_rawIn__sExp = {1'b0,$signed(io_out_im_rawIn_exp)}; // @[rawFloatFromRecFN.scala 59:27]
  wire  _io_out_im_rawIn_out_sig_T = ~io_out_im_rawIn_isZero; // @[rawFloatFromRecFN.scala 60:39]
  wire [11:0] io_out_im_rawIn__sig = {1'h0,_io_out_im_rawIn_out_sig_T,io_in_im[9:0]}; // @[Cat.scala 33:92]
  wire  io_out_im_isSubnormal = $signed(io_out_im_rawIn__sExp) < 7'sh12; // @[fNFromRecFN.scala 50:39]
  wire [3:0] io_out_im_denormShiftDist = 4'h1 - io_out_im_rawIn__sExp[3:0]; // @[fNFromRecFN.scala 51:39]
  wire [10:0] _io_out_im_denormFract_T_1 = io_out_im_rawIn__sig[11:1] >> io_out_im_denormShiftDist; // @[fNFromRecFN.scala 52:42]
  wire [9:0] io_out_im_denormFract = _io_out_im_denormFract_T_1[9:0]; // @[fNFromRecFN.scala 52:60]
  wire [4:0] _io_out_im_expOut_T_2 = io_out_im_rawIn__sExp[4:0] - 5'h11; // @[fNFromRecFN.scala 57:45]
  wire [4:0] _io_out_im_expOut_T_3 = io_out_im_isSubnormal ? 5'h0 : _io_out_im_expOut_T_2; // @[fNFromRecFN.scala 55:16]
  wire  _io_out_im_expOut_T_4 = io_out_im_rawIn__isNaN | io_out_im_rawIn__isInf; // @[fNFromRecFN.scala 59:44]
  wire [4:0] _io_out_im_expOut_T_6 = _io_out_im_expOut_T_4 ? 5'h1f : 5'h0; // @[Bitwise.scala 77:12]
  wire [4:0] io_out_im_expOut = _io_out_im_expOut_T_3 | _io_out_im_expOut_T_6; // @[fNFromRecFN.scala 59:15]
  wire [9:0] _io_out_im_fractOut_T_1 = io_out_im_rawIn__isInf ? 10'h0 : io_out_im_rawIn__sig[9:0]; // @[fNFromRecFN.scala 63:20]
  wire [9:0] io_out_im_fractOut = io_out_im_isSubnormal ? io_out_im_denormFract : _io_out_im_fractOut_T_1; // @[fNFromRecFN.scala 61:16]
  wire [5:0] io_out_im_hi = {io_out_im_rawIn__sign,io_out_im_expOut}; // @[Cat.scala 33:92]
  assign io_out_re = {io_out_re_hi,io_out_re_fractOut}; // @[Cat.scala 33:92]
  assign io_out_im = {io_out_im_hi,io_out_im_fractOut}; // @[Cat.scala 33:92]
endmodule
module FFT(
  input         clock,
  input         reset,
  input  [15:0] io_dIn_0_re,
  input  [15:0] io_dIn_0_im,
  input  [15:0] io_dIn_1_re,
  input  [15:0] io_dIn_1_im,
  input  [15:0] io_dIn_2_re,
  input  [15:0] io_dIn_2_im,
  input  [15:0] io_dIn_3_re,
  input  [15:0] io_dIn_3_im,
  input  [15:0] io_dIn_4_re,
  input  [15:0] io_dIn_4_im,
  input  [15:0] io_dIn_5_re,
  input  [15:0] io_dIn_5_im,
  input  [15:0] io_dIn_6_re,
  input  [15:0] io_dIn_6_im,
  input  [15:0] io_dIn_7_re,
  input  [15:0] io_dIn_7_im,
  output [15:0] io_dOut_0_re,
  output [15:0] io_dOut_0_im,
  output [15:0] io_dOut_1_re,
  output [15:0] io_dOut_1_im,
  output [15:0] io_dOut_2_re,
  output [15:0] io_dOut_2_im,
  output [15:0] io_dOut_3_re,
  output [15:0] io_dOut_3_im,
  output [15:0] io_dOut_4_re,
  output [15:0] io_dOut_4_im,
  output [15:0] io_dOut_5_re,
  output [15:0] io_dOut_5_im,
  output [15:0] io_dOut_6_re,
  output [15:0] io_dOut_6_im,
  output [15:0] io_dOut_7_re,
  output [15:0] io_dOut_7_im,
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
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
`endif // RANDOMIZE_REG_INIT
  wire [16:0] inst_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_1_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_1_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_1_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_1_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_1_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_1_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_1_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_1_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_1_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_1_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_2_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_2_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_2_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_2_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_2_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_2_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_2_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_2_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_2_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_2_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_3_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_3_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_3_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_3_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_3_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_3_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_3_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_3_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_3_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_3_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_4_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_4_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_4_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_4_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_4_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_4_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_4_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_4_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_4_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_4_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_5_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_5_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_5_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_5_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_5_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_5_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_5_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_5_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_5_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_5_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_6_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_6_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_6_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_6_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_6_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_6_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_6_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_6_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_6_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_6_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_7_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_7_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_7_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_7_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_7_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_7_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_7_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_7_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_7_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_7_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_8_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_8_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_8_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_8_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_8_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_8_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_8_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_8_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_8_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_8_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_9_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_9_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_9_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_9_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_9_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_9_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_9_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_9_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_9_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_9_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_10_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_10_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_10_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_10_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_10_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_10_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_10_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_10_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_10_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_10_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_11_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_11_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_11_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_11_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_11_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_11_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_11_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_11_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_11_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_11_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_12_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_12_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_12_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_12_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_12_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_12_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_12_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_12_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_12_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_12_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_13_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_13_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_13_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_13_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_13_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_13_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_13_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_13_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_13_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_13_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_14_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_14_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_14_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_14_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_14_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_14_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_14_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_14_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_14_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_14_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_15_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_15_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_15_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_15_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_15_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_15_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_15_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_15_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_15_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_15_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_16_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_16_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_16_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_16_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_16_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_16_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_16_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_16_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_16_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_16_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_17_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_17_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_17_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_17_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_17_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_17_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_17_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_17_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_17_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_17_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_18_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_18_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_18_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_18_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_18_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_18_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_18_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_18_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_18_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_18_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_19_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_19_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_19_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_19_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_19_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_19_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_19_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_19_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_19_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_19_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_20_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_20_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_20_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_20_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_20_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_20_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_20_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_20_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_20_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_20_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_21_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_21_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_21_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_21_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_21_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_21_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_21_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_21_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_21_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_21_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_22_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_22_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_22_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_22_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_22_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_22_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_22_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_22_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_22_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_22_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_23_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_23_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_23_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_23_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_23_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_23_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_23_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_23_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_23_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_23_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_24_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_24_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_24_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_24_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_24_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_24_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_24_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_24_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_24_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_24_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_25_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_25_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_25_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_25_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_25_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_25_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_25_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_25_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_25_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_25_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_26_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_26_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_26_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_26_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_26_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_26_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_26_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_26_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_26_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_26_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_27_io_in_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_27_io_in_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_27_io_in_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_27_io_in_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_27_io_out_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_27_io_out_0_im; // @[Modules.scala 287:22]
  wire [16:0] inst_27_io_out_1_re; // @[Modules.scala 287:22]
  wire [16:0] inst_27_io_out_1_im; // @[Modules.scala 287:22]
  wire [16:0] inst_27_io_wn_0_re; // @[Modules.scala 287:22]
  wire [16:0] inst_27_io_wn_0_im; // @[Modules.scala 287:22]
  wire [16:0] dataotemp_inst_io_in_0_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_io_in_0_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_io_in_1_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_io_in_1_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_io_out_0_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_io_out_0_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_io_out_1_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_io_out_1_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_1_io_in_0_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_1_io_in_0_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_1_io_in_1_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_1_io_in_1_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_1_io_out_0_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_1_io_out_0_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_1_io_out_1_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_1_io_out_1_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_2_io_in_0_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_2_io_in_0_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_2_io_in_1_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_2_io_in_1_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_2_io_out_0_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_2_io_out_0_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_2_io_out_1_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_2_io_out_1_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_3_io_in_0_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_3_io_in_0_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_3_io_in_1_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_3_io_in_1_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_3_io_out_0_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_3_io_out_0_im; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_3_io_out_1_re; // @[Modules.scala 213:22]
  wire [16:0] dataotemp_inst_3_io_out_1_im; // @[Modules.scala 213:22]
  wire [16:0] exdata_inst_io_in_0_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_in_0_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_in_0_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_in_0_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_in_1_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_in_1_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_in_1_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_in_1_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_out_0_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_out_0_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_out_0_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_out_0_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_out_1_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_out_1_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_out_1_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_io_out_1_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_in_0_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_in_0_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_in_0_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_in_0_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_in_1_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_in_1_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_in_1_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_in_1_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_out_0_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_out_0_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_out_0_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_out_0_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_out_1_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_out_1_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_out_1_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_1_io_out_1_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_in_0_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_in_0_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_in_0_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_in_0_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_in_1_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_in_1_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_in_1_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_in_1_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_out_0_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_out_0_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_out_0_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_out_0_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_out_1_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_out_1_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_out_1_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_2_io_out_1_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_in_0_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_in_0_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_in_0_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_in_0_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_in_1_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_in_1_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_in_1_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_in_1_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_out_0_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_out_0_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_out_0_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_out_0_1_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_out_1_0_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_out_1_0_im; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_out_1_1_re; // @[Modules.scala 331:22]
  wire [16:0] exdata_inst_3_io_out_1_1_im; // @[Modules.scala 331:22]
  wire  inst_28_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_28_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_28_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_28_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_28_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_28_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_28_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_28_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_28_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_28_io_sel; // @[Modules.scala 311:22]
  wire  inst_29_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_29_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_29_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_29_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_29_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_29_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_29_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_29_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_29_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_29_io_sel; // @[Modules.scala 311:22]
  wire  inst_30_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_30_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_30_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_30_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_30_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_30_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_30_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_30_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_30_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_30_io_sel; // @[Modules.scala 311:22]
  wire  inst_31_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_31_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_31_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_31_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_31_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_31_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_31_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_31_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_31_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_31_io_sel; // @[Modules.scala 311:22]
  wire  inst_32_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_32_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_32_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_32_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_32_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_32_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_32_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_32_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_32_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_32_io_sel; // @[Modules.scala 311:22]
  wire  inst_33_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_33_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_33_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_33_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_33_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_33_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_33_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_33_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_33_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_33_io_sel; // @[Modules.scala 311:22]
  wire  inst_34_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_34_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_34_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_34_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_34_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_34_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_34_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_34_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_34_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_34_io_sel; // @[Modules.scala 311:22]
  wire  inst_35_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_35_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_35_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_35_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_35_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_35_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_35_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_35_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_35_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_35_io_sel; // @[Modules.scala 311:22]
  wire  inst_36_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_36_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_36_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_36_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_36_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_36_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_36_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_36_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_36_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_36_io_sel; // @[Modules.scala 311:22]
  wire  inst_37_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_37_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_37_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_37_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_37_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_37_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_37_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_37_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_37_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_37_io_sel; // @[Modules.scala 311:22]
  wire  inst_38_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_38_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_38_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_38_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_38_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_38_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_38_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_38_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_38_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_38_io_sel; // @[Modules.scala 311:22]
  wire  inst_39_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_39_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_39_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_39_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_39_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_39_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_39_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_39_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_39_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_39_io_sel; // @[Modules.scala 311:22]
  wire  inst_40_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_40_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_40_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_40_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_40_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_40_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_40_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_40_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_40_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_40_io_sel; // @[Modules.scala 311:22]
  wire  inst_41_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_41_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_41_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_41_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_41_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_41_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_41_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_41_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_41_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_41_io_sel; // @[Modules.scala 311:22]
  wire  inst_42_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_42_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_42_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_42_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_42_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_42_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_42_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_42_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_42_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_42_io_sel; // @[Modules.scala 311:22]
  wire  inst_43_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_43_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_43_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_43_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_43_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_43_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_43_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_43_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_43_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_43_io_sel; // @[Modules.scala 311:22]
  wire  inst_44_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_44_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_44_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_44_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_44_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_44_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_44_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_44_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_44_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_44_io_sel; // @[Modules.scala 311:22]
  wire  inst_45_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_45_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_45_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_45_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_45_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_45_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_45_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_45_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_45_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_45_io_sel; // @[Modules.scala 311:22]
  wire  inst_46_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_46_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_46_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_46_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_46_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_46_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_46_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_46_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_46_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_46_io_sel; // @[Modules.scala 311:22]
  wire  inst_47_clock; // @[Modules.scala 311:22]
  wire [16:0] inst_47_io_in_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_47_io_in_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_47_io_in_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_47_io_in_1_im; // @[Modules.scala 311:22]
  wire [16:0] inst_47_io_out_0_re; // @[Modules.scala 311:22]
  wire [16:0] inst_47_io_out_0_im; // @[Modules.scala 311:22]
  wire [16:0] inst_47_io_out_1_re; // @[Modules.scala 311:22]
  wire [16:0] inst_47_io_out_1_im; // @[Modules.scala 311:22]
  wire  inst_47_io_sel; // @[Modules.scala 311:22]
  wire [15:0] inst_48_io_in_re; // @[Modules.scala 40:22]
  wire [15:0] inst_48_io_in_im; // @[Modules.scala 40:22]
  wire [16:0] inst_48_io_out_re; // @[Modules.scala 40:22]
  wire [16:0] inst_48_io_out_im; // @[Modules.scala 40:22]
  wire [15:0] inst_49_io_in_re; // @[Modules.scala 40:22]
  wire [15:0] inst_49_io_in_im; // @[Modules.scala 40:22]
  wire [16:0] inst_49_io_out_re; // @[Modules.scala 40:22]
  wire [16:0] inst_49_io_out_im; // @[Modules.scala 40:22]
  wire [15:0] inst_50_io_in_re; // @[Modules.scala 40:22]
  wire [15:0] inst_50_io_in_im; // @[Modules.scala 40:22]
  wire [16:0] inst_50_io_out_re; // @[Modules.scala 40:22]
  wire [16:0] inst_50_io_out_im; // @[Modules.scala 40:22]
  wire [15:0] inst_51_io_in_re; // @[Modules.scala 40:22]
  wire [15:0] inst_51_io_in_im; // @[Modules.scala 40:22]
  wire [16:0] inst_51_io_out_re; // @[Modules.scala 40:22]
  wire [16:0] inst_51_io_out_im; // @[Modules.scala 40:22]
  wire [15:0] inst_52_io_in_re; // @[Modules.scala 40:22]
  wire [15:0] inst_52_io_in_im; // @[Modules.scala 40:22]
  wire [16:0] inst_52_io_out_re; // @[Modules.scala 40:22]
  wire [16:0] inst_52_io_out_im; // @[Modules.scala 40:22]
  wire [15:0] inst_53_io_in_re; // @[Modules.scala 40:22]
  wire [15:0] inst_53_io_in_im; // @[Modules.scala 40:22]
  wire [16:0] inst_53_io_out_re; // @[Modules.scala 40:22]
  wire [16:0] inst_53_io_out_im; // @[Modules.scala 40:22]
  wire [15:0] inst_54_io_in_re; // @[Modules.scala 40:22]
  wire [15:0] inst_54_io_in_im; // @[Modules.scala 40:22]
  wire [16:0] inst_54_io_out_re; // @[Modules.scala 40:22]
  wire [16:0] inst_54_io_out_im; // @[Modules.scala 40:22]
  wire [15:0] inst_55_io_in_re; // @[Modules.scala 40:22]
  wire [15:0] inst_55_io_in_im; // @[Modules.scala 40:22]
  wire [16:0] inst_55_io_out_re; // @[Modules.scala 40:22]
  wire [16:0] inst_55_io_out_im; // @[Modules.scala 40:22]
  wire [16:0] inst_56_io_in_re; // @[Modules.scala 56:22]
  wire [16:0] inst_56_io_in_im; // @[Modules.scala 56:22]
  wire [15:0] inst_56_io_out_re; // @[Modules.scala 56:22]
  wire [15:0] inst_56_io_out_im; // @[Modules.scala 56:22]
  wire [16:0] inst_57_io_in_re; // @[Modules.scala 56:22]
  wire [16:0] inst_57_io_in_im; // @[Modules.scala 56:22]
  wire [15:0] inst_57_io_out_re; // @[Modules.scala 56:22]
  wire [15:0] inst_57_io_out_im; // @[Modules.scala 56:22]
  wire [16:0] inst_58_io_in_re; // @[Modules.scala 56:22]
  wire [16:0] inst_58_io_in_im; // @[Modules.scala 56:22]
  wire [15:0] inst_58_io_out_re; // @[Modules.scala 56:22]
  wire [15:0] inst_58_io_out_im; // @[Modules.scala 56:22]
  wire [16:0] inst_59_io_in_re; // @[Modules.scala 56:22]
  wire [16:0] inst_59_io_in_im; // @[Modules.scala 56:22]
  wire [15:0] inst_59_io_out_re; // @[Modules.scala 56:22]
  wire [15:0] inst_59_io_out_im; // @[Modules.scala 56:22]
  wire [16:0] inst_60_io_in_re; // @[Modules.scala 56:22]
  wire [16:0] inst_60_io_in_im; // @[Modules.scala 56:22]
  wire [15:0] inst_60_io_out_re; // @[Modules.scala 56:22]
  wire [15:0] inst_60_io_out_im; // @[Modules.scala 56:22]
  wire [16:0] inst_61_io_in_re; // @[Modules.scala 56:22]
  wire [16:0] inst_61_io_in_im; // @[Modules.scala 56:22]
  wire [15:0] inst_61_io_out_re; // @[Modules.scala 56:22]
  wire [15:0] inst_61_io_out_im; // @[Modules.scala 56:22]
  wire [16:0] inst_62_io_in_re; // @[Modules.scala 56:22]
  wire [16:0] inst_62_io_in_im; // @[Modules.scala 56:22]
  wire [15:0] inst_62_io_out_re; // @[Modules.scala 56:22]
  wire [15:0] inst_62_io_out_im; // @[Modules.scala 56:22]
  wire [16:0] inst_63_io_in_re; // @[Modules.scala 56:22]
  wire [16:0] inst_63_io_in_im; // @[Modules.scala 56:22]
  wire [15:0] inst_63_io_out_re; // @[Modules.scala 56:22]
  wire [15:0] inst_63_io_out_im; // @[Modules.scala 56:22]
  reg [6:0] cnt_0; // @[FFT.scala 110:46]
  reg [6:0] cnt_1; // @[FFT.scala 110:46]
  reg [6:0] cnt_2; // @[FFT.scala 110:46]
  wire  busy = cnt_0 != 7'h0; // @[FFT.scala 114:21]
  wire [6:0] _cnt_0_T_2 = cnt_0 + 7'h1; // @[FFT.scala 116:87]
  wire [7:0] _wnList_T = {{1'd0}, cnt_0}; // @[FFT.scala 135:96]
  wire [6:0] wnList_res_re_rawIn__sExp = {1'b0,$signed(6'h20)}; // @[rawFloatFromFN.scala 70:48]
  wire [16:0] _wnList_res_re_T_7 = {1'h0,wnList_res_re_rawIn__sExp[5:3],wnList_res_re_rawIn__sExp[2:0],10'h0}; // @[Cat.scala 33:92]
  wire [6:0] wnList_res_re_rawIn_1_sExp = {1'b0,$signed(6'h1f)}; // @[rawFloatFromFN.scala 70:48]
  wire [16:0] _wnList_res_re_T_15 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3ff}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_23 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3fd}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_31 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3fa}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_39 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3f6}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_47 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3f0}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_55 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3e9}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_63 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3e1}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_71 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3d8}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_79 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3ce}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_87 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3c2}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_95 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3b5}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_103 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3a7}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_111 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h398}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_119 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h388}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_127 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h376}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_135 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h364}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_143 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h350}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_151 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h33b}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_159 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h325}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_167 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h30e}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_175 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h2f5}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_183 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h2dc}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_191 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h2c2}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_199 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h2a6}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_207 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h28a}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_215 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h26c}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_223 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h24e}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_231 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h22f}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_239 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h20e}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_247 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h1ed}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_255 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h1cb}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_263 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h1a8}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_271 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h184}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_279 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h15f}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_287 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h139}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_295 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h113}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_303 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'heb}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_311 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'hc3}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_319 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h9b}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_327 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h71}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_335 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h47}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_343 = {1'h0,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h1c}; // @[Cat.scala 33:92]
  wire [6:0] wnList_res_re_rawIn_43_sExp = {1'b0,$signed(6'h1e)}; // @[rawFloatFromFN.scala 70:48]
  wire [16:0] _wnList_res_re_T_351 = {1'h0,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h3e2}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_359 = {1'h0,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h38a}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_367 = {1'h0,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h331}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_375 = {1'h0,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h2d7}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_383 = {1'h0,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h27b}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_391 = {1'h0,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h21f}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_399 = {1'h0,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h1c2}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_407 = {1'h0,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h163}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_415 = {1'h0,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h104}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_423 = {1'h0,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'ha5}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_431 = {1'h0,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h44}; // @[Cat.scala 33:92]
  wire [6:0] wnList_res_re_rawIn_54_sExp = {1'b0,$signed(6'h1d)}; // @[rawFloatFromFN.scala 70:48]
  wire [16:0] _wnList_res_re_T_439 = {1'h0,wnList_res_re_rawIn_54_sExp[5:3],wnList_res_re_rawIn_54_sExp[2:0],10'h3c6}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_447 = {1'h0,wnList_res_re_rawIn_54_sExp[5:3],wnList_res_re_rawIn_54_sExp[2:0],10'h302}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_455 = {1'h0,wnList_res_re_rawIn_54_sExp[5:3],wnList_res_re_rawIn_54_sExp[2:0],10'h23e}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_463 = {1'h0,wnList_res_re_rawIn_54_sExp[5:3],wnList_res_re_rawIn_54_sExp[2:0],10'h178}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_471 = {1'h0,wnList_res_re_rawIn_54_sExp[5:3],wnList_res_re_rawIn_54_sExp[2:0],10'hb2}; // @[Cat.scala 33:92]
  wire [6:0] wnList_res_re_rawIn_59_sExp = {1'b0,$signed(6'h1c)}; // @[rawFloatFromFN.scala 70:48]
  wire [16:0] _wnList_res_re_T_479 = {1'h0,wnList_res_re_rawIn_59_sExp[5:3],wnList_res_re_rawIn_59_sExp[2:0],10'h3d5}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_487 = {1'h0,wnList_res_re_rawIn_59_sExp[5:3],wnList_res_re_rawIn_59_sExp[2:0],10'h245}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_495 = {1'h0,wnList_res_re_rawIn_59_sExp[5:3],wnList_res_re_rawIn_59_sExp[2:0],10'hb5}; // @[Cat.scala 33:92]
  wire [6:0] wnList_res_re_rawIn_62_sExp = {1'b0,$signed(6'h1b)}; // @[rawFloatFromFN.scala 70:48]
  wire [16:0] _wnList_res_re_T_503 = {1'h0,wnList_res_re_rawIn_62_sExp[5:3],wnList_res_re_rawIn_62_sExp[2:0],10'h247}; // @[Cat.scala 33:92]
  wire [6:0] wnList_res_re_rawIn_63_sExp = {1'b0,$signed(6'h1a)}; // @[rawFloatFromFN.scala 70:48]
  wire [16:0] _wnList_res_re_T_511 = {1'h0,wnList_res_re_rawIn_63_sExp[5:3],wnList_res_re_rawIn_63_sExp[2:0],10'h248}; // @[Cat.scala 33:92]
  wire [6:0] wnList_res_re_rawIn_64_sExp = {1'b0,$signed(6'h8)}; // @[rawFloatFromFN.scala 70:48]
  wire [16:0] _wnList_res_re_T_519 = {4'h0,wnList_res_re_rawIn_64_sExp[2:0],10'h0}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_527 = {1'h1,wnList_res_re_rawIn_63_sExp[5:3],wnList_res_re_rawIn_63_sExp[2:0],10'h248}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_535 = {1'h1,wnList_res_re_rawIn_62_sExp[5:3],wnList_res_re_rawIn_62_sExp[2:0],10'h247}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_543 = {1'h1,wnList_res_re_rawIn_59_sExp[5:3],wnList_res_re_rawIn_59_sExp[2:0],10'hb5}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_551 = {1'h1,wnList_res_re_rawIn_59_sExp[5:3],wnList_res_re_rawIn_59_sExp[2:0],10'h245}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_559 = {1'h1,wnList_res_re_rawIn_59_sExp[5:3],wnList_res_re_rawIn_59_sExp[2:0],10'h3d5}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_567 = {1'h1,wnList_res_re_rawIn_54_sExp[5:3],wnList_res_re_rawIn_54_sExp[2:0],10'hb2}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_575 = {1'h1,wnList_res_re_rawIn_54_sExp[5:3],wnList_res_re_rawIn_54_sExp[2:0],10'h178}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_583 = {1'h1,wnList_res_re_rawIn_54_sExp[5:3],wnList_res_re_rawIn_54_sExp[2:0],10'h23e}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_591 = {1'h1,wnList_res_re_rawIn_54_sExp[5:3],wnList_res_re_rawIn_54_sExp[2:0],10'h302}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_599 = {1'h1,wnList_res_re_rawIn_54_sExp[5:3],wnList_res_re_rawIn_54_sExp[2:0],10'h3c6}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_607 = {1'h1,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h44}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_615 = {1'h1,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'ha5}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_623 = {1'h1,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h104}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_631 = {1'h1,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h163}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_639 = {1'h1,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h1c2}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_647 = {1'h1,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h21f}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_655 = {1'h1,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h27b}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_663 = {1'h1,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h2d7}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_671 = {1'h1,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h331}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_679 = {1'h1,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h38a}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_687 = {1'h1,wnList_res_re_rawIn_43_sExp[5:3],wnList_res_re_rawIn_43_sExp[2:0],10'h3e2}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_695 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h1c}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_703 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h47}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_711 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h71}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_719 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h9b}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_727 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'hc3}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_735 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'heb}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_743 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h113}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_751 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h139}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_759 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h15f}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_767 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h184}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_775 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h1a8}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_783 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h1cb}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_791 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h1ed}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_799 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h20e}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_807 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h22f}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_815 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h24e}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_823 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h26c}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_831 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h28a}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_839 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h2a6}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_847 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h2c2}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_855 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h2dc}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_863 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h2f5}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_871 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h30e}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_879 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h325}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_887 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h33b}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_895 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h350}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_903 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h364}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_911 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h376}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_919 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h388}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_927 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h398}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_935 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3a7}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_943 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3b5}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_951 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3c2}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_959 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3ce}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_967 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3d8}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_975 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3e1}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_983 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3e9}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_991 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3f0}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_999 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3f6}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_1007 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3fa}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_1015 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3fd}; // @[Cat.scala 33:92]
  wire [16:0] _wnList_res_re_T_1023 = {1'h1,wnList_res_re_rawIn_1_sExp[5:3],wnList_res_re_rawIn_1_sExp[2:0],10'h3ff}; // @[Cat.scala 33:92]
  wire [16:0] _GEN_2 = 7'h1 == _wnList_T[6:0] ? _wnList_res_re_T_15 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_3 = 7'h2 == _wnList_T[6:0] ? _wnList_res_re_T_23 : _GEN_2; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_4 = 7'h3 == _wnList_T[6:0] ? _wnList_res_re_T_31 : _GEN_3; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_5 = 7'h4 == _wnList_T[6:0] ? _wnList_res_re_T_39 : _GEN_4; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_6 = 7'h5 == _wnList_T[6:0] ? _wnList_res_re_T_47 : _GEN_5; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_7 = 7'h6 == _wnList_T[6:0] ? _wnList_res_re_T_55 : _GEN_6; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_8 = 7'h7 == _wnList_T[6:0] ? _wnList_res_re_T_63 : _GEN_7; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_9 = 7'h8 == _wnList_T[6:0] ? _wnList_res_re_T_71 : _GEN_8; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_10 = 7'h9 == _wnList_T[6:0] ? _wnList_res_re_T_79 : _GEN_9; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_11 = 7'ha == _wnList_T[6:0] ? _wnList_res_re_T_87 : _GEN_10; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_12 = 7'hb == _wnList_T[6:0] ? _wnList_res_re_T_95 : _GEN_11; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_13 = 7'hc == _wnList_T[6:0] ? _wnList_res_re_T_103 : _GEN_12; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_14 = 7'hd == _wnList_T[6:0] ? _wnList_res_re_T_111 : _GEN_13; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_15 = 7'he == _wnList_T[6:0] ? _wnList_res_re_T_119 : _GEN_14; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_16 = 7'hf == _wnList_T[6:0] ? _wnList_res_re_T_127 : _GEN_15; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_17 = 7'h10 == _wnList_T[6:0] ? _wnList_res_re_T_135 : _GEN_16; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_18 = 7'h11 == _wnList_T[6:0] ? _wnList_res_re_T_143 : _GEN_17; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_19 = 7'h12 == _wnList_T[6:0] ? _wnList_res_re_T_151 : _GEN_18; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_20 = 7'h13 == _wnList_T[6:0] ? _wnList_res_re_T_159 : _GEN_19; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_21 = 7'h14 == _wnList_T[6:0] ? _wnList_res_re_T_167 : _GEN_20; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_22 = 7'h15 == _wnList_T[6:0] ? _wnList_res_re_T_175 : _GEN_21; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_23 = 7'h16 == _wnList_T[6:0] ? _wnList_res_re_T_183 : _GEN_22; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_24 = 7'h17 == _wnList_T[6:0] ? _wnList_res_re_T_191 : _GEN_23; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_25 = 7'h18 == _wnList_T[6:0] ? _wnList_res_re_T_199 : _GEN_24; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_26 = 7'h19 == _wnList_T[6:0] ? _wnList_res_re_T_207 : _GEN_25; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_27 = 7'h1a == _wnList_T[6:0] ? _wnList_res_re_T_215 : _GEN_26; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_28 = 7'h1b == _wnList_T[6:0] ? _wnList_res_re_T_223 : _GEN_27; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_29 = 7'h1c == _wnList_T[6:0] ? _wnList_res_re_T_231 : _GEN_28; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_30 = 7'h1d == _wnList_T[6:0] ? _wnList_res_re_T_239 : _GEN_29; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_31 = 7'h1e == _wnList_T[6:0] ? _wnList_res_re_T_247 : _GEN_30; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_32 = 7'h1f == _wnList_T[6:0] ? _wnList_res_re_T_255 : _GEN_31; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_33 = 7'h20 == _wnList_T[6:0] ? _wnList_res_re_T_263 : _GEN_32; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_34 = 7'h21 == _wnList_T[6:0] ? _wnList_res_re_T_271 : _GEN_33; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_35 = 7'h22 == _wnList_T[6:0] ? _wnList_res_re_T_279 : _GEN_34; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_36 = 7'h23 == _wnList_T[6:0] ? _wnList_res_re_T_287 : _GEN_35; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_37 = 7'h24 == _wnList_T[6:0] ? _wnList_res_re_T_295 : _GEN_36; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_38 = 7'h25 == _wnList_T[6:0] ? _wnList_res_re_T_303 : _GEN_37; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_39 = 7'h26 == _wnList_T[6:0] ? _wnList_res_re_T_311 : _GEN_38; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_40 = 7'h27 == _wnList_T[6:0] ? _wnList_res_re_T_319 : _GEN_39; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_41 = 7'h28 == _wnList_T[6:0] ? _wnList_res_re_T_327 : _GEN_40; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_42 = 7'h29 == _wnList_T[6:0] ? _wnList_res_re_T_335 : _GEN_41; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_43 = 7'h2a == _wnList_T[6:0] ? _wnList_res_re_T_343 : _GEN_42; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_44 = 7'h2b == _wnList_T[6:0] ? _wnList_res_re_T_351 : _GEN_43; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_45 = 7'h2c == _wnList_T[6:0] ? _wnList_res_re_T_359 : _GEN_44; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_46 = 7'h2d == _wnList_T[6:0] ? _wnList_res_re_T_367 : _GEN_45; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_47 = 7'h2e == _wnList_T[6:0] ? _wnList_res_re_T_375 : _GEN_46; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_48 = 7'h2f == _wnList_T[6:0] ? _wnList_res_re_T_383 : _GEN_47; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_49 = 7'h30 == _wnList_T[6:0] ? _wnList_res_re_T_391 : _GEN_48; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_50 = 7'h31 == _wnList_T[6:0] ? _wnList_res_re_T_399 : _GEN_49; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_51 = 7'h32 == _wnList_T[6:0] ? _wnList_res_re_T_407 : _GEN_50; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_52 = 7'h33 == _wnList_T[6:0] ? _wnList_res_re_T_415 : _GEN_51; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_53 = 7'h34 == _wnList_T[6:0] ? _wnList_res_re_T_423 : _GEN_52; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_54 = 7'h35 == _wnList_T[6:0] ? _wnList_res_re_T_431 : _GEN_53; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_55 = 7'h36 == _wnList_T[6:0] ? _wnList_res_re_T_439 : _GEN_54; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_56 = 7'h37 == _wnList_T[6:0] ? _wnList_res_re_T_447 : _GEN_55; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_57 = 7'h38 == _wnList_T[6:0] ? _wnList_res_re_T_455 : _GEN_56; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_58 = 7'h39 == _wnList_T[6:0] ? _wnList_res_re_T_463 : _GEN_57; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_59 = 7'h3a == _wnList_T[6:0] ? _wnList_res_re_T_471 : _GEN_58; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_60 = 7'h3b == _wnList_T[6:0] ? _wnList_res_re_T_479 : _GEN_59; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_61 = 7'h3c == _wnList_T[6:0] ? _wnList_res_re_T_487 : _GEN_60; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_62 = 7'h3d == _wnList_T[6:0] ? _wnList_res_re_T_495 : _GEN_61; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_63 = 7'h3e == _wnList_T[6:0] ? _wnList_res_re_T_503 : _GEN_62; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_64 = 7'h3f == _wnList_T[6:0] ? _wnList_res_re_T_511 : _GEN_63; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_65 = 7'h40 == _wnList_T[6:0] ? _wnList_res_re_T_519 : _GEN_64; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_66 = 7'h41 == _wnList_T[6:0] ? _wnList_res_re_T_527 : _GEN_65; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_67 = 7'h42 == _wnList_T[6:0] ? _wnList_res_re_T_535 : _GEN_66; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_68 = 7'h43 == _wnList_T[6:0] ? _wnList_res_re_T_543 : _GEN_67; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_69 = 7'h44 == _wnList_T[6:0] ? _wnList_res_re_T_551 : _GEN_68; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_70 = 7'h45 == _wnList_T[6:0] ? _wnList_res_re_T_559 : _GEN_69; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_71 = 7'h46 == _wnList_T[6:0] ? _wnList_res_re_T_567 : _GEN_70; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_72 = 7'h47 == _wnList_T[6:0] ? _wnList_res_re_T_575 : _GEN_71; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_73 = 7'h48 == _wnList_T[6:0] ? _wnList_res_re_T_583 : _GEN_72; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_74 = 7'h49 == _wnList_T[6:0] ? _wnList_res_re_T_591 : _GEN_73; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_75 = 7'h4a == _wnList_T[6:0] ? _wnList_res_re_T_599 : _GEN_74; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_76 = 7'h4b == _wnList_T[6:0] ? _wnList_res_re_T_607 : _GEN_75; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_77 = 7'h4c == _wnList_T[6:0] ? _wnList_res_re_T_615 : _GEN_76; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_78 = 7'h4d == _wnList_T[6:0] ? _wnList_res_re_T_623 : _GEN_77; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_79 = 7'h4e == _wnList_T[6:0] ? _wnList_res_re_T_631 : _GEN_78; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_80 = 7'h4f == _wnList_T[6:0] ? _wnList_res_re_T_639 : _GEN_79; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_81 = 7'h50 == _wnList_T[6:0] ? _wnList_res_re_T_647 : _GEN_80; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_82 = 7'h51 == _wnList_T[6:0] ? _wnList_res_re_T_655 : _GEN_81; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_83 = 7'h52 == _wnList_T[6:0] ? _wnList_res_re_T_663 : _GEN_82; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_84 = 7'h53 == _wnList_T[6:0] ? _wnList_res_re_T_671 : _GEN_83; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_85 = 7'h54 == _wnList_T[6:0] ? _wnList_res_re_T_679 : _GEN_84; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_86 = 7'h55 == _wnList_T[6:0] ? _wnList_res_re_T_687 : _GEN_85; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_87 = 7'h56 == _wnList_T[6:0] ? _wnList_res_re_T_695 : _GEN_86; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_88 = 7'h57 == _wnList_T[6:0] ? _wnList_res_re_T_703 : _GEN_87; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_89 = 7'h58 == _wnList_T[6:0] ? _wnList_res_re_T_711 : _GEN_88; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_90 = 7'h59 == _wnList_T[6:0] ? _wnList_res_re_T_719 : _GEN_89; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_91 = 7'h5a == _wnList_T[6:0] ? _wnList_res_re_T_727 : _GEN_90; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_92 = 7'h5b == _wnList_T[6:0] ? _wnList_res_re_T_735 : _GEN_91; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_93 = 7'h5c == _wnList_T[6:0] ? _wnList_res_re_T_743 : _GEN_92; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_94 = 7'h5d == _wnList_T[6:0] ? _wnList_res_re_T_751 : _GEN_93; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_95 = 7'h5e == _wnList_T[6:0] ? _wnList_res_re_T_759 : _GEN_94; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_96 = 7'h5f == _wnList_T[6:0] ? _wnList_res_re_T_767 : _GEN_95; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_97 = 7'h60 == _wnList_T[6:0] ? _wnList_res_re_T_775 : _GEN_96; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_98 = 7'h61 == _wnList_T[6:0] ? _wnList_res_re_T_783 : _GEN_97; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_99 = 7'h62 == _wnList_T[6:0] ? _wnList_res_re_T_791 : _GEN_98; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_100 = 7'h63 == _wnList_T[6:0] ? _wnList_res_re_T_799 : _GEN_99; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_101 = 7'h64 == _wnList_T[6:0] ? _wnList_res_re_T_807 : _GEN_100; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_102 = 7'h65 == _wnList_T[6:0] ? _wnList_res_re_T_815 : _GEN_101; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_103 = 7'h66 == _wnList_T[6:0] ? _wnList_res_re_T_823 : _GEN_102; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_104 = 7'h67 == _wnList_T[6:0] ? _wnList_res_re_T_831 : _GEN_103; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_105 = 7'h68 == _wnList_T[6:0] ? _wnList_res_re_T_839 : _GEN_104; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_106 = 7'h69 == _wnList_T[6:0] ? _wnList_res_re_T_847 : _GEN_105; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_107 = 7'h6a == _wnList_T[6:0] ? _wnList_res_re_T_855 : _GEN_106; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_108 = 7'h6b == _wnList_T[6:0] ? _wnList_res_re_T_863 : _GEN_107; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_109 = 7'h6c == _wnList_T[6:0] ? _wnList_res_re_T_871 : _GEN_108; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_110 = 7'h6d == _wnList_T[6:0] ? _wnList_res_re_T_879 : _GEN_109; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_111 = 7'h6e == _wnList_T[6:0] ? _wnList_res_re_T_887 : _GEN_110; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_112 = 7'h6f == _wnList_T[6:0] ? _wnList_res_re_T_895 : _GEN_111; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_113 = 7'h70 == _wnList_T[6:0] ? _wnList_res_re_T_903 : _GEN_112; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_114 = 7'h71 == _wnList_T[6:0] ? _wnList_res_re_T_911 : _GEN_113; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_115 = 7'h72 == _wnList_T[6:0] ? _wnList_res_re_T_919 : _GEN_114; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_116 = 7'h73 == _wnList_T[6:0] ? _wnList_res_re_T_927 : _GEN_115; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_117 = 7'h74 == _wnList_T[6:0] ? _wnList_res_re_T_935 : _GEN_116; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_118 = 7'h75 == _wnList_T[6:0] ? _wnList_res_re_T_943 : _GEN_117; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_119 = 7'h76 == _wnList_T[6:0] ? _wnList_res_re_T_951 : _GEN_118; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_120 = 7'h77 == _wnList_T[6:0] ? _wnList_res_re_T_959 : _GEN_119; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_121 = 7'h78 == _wnList_T[6:0] ? _wnList_res_re_T_967 : _GEN_120; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_122 = 7'h79 == _wnList_T[6:0] ? _wnList_res_re_T_975 : _GEN_121; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_123 = 7'h7a == _wnList_T[6:0] ? _wnList_res_re_T_983 : _GEN_122; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_124 = 7'h7b == _wnList_T[6:0] ? _wnList_res_re_T_991 : _GEN_123; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_125 = 7'h7c == _wnList_T[6:0] ? _wnList_res_re_T_999 : _GEN_124; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_126 = 7'h7d == _wnList_T[6:0] ? _wnList_res_re_T_1007 : _GEN_125; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_127 = 7'h7e == _wnList_T[6:0] ? _wnList_res_re_T_1015 : _GEN_126; // @[FFT.scala 104:{12,12}]
  wire [16:0] _wnList_res_im_T_519 = {1'h1,wnList_res_re_rawIn__sExp[5:3],wnList_res_re_rawIn__sExp[2:0],10'h0}; // @[Cat.scala 33:92]
  wire [16:0] _GEN_130 = 7'h1 == _wnList_T[6:0] ? _wnList_res_re_T_527 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_131 = 7'h2 == _wnList_T[6:0] ? _wnList_res_re_T_535 : _GEN_130; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_132 = 7'h3 == _wnList_T[6:0] ? _wnList_res_re_T_543 : _GEN_131; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_133 = 7'h4 == _wnList_T[6:0] ? _wnList_res_re_T_551 : _GEN_132; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_134 = 7'h5 == _wnList_T[6:0] ? _wnList_res_re_T_559 : _GEN_133; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_135 = 7'h6 == _wnList_T[6:0] ? _wnList_res_re_T_567 : _GEN_134; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_136 = 7'h7 == _wnList_T[6:0] ? _wnList_res_re_T_575 : _GEN_135; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_137 = 7'h8 == _wnList_T[6:0] ? _wnList_res_re_T_583 : _GEN_136; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_138 = 7'h9 == _wnList_T[6:0] ? _wnList_res_re_T_591 : _GEN_137; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_139 = 7'ha == _wnList_T[6:0] ? _wnList_res_re_T_599 : _GEN_138; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_140 = 7'hb == _wnList_T[6:0] ? _wnList_res_re_T_607 : _GEN_139; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_141 = 7'hc == _wnList_T[6:0] ? _wnList_res_re_T_615 : _GEN_140; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_142 = 7'hd == _wnList_T[6:0] ? _wnList_res_re_T_623 : _GEN_141; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_143 = 7'he == _wnList_T[6:0] ? _wnList_res_re_T_631 : _GEN_142; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_144 = 7'hf == _wnList_T[6:0] ? _wnList_res_re_T_639 : _GEN_143; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_145 = 7'h10 == _wnList_T[6:0] ? _wnList_res_re_T_647 : _GEN_144; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_146 = 7'h11 == _wnList_T[6:0] ? _wnList_res_re_T_655 : _GEN_145; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_147 = 7'h12 == _wnList_T[6:0] ? _wnList_res_re_T_663 : _GEN_146; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_148 = 7'h13 == _wnList_T[6:0] ? _wnList_res_re_T_671 : _GEN_147; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_149 = 7'h14 == _wnList_T[6:0] ? _wnList_res_re_T_679 : _GEN_148; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_150 = 7'h15 == _wnList_T[6:0] ? _wnList_res_re_T_687 : _GEN_149; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_151 = 7'h16 == _wnList_T[6:0] ? _wnList_res_re_T_695 : _GEN_150; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_152 = 7'h17 == _wnList_T[6:0] ? _wnList_res_re_T_703 : _GEN_151; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_153 = 7'h18 == _wnList_T[6:0] ? _wnList_res_re_T_711 : _GEN_152; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_154 = 7'h19 == _wnList_T[6:0] ? _wnList_res_re_T_719 : _GEN_153; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_155 = 7'h1a == _wnList_T[6:0] ? _wnList_res_re_T_727 : _GEN_154; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_156 = 7'h1b == _wnList_T[6:0] ? _wnList_res_re_T_735 : _GEN_155; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_157 = 7'h1c == _wnList_T[6:0] ? _wnList_res_re_T_743 : _GEN_156; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_158 = 7'h1d == _wnList_T[6:0] ? _wnList_res_re_T_751 : _GEN_157; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_159 = 7'h1e == _wnList_T[6:0] ? _wnList_res_re_T_759 : _GEN_158; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_160 = 7'h1f == _wnList_T[6:0] ? _wnList_res_re_T_767 : _GEN_159; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_161 = 7'h20 == _wnList_T[6:0] ? _wnList_res_re_T_775 : _GEN_160; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_162 = 7'h21 == _wnList_T[6:0] ? _wnList_res_re_T_783 : _GEN_161; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_163 = 7'h22 == _wnList_T[6:0] ? _wnList_res_re_T_791 : _GEN_162; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_164 = 7'h23 == _wnList_T[6:0] ? _wnList_res_re_T_799 : _GEN_163; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_165 = 7'h24 == _wnList_T[6:0] ? _wnList_res_re_T_807 : _GEN_164; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_166 = 7'h25 == _wnList_T[6:0] ? _wnList_res_re_T_815 : _GEN_165; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_167 = 7'h26 == _wnList_T[6:0] ? _wnList_res_re_T_823 : _GEN_166; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_168 = 7'h27 == _wnList_T[6:0] ? _wnList_res_re_T_831 : _GEN_167; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_169 = 7'h28 == _wnList_T[6:0] ? _wnList_res_re_T_839 : _GEN_168; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_170 = 7'h29 == _wnList_T[6:0] ? _wnList_res_re_T_847 : _GEN_169; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_171 = 7'h2a == _wnList_T[6:0] ? _wnList_res_re_T_855 : _GEN_170; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_172 = 7'h2b == _wnList_T[6:0] ? _wnList_res_re_T_863 : _GEN_171; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_173 = 7'h2c == _wnList_T[6:0] ? _wnList_res_re_T_871 : _GEN_172; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_174 = 7'h2d == _wnList_T[6:0] ? _wnList_res_re_T_879 : _GEN_173; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_175 = 7'h2e == _wnList_T[6:0] ? _wnList_res_re_T_887 : _GEN_174; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_176 = 7'h2f == _wnList_T[6:0] ? _wnList_res_re_T_895 : _GEN_175; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_177 = 7'h30 == _wnList_T[6:0] ? _wnList_res_re_T_903 : _GEN_176; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_178 = 7'h31 == _wnList_T[6:0] ? _wnList_res_re_T_911 : _GEN_177; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_179 = 7'h32 == _wnList_T[6:0] ? _wnList_res_re_T_919 : _GEN_178; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_180 = 7'h33 == _wnList_T[6:0] ? _wnList_res_re_T_927 : _GEN_179; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_181 = 7'h34 == _wnList_T[6:0] ? _wnList_res_re_T_935 : _GEN_180; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_182 = 7'h35 == _wnList_T[6:0] ? _wnList_res_re_T_943 : _GEN_181; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_183 = 7'h36 == _wnList_T[6:0] ? _wnList_res_re_T_951 : _GEN_182; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_184 = 7'h37 == _wnList_T[6:0] ? _wnList_res_re_T_959 : _GEN_183; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_185 = 7'h38 == _wnList_T[6:0] ? _wnList_res_re_T_967 : _GEN_184; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_186 = 7'h39 == _wnList_T[6:0] ? _wnList_res_re_T_975 : _GEN_185; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_187 = 7'h3a == _wnList_T[6:0] ? _wnList_res_re_T_983 : _GEN_186; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_188 = 7'h3b == _wnList_T[6:0] ? _wnList_res_re_T_991 : _GEN_187; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_189 = 7'h3c == _wnList_T[6:0] ? _wnList_res_re_T_999 : _GEN_188; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_190 = 7'h3d == _wnList_T[6:0] ? _wnList_res_re_T_1007 : _GEN_189; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_191 = 7'h3e == _wnList_T[6:0] ? _wnList_res_re_T_1015 : _GEN_190; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_192 = 7'h3f == _wnList_T[6:0] ? _wnList_res_re_T_1023 : _GEN_191; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_193 = 7'h40 == _wnList_T[6:0] ? _wnList_res_im_T_519 : _GEN_192; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_194 = 7'h41 == _wnList_T[6:0] ? _wnList_res_re_T_1023 : _GEN_193; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_195 = 7'h42 == _wnList_T[6:0] ? _wnList_res_re_T_1015 : _GEN_194; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_196 = 7'h43 == _wnList_T[6:0] ? _wnList_res_re_T_1007 : _GEN_195; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_197 = 7'h44 == _wnList_T[6:0] ? _wnList_res_re_T_999 : _GEN_196; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_198 = 7'h45 == _wnList_T[6:0] ? _wnList_res_re_T_991 : _GEN_197; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_199 = 7'h46 == _wnList_T[6:0] ? _wnList_res_re_T_983 : _GEN_198; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_200 = 7'h47 == _wnList_T[6:0] ? _wnList_res_re_T_975 : _GEN_199; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_201 = 7'h48 == _wnList_T[6:0] ? _wnList_res_re_T_967 : _GEN_200; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_202 = 7'h49 == _wnList_T[6:0] ? _wnList_res_re_T_959 : _GEN_201; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_203 = 7'h4a == _wnList_T[6:0] ? _wnList_res_re_T_951 : _GEN_202; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_204 = 7'h4b == _wnList_T[6:0] ? _wnList_res_re_T_943 : _GEN_203; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_205 = 7'h4c == _wnList_T[6:0] ? _wnList_res_re_T_935 : _GEN_204; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_206 = 7'h4d == _wnList_T[6:0] ? _wnList_res_re_T_927 : _GEN_205; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_207 = 7'h4e == _wnList_T[6:0] ? _wnList_res_re_T_919 : _GEN_206; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_208 = 7'h4f == _wnList_T[6:0] ? _wnList_res_re_T_911 : _GEN_207; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_209 = 7'h50 == _wnList_T[6:0] ? _wnList_res_re_T_903 : _GEN_208; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_210 = 7'h51 == _wnList_T[6:0] ? _wnList_res_re_T_895 : _GEN_209; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_211 = 7'h52 == _wnList_T[6:0] ? _wnList_res_re_T_887 : _GEN_210; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_212 = 7'h53 == _wnList_T[6:0] ? _wnList_res_re_T_879 : _GEN_211; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_213 = 7'h54 == _wnList_T[6:0] ? _wnList_res_re_T_871 : _GEN_212; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_214 = 7'h55 == _wnList_T[6:0] ? _wnList_res_re_T_863 : _GEN_213; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_215 = 7'h56 == _wnList_T[6:0] ? _wnList_res_re_T_855 : _GEN_214; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_216 = 7'h57 == _wnList_T[6:0] ? _wnList_res_re_T_847 : _GEN_215; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_217 = 7'h58 == _wnList_T[6:0] ? _wnList_res_re_T_839 : _GEN_216; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_218 = 7'h59 == _wnList_T[6:0] ? _wnList_res_re_T_831 : _GEN_217; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_219 = 7'h5a == _wnList_T[6:0] ? _wnList_res_re_T_823 : _GEN_218; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_220 = 7'h5b == _wnList_T[6:0] ? _wnList_res_re_T_815 : _GEN_219; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_221 = 7'h5c == _wnList_T[6:0] ? _wnList_res_re_T_807 : _GEN_220; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_222 = 7'h5d == _wnList_T[6:0] ? _wnList_res_re_T_799 : _GEN_221; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_223 = 7'h5e == _wnList_T[6:0] ? _wnList_res_re_T_791 : _GEN_222; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_224 = 7'h5f == _wnList_T[6:0] ? _wnList_res_re_T_783 : _GEN_223; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_225 = 7'h60 == _wnList_T[6:0] ? _wnList_res_re_T_775 : _GEN_224; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_226 = 7'h61 == _wnList_T[6:0] ? _wnList_res_re_T_767 : _GEN_225; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_227 = 7'h62 == _wnList_T[6:0] ? _wnList_res_re_T_759 : _GEN_226; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_228 = 7'h63 == _wnList_T[6:0] ? _wnList_res_re_T_751 : _GEN_227; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_229 = 7'h64 == _wnList_T[6:0] ? _wnList_res_re_T_743 : _GEN_228; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_230 = 7'h65 == _wnList_T[6:0] ? _wnList_res_re_T_735 : _GEN_229; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_231 = 7'h66 == _wnList_T[6:0] ? _wnList_res_re_T_727 : _GEN_230; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_232 = 7'h67 == _wnList_T[6:0] ? _wnList_res_re_T_719 : _GEN_231; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_233 = 7'h68 == _wnList_T[6:0] ? _wnList_res_re_T_711 : _GEN_232; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_234 = 7'h69 == _wnList_T[6:0] ? _wnList_res_re_T_703 : _GEN_233; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_235 = 7'h6a == _wnList_T[6:0] ? _wnList_res_re_T_695 : _GEN_234; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_236 = 7'h6b == _wnList_T[6:0] ? _wnList_res_re_T_687 : _GEN_235; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_237 = 7'h6c == _wnList_T[6:0] ? _wnList_res_re_T_679 : _GEN_236; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_238 = 7'h6d == _wnList_T[6:0] ? _wnList_res_re_T_671 : _GEN_237; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_239 = 7'h6e == _wnList_T[6:0] ? _wnList_res_re_T_663 : _GEN_238; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_240 = 7'h6f == _wnList_T[6:0] ? _wnList_res_re_T_655 : _GEN_239; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_241 = 7'h70 == _wnList_T[6:0] ? _wnList_res_re_T_647 : _GEN_240; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_242 = 7'h71 == _wnList_T[6:0] ? _wnList_res_re_T_639 : _GEN_241; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_243 = 7'h72 == _wnList_T[6:0] ? _wnList_res_re_T_631 : _GEN_242; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_244 = 7'h73 == _wnList_T[6:0] ? _wnList_res_re_T_623 : _GEN_243; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_245 = 7'h74 == _wnList_T[6:0] ? _wnList_res_re_T_615 : _GEN_244; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_246 = 7'h75 == _wnList_T[6:0] ? _wnList_res_re_T_607 : _GEN_245; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_247 = 7'h76 == _wnList_T[6:0] ? _wnList_res_re_T_599 : _GEN_246; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_248 = 7'h77 == _wnList_T[6:0] ? _wnList_res_re_T_591 : _GEN_247; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_249 = 7'h78 == _wnList_T[6:0] ? _wnList_res_re_T_583 : _GEN_248; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_250 = 7'h79 == _wnList_T[6:0] ? _wnList_res_re_T_575 : _GEN_249; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_251 = 7'h7a == _wnList_T[6:0] ? _wnList_res_re_T_567 : _GEN_250; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_252 = 7'h7b == _wnList_T[6:0] ? _wnList_res_re_T_559 : _GEN_251; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_253 = 7'h7c == _wnList_T[6:0] ? _wnList_res_re_T_551 : _GEN_252; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_254 = 7'h7d == _wnList_T[6:0] ? _wnList_res_re_T_543 : _GEN_253; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_255 = 7'h7e == _wnList_T[6:0] ? _wnList_res_re_T_535 : _GEN_254; // @[FFT.scala 105:{12,12}]
  wire [6:0] _wnList_T_3 = 7'h20 + cnt_0; // @[FFT.scala 135:96]
  wire [16:0] _GEN_258 = 7'h1 == _wnList_T_3 ? _wnList_res_re_T_15 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_259 = 7'h2 == _wnList_T_3 ? _wnList_res_re_T_23 : _GEN_258; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_260 = 7'h3 == _wnList_T_3 ? _wnList_res_re_T_31 : _GEN_259; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_261 = 7'h4 == _wnList_T_3 ? _wnList_res_re_T_39 : _GEN_260; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_262 = 7'h5 == _wnList_T_3 ? _wnList_res_re_T_47 : _GEN_261; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_263 = 7'h6 == _wnList_T_3 ? _wnList_res_re_T_55 : _GEN_262; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_264 = 7'h7 == _wnList_T_3 ? _wnList_res_re_T_63 : _GEN_263; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_265 = 7'h8 == _wnList_T_3 ? _wnList_res_re_T_71 : _GEN_264; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_266 = 7'h9 == _wnList_T_3 ? _wnList_res_re_T_79 : _GEN_265; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_267 = 7'ha == _wnList_T_3 ? _wnList_res_re_T_87 : _GEN_266; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_268 = 7'hb == _wnList_T_3 ? _wnList_res_re_T_95 : _GEN_267; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_269 = 7'hc == _wnList_T_3 ? _wnList_res_re_T_103 : _GEN_268; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_270 = 7'hd == _wnList_T_3 ? _wnList_res_re_T_111 : _GEN_269; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_271 = 7'he == _wnList_T_3 ? _wnList_res_re_T_119 : _GEN_270; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_272 = 7'hf == _wnList_T_3 ? _wnList_res_re_T_127 : _GEN_271; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_273 = 7'h10 == _wnList_T_3 ? _wnList_res_re_T_135 : _GEN_272; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_274 = 7'h11 == _wnList_T_3 ? _wnList_res_re_T_143 : _GEN_273; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_275 = 7'h12 == _wnList_T_3 ? _wnList_res_re_T_151 : _GEN_274; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_276 = 7'h13 == _wnList_T_3 ? _wnList_res_re_T_159 : _GEN_275; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_277 = 7'h14 == _wnList_T_3 ? _wnList_res_re_T_167 : _GEN_276; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_278 = 7'h15 == _wnList_T_3 ? _wnList_res_re_T_175 : _GEN_277; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_279 = 7'h16 == _wnList_T_3 ? _wnList_res_re_T_183 : _GEN_278; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_280 = 7'h17 == _wnList_T_3 ? _wnList_res_re_T_191 : _GEN_279; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_281 = 7'h18 == _wnList_T_3 ? _wnList_res_re_T_199 : _GEN_280; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_282 = 7'h19 == _wnList_T_3 ? _wnList_res_re_T_207 : _GEN_281; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_283 = 7'h1a == _wnList_T_3 ? _wnList_res_re_T_215 : _GEN_282; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_284 = 7'h1b == _wnList_T_3 ? _wnList_res_re_T_223 : _GEN_283; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_285 = 7'h1c == _wnList_T_3 ? _wnList_res_re_T_231 : _GEN_284; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_286 = 7'h1d == _wnList_T_3 ? _wnList_res_re_T_239 : _GEN_285; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_287 = 7'h1e == _wnList_T_3 ? _wnList_res_re_T_247 : _GEN_286; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_288 = 7'h1f == _wnList_T_3 ? _wnList_res_re_T_255 : _GEN_287; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_289 = 7'h20 == _wnList_T_3 ? _wnList_res_re_T_263 : _GEN_288; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_290 = 7'h21 == _wnList_T_3 ? _wnList_res_re_T_271 : _GEN_289; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_291 = 7'h22 == _wnList_T_3 ? _wnList_res_re_T_279 : _GEN_290; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_292 = 7'h23 == _wnList_T_3 ? _wnList_res_re_T_287 : _GEN_291; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_293 = 7'h24 == _wnList_T_3 ? _wnList_res_re_T_295 : _GEN_292; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_294 = 7'h25 == _wnList_T_3 ? _wnList_res_re_T_303 : _GEN_293; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_295 = 7'h26 == _wnList_T_3 ? _wnList_res_re_T_311 : _GEN_294; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_296 = 7'h27 == _wnList_T_3 ? _wnList_res_re_T_319 : _GEN_295; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_297 = 7'h28 == _wnList_T_3 ? _wnList_res_re_T_327 : _GEN_296; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_298 = 7'h29 == _wnList_T_3 ? _wnList_res_re_T_335 : _GEN_297; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_299 = 7'h2a == _wnList_T_3 ? _wnList_res_re_T_343 : _GEN_298; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_300 = 7'h2b == _wnList_T_3 ? _wnList_res_re_T_351 : _GEN_299; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_301 = 7'h2c == _wnList_T_3 ? _wnList_res_re_T_359 : _GEN_300; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_302 = 7'h2d == _wnList_T_3 ? _wnList_res_re_T_367 : _GEN_301; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_303 = 7'h2e == _wnList_T_3 ? _wnList_res_re_T_375 : _GEN_302; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_304 = 7'h2f == _wnList_T_3 ? _wnList_res_re_T_383 : _GEN_303; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_305 = 7'h30 == _wnList_T_3 ? _wnList_res_re_T_391 : _GEN_304; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_306 = 7'h31 == _wnList_T_3 ? _wnList_res_re_T_399 : _GEN_305; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_307 = 7'h32 == _wnList_T_3 ? _wnList_res_re_T_407 : _GEN_306; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_308 = 7'h33 == _wnList_T_3 ? _wnList_res_re_T_415 : _GEN_307; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_309 = 7'h34 == _wnList_T_3 ? _wnList_res_re_T_423 : _GEN_308; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_310 = 7'h35 == _wnList_T_3 ? _wnList_res_re_T_431 : _GEN_309; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_311 = 7'h36 == _wnList_T_3 ? _wnList_res_re_T_439 : _GEN_310; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_312 = 7'h37 == _wnList_T_3 ? _wnList_res_re_T_447 : _GEN_311; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_313 = 7'h38 == _wnList_T_3 ? _wnList_res_re_T_455 : _GEN_312; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_314 = 7'h39 == _wnList_T_3 ? _wnList_res_re_T_463 : _GEN_313; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_315 = 7'h3a == _wnList_T_3 ? _wnList_res_re_T_471 : _GEN_314; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_316 = 7'h3b == _wnList_T_3 ? _wnList_res_re_T_479 : _GEN_315; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_317 = 7'h3c == _wnList_T_3 ? _wnList_res_re_T_487 : _GEN_316; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_318 = 7'h3d == _wnList_T_3 ? _wnList_res_re_T_495 : _GEN_317; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_319 = 7'h3e == _wnList_T_3 ? _wnList_res_re_T_503 : _GEN_318; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_320 = 7'h3f == _wnList_T_3 ? _wnList_res_re_T_511 : _GEN_319; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_321 = 7'h40 == _wnList_T_3 ? _wnList_res_re_T_519 : _GEN_320; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_322 = 7'h41 == _wnList_T_3 ? _wnList_res_re_T_527 : _GEN_321; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_323 = 7'h42 == _wnList_T_3 ? _wnList_res_re_T_535 : _GEN_322; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_324 = 7'h43 == _wnList_T_3 ? _wnList_res_re_T_543 : _GEN_323; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_325 = 7'h44 == _wnList_T_3 ? _wnList_res_re_T_551 : _GEN_324; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_326 = 7'h45 == _wnList_T_3 ? _wnList_res_re_T_559 : _GEN_325; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_327 = 7'h46 == _wnList_T_3 ? _wnList_res_re_T_567 : _GEN_326; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_328 = 7'h47 == _wnList_T_3 ? _wnList_res_re_T_575 : _GEN_327; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_329 = 7'h48 == _wnList_T_3 ? _wnList_res_re_T_583 : _GEN_328; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_330 = 7'h49 == _wnList_T_3 ? _wnList_res_re_T_591 : _GEN_329; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_331 = 7'h4a == _wnList_T_3 ? _wnList_res_re_T_599 : _GEN_330; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_332 = 7'h4b == _wnList_T_3 ? _wnList_res_re_T_607 : _GEN_331; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_333 = 7'h4c == _wnList_T_3 ? _wnList_res_re_T_615 : _GEN_332; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_334 = 7'h4d == _wnList_T_3 ? _wnList_res_re_T_623 : _GEN_333; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_335 = 7'h4e == _wnList_T_3 ? _wnList_res_re_T_631 : _GEN_334; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_336 = 7'h4f == _wnList_T_3 ? _wnList_res_re_T_639 : _GEN_335; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_337 = 7'h50 == _wnList_T_3 ? _wnList_res_re_T_647 : _GEN_336; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_338 = 7'h51 == _wnList_T_3 ? _wnList_res_re_T_655 : _GEN_337; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_339 = 7'h52 == _wnList_T_3 ? _wnList_res_re_T_663 : _GEN_338; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_340 = 7'h53 == _wnList_T_3 ? _wnList_res_re_T_671 : _GEN_339; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_341 = 7'h54 == _wnList_T_3 ? _wnList_res_re_T_679 : _GEN_340; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_342 = 7'h55 == _wnList_T_3 ? _wnList_res_re_T_687 : _GEN_341; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_343 = 7'h56 == _wnList_T_3 ? _wnList_res_re_T_695 : _GEN_342; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_344 = 7'h57 == _wnList_T_3 ? _wnList_res_re_T_703 : _GEN_343; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_345 = 7'h58 == _wnList_T_3 ? _wnList_res_re_T_711 : _GEN_344; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_346 = 7'h59 == _wnList_T_3 ? _wnList_res_re_T_719 : _GEN_345; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_347 = 7'h5a == _wnList_T_3 ? _wnList_res_re_T_727 : _GEN_346; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_348 = 7'h5b == _wnList_T_3 ? _wnList_res_re_T_735 : _GEN_347; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_349 = 7'h5c == _wnList_T_3 ? _wnList_res_re_T_743 : _GEN_348; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_350 = 7'h5d == _wnList_T_3 ? _wnList_res_re_T_751 : _GEN_349; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_351 = 7'h5e == _wnList_T_3 ? _wnList_res_re_T_759 : _GEN_350; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_352 = 7'h5f == _wnList_T_3 ? _wnList_res_re_T_767 : _GEN_351; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_353 = 7'h60 == _wnList_T_3 ? _wnList_res_re_T_775 : _GEN_352; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_354 = 7'h61 == _wnList_T_3 ? _wnList_res_re_T_783 : _GEN_353; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_355 = 7'h62 == _wnList_T_3 ? _wnList_res_re_T_791 : _GEN_354; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_356 = 7'h63 == _wnList_T_3 ? _wnList_res_re_T_799 : _GEN_355; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_357 = 7'h64 == _wnList_T_3 ? _wnList_res_re_T_807 : _GEN_356; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_358 = 7'h65 == _wnList_T_3 ? _wnList_res_re_T_815 : _GEN_357; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_359 = 7'h66 == _wnList_T_3 ? _wnList_res_re_T_823 : _GEN_358; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_360 = 7'h67 == _wnList_T_3 ? _wnList_res_re_T_831 : _GEN_359; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_361 = 7'h68 == _wnList_T_3 ? _wnList_res_re_T_839 : _GEN_360; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_362 = 7'h69 == _wnList_T_3 ? _wnList_res_re_T_847 : _GEN_361; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_363 = 7'h6a == _wnList_T_3 ? _wnList_res_re_T_855 : _GEN_362; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_364 = 7'h6b == _wnList_T_3 ? _wnList_res_re_T_863 : _GEN_363; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_365 = 7'h6c == _wnList_T_3 ? _wnList_res_re_T_871 : _GEN_364; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_366 = 7'h6d == _wnList_T_3 ? _wnList_res_re_T_879 : _GEN_365; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_367 = 7'h6e == _wnList_T_3 ? _wnList_res_re_T_887 : _GEN_366; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_368 = 7'h6f == _wnList_T_3 ? _wnList_res_re_T_895 : _GEN_367; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_369 = 7'h70 == _wnList_T_3 ? _wnList_res_re_T_903 : _GEN_368; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_370 = 7'h71 == _wnList_T_3 ? _wnList_res_re_T_911 : _GEN_369; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_371 = 7'h72 == _wnList_T_3 ? _wnList_res_re_T_919 : _GEN_370; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_372 = 7'h73 == _wnList_T_3 ? _wnList_res_re_T_927 : _GEN_371; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_373 = 7'h74 == _wnList_T_3 ? _wnList_res_re_T_935 : _GEN_372; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_374 = 7'h75 == _wnList_T_3 ? _wnList_res_re_T_943 : _GEN_373; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_375 = 7'h76 == _wnList_T_3 ? _wnList_res_re_T_951 : _GEN_374; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_376 = 7'h77 == _wnList_T_3 ? _wnList_res_re_T_959 : _GEN_375; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_377 = 7'h78 == _wnList_T_3 ? _wnList_res_re_T_967 : _GEN_376; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_378 = 7'h79 == _wnList_T_3 ? _wnList_res_re_T_975 : _GEN_377; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_379 = 7'h7a == _wnList_T_3 ? _wnList_res_re_T_983 : _GEN_378; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_380 = 7'h7b == _wnList_T_3 ? _wnList_res_re_T_991 : _GEN_379; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_381 = 7'h7c == _wnList_T_3 ? _wnList_res_re_T_999 : _GEN_380; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_382 = 7'h7d == _wnList_T_3 ? _wnList_res_re_T_1007 : _GEN_381; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_383 = 7'h7e == _wnList_T_3 ? _wnList_res_re_T_1015 : _GEN_382; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_386 = 7'h1 == _wnList_T_3 ? _wnList_res_re_T_527 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_387 = 7'h2 == _wnList_T_3 ? _wnList_res_re_T_535 : _GEN_386; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_388 = 7'h3 == _wnList_T_3 ? _wnList_res_re_T_543 : _GEN_387; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_389 = 7'h4 == _wnList_T_3 ? _wnList_res_re_T_551 : _GEN_388; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_390 = 7'h5 == _wnList_T_3 ? _wnList_res_re_T_559 : _GEN_389; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_391 = 7'h6 == _wnList_T_3 ? _wnList_res_re_T_567 : _GEN_390; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_392 = 7'h7 == _wnList_T_3 ? _wnList_res_re_T_575 : _GEN_391; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_393 = 7'h8 == _wnList_T_3 ? _wnList_res_re_T_583 : _GEN_392; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_394 = 7'h9 == _wnList_T_3 ? _wnList_res_re_T_591 : _GEN_393; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_395 = 7'ha == _wnList_T_3 ? _wnList_res_re_T_599 : _GEN_394; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_396 = 7'hb == _wnList_T_3 ? _wnList_res_re_T_607 : _GEN_395; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_397 = 7'hc == _wnList_T_3 ? _wnList_res_re_T_615 : _GEN_396; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_398 = 7'hd == _wnList_T_3 ? _wnList_res_re_T_623 : _GEN_397; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_399 = 7'he == _wnList_T_3 ? _wnList_res_re_T_631 : _GEN_398; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_400 = 7'hf == _wnList_T_3 ? _wnList_res_re_T_639 : _GEN_399; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_401 = 7'h10 == _wnList_T_3 ? _wnList_res_re_T_647 : _GEN_400; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_402 = 7'h11 == _wnList_T_3 ? _wnList_res_re_T_655 : _GEN_401; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_403 = 7'h12 == _wnList_T_3 ? _wnList_res_re_T_663 : _GEN_402; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_404 = 7'h13 == _wnList_T_3 ? _wnList_res_re_T_671 : _GEN_403; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_405 = 7'h14 == _wnList_T_3 ? _wnList_res_re_T_679 : _GEN_404; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_406 = 7'h15 == _wnList_T_3 ? _wnList_res_re_T_687 : _GEN_405; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_407 = 7'h16 == _wnList_T_3 ? _wnList_res_re_T_695 : _GEN_406; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_408 = 7'h17 == _wnList_T_3 ? _wnList_res_re_T_703 : _GEN_407; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_409 = 7'h18 == _wnList_T_3 ? _wnList_res_re_T_711 : _GEN_408; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_410 = 7'h19 == _wnList_T_3 ? _wnList_res_re_T_719 : _GEN_409; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_411 = 7'h1a == _wnList_T_3 ? _wnList_res_re_T_727 : _GEN_410; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_412 = 7'h1b == _wnList_T_3 ? _wnList_res_re_T_735 : _GEN_411; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_413 = 7'h1c == _wnList_T_3 ? _wnList_res_re_T_743 : _GEN_412; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_414 = 7'h1d == _wnList_T_3 ? _wnList_res_re_T_751 : _GEN_413; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_415 = 7'h1e == _wnList_T_3 ? _wnList_res_re_T_759 : _GEN_414; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_416 = 7'h1f == _wnList_T_3 ? _wnList_res_re_T_767 : _GEN_415; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_417 = 7'h20 == _wnList_T_3 ? _wnList_res_re_T_775 : _GEN_416; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_418 = 7'h21 == _wnList_T_3 ? _wnList_res_re_T_783 : _GEN_417; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_419 = 7'h22 == _wnList_T_3 ? _wnList_res_re_T_791 : _GEN_418; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_420 = 7'h23 == _wnList_T_3 ? _wnList_res_re_T_799 : _GEN_419; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_421 = 7'h24 == _wnList_T_3 ? _wnList_res_re_T_807 : _GEN_420; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_422 = 7'h25 == _wnList_T_3 ? _wnList_res_re_T_815 : _GEN_421; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_423 = 7'h26 == _wnList_T_3 ? _wnList_res_re_T_823 : _GEN_422; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_424 = 7'h27 == _wnList_T_3 ? _wnList_res_re_T_831 : _GEN_423; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_425 = 7'h28 == _wnList_T_3 ? _wnList_res_re_T_839 : _GEN_424; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_426 = 7'h29 == _wnList_T_3 ? _wnList_res_re_T_847 : _GEN_425; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_427 = 7'h2a == _wnList_T_3 ? _wnList_res_re_T_855 : _GEN_426; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_428 = 7'h2b == _wnList_T_3 ? _wnList_res_re_T_863 : _GEN_427; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_429 = 7'h2c == _wnList_T_3 ? _wnList_res_re_T_871 : _GEN_428; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_430 = 7'h2d == _wnList_T_3 ? _wnList_res_re_T_879 : _GEN_429; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_431 = 7'h2e == _wnList_T_3 ? _wnList_res_re_T_887 : _GEN_430; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_432 = 7'h2f == _wnList_T_3 ? _wnList_res_re_T_895 : _GEN_431; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_433 = 7'h30 == _wnList_T_3 ? _wnList_res_re_T_903 : _GEN_432; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_434 = 7'h31 == _wnList_T_3 ? _wnList_res_re_T_911 : _GEN_433; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_435 = 7'h32 == _wnList_T_3 ? _wnList_res_re_T_919 : _GEN_434; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_436 = 7'h33 == _wnList_T_3 ? _wnList_res_re_T_927 : _GEN_435; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_437 = 7'h34 == _wnList_T_3 ? _wnList_res_re_T_935 : _GEN_436; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_438 = 7'h35 == _wnList_T_3 ? _wnList_res_re_T_943 : _GEN_437; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_439 = 7'h36 == _wnList_T_3 ? _wnList_res_re_T_951 : _GEN_438; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_440 = 7'h37 == _wnList_T_3 ? _wnList_res_re_T_959 : _GEN_439; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_441 = 7'h38 == _wnList_T_3 ? _wnList_res_re_T_967 : _GEN_440; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_442 = 7'h39 == _wnList_T_3 ? _wnList_res_re_T_975 : _GEN_441; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_443 = 7'h3a == _wnList_T_3 ? _wnList_res_re_T_983 : _GEN_442; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_444 = 7'h3b == _wnList_T_3 ? _wnList_res_re_T_991 : _GEN_443; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_445 = 7'h3c == _wnList_T_3 ? _wnList_res_re_T_999 : _GEN_444; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_446 = 7'h3d == _wnList_T_3 ? _wnList_res_re_T_1007 : _GEN_445; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_447 = 7'h3e == _wnList_T_3 ? _wnList_res_re_T_1015 : _GEN_446; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_448 = 7'h3f == _wnList_T_3 ? _wnList_res_re_T_1023 : _GEN_447; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_449 = 7'h40 == _wnList_T_3 ? _wnList_res_im_T_519 : _GEN_448; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_450 = 7'h41 == _wnList_T_3 ? _wnList_res_re_T_1023 : _GEN_449; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_451 = 7'h42 == _wnList_T_3 ? _wnList_res_re_T_1015 : _GEN_450; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_452 = 7'h43 == _wnList_T_3 ? _wnList_res_re_T_1007 : _GEN_451; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_453 = 7'h44 == _wnList_T_3 ? _wnList_res_re_T_999 : _GEN_452; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_454 = 7'h45 == _wnList_T_3 ? _wnList_res_re_T_991 : _GEN_453; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_455 = 7'h46 == _wnList_T_3 ? _wnList_res_re_T_983 : _GEN_454; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_456 = 7'h47 == _wnList_T_3 ? _wnList_res_re_T_975 : _GEN_455; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_457 = 7'h48 == _wnList_T_3 ? _wnList_res_re_T_967 : _GEN_456; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_458 = 7'h49 == _wnList_T_3 ? _wnList_res_re_T_959 : _GEN_457; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_459 = 7'h4a == _wnList_T_3 ? _wnList_res_re_T_951 : _GEN_458; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_460 = 7'h4b == _wnList_T_3 ? _wnList_res_re_T_943 : _GEN_459; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_461 = 7'h4c == _wnList_T_3 ? _wnList_res_re_T_935 : _GEN_460; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_462 = 7'h4d == _wnList_T_3 ? _wnList_res_re_T_927 : _GEN_461; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_463 = 7'h4e == _wnList_T_3 ? _wnList_res_re_T_919 : _GEN_462; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_464 = 7'h4f == _wnList_T_3 ? _wnList_res_re_T_911 : _GEN_463; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_465 = 7'h50 == _wnList_T_3 ? _wnList_res_re_T_903 : _GEN_464; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_466 = 7'h51 == _wnList_T_3 ? _wnList_res_re_T_895 : _GEN_465; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_467 = 7'h52 == _wnList_T_3 ? _wnList_res_re_T_887 : _GEN_466; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_468 = 7'h53 == _wnList_T_3 ? _wnList_res_re_T_879 : _GEN_467; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_469 = 7'h54 == _wnList_T_3 ? _wnList_res_re_T_871 : _GEN_468; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_470 = 7'h55 == _wnList_T_3 ? _wnList_res_re_T_863 : _GEN_469; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_471 = 7'h56 == _wnList_T_3 ? _wnList_res_re_T_855 : _GEN_470; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_472 = 7'h57 == _wnList_T_3 ? _wnList_res_re_T_847 : _GEN_471; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_473 = 7'h58 == _wnList_T_3 ? _wnList_res_re_T_839 : _GEN_472; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_474 = 7'h59 == _wnList_T_3 ? _wnList_res_re_T_831 : _GEN_473; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_475 = 7'h5a == _wnList_T_3 ? _wnList_res_re_T_823 : _GEN_474; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_476 = 7'h5b == _wnList_T_3 ? _wnList_res_re_T_815 : _GEN_475; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_477 = 7'h5c == _wnList_T_3 ? _wnList_res_re_T_807 : _GEN_476; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_478 = 7'h5d == _wnList_T_3 ? _wnList_res_re_T_799 : _GEN_477; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_479 = 7'h5e == _wnList_T_3 ? _wnList_res_re_T_791 : _GEN_478; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_480 = 7'h5f == _wnList_T_3 ? _wnList_res_re_T_783 : _GEN_479; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_481 = 7'h60 == _wnList_T_3 ? _wnList_res_re_T_775 : _GEN_480; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_482 = 7'h61 == _wnList_T_3 ? _wnList_res_re_T_767 : _GEN_481; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_483 = 7'h62 == _wnList_T_3 ? _wnList_res_re_T_759 : _GEN_482; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_484 = 7'h63 == _wnList_T_3 ? _wnList_res_re_T_751 : _GEN_483; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_485 = 7'h64 == _wnList_T_3 ? _wnList_res_re_T_743 : _GEN_484; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_486 = 7'h65 == _wnList_T_3 ? _wnList_res_re_T_735 : _GEN_485; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_487 = 7'h66 == _wnList_T_3 ? _wnList_res_re_T_727 : _GEN_486; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_488 = 7'h67 == _wnList_T_3 ? _wnList_res_re_T_719 : _GEN_487; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_489 = 7'h68 == _wnList_T_3 ? _wnList_res_re_T_711 : _GEN_488; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_490 = 7'h69 == _wnList_T_3 ? _wnList_res_re_T_703 : _GEN_489; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_491 = 7'h6a == _wnList_T_3 ? _wnList_res_re_T_695 : _GEN_490; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_492 = 7'h6b == _wnList_T_3 ? _wnList_res_re_T_687 : _GEN_491; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_493 = 7'h6c == _wnList_T_3 ? _wnList_res_re_T_679 : _GEN_492; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_494 = 7'h6d == _wnList_T_3 ? _wnList_res_re_T_671 : _GEN_493; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_495 = 7'h6e == _wnList_T_3 ? _wnList_res_re_T_663 : _GEN_494; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_496 = 7'h6f == _wnList_T_3 ? _wnList_res_re_T_655 : _GEN_495; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_497 = 7'h70 == _wnList_T_3 ? _wnList_res_re_T_647 : _GEN_496; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_498 = 7'h71 == _wnList_T_3 ? _wnList_res_re_T_639 : _GEN_497; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_499 = 7'h72 == _wnList_T_3 ? _wnList_res_re_T_631 : _GEN_498; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_500 = 7'h73 == _wnList_T_3 ? _wnList_res_re_T_623 : _GEN_499; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_501 = 7'h74 == _wnList_T_3 ? _wnList_res_re_T_615 : _GEN_500; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_502 = 7'h75 == _wnList_T_3 ? _wnList_res_re_T_607 : _GEN_501; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_503 = 7'h76 == _wnList_T_3 ? _wnList_res_re_T_599 : _GEN_502; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_504 = 7'h77 == _wnList_T_3 ? _wnList_res_re_T_591 : _GEN_503; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_505 = 7'h78 == _wnList_T_3 ? _wnList_res_re_T_583 : _GEN_504; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_506 = 7'h79 == _wnList_T_3 ? _wnList_res_re_T_575 : _GEN_505; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_507 = 7'h7a == _wnList_T_3 ? _wnList_res_re_T_567 : _GEN_506; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_508 = 7'h7b == _wnList_T_3 ? _wnList_res_re_T_559 : _GEN_507; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_509 = 7'h7c == _wnList_T_3 ? _wnList_res_re_T_551 : _GEN_508; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_510 = 7'h7d == _wnList_T_3 ? _wnList_res_re_T_543 : _GEN_509; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_511 = 7'h7e == _wnList_T_3 ? _wnList_res_re_T_535 : _GEN_510; // @[FFT.scala 105:{12,12}]
  wire [6:0] _wnList_T_5 = 7'h40 + cnt_0; // @[FFT.scala 135:96]
  wire [16:0] _GEN_514 = 7'h1 == _wnList_T_5 ? _wnList_res_re_T_15 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_515 = 7'h2 == _wnList_T_5 ? _wnList_res_re_T_23 : _GEN_514; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_516 = 7'h3 == _wnList_T_5 ? _wnList_res_re_T_31 : _GEN_515; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_517 = 7'h4 == _wnList_T_5 ? _wnList_res_re_T_39 : _GEN_516; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_518 = 7'h5 == _wnList_T_5 ? _wnList_res_re_T_47 : _GEN_517; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_519 = 7'h6 == _wnList_T_5 ? _wnList_res_re_T_55 : _GEN_518; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_520 = 7'h7 == _wnList_T_5 ? _wnList_res_re_T_63 : _GEN_519; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_521 = 7'h8 == _wnList_T_5 ? _wnList_res_re_T_71 : _GEN_520; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_522 = 7'h9 == _wnList_T_5 ? _wnList_res_re_T_79 : _GEN_521; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_523 = 7'ha == _wnList_T_5 ? _wnList_res_re_T_87 : _GEN_522; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_524 = 7'hb == _wnList_T_5 ? _wnList_res_re_T_95 : _GEN_523; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_525 = 7'hc == _wnList_T_5 ? _wnList_res_re_T_103 : _GEN_524; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_526 = 7'hd == _wnList_T_5 ? _wnList_res_re_T_111 : _GEN_525; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_527 = 7'he == _wnList_T_5 ? _wnList_res_re_T_119 : _GEN_526; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_528 = 7'hf == _wnList_T_5 ? _wnList_res_re_T_127 : _GEN_527; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_529 = 7'h10 == _wnList_T_5 ? _wnList_res_re_T_135 : _GEN_528; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_530 = 7'h11 == _wnList_T_5 ? _wnList_res_re_T_143 : _GEN_529; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_531 = 7'h12 == _wnList_T_5 ? _wnList_res_re_T_151 : _GEN_530; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_532 = 7'h13 == _wnList_T_5 ? _wnList_res_re_T_159 : _GEN_531; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_533 = 7'h14 == _wnList_T_5 ? _wnList_res_re_T_167 : _GEN_532; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_534 = 7'h15 == _wnList_T_5 ? _wnList_res_re_T_175 : _GEN_533; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_535 = 7'h16 == _wnList_T_5 ? _wnList_res_re_T_183 : _GEN_534; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_536 = 7'h17 == _wnList_T_5 ? _wnList_res_re_T_191 : _GEN_535; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_537 = 7'h18 == _wnList_T_5 ? _wnList_res_re_T_199 : _GEN_536; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_538 = 7'h19 == _wnList_T_5 ? _wnList_res_re_T_207 : _GEN_537; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_539 = 7'h1a == _wnList_T_5 ? _wnList_res_re_T_215 : _GEN_538; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_540 = 7'h1b == _wnList_T_5 ? _wnList_res_re_T_223 : _GEN_539; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_541 = 7'h1c == _wnList_T_5 ? _wnList_res_re_T_231 : _GEN_540; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_542 = 7'h1d == _wnList_T_5 ? _wnList_res_re_T_239 : _GEN_541; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_543 = 7'h1e == _wnList_T_5 ? _wnList_res_re_T_247 : _GEN_542; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_544 = 7'h1f == _wnList_T_5 ? _wnList_res_re_T_255 : _GEN_543; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_545 = 7'h20 == _wnList_T_5 ? _wnList_res_re_T_263 : _GEN_544; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_546 = 7'h21 == _wnList_T_5 ? _wnList_res_re_T_271 : _GEN_545; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_547 = 7'h22 == _wnList_T_5 ? _wnList_res_re_T_279 : _GEN_546; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_548 = 7'h23 == _wnList_T_5 ? _wnList_res_re_T_287 : _GEN_547; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_549 = 7'h24 == _wnList_T_5 ? _wnList_res_re_T_295 : _GEN_548; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_550 = 7'h25 == _wnList_T_5 ? _wnList_res_re_T_303 : _GEN_549; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_551 = 7'h26 == _wnList_T_5 ? _wnList_res_re_T_311 : _GEN_550; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_552 = 7'h27 == _wnList_T_5 ? _wnList_res_re_T_319 : _GEN_551; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_553 = 7'h28 == _wnList_T_5 ? _wnList_res_re_T_327 : _GEN_552; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_554 = 7'h29 == _wnList_T_5 ? _wnList_res_re_T_335 : _GEN_553; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_555 = 7'h2a == _wnList_T_5 ? _wnList_res_re_T_343 : _GEN_554; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_556 = 7'h2b == _wnList_T_5 ? _wnList_res_re_T_351 : _GEN_555; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_557 = 7'h2c == _wnList_T_5 ? _wnList_res_re_T_359 : _GEN_556; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_558 = 7'h2d == _wnList_T_5 ? _wnList_res_re_T_367 : _GEN_557; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_559 = 7'h2e == _wnList_T_5 ? _wnList_res_re_T_375 : _GEN_558; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_560 = 7'h2f == _wnList_T_5 ? _wnList_res_re_T_383 : _GEN_559; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_561 = 7'h30 == _wnList_T_5 ? _wnList_res_re_T_391 : _GEN_560; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_562 = 7'h31 == _wnList_T_5 ? _wnList_res_re_T_399 : _GEN_561; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_563 = 7'h32 == _wnList_T_5 ? _wnList_res_re_T_407 : _GEN_562; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_564 = 7'h33 == _wnList_T_5 ? _wnList_res_re_T_415 : _GEN_563; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_565 = 7'h34 == _wnList_T_5 ? _wnList_res_re_T_423 : _GEN_564; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_566 = 7'h35 == _wnList_T_5 ? _wnList_res_re_T_431 : _GEN_565; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_567 = 7'h36 == _wnList_T_5 ? _wnList_res_re_T_439 : _GEN_566; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_568 = 7'h37 == _wnList_T_5 ? _wnList_res_re_T_447 : _GEN_567; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_569 = 7'h38 == _wnList_T_5 ? _wnList_res_re_T_455 : _GEN_568; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_570 = 7'h39 == _wnList_T_5 ? _wnList_res_re_T_463 : _GEN_569; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_571 = 7'h3a == _wnList_T_5 ? _wnList_res_re_T_471 : _GEN_570; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_572 = 7'h3b == _wnList_T_5 ? _wnList_res_re_T_479 : _GEN_571; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_573 = 7'h3c == _wnList_T_5 ? _wnList_res_re_T_487 : _GEN_572; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_574 = 7'h3d == _wnList_T_5 ? _wnList_res_re_T_495 : _GEN_573; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_575 = 7'h3e == _wnList_T_5 ? _wnList_res_re_T_503 : _GEN_574; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_576 = 7'h3f == _wnList_T_5 ? _wnList_res_re_T_511 : _GEN_575; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_577 = 7'h40 == _wnList_T_5 ? _wnList_res_re_T_519 : _GEN_576; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_578 = 7'h41 == _wnList_T_5 ? _wnList_res_re_T_527 : _GEN_577; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_579 = 7'h42 == _wnList_T_5 ? _wnList_res_re_T_535 : _GEN_578; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_580 = 7'h43 == _wnList_T_5 ? _wnList_res_re_T_543 : _GEN_579; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_581 = 7'h44 == _wnList_T_5 ? _wnList_res_re_T_551 : _GEN_580; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_582 = 7'h45 == _wnList_T_5 ? _wnList_res_re_T_559 : _GEN_581; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_583 = 7'h46 == _wnList_T_5 ? _wnList_res_re_T_567 : _GEN_582; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_584 = 7'h47 == _wnList_T_5 ? _wnList_res_re_T_575 : _GEN_583; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_585 = 7'h48 == _wnList_T_5 ? _wnList_res_re_T_583 : _GEN_584; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_586 = 7'h49 == _wnList_T_5 ? _wnList_res_re_T_591 : _GEN_585; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_587 = 7'h4a == _wnList_T_5 ? _wnList_res_re_T_599 : _GEN_586; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_588 = 7'h4b == _wnList_T_5 ? _wnList_res_re_T_607 : _GEN_587; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_589 = 7'h4c == _wnList_T_5 ? _wnList_res_re_T_615 : _GEN_588; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_590 = 7'h4d == _wnList_T_5 ? _wnList_res_re_T_623 : _GEN_589; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_591 = 7'h4e == _wnList_T_5 ? _wnList_res_re_T_631 : _GEN_590; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_592 = 7'h4f == _wnList_T_5 ? _wnList_res_re_T_639 : _GEN_591; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_593 = 7'h50 == _wnList_T_5 ? _wnList_res_re_T_647 : _GEN_592; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_594 = 7'h51 == _wnList_T_5 ? _wnList_res_re_T_655 : _GEN_593; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_595 = 7'h52 == _wnList_T_5 ? _wnList_res_re_T_663 : _GEN_594; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_596 = 7'h53 == _wnList_T_5 ? _wnList_res_re_T_671 : _GEN_595; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_597 = 7'h54 == _wnList_T_5 ? _wnList_res_re_T_679 : _GEN_596; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_598 = 7'h55 == _wnList_T_5 ? _wnList_res_re_T_687 : _GEN_597; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_599 = 7'h56 == _wnList_T_5 ? _wnList_res_re_T_695 : _GEN_598; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_600 = 7'h57 == _wnList_T_5 ? _wnList_res_re_T_703 : _GEN_599; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_601 = 7'h58 == _wnList_T_5 ? _wnList_res_re_T_711 : _GEN_600; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_602 = 7'h59 == _wnList_T_5 ? _wnList_res_re_T_719 : _GEN_601; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_603 = 7'h5a == _wnList_T_5 ? _wnList_res_re_T_727 : _GEN_602; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_604 = 7'h5b == _wnList_T_5 ? _wnList_res_re_T_735 : _GEN_603; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_605 = 7'h5c == _wnList_T_5 ? _wnList_res_re_T_743 : _GEN_604; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_606 = 7'h5d == _wnList_T_5 ? _wnList_res_re_T_751 : _GEN_605; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_607 = 7'h5e == _wnList_T_5 ? _wnList_res_re_T_759 : _GEN_606; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_608 = 7'h5f == _wnList_T_5 ? _wnList_res_re_T_767 : _GEN_607; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_609 = 7'h60 == _wnList_T_5 ? _wnList_res_re_T_775 : _GEN_608; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_610 = 7'h61 == _wnList_T_5 ? _wnList_res_re_T_783 : _GEN_609; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_611 = 7'h62 == _wnList_T_5 ? _wnList_res_re_T_791 : _GEN_610; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_612 = 7'h63 == _wnList_T_5 ? _wnList_res_re_T_799 : _GEN_611; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_613 = 7'h64 == _wnList_T_5 ? _wnList_res_re_T_807 : _GEN_612; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_614 = 7'h65 == _wnList_T_5 ? _wnList_res_re_T_815 : _GEN_613; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_615 = 7'h66 == _wnList_T_5 ? _wnList_res_re_T_823 : _GEN_614; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_616 = 7'h67 == _wnList_T_5 ? _wnList_res_re_T_831 : _GEN_615; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_617 = 7'h68 == _wnList_T_5 ? _wnList_res_re_T_839 : _GEN_616; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_618 = 7'h69 == _wnList_T_5 ? _wnList_res_re_T_847 : _GEN_617; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_619 = 7'h6a == _wnList_T_5 ? _wnList_res_re_T_855 : _GEN_618; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_620 = 7'h6b == _wnList_T_5 ? _wnList_res_re_T_863 : _GEN_619; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_621 = 7'h6c == _wnList_T_5 ? _wnList_res_re_T_871 : _GEN_620; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_622 = 7'h6d == _wnList_T_5 ? _wnList_res_re_T_879 : _GEN_621; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_623 = 7'h6e == _wnList_T_5 ? _wnList_res_re_T_887 : _GEN_622; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_624 = 7'h6f == _wnList_T_5 ? _wnList_res_re_T_895 : _GEN_623; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_625 = 7'h70 == _wnList_T_5 ? _wnList_res_re_T_903 : _GEN_624; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_626 = 7'h71 == _wnList_T_5 ? _wnList_res_re_T_911 : _GEN_625; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_627 = 7'h72 == _wnList_T_5 ? _wnList_res_re_T_919 : _GEN_626; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_628 = 7'h73 == _wnList_T_5 ? _wnList_res_re_T_927 : _GEN_627; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_629 = 7'h74 == _wnList_T_5 ? _wnList_res_re_T_935 : _GEN_628; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_630 = 7'h75 == _wnList_T_5 ? _wnList_res_re_T_943 : _GEN_629; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_631 = 7'h76 == _wnList_T_5 ? _wnList_res_re_T_951 : _GEN_630; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_632 = 7'h77 == _wnList_T_5 ? _wnList_res_re_T_959 : _GEN_631; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_633 = 7'h78 == _wnList_T_5 ? _wnList_res_re_T_967 : _GEN_632; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_634 = 7'h79 == _wnList_T_5 ? _wnList_res_re_T_975 : _GEN_633; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_635 = 7'h7a == _wnList_T_5 ? _wnList_res_re_T_983 : _GEN_634; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_636 = 7'h7b == _wnList_T_5 ? _wnList_res_re_T_991 : _GEN_635; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_637 = 7'h7c == _wnList_T_5 ? _wnList_res_re_T_999 : _GEN_636; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_638 = 7'h7d == _wnList_T_5 ? _wnList_res_re_T_1007 : _GEN_637; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_639 = 7'h7e == _wnList_T_5 ? _wnList_res_re_T_1015 : _GEN_638; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_642 = 7'h1 == _wnList_T_5 ? _wnList_res_re_T_527 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_643 = 7'h2 == _wnList_T_5 ? _wnList_res_re_T_535 : _GEN_642; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_644 = 7'h3 == _wnList_T_5 ? _wnList_res_re_T_543 : _GEN_643; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_645 = 7'h4 == _wnList_T_5 ? _wnList_res_re_T_551 : _GEN_644; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_646 = 7'h5 == _wnList_T_5 ? _wnList_res_re_T_559 : _GEN_645; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_647 = 7'h6 == _wnList_T_5 ? _wnList_res_re_T_567 : _GEN_646; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_648 = 7'h7 == _wnList_T_5 ? _wnList_res_re_T_575 : _GEN_647; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_649 = 7'h8 == _wnList_T_5 ? _wnList_res_re_T_583 : _GEN_648; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_650 = 7'h9 == _wnList_T_5 ? _wnList_res_re_T_591 : _GEN_649; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_651 = 7'ha == _wnList_T_5 ? _wnList_res_re_T_599 : _GEN_650; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_652 = 7'hb == _wnList_T_5 ? _wnList_res_re_T_607 : _GEN_651; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_653 = 7'hc == _wnList_T_5 ? _wnList_res_re_T_615 : _GEN_652; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_654 = 7'hd == _wnList_T_5 ? _wnList_res_re_T_623 : _GEN_653; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_655 = 7'he == _wnList_T_5 ? _wnList_res_re_T_631 : _GEN_654; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_656 = 7'hf == _wnList_T_5 ? _wnList_res_re_T_639 : _GEN_655; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_657 = 7'h10 == _wnList_T_5 ? _wnList_res_re_T_647 : _GEN_656; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_658 = 7'h11 == _wnList_T_5 ? _wnList_res_re_T_655 : _GEN_657; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_659 = 7'h12 == _wnList_T_5 ? _wnList_res_re_T_663 : _GEN_658; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_660 = 7'h13 == _wnList_T_5 ? _wnList_res_re_T_671 : _GEN_659; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_661 = 7'h14 == _wnList_T_5 ? _wnList_res_re_T_679 : _GEN_660; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_662 = 7'h15 == _wnList_T_5 ? _wnList_res_re_T_687 : _GEN_661; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_663 = 7'h16 == _wnList_T_5 ? _wnList_res_re_T_695 : _GEN_662; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_664 = 7'h17 == _wnList_T_5 ? _wnList_res_re_T_703 : _GEN_663; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_665 = 7'h18 == _wnList_T_5 ? _wnList_res_re_T_711 : _GEN_664; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_666 = 7'h19 == _wnList_T_5 ? _wnList_res_re_T_719 : _GEN_665; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_667 = 7'h1a == _wnList_T_5 ? _wnList_res_re_T_727 : _GEN_666; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_668 = 7'h1b == _wnList_T_5 ? _wnList_res_re_T_735 : _GEN_667; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_669 = 7'h1c == _wnList_T_5 ? _wnList_res_re_T_743 : _GEN_668; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_670 = 7'h1d == _wnList_T_5 ? _wnList_res_re_T_751 : _GEN_669; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_671 = 7'h1e == _wnList_T_5 ? _wnList_res_re_T_759 : _GEN_670; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_672 = 7'h1f == _wnList_T_5 ? _wnList_res_re_T_767 : _GEN_671; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_673 = 7'h20 == _wnList_T_5 ? _wnList_res_re_T_775 : _GEN_672; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_674 = 7'h21 == _wnList_T_5 ? _wnList_res_re_T_783 : _GEN_673; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_675 = 7'h22 == _wnList_T_5 ? _wnList_res_re_T_791 : _GEN_674; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_676 = 7'h23 == _wnList_T_5 ? _wnList_res_re_T_799 : _GEN_675; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_677 = 7'h24 == _wnList_T_5 ? _wnList_res_re_T_807 : _GEN_676; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_678 = 7'h25 == _wnList_T_5 ? _wnList_res_re_T_815 : _GEN_677; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_679 = 7'h26 == _wnList_T_5 ? _wnList_res_re_T_823 : _GEN_678; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_680 = 7'h27 == _wnList_T_5 ? _wnList_res_re_T_831 : _GEN_679; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_681 = 7'h28 == _wnList_T_5 ? _wnList_res_re_T_839 : _GEN_680; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_682 = 7'h29 == _wnList_T_5 ? _wnList_res_re_T_847 : _GEN_681; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_683 = 7'h2a == _wnList_T_5 ? _wnList_res_re_T_855 : _GEN_682; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_684 = 7'h2b == _wnList_T_5 ? _wnList_res_re_T_863 : _GEN_683; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_685 = 7'h2c == _wnList_T_5 ? _wnList_res_re_T_871 : _GEN_684; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_686 = 7'h2d == _wnList_T_5 ? _wnList_res_re_T_879 : _GEN_685; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_687 = 7'h2e == _wnList_T_5 ? _wnList_res_re_T_887 : _GEN_686; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_688 = 7'h2f == _wnList_T_5 ? _wnList_res_re_T_895 : _GEN_687; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_689 = 7'h30 == _wnList_T_5 ? _wnList_res_re_T_903 : _GEN_688; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_690 = 7'h31 == _wnList_T_5 ? _wnList_res_re_T_911 : _GEN_689; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_691 = 7'h32 == _wnList_T_5 ? _wnList_res_re_T_919 : _GEN_690; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_692 = 7'h33 == _wnList_T_5 ? _wnList_res_re_T_927 : _GEN_691; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_693 = 7'h34 == _wnList_T_5 ? _wnList_res_re_T_935 : _GEN_692; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_694 = 7'h35 == _wnList_T_5 ? _wnList_res_re_T_943 : _GEN_693; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_695 = 7'h36 == _wnList_T_5 ? _wnList_res_re_T_951 : _GEN_694; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_696 = 7'h37 == _wnList_T_5 ? _wnList_res_re_T_959 : _GEN_695; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_697 = 7'h38 == _wnList_T_5 ? _wnList_res_re_T_967 : _GEN_696; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_698 = 7'h39 == _wnList_T_5 ? _wnList_res_re_T_975 : _GEN_697; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_699 = 7'h3a == _wnList_T_5 ? _wnList_res_re_T_983 : _GEN_698; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_700 = 7'h3b == _wnList_T_5 ? _wnList_res_re_T_991 : _GEN_699; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_701 = 7'h3c == _wnList_T_5 ? _wnList_res_re_T_999 : _GEN_700; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_702 = 7'h3d == _wnList_T_5 ? _wnList_res_re_T_1007 : _GEN_701; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_703 = 7'h3e == _wnList_T_5 ? _wnList_res_re_T_1015 : _GEN_702; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_704 = 7'h3f == _wnList_T_5 ? _wnList_res_re_T_1023 : _GEN_703; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_705 = 7'h40 == _wnList_T_5 ? _wnList_res_im_T_519 : _GEN_704; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_706 = 7'h41 == _wnList_T_5 ? _wnList_res_re_T_1023 : _GEN_705; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_707 = 7'h42 == _wnList_T_5 ? _wnList_res_re_T_1015 : _GEN_706; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_708 = 7'h43 == _wnList_T_5 ? _wnList_res_re_T_1007 : _GEN_707; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_709 = 7'h44 == _wnList_T_5 ? _wnList_res_re_T_999 : _GEN_708; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_710 = 7'h45 == _wnList_T_5 ? _wnList_res_re_T_991 : _GEN_709; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_711 = 7'h46 == _wnList_T_5 ? _wnList_res_re_T_983 : _GEN_710; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_712 = 7'h47 == _wnList_T_5 ? _wnList_res_re_T_975 : _GEN_711; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_713 = 7'h48 == _wnList_T_5 ? _wnList_res_re_T_967 : _GEN_712; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_714 = 7'h49 == _wnList_T_5 ? _wnList_res_re_T_959 : _GEN_713; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_715 = 7'h4a == _wnList_T_5 ? _wnList_res_re_T_951 : _GEN_714; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_716 = 7'h4b == _wnList_T_5 ? _wnList_res_re_T_943 : _GEN_715; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_717 = 7'h4c == _wnList_T_5 ? _wnList_res_re_T_935 : _GEN_716; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_718 = 7'h4d == _wnList_T_5 ? _wnList_res_re_T_927 : _GEN_717; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_719 = 7'h4e == _wnList_T_5 ? _wnList_res_re_T_919 : _GEN_718; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_720 = 7'h4f == _wnList_T_5 ? _wnList_res_re_T_911 : _GEN_719; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_721 = 7'h50 == _wnList_T_5 ? _wnList_res_re_T_903 : _GEN_720; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_722 = 7'h51 == _wnList_T_5 ? _wnList_res_re_T_895 : _GEN_721; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_723 = 7'h52 == _wnList_T_5 ? _wnList_res_re_T_887 : _GEN_722; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_724 = 7'h53 == _wnList_T_5 ? _wnList_res_re_T_879 : _GEN_723; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_725 = 7'h54 == _wnList_T_5 ? _wnList_res_re_T_871 : _GEN_724; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_726 = 7'h55 == _wnList_T_5 ? _wnList_res_re_T_863 : _GEN_725; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_727 = 7'h56 == _wnList_T_5 ? _wnList_res_re_T_855 : _GEN_726; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_728 = 7'h57 == _wnList_T_5 ? _wnList_res_re_T_847 : _GEN_727; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_729 = 7'h58 == _wnList_T_5 ? _wnList_res_re_T_839 : _GEN_728; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_730 = 7'h59 == _wnList_T_5 ? _wnList_res_re_T_831 : _GEN_729; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_731 = 7'h5a == _wnList_T_5 ? _wnList_res_re_T_823 : _GEN_730; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_732 = 7'h5b == _wnList_T_5 ? _wnList_res_re_T_815 : _GEN_731; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_733 = 7'h5c == _wnList_T_5 ? _wnList_res_re_T_807 : _GEN_732; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_734 = 7'h5d == _wnList_T_5 ? _wnList_res_re_T_799 : _GEN_733; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_735 = 7'h5e == _wnList_T_5 ? _wnList_res_re_T_791 : _GEN_734; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_736 = 7'h5f == _wnList_T_5 ? _wnList_res_re_T_783 : _GEN_735; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_737 = 7'h60 == _wnList_T_5 ? _wnList_res_re_T_775 : _GEN_736; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_738 = 7'h61 == _wnList_T_5 ? _wnList_res_re_T_767 : _GEN_737; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_739 = 7'h62 == _wnList_T_5 ? _wnList_res_re_T_759 : _GEN_738; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_740 = 7'h63 == _wnList_T_5 ? _wnList_res_re_T_751 : _GEN_739; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_741 = 7'h64 == _wnList_T_5 ? _wnList_res_re_T_743 : _GEN_740; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_742 = 7'h65 == _wnList_T_5 ? _wnList_res_re_T_735 : _GEN_741; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_743 = 7'h66 == _wnList_T_5 ? _wnList_res_re_T_727 : _GEN_742; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_744 = 7'h67 == _wnList_T_5 ? _wnList_res_re_T_719 : _GEN_743; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_745 = 7'h68 == _wnList_T_5 ? _wnList_res_re_T_711 : _GEN_744; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_746 = 7'h69 == _wnList_T_5 ? _wnList_res_re_T_703 : _GEN_745; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_747 = 7'h6a == _wnList_T_5 ? _wnList_res_re_T_695 : _GEN_746; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_748 = 7'h6b == _wnList_T_5 ? _wnList_res_re_T_687 : _GEN_747; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_749 = 7'h6c == _wnList_T_5 ? _wnList_res_re_T_679 : _GEN_748; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_750 = 7'h6d == _wnList_T_5 ? _wnList_res_re_T_671 : _GEN_749; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_751 = 7'h6e == _wnList_T_5 ? _wnList_res_re_T_663 : _GEN_750; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_752 = 7'h6f == _wnList_T_5 ? _wnList_res_re_T_655 : _GEN_751; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_753 = 7'h70 == _wnList_T_5 ? _wnList_res_re_T_647 : _GEN_752; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_754 = 7'h71 == _wnList_T_5 ? _wnList_res_re_T_639 : _GEN_753; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_755 = 7'h72 == _wnList_T_5 ? _wnList_res_re_T_631 : _GEN_754; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_756 = 7'h73 == _wnList_T_5 ? _wnList_res_re_T_623 : _GEN_755; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_757 = 7'h74 == _wnList_T_5 ? _wnList_res_re_T_615 : _GEN_756; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_758 = 7'h75 == _wnList_T_5 ? _wnList_res_re_T_607 : _GEN_757; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_759 = 7'h76 == _wnList_T_5 ? _wnList_res_re_T_599 : _GEN_758; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_760 = 7'h77 == _wnList_T_5 ? _wnList_res_re_T_591 : _GEN_759; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_761 = 7'h78 == _wnList_T_5 ? _wnList_res_re_T_583 : _GEN_760; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_762 = 7'h79 == _wnList_T_5 ? _wnList_res_re_T_575 : _GEN_761; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_763 = 7'h7a == _wnList_T_5 ? _wnList_res_re_T_567 : _GEN_762; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_764 = 7'h7b == _wnList_T_5 ? _wnList_res_re_T_559 : _GEN_763; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_765 = 7'h7c == _wnList_T_5 ? _wnList_res_re_T_551 : _GEN_764; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_766 = 7'h7d == _wnList_T_5 ? _wnList_res_re_T_543 : _GEN_765; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_767 = 7'h7e == _wnList_T_5 ? _wnList_res_re_T_535 : _GEN_766; // @[FFT.scala 105:{12,12}]
  wire [6:0] _wnList_T_7 = 7'h60 + cnt_0; // @[FFT.scala 135:96]
  wire [16:0] _GEN_770 = 7'h1 == _wnList_T_7 ? _wnList_res_re_T_15 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_771 = 7'h2 == _wnList_T_7 ? _wnList_res_re_T_23 : _GEN_770; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_772 = 7'h3 == _wnList_T_7 ? _wnList_res_re_T_31 : _GEN_771; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_773 = 7'h4 == _wnList_T_7 ? _wnList_res_re_T_39 : _GEN_772; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_774 = 7'h5 == _wnList_T_7 ? _wnList_res_re_T_47 : _GEN_773; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_775 = 7'h6 == _wnList_T_7 ? _wnList_res_re_T_55 : _GEN_774; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_776 = 7'h7 == _wnList_T_7 ? _wnList_res_re_T_63 : _GEN_775; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_777 = 7'h8 == _wnList_T_7 ? _wnList_res_re_T_71 : _GEN_776; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_778 = 7'h9 == _wnList_T_7 ? _wnList_res_re_T_79 : _GEN_777; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_779 = 7'ha == _wnList_T_7 ? _wnList_res_re_T_87 : _GEN_778; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_780 = 7'hb == _wnList_T_7 ? _wnList_res_re_T_95 : _GEN_779; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_781 = 7'hc == _wnList_T_7 ? _wnList_res_re_T_103 : _GEN_780; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_782 = 7'hd == _wnList_T_7 ? _wnList_res_re_T_111 : _GEN_781; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_783 = 7'he == _wnList_T_7 ? _wnList_res_re_T_119 : _GEN_782; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_784 = 7'hf == _wnList_T_7 ? _wnList_res_re_T_127 : _GEN_783; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_785 = 7'h10 == _wnList_T_7 ? _wnList_res_re_T_135 : _GEN_784; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_786 = 7'h11 == _wnList_T_7 ? _wnList_res_re_T_143 : _GEN_785; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_787 = 7'h12 == _wnList_T_7 ? _wnList_res_re_T_151 : _GEN_786; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_788 = 7'h13 == _wnList_T_7 ? _wnList_res_re_T_159 : _GEN_787; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_789 = 7'h14 == _wnList_T_7 ? _wnList_res_re_T_167 : _GEN_788; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_790 = 7'h15 == _wnList_T_7 ? _wnList_res_re_T_175 : _GEN_789; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_791 = 7'h16 == _wnList_T_7 ? _wnList_res_re_T_183 : _GEN_790; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_792 = 7'h17 == _wnList_T_7 ? _wnList_res_re_T_191 : _GEN_791; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_793 = 7'h18 == _wnList_T_7 ? _wnList_res_re_T_199 : _GEN_792; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_794 = 7'h19 == _wnList_T_7 ? _wnList_res_re_T_207 : _GEN_793; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_795 = 7'h1a == _wnList_T_7 ? _wnList_res_re_T_215 : _GEN_794; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_796 = 7'h1b == _wnList_T_7 ? _wnList_res_re_T_223 : _GEN_795; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_797 = 7'h1c == _wnList_T_7 ? _wnList_res_re_T_231 : _GEN_796; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_798 = 7'h1d == _wnList_T_7 ? _wnList_res_re_T_239 : _GEN_797; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_799 = 7'h1e == _wnList_T_7 ? _wnList_res_re_T_247 : _GEN_798; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_800 = 7'h1f == _wnList_T_7 ? _wnList_res_re_T_255 : _GEN_799; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_801 = 7'h20 == _wnList_T_7 ? _wnList_res_re_T_263 : _GEN_800; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_802 = 7'h21 == _wnList_T_7 ? _wnList_res_re_T_271 : _GEN_801; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_803 = 7'h22 == _wnList_T_7 ? _wnList_res_re_T_279 : _GEN_802; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_804 = 7'h23 == _wnList_T_7 ? _wnList_res_re_T_287 : _GEN_803; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_805 = 7'h24 == _wnList_T_7 ? _wnList_res_re_T_295 : _GEN_804; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_806 = 7'h25 == _wnList_T_7 ? _wnList_res_re_T_303 : _GEN_805; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_807 = 7'h26 == _wnList_T_7 ? _wnList_res_re_T_311 : _GEN_806; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_808 = 7'h27 == _wnList_T_7 ? _wnList_res_re_T_319 : _GEN_807; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_809 = 7'h28 == _wnList_T_7 ? _wnList_res_re_T_327 : _GEN_808; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_810 = 7'h29 == _wnList_T_7 ? _wnList_res_re_T_335 : _GEN_809; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_811 = 7'h2a == _wnList_T_7 ? _wnList_res_re_T_343 : _GEN_810; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_812 = 7'h2b == _wnList_T_7 ? _wnList_res_re_T_351 : _GEN_811; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_813 = 7'h2c == _wnList_T_7 ? _wnList_res_re_T_359 : _GEN_812; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_814 = 7'h2d == _wnList_T_7 ? _wnList_res_re_T_367 : _GEN_813; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_815 = 7'h2e == _wnList_T_7 ? _wnList_res_re_T_375 : _GEN_814; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_816 = 7'h2f == _wnList_T_7 ? _wnList_res_re_T_383 : _GEN_815; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_817 = 7'h30 == _wnList_T_7 ? _wnList_res_re_T_391 : _GEN_816; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_818 = 7'h31 == _wnList_T_7 ? _wnList_res_re_T_399 : _GEN_817; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_819 = 7'h32 == _wnList_T_7 ? _wnList_res_re_T_407 : _GEN_818; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_820 = 7'h33 == _wnList_T_7 ? _wnList_res_re_T_415 : _GEN_819; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_821 = 7'h34 == _wnList_T_7 ? _wnList_res_re_T_423 : _GEN_820; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_822 = 7'h35 == _wnList_T_7 ? _wnList_res_re_T_431 : _GEN_821; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_823 = 7'h36 == _wnList_T_7 ? _wnList_res_re_T_439 : _GEN_822; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_824 = 7'h37 == _wnList_T_7 ? _wnList_res_re_T_447 : _GEN_823; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_825 = 7'h38 == _wnList_T_7 ? _wnList_res_re_T_455 : _GEN_824; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_826 = 7'h39 == _wnList_T_7 ? _wnList_res_re_T_463 : _GEN_825; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_827 = 7'h3a == _wnList_T_7 ? _wnList_res_re_T_471 : _GEN_826; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_828 = 7'h3b == _wnList_T_7 ? _wnList_res_re_T_479 : _GEN_827; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_829 = 7'h3c == _wnList_T_7 ? _wnList_res_re_T_487 : _GEN_828; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_830 = 7'h3d == _wnList_T_7 ? _wnList_res_re_T_495 : _GEN_829; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_831 = 7'h3e == _wnList_T_7 ? _wnList_res_re_T_503 : _GEN_830; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_832 = 7'h3f == _wnList_T_7 ? _wnList_res_re_T_511 : _GEN_831; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_833 = 7'h40 == _wnList_T_7 ? _wnList_res_re_T_519 : _GEN_832; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_834 = 7'h41 == _wnList_T_7 ? _wnList_res_re_T_527 : _GEN_833; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_835 = 7'h42 == _wnList_T_7 ? _wnList_res_re_T_535 : _GEN_834; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_836 = 7'h43 == _wnList_T_7 ? _wnList_res_re_T_543 : _GEN_835; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_837 = 7'h44 == _wnList_T_7 ? _wnList_res_re_T_551 : _GEN_836; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_838 = 7'h45 == _wnList_T_7 ? _wnList_res_re_T_559 : _GEN_837; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_839 = 7'h46 == _wnList_T_7 ? _wnList_res_re_T_567 : _GEN_838; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_840 = 7'h47 == _wnList_T_7 ? _wnList_res_re_T_575 : _GEN_839; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_841 = 7'h48 == _wnList_T_7 ? _wnList_res_re_T_583 : _GEN_840; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_842 = 7'h49 == _wnList_T_7 ? _wnList_res_re_T_591 : _GEN_841; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_843 = 7'h4a == _wnList_T_7 ? _wnList_res_re_T_599 : _GEN_842; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_844 = 7'h4b == _wnList_T_7 ? _wnList_res_re_T_607 : _GEN_843; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_845 = 7'h4c == _wnList_T_7 ? _wnList_res_re_T_615 : _GEN_844; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_846 = 7'h4d == _wnList_T_7 ? _wnList_res_re_T_623 : _GEN_845; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_847 = 7'h4e == _wnList_T_7 ? _wnList_res_re_T_631 : _GEN_846; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_848 = 7'h4f == _wnList_T_7 ? _wnList_res_re_T_639 : _GEN_847; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_849 = 7'h50 == _wnList_T_7 ? _wnList_res_re_T_647 : _GEN_848; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_850 = 7'h51 == _wnList_T_7 ? _wnList_res_re_T_655 : _GEN_849; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_851 = 7'h52 == _wnList_T_7 ? _wnList_res_re_T_663 : _GEN_850; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_852 = 7'h53 == _wnList_T_7 ? _wnList_res_re_T_671 : _GEN_851; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_853 = 7'h54 == _wnList_T_7 ? _wnList_res_re_T_679 : _GEN_852; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_854 = 7'h55 == _wnList_T_7 ? _wnList_res_re_T_687 : _GEN_853; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_855 = 7'h56 == _wnList_T_7 ? _wnList_res_re_T_695 : _GEN_854; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_856 = 7'h57 == _wnList_T_7 ? _wnList_res_re_T_703 : _GEN_855; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_857 = 7'h58 == _wnList_T_7 ? _wnList_res_re_T_711 : _GEN_856; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_858 = 7'h59 == _wnList_T_7 ? _wnList_res_re_T_719 : _GEN_857; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_859 = 7'h5a == _wnList_T_7 ? _wnList_res_re_T_727 : _GEN_858; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_860 = 7'h5b == _wnList_T_7 ? _wnList_res_re_T_735 : _GEN_859; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_861 = 7'h5c == _wnList_T_7 ? _wnList_res_re_T_743 : _GEN_860; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_862 = 7'h5d == _wnList_T_7 ? _wnList_res_re_T_751 : _GEN_861; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_863 = 7'h5e == _wnList_T_7 ? _wnList_res_re_T_759 : _GEN_862; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_864 = 7'h5f == _wnList_T_7 ? _wnList_res_re_T_767 : _GEN_863; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_865 = 7'h60 == _wnList_T_7 ? _wnList_res_re_T_775 : _GEN_864; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_866 = 7'h61 == _wnList_T_7 ? _wnList_res_re_T_783 : _GEN_865; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_867 = 7'h62 == _wnList_T_7 ? _wnList_res_re_T_791 : _GEN_866; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_868 = 7'h63 == _wnList_T_7 ? _wnList_res_re_T_799 : _GEN_867; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_869 = 7'h64 == _wnList_T_7 ? _wnList_res_re_T_807 : _GEN_868; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_870 = 7'h65 == _wnList_T_7 ? _wnList_res_re_T_815 : _GEN_869; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_871 = 7'h66 == _wnList_T_7 ? _wnList_res_re_T_823 : _GEN_870; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_872 = 7'h67 == _wnList_T_7 ? _wnList_res_re_T_831 : _GEN_871; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_873 = 7'h68 == _wnList_T_7 ? _wnList_res_re_T_839 : _GEN_872; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_874 = 7'h69 == _wnList_T_7 ? _wnList_res_re_T_847 : _GEN_873; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_875 = 7'h6a == _wnList_T_7 ? _wnList_res_re_T_855 : _GEN_874; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_876 = 7'h6b == _wnList_T_7 ? _wnList_res_re_T_863 : _GEN_875; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_877 = 7'h6c == _wnList_T_7 ? _wnList_res_re_T_871 : _GEN_876; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_878 = 7'h6d == _wnList_T_7 ? _wnList_res_re_T_879 : _GEN_877; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_879 = 7'h6e == _wnList_T_7 ? _wnList_res_re_T_887 : _GEN_878; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_880 = 7'h6f == _wnList_T_7 ? _wnList_res_re_T_895 : _GEN_879; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_881 = 7'h70 == _wnList_T_7 ? _wnList_res_re_T_903 : _GEN_880; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_882 = 7'h71 == _wnList_T_7 ? _wnList_res_re_T_911 : _GEN_881; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_883 = 7'h72 == _wnList_T_7 ? _wnList_res_re_T_919 : _GEN_882; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_884 = 7'h73 == _wnList_T_7 ? _wnList_res_re_T_927 : _GEN_883; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_885 = 7'h74 == _wnList_T_7 ? _wnList_res_re_T_935 : _GEN_884; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_886 = 7'h75 == _wnList_T_7 ? _wnList_res_re_T_943 : _GEN_885; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_887 = 7'h76 == _wnList_T_7 ? _wnList_res_re_T_951 : _GEN_886; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_888 = 7'h77 == _wnList_T_7 ? _wnList_res_re_T_959 : _GEN_887; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_889 = 7'h78 == _wnList_T_7 ? _wnList_res_re_T_967 : _GEN_888; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_890 = 7'h79 == _wnList_T_7 ? _wnList_res_re_T_975 : _GEN_889; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_891 = 7'h7a == _wnList_T_7 ? _wnList_res_re_T_983 : _GEN_890; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_892 = 7'h7b == _wnList_T_7 ? _wnList_res_re_T_991 : _GEN_891; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_893 = 7'h7c == _wnList_T_7 ? _wnList_res_re_T_999 : _GEN_892; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_894 = 7'h7d == _wnList_T_7 ? _wnList_res_re_T_1007 : _GEN_893; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_895 = 7'h7e == _wnList_T_7 ? _wnList_res_re_T_1015 : _GEN_894; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_898 = 7'h1 == _wnList_T_7 ? _wnList_res_re_T_527 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_899 = 7'h2 == _wnList_T_7 ? _wnList_res_re_T_535 : _GEN_898; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_900 = 7'h3 == _wnList_T_7 ? _wnList_res_re_T_543 : _GEN_899; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_901 = 7'h4 == _wnList_T_7 ? _wnList_res_re_T_551 : _GEN_900; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_902 = 7'h5 == _wnList_T_7 ? _wnList_res_re_T_559 : _GEN_901; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_903 = 7'h6 == _wnList_T_7 ? _wnList_res_re_T_567 : _GEN_902; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_904 = 7'h7 == _wnList_T_7 ? _wnList_res_re_T_575 : _GEN_903; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_905 = 7'h8 == _wnList_T_7 ? _wnList_res_re_T_583 : _GEN_904; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_906 = 7'h9 == _wnList_T_7 ? _wnList_res_re_T_591 : _GEN_905; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_907 = 7'ha == _wnList_T_7 ? _wnList_res_re_T_599 : _GEN_906; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_908 = 7'hb == _wnList_T_7 ? _wnList_res_re_T_607 : _GEN_907; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_909 = 7'hc == _wnList_T_7 ? _wnList_res_re_T_615 : _GEN_908; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_910 = 7'hd == _wnList_T_7 ? _wnList_res_re_T_623 : _GEN_909; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_911 = 7'he == _wnList_T_7 ? _wnList_res_re_T_631 : _GEN_910; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_912 = 7'hf == _wnList_T_7 ? _wnList_res_re_T_639 : _GEN_911; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_913 = 7'h10 == _wnList_T_7 ? _wnList_res_re_T_647 : _GEN_912; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_914 = 7'h11 == _wnList_T_7 ? _wnList_res_re_T_655 : _GEN_913; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_915 = 7'h12 == _wnList_T_7 ? _wnList_res_re_T_663 : _GEN_914; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_916 = 7'h13 == _wnList_T_7 ? _wnList_res_re_T_671 : _GEN_915; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_917 = 7'h14 == _wnList_T_7 ? _wnList_res_re_T_679 : _GEN_916; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_918 = 7'h15 == _wnList_T_7 ? _wnList_res_re_T_687 : _GEN_917; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_919 = 7'h16 == _wnList_T_7 ? _wnList_res_re_T_695 : _GEN_918; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_920 = 7'h17 == _wnList_T_7 ? _wnList_res_re_T_703 : _GEN_919; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_921 = 7'h18 == _wnList_T_7 ? _wnList_res_re_T_711 : _GEN_920; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_922 = 7'h19 == _wnList_T_7 ? _wnList_res_re_T_719 : _GEN_921; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_923 = 7'h1a == _wnList_T_7 ? _wnList_res_re_T_727 : _GEN_922; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_924 = 7'h1b == _wnList_T_7 ? _wnList_res_re_T_735 : _GEN_923; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_925 = 7'h1c == _wnList_T_7 ? _wnList_res_re_T_743 : _GEN_924; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_926 = 7'h1d == _wnList_T_7 ? _wnList_res_re_T_751 : _GEN_925; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_927 = 7'h1e == _wnList_T_7 ? _wnList_res_re_T_759 : _GEN_926; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_928 = 7'h1f == _wnList_T_7 ? _wnList_res_re_T_767 : _GEN_927; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_929 = 7'h20 == _wnList_T_7 ? _wnList_res_re_T_775 : _GEN_928; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_930 = 7'h21 == _wnList_T_7 ? _wnList_res_re_T_783 : _GEN_929; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_931 = 7'h22 == _wnList_T_7 ? _wnList_res_re_T_791 : _GEN_930; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_932 = 7'h23 == _wnList_T_7 ? _wnList_res_re_T_799 : _GEN_931; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_933 = 7'h24 == _wnList_T_7 ? _wnList_res_re_T_807 : _GEN_932; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_934 = 7'h25 == _wnList_T_7 ? _wnList_res_re_T_815 : _GEN_933; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_935 = 7'h26 == _wnList_T_7 ? _wnList_res_re_T_823 : _GEN_934; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_936 = 7'h27 == _wnList_T_7 ? _wnList_res_re_T_831 : _GEN_935; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_937 = 7'h28 == _wnList_T_7 ? _wnList_res_re_T_839 : _GEN_936; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_938 = 7'h29 == _wnList_T_7 ? _wnList_res_re_T_847 : _GEN_937; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_939 = 7'h2a == _wnList_T_7 ? _wnList_res_re_T_855 : _GEN_938; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_940 = 7'h2b == _wnList_T_7 ? _wnList_res_re_T_863 : _GEN_939; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_941 = 7'h2c == _wnList_T_7 ? _wnList_res_re_T_871 : _GEN_940; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_942 = 7'h2d == _wnList_T_7 ? _wnList_res_re_T_879 : _GEN_941; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_943 = 7'h2e == _wnList_T_7 ? _wnList_res_re_T_887 : _GEN_942; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_944 = 7'h2f == _wnList_T_7 ? _wnList_res_re_T_895 : _GEN_943; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_945 = 7'h30 == _wnList_T_7 ? _wnList_res_re_T_903 : _GEN_944; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_946 = 7'h31 == _wnList_T_7 ? _wnList_res_re_T_911 : _GEN_945; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_947 = 7'h32 == _wnList_T_7 ? _wnList_res_re_T_919 : _GEN_946; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_948 = 7'h33 == _wnList_T_7 ? _wnList_res_re_T_927 : _GEN_947; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_949 = 7'h34 == _wnList_T_7 ? _wnList_res_re_T_935 : _GEN_948; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_950 = 7'h35 == _wnList_T_7 ? _wnList_res_re_T_943 : _GEN_949; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_951 = 7'h36 == _wnList_T_7 ? _wnList_res_re_T_951 : _GEN_950; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_952 = 7'h37 == _wnList_T_7 ? _wnList_res_re_T_959 : _GEN_951; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_953 = 7'h38 == _wnList_T_7 ? _wnList_res_re_T_967 : _GEN_952; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_954 = 7'h39 == _wnList_T_7 ? _wnList_res_re_T_975 : _GEN_953; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_955 = 7'h3a == _wnList_T_7 ? _wnList_res_re_T_983 : _GEN_954; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_956 = 7'h3b == _wnList_T_7 ? _wnList_res_re_T_991 : _GEN_955; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_957 = 7'h3c == _wnList_T_7 ? _wnList_res_re_T_999 : _GEN_956; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_958 = 7'h3d == _wnList_T_7 ? _wnList_res_re_T_1007 : _GEN_957; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_959 = 7'h3e == _wnList_T_7 ? _wnList_res_re_T_1015 : _GEN_958; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_960 = 7'h3f == _wnList_T_7 ? _wnList_res_re_T_1023 : _GEN_959; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_961 = 7'h40 == _wnList_T_7 ? _wnList_res_im_T_519 : _GEN_960; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_962 = 7'h41 == _wnList_T_7 ? _wnList_res_re_T_1023 : _GEN_961; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_963 = 7'h42 == _wnList_T_7 ? _wnList_res_re_T_1015 : _GEN_962; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_964 = 7'h43 == _wnList_T_7 ? _wnList_res_re_T_1007 : _GEN_963; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_965 = 7'h44 == _wnList_T_7 ? _wnList_res_re_T_999 : _GEN_964; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_966 = 7'h45 == _wnList_T_7 ? _wnList_res_re_T_991 : _GEN_965; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_967 = 7'h46 == _wnList_T_7 ? _wnList_res_re_T_983 : _GEN_966; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_968 = 7'h47 == _wnList_T_7 ? _wnList_res_re_T_975 : _GEN_967; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_969 = 7'h48 == _wnList_T_7 ? _wnList_res_re_T_967 : _GEN_968; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_970 = 7'h49 == _wnList_T_7 ? _wnList_res_re_T_959 : _GEN_969; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_971 = 7'h4a == _wnList_T_7 ? _wnList_res_re_T_951 : _GEN_970; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_972 = 7'h4b == _wnList_T_7 ? _wnList_res_re_T_943 : _GEN_971; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_973 = 7'h4c == _wnList_T_7 ? _wnList_res_re_T_935 : _GEN_972; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_974 = 7'h4d == _wnList_T_7 ? _wnList_res_re_T_927 : _GEN_973; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_975 = 7'h4e == _wnList_T_7 ? _wnList_res_re_T_919 : _GEN_974; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_976 = 7'h4f == _wnList_T_7 ? _wnList_res_re_T_911 : _GEN_975; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_977 = 7'h50 == _wnList_T_7 ? _wnList_res_re_T_903 : _GEN_976; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_978 = 7'h51 == _wnList_T_7 ? _wnList_res_re_T_895 : _GEN_977; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_979 = 7'h52 == _wnList_T_7 ? _wnList_res_re_T_887 : _GEN_978; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_980 = 7'h53 == _wnList_T_7 ? _wnList_res_re_T_879 : _GEN_979; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_981 = 7'h54 == _wnList_T_7 ? _wnList_res_re_T_871 : _GEN_980; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_982 = 7'h55 == _wnList_T_7 ? _wnList_res_re_T_863 : _GEN_981; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_983 = 7'h56 == _wnList_T_7 ? _wnList_res_re_T_855 : _GEN_982; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_984 = 7'h57 == _wnList_T_7 ? _wnList_res_re_T_847 : _GEN_983; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_985 = 7'h58 == _wnList_T_7 ? _wnList_res_re_T_839 : _GEN_984; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_986 = 7'h59 == _wnList_T_7 ? _wnList_res_re_T_831 : _GEN_985; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_987 = 7'h5a == _wnList_T_7 ? _wnList_res_re_T_823 : _GEN_986; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_988 = 7'h5b == _wnList_T_7 ? _wnList_res_re_T_815 : _GEN_987; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_989 = 7'h5c == _wnList_T_7 ? _wnList_res_re_T_807 : _GEN_988; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_990 = 7'h5d == _wnList_T_7 ? _wnList_res_re_T_799 : _GEN_989; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_991 = 7'h5e == _wnList_T_7 ? _wnList_res_re_T_791 : _GEN_990; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_992 = 7'h5f == _wnList_T_7 ? _wnList_res_re_T_783 : _GEN_991; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_993 = 7'h60 == _wnList_T_7 ? _wnList_res_re_T_775 : _GEN_992; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_994 = 7'h61 == _wnList_T_7 ? _wnList_res_re_T_767 : _GEN_993; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_995 = 7'h62 == _wnList_T_7 ? _wnList_res_re_T_759 : _GEN_994; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_996 = 7'h63 == _wnList_T_7 ? _wnList_res_re_T_751 : _GEN_995; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_997 = 7'h64 == _wnList_T_7 ? _wnList_res_re_T_743 : _GEN_996; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_998 = 7'h65 == _wnList_T_7 ? _wnList_res_re_T_735 : _GEN_997; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_999 = 7'h66 == _wnList_T_7 ? _wnList_res_re_T_727 : _GEN_998; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1000 = 7'h67 == _wnList_T_7 ? _wnList_res_re_T_719 : _GEN_999; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1001 = 7'h68 == _wnList_T_7 ? _wnList_res_re_T_711 : _GEN_1000; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1002 = 7'h69 == _wnList_T_7 ? _wnList_res_re_T_703 : _GEN_1001; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1003 = 7'h6a == _wnList_T_7 ? _wnList_res_re_T_695 : _GEN_1002; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1004 = 7'h6b == _wnList_T_7 ? _wnList_res_re_T_687 : _GEN_1003; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1005 = 7'h6c == _wnList_T_7 ? _wnList_res_re_T_679 : _GEN_1004; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1006 = 7'h6d == _wnList_T_7 ? _wnList_res_re_T_671 : _GEN_1005; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1007 = 7'h6e == _wnList_T_7 ? _wnList_res_re_T_663 : _GEN_1006; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1008 = 7'h6f == _wnList_T_7 ? _wnList_res_re_T_655 : _GEN_1007; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1009 = 7'h70 == _wnList_T_7 ? _wnList_res_re_T_647 : _GEN_1008; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1010 = 7'h71 == _wnList_T_7 ? _wnList_res_re_T_639 : _GEN_1009; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1011 = 7'h72 == _wnList_T_7 ? _wnList_res_re_T_631 : _GEN_1010; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1012 = 7'h73 == _wnList_T_7 ? _wnList_res_re_T_623 : _GEN_1011; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1013 = 7'h74 == _wnList_T_7 ? _wnList_res_re_T_615 : _GEN_1012; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1014 = 7'h75 == _wnList_T_7 ? _wnList_res_re_T_607 : _GEN_1013; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1015 = 7'h76 == _wnList_T_7 ? _wnList_res_re_T_599 : _GEN_1014; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1016 = 7'h77 == _wnList_T_7 ? _wnList_res_re_T_591 : _GEN_1015; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1017 = 7'h78 == _wnList_T_7 ? _wnList_res_re_T_583 : _GEN_1016; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1018 = 7'h79 == _wnList_T_7 ? _wnList_res_re_T_575 : _GEN_1017; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1019 = 7'h7a == _wnList_T_7 ? _wnList_res_re_T_567 : _GEN_1018; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1020 = 7'h7b == _wnList_T_7 ? _wnList_res_re_T_559 : _GEN_1019; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1021 = 7'h7c == _wnList_T_7 ? _wnList_res_re_T_551 : _GEN_1020; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1022 = 7'h7d == _wnList_T_7 ? _wnList_res_re_T_543 : _GEN_1021; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1023 = 7'h7e == _wnList_T_7 ? _wnList_res_re_T_535 : _GEN_1022; // @[FFT.scala 105:{12,12}]
  wire [7:0] _wnList_T_8 = {{1'd0}, cnt_1}; // @[FFT.scala 135:96]
  wire [16:0] _GEN_1026 = 6'h1 == _wnList_T_8[5:0] ? _wnList_res_re_T_23 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1027 = 6'h2 == _wnList_T_8[5:0] ? _wnList_res_re_T_39 : _GEN_1026; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1028 = 6'h3 == _wnList_T_8[5:0] ? _wnList_res_re_T_55 : _GEN_1027; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1029 = 6'h4 == _wnList_T_8[5:0] ? _wnList_res_re_T_71 : _GEN_1028; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1030 = 6'h5 == _wnList_T_8[5:0] ? _wnList_res_re_T_87 : _GEN_1029; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1031 = 6'h6 == _wnList_T_8[5:0] ? _wnList_res_re_T_103 : _GEN_1030; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1032 = 6'h7 == _wnList_T_8[5:0] ? _wnList_res_re_T_119 : _GEN_1031; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1033 = 6'h8 == _wnList_T_8[5:0] ? _wnList_res_re_T_135 : _GEN_1032; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1034 = 6'h9 == _wnList_T_8[5:0] ? _wnList_res_re_T_151 : _GEN_1033; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1035 = 6'ha == _wnList_T_8[5:0] ? _wnList_res_re_T_167 : _GEN_1034; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1036 = 6'hb == _wnList_T_8[5:0] ? _wnList_res_re_T_183 : _GEN_1035; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1037 = 6'hc == _wnList_T_8[5:0] ? _wnList_res_re_T_199 : _GEN_1036; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1038 = 6'hd == _wnList_T_8[5:0] ? _wnList_res_re_T_215 : _GEN_1037; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1039 = 6'he == _wnList_T_8[5:0] ? _wnList_res_re_T_231 : _GEN_1038; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1040 = 6'hf == _wnList_T_8[5:0] ? _wnList_res_re_T_247 : _GEN_1039; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1041 = 6'h10 == _wnList_T_8[5:0] ? _wnList_res_re_T_263 : _GEN_1040; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1042 = 6'h11 == _wnList_T_8[5:0] ? _wnList_res_re_T_279 : _GEN_1041; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1043 = 6'h12 == _wnList_T_8[5:0] ? _wnList_res_re_T_295 : _GEN_1042; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1044 = 6'h13 == _wnList_T_8[5:0] ? _wnList_res_re_T_311 : _GEN_1043; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1045 = 6'h14 == _wnList_T_8[5:0] ? _wnList_res_re_T_327 : _GEN_1044; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1046 = 6'h15 == _wnList_T_8[5:0] ? _wnList_res_re_T_343 : _GEN_1045; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1047 = 6'h16 == _wnList_T_8[5:0] ? _wnList_res_re_T_359 : _GEN_1046; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1048 = 6'h17 == _wnList_T_8[5:0] ? _wnList_res_re_T_375 : _GEN_1047; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1049 = 6'h18 == _wnList_T_8[5:0] ? _wnList_res_re_T_391 : _GEN_1048; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1050 = 6'h19 == _wnList_T_8[5:0] ? _wnList_res_re_T_407 : _GEN_1049; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1051 = 6'h1a == _wnList_T_8[5:0] ? _wnList_res_re_T_423 : _GEN_1050; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1052 = 6'h1b == _wnList_T_8[5:0] ? _wnList_res_re_T_439 : _GEN_1051; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1053 = 6'h1c == _wnList_T_8[5:0] ? _wnList_res_re_T_455 : _GEN_1052; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1054 = 6'h1d == _wnList_T_8[5:0] ? _wnList_res_re_T_471 : _GEN_1053; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1055 = 6'h1e == _wnList_T_8[5:0] ? _wnList_res_re_T_487 : _GEN_1054; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1056 = 6'h1f == _wnList_T_8[5:0] ? _wnList_res_re_T_503 : _GEN_1055; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1057 = 6'h20 == _wnList_T_8[5:0] ? _wnList_res_re_T_519 : _GEN_1056; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1058 = 6'h21 == _wnList_T_8[5:0] ? _wnList_res_re_T_535 : _GEN_1057; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1059 = 6'h22 == _wnList_T_8[5:0] ? _wnList_res_re_T_551 : _GEN_1058; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1060 = 6'h23 == _wnList_T_8[5:0] ? _wnList_res_re_T_567 : _GEN_1059; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1061 = 6'h24 == _wnList_T_8[5:0] ? _wnList_res_re_T_583 : _GEN_1060; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1062 = 6'h25 == _wnList_T_8[5:0] ? _wnList_res_re_T_599 : _GEN_1061; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1063 = 6'h26 == _wnList_T_8[5:0] ? _wnList_res_re_T_615 : _GEN_1062; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1064 = 6'h27 == _wnList_T_8[5:0] ? _wnList_res_re_T_631 : _GEN_1063; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1065 = 6'h28 == _wnList_T_8[5:0] ? _wnList_res_re_T_647 : _GEN_1064; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1066 = 6'h29 == _wnList_T_8[5:0] ? _wnList_res_re_T_663 : _GEN_1065; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1067 = 6'h2a == _wnList_T_8[5:0] ? _wnList_res_re_T_679 : _GEN_1066; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1068 = 6'h2b == _wnList_T_8[5:0] ? _wnList_res_re_T_695 : _GEN_1067; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1069 = 6'h2c == _wnList_T_8[5:0] ? _wnList_res_re_T_711 : _GEN_1068; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1070 = 6'h2d == _wnList_T_8[5:0] ? _wnList_res_re_T_727 : _GEN_1069; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1071 = 6'h2e == _wnList_T_8[5:0] ? _wnList_res_re_T_743 : _GEN_1070; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1072 = 6'h2f == _wnList_T_8[5:0] ? _wnList_res_re_T_759 : _GEN_1071; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1073 = 6'h30 == _wnList_T_8[5:0] ? _wnList_res_re_T_775 : _GEN_1072; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1074 = 6'h31 == _wnList_T_8[5:0] ? _wnList_res_re_T_791 : _GEN_1073; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1075 = 6'h32 == _wnList_T_8[5:0] ? _wnList_res_re_T_807 : _GEN_1074; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1076 = 6'h33 == _wnList_T_8[5:0] ? _wnList_res_re_T_823 : _GEN_1075; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1077 = 6'h34 == _wnList_T_8[5:0] ? _wnList_res_re_T_839 : _GEN_1076; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1078 = 6'h35 == _wnList_T_8[5:0] ? _wnList_res_re_T_855 : _GEN_1077; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1079 = 6'h36 == _wnList_T_8[5:0] ? _wnList_res_re_T_871 : _GEN_1078; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1080 = 6'h37 == _wnList_T_8[5:0] ? _wnList_res_re_T_887 : _GEN_1079; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1081 = 6'h38 == _wnList_T_8[5:0] ? _wnList_res_re_T_903 : _GEN_1080; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1082 = 6'h39 == _wnList_T_8[5:0] ? _wnList_res_re_T_919 : _GEN_1081; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1083 = 6'h3a == _wnList_T_8[5:0] ? _wnList_res_re_T_935 : _GEN_1082; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1084 = 6'h3b == _wnList_T_8[5:0] ? _wnList_res_re_T_951 : _GEN_1083; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1085 = 6'h3c == _wnList_T_8[5:0] ? _wnList_res_re_T_967 : _GEN_1084; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1086 = 6'h3d == _wnList_T_8[5:0] ? _wnList_res_re_T_983 : _GEN_1085; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1087 = 6'h3e == _wnList_T_8[5:0] ? _wnList_res_re_T_999 : _GEN_1086; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1090 = 6'h1 == _wnList_T_8[5:0] ? _wnList_res_re_T_535 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1091 = 6'h2 == _wnList_T_8[5:0] ? _wnList_res_re_T_551 : _GEN_1090; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1092 = 6'h3 == _wnList_T_8[5:0] ? _wnList_res_re_T_567 : _GEN_1091; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1093 = 6'h4 == _wnList_T_8[5:0] ? _wnList_res_re_T_583 : _GEN_1092; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1094 = 6'h5 == _wnList_T_8[5:0] ? _wnList_res_re_T_599 : _GEN_1093; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1095 = 6'h6 == _wnList_T_8[5:0] ? _wnList_res_re_T_615 : _GEN_1094; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1096 = 6'h7 == _wnList_T_8[5:0] ? _wnList_res_re_T_631 : _GEN_1095; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1097 = 6'h8 == _wnList_T_8[5:0] ? _wnList_res_re_T_647 : _GEN_1096; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1098 = 6'h9 == _wnList_T_8[5:0] ? _wnList_res_re_T_663 : _GEN_1097; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1099 = 6'ha == _wnList_T_8[5:0] ? _wnList_res_re_T_679 : _GEN_1098; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1100 = 6'hb == _wnList_T_8[5:0] ? _wnList_res_re_T_695 : _GEN_1099; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1101 = 6'hc == _wnList_T_8[5:0] ? _wnList_res_re_T_711 : _GEN_1100; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1102 = 6'hd == _wnList_T_8[5:0] ? _wnList_res_re_T_727 : _GEN_1101; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1103 = 6'he == _wnList_T_8[5:0] ? _wnList_res_re_T_743 : _GEN_1102; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1104 = 6'hf == _wnList_T_8[5:0] ? _wnList_res_re_T_759 : _GEN_1103; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1105 = 6'h10 == _wnList_T_8[5:0] ? _wnList_res_re_T_775 : _GEN_1104; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1106 = 6'h11 == _wnList_T_8[5:0] ? _wnList_res_re_T_791 : _GEN_1105; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1107 = 6'h12 == _wnList_T_8[5:0] ? _wnList_res_re_T_807 : _GEN_1106; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1108 = 6'h13 == _wnList_T_8[5:0] ? _wnList_res_re_T_823 : _GEN_1107; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1109 = 6'h14 == _wnList_T_8[5:0] ? _wnList_res_re_T_839 : _GEN_1108; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1110 = 6'h15 == _wnList_T_8[5:0] ? _wnList_res_re_T_855 : _GEN_1109; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1111 = 6'h16 == _wnList_T_8[5:0] ? _wnList_res_re_T_871 : _GEN_1110; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1112 = 6'h17 == _wnList_T_8[5:0] ? _wnList_res_re_T_887 : _GEN_1111; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1113 = 6'h18 == _wnList_T_8[5:0] ? _wnList_res_re_T_903 : _GEN_1112; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1114 = 6'h19 == _wnList_T_8[5:0] ? _wnList_res_re_T_919 : _GEN_1113; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1115 = 6'h1a == _wnList_T_8[5:0] ? _wnList_res_re_T_935 : _GEN_1114; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1116 = 6'h1b == _wnList_T_8[5:0] ? _wnList_res_re_T_951 : _GEN_1115; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1117 = 6'h1c == _wnList_T_8[5:0] ? _wnList_res_re_T_967 : _GEN_1116; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1118 = 6'h1d == _wnList_T_8[5:0] ? _wnList_res_re_T_983 : _GEN_1117; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1119 = 6'h1e == _wnList_T_8[5:0] ? _wnList_res_re_T_999 : _GEN_1118; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1120 = 6'h1f == _wnList_T_8[5:0] ? _wnList_res_re_T_1015 : _GEN_1119; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1121 = 6'h20 == _wnList_T_8[5:0] ? _wnList_res_im_T_519 : _GEN_1120; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1122 = 6'h21 == _wnList_T_8[5:0] ? _wnList_res_re_T_1015 : _GEN_1121; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1123 = 6'h22 == _wnList_T_8[5:0] ? _wnList_res_re_T_999 : _GEN_1122; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1124 = 6'h23 == _wnList_T_8[5:0] ? _wnList_res_re_T_983 : _GEN_1123; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1125 = 6'h24 == _wnList_T_8[5:0] ? _wnList_res_re_T_967 : _GEN_1124; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1126 = 6'h25 == _wnList_T_8[5:0] ? _wnList_res_re_T_951 : _GEN_1125; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1127 = 6'h26 == _wnList_T_8[5:0] ? _wnList_res_re_T_935 : _GEN_1126; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1128 = 6'h27 == _wnList_T_8[5:0] ? _wnList_res_re_T_919 : _GEN_1127; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1129 = 6'h28 == _wnList_T_8[5:0] ? _wnList_res_re_T_903 : _GEN_1128; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1130 = 6'h29 == _wnList_T_8[5:0] ? _wnList_res_re_T_887 : _GEN_1129; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1131 = 6'h2a == _wnList_T_8[5:0] ? _wnList_res_re_T_871 : _GEN_1130; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1132 = 6'h2b == _wnList_T_8[5:0] ? _wnList_res_re_T_855 : _GEN_1131; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1133 = 6'h2c == _wnList_T_8[5:0] ? _wnList_res_re_T_839 : _GEN_1132; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1134 = 6'h2d == _wnList_T_8[5:0] ? _wnList_res_re_T_823 : _GEN_1133; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1135 = 6'h2e == _wnList_T_8[5:0] ? _wnList_res_re_T_807 : _GEN_1134; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1136 = 6'h2f == _wnList_T_8[5:0] ? _wnList_res_re_T_791 : _GEN_1135; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1137 = 6'h30 == _wnList_T_8[5:0] ? _wnList_res_re_T_775 : _GEN_1136; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1138 = 6'h31 == _wnList_T_8[5:0] ? _wnList_res_re_T_759 : _GEN_1137; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1139 = 6'h32 == _wnList_T_8[5:0] ? _wnList_res_re_T_743 : _GEN_1138; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1140 = 6'h33 == _wnList_T_8[5:0] ? _wnList_res_re_T_727 : _GEN_1139; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1141 = 6'h34 == _wnList_T_8[5:0] ? _wnList_res_re_T_711 : _GEN_1140; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1142 = 6'h35 == _wnList_T_8[5:0] ? _wnList_res_re_T_695 : _GEN_1141; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1143 = 6'h36 == _wnList_T_8[5:0] ? _wnList_res_re_T_679 : _GEN_1142; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1144 = 6'h37 == _wnList_T_8[5:0] ? _wnList_res_re_T_663 : _GEN_1143; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1145 = 6'h38 == _wnList_T_8[5:0] ? _wnList_res_re_T_647 : _GEN_1144; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1146 = 6'h39 == _wnList_T_8[5:0] ? _wnList_res_re_T_631 : _GEN_1145; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1147 = 6'h3a == _wnList_T_8[5:0] ? _wnList_res_re_T_615 : _GEN_1146; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1148 = 6'h3b == _wnList_T_8[5:0] ? _wnList_res_re_T_599 : _GEN_1147; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1149 = 6'h3c == _wnList_T_8[5:0] ? _wnList_res_re_T_583 : _GEN_1148; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1150 = 6'h3d == _wnList_T_8[5:0] ? _wnList_res_re_T_567 : _GEN_1149; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1151 = 6'h3e == _wnList_T_8[5:0] ? _wnList_res_re_T_551 : _GEN_1150; // @[FFT.scala 105:{12,12}]
  wire [6:0] _wnList_T_11 = 7'h20 + cnt_1; // @[FFT.scala 135:96]
  wire [16:0] _GEN_1154 = 6'h1 == _wnList_T_11[5:0] ? _wnList_res_re_T_23 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1155 = 6'h2 == _wnList_T_11[5:0] ? _wnList_res_re_T_39 : _GEN_1154; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1156 = 6'h3 == _wnList_T_11[5:0] ? _wnList_res_re_T_55 : _GEN_1155; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1157 = 6'h4 == _wnList_T_11[5:0] ? _wnList_res_re_T_71 : _GEN_1156; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1158 = 6'h5 == _wnList_T_11[5:0] ? _wnList_res_re_T_87 : _GEN_1157; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1159 = 6'h6 == _wnList_T_11[5:0] ? _wnList_res_re_T_103 : _GEN_1158; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1160 = 6'h7 == _wnList_T_11[5:0] ? _wnList_res_re_T_119 : _GEN_1159; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1161 = 6'h8 == _wnList_T_11[5:0] ? _wnList_res_re_T_135 : _GEN_1160; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1162 = 6'h9 == _wnList_T_11[5:0] ? _wnList_res_re_T_151 : _GEN_1161; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1163 = 6'ha == _wnList_T_11[5:0] ? _wnList_res_re_T_167 : _GEN_1162; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1164 = 6'hb == _wnList_T_11[5:0] ? _wnList_res_re_T_183 : _GEN_1163; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1165 = 6'hc == _wnList_T_11[5:0] ? _wnList_res_re_T_199 : _GEN_1164; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1166 = 6'hd == _wnList_T_11[5:0] ? _wnList_res_re_T_215 : _GEN_1165; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1167 = 6'he == _wnList_T_11[5:0] ? _wnList_res_re_T_231 : _GEN_1166; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1168 = 6'hf == _wnList_T_11[5:0] ? _wnList_res_re_T_247 : _GEN_1167; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1169 = 6'h10 == _wnList_T_11[5:0] ? _wnList_res_re_T_263 : _GEN_1168; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1170 = 6'h11 == _wnList_T_11[5:0] ? _wnList_res_re_T_279 : _GEN_1169; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1171 = 6'h12 == _wnList_T_11[5:0] ? _wnList_res_re_T_295 : _GEN_1170; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1172 = 6'h13 == _wnList_T_11[5:0] ? _wnList_res_re_T_311 : _GEN_1171; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1173 = 6'h14 == _wnList_T_11[5:0] ? _wnList_res_re_T_327 : _GEN_1172; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1174 = 6'h15 == _wnList_T_11[5:0] ? _wnList_res_re_T_343 : _GEN_1173; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1175 = 6'h16 == _wnList_T_11[5:0] ? _wnList_res_re_T_359 : _GEN_1174; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1176 = 6'h17 == _wnList_T_11[5:0] ? _wnList_res_re_T_375 : _GEN_1175; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1177 = 6'h18 == _wnList_T_11[5:0] ? _wnList_res_re_T_391 : _GEN_1176; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1178 = 6'h19 == _wnList_T_11[5:0] ? _wnList_res_re_T_407 : _GEN_1177; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1179 = 6'h1a == _wnList_T_11[5:0] ? _wnList_res_re_T_423 : _GEN_1178; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1180 = 6'h1b == _wnList_T_11[5:0] ? _wnList_res_re_T_439 : _GEN_1179; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1181 = 6'h1c == _wnList_T_11[5:0] ? _wnList_res_re_T_455 : _GEN_1180; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1182 = 6'h1d == _wnList_T_11[5:0] ? _wnList_res_re_T_471 : _GEN_1181; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1183 = 6'h1e == _wnList_T_11[5:0] ? _wnList_res_re_T_487 : _GEN_1182; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1184 = 6'h1f == _wnList_T_11[5:0] ? _wnList_res_re_T_503 : _GEN_1183; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1185 = 6'h20 == _wnList_T_11[5:0] ? _wnList_res_re_T_519 : _GEN_1184; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1186 = 6'h21 == _wnList_T_11[5:0] ? _wnList_res_re_T_535 : _GEN_1185; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1187 = 6'h22 == _wnList_T_11[5:0] ? _wnList_res_re_T_551 : _GEN_1186; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1188 = 6'h23 == _wnList_T_11[5:0] ? _wnList_res_re_T_567 : _GEN_1187; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1189 = 6'h24 == _wnList_T_11[5:0] ? _wnList_res_re_T_583 : _GEN_1188; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1190 = 6'h25 == _wnList_T_11[5:0] ? _wnList_res_re_T_599 : _GEN_1189; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1191 = 6'h26 == _wnList_T_11[5:0] ? _wnList_res_re_T_615 : _GEN_1190; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1192 = 6'h27 == _wnList_T_11[5:0] ? _wnList_res_re_T_631 : _GEN_1191; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1193 = 6'h28 == _wnList_T_11[5:0] ? _wnList_res_re_T_647 : _GEN_1192; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1194 = 6'h29 == _wnList_T_11[5:0] ? _wnList_res_re_T_663 : _GEN_1193; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1195 = 6'h2a == _wnList_T_11[5:0] ? _wnList_res_re_T_679 : _GEN_1194; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1196 = 6'h2b == _wnList_T_11[5:0] ? _wnList_res_re_T_695 : _GEN_1195; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1197 = 6'h2c == _wnList_T_11[5:0] ? _wnList_res_re_T_711 : _GEN_1196; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1198 = 6'h2d == _wnList_T_11[5:0] ? _wnList_res_re_T_727 : _GEN_1197; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1199 = 6'h2e == _wnList_T_11[5:0] ? _wnList_res_re_T_743 : _GEN_1198; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1200 = 6'h2f == _wnList_T_11[5:0] ? _wnList_res_re_T_759 : _GEN_1199; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1201 = 6'h30 == _wnList_T_11[5:0] ? _wnList_res_re_T_775 : _GEN_1200; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1202 = 6'h31 == _wnList_T_11[5:0] ? _wnList_res_re_T_791 : _GEN_1201; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1203 = 6'h32 == _wnList_T_11[5:0] ? _wnList_res_re_T_807 : _GEN_1202; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1204 = 6'h33 == _wnList_T_11[5:0] ? _wnList_res_re_T_823 : _GEN_1203; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1205 = 6'h34 == _wnList_T_11[5:0] ? _wnList_res_re_T_839 : _GEN_1204; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1206 = 6'h35 == _wnList_T_11[5:0] ? _wnList_res_re_T_855 : _GEN_1205; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1207 = 6'h36 == _wnList_T_11[5:0] ? _wnList_res_re_T_871 : _GEN_1206; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1208 = 6'h37 == _wnList_T_11[5:0] ? _wnList_res_re_T_887 : _GEN_1207; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1209 = 6'h38 == _wnList_T_11[5:0] ? _wnList_res_re_T_903 : _GEN_1208; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1210 = 6'h39 == _wnList_T_11[5:0] ? _wnList_res_re_T_919 : _GEN_1209; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1211 = 6'h3a == _wnList_T_11[5:0] ? _wnList_res_re_T_935 : _GEN_1210; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1212 = 6'h3b == _wnList_T_11[5:0] ? _wnList_res_re_T_951 : _GEN_1211; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1213 = 6'h3c == _wnList_T_11[5:0] ? _wnList_res_re_T_967 : _GEN_1212; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1214 = 6'h3d == _wnList_T_11[5:0] ? _wnList_res_re_T_983 : _GEN_1213; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1215 = 6'h3e == _wnList_T_11[5:0] ? _wnList_res_re_T_999 : _GEN_1214; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1218 = 6'h1 == _wnList_T_11[5:0] ? _wnList_res_re_T_535 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1219 = 6'h2 == _wnList_T_11[5:0] ? _wnList_res_re_T_551 : _GEN_1218; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1220 = 6'h3 == _wnList_T_11[5:0] ? _wnList_res_re_T_567 : _GEN_1219; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1221 = 6'h4 == _wnList_T_11[5:0] ? _wnList_res_re_T_583 : _GEN_1220; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1222 = 6'h5 == _wnList_T_11[5:0] ? _wnList_res_re_T_599 : _GEN_1221; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1223 = 6'h6 == _wnList_T_11[5:0] ? _wnList_res_re_T_615 : _GEN_1222; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1224 = 6'h7 == _wnList_T_11[5:0] ? _wnList_res_re_T_631 : _GEN_1223; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1225 = 6'h8 == _wnList_T_11[5:0] ? _wnList_res_re_T_647 : _GEN_1224; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1226 = 6'h9 == _wnList_T_11[5:0] ? _wnList_res_re_T_663 : _GEN_1225; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1227 = 6'ha == _wnList_T_11[5:0] ? _wnList_res_re_T_679 : _GEN_1226; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1228 = 6'hb == _wnList_T_11[5:0] ? _wnList_res_re_T_695 : _GEN_1227; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1229 = 6'hc == _wnList_T_11[5:0] ? _wnList_res_re_T_711 : _GEN_1228; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1230 = 6'hd == _wnList_T_11[5:0] ? _wnList_res_re_T_727 : _GEN_1229; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1231 = 6'he == _wnList_T_11[5:0] ? _wnList_res_re_T_743 : _GEN_1230; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1232 = 6'hf == _wnList_T_11[5:0] ? _wnList_res_re_T_759 : _GEN_1231; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1233 = 6'h10 == _wnList_T_11[5:0] ? _wnList_res_re_T_775 : _GEN_1232; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1234 = 6'h11 == _wnList_T_11[5:0] ? _wnList_res_re_T_791 : _GEN_1233; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1235 = 6'h12 == _wnList_T_11[5:0] ? _wnList_res_re_T_807 : _GEN_1234; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1236 = 6'h13 == _wnList_T_11[5:0] ? _wnList_res_re_T_823 : _GEN_1235; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1237 = 6'h14 == _wnList_T_11[5:0] ? _wnList_res_re_T_839 : _GEN_1236; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1238 = 6'h15 == _wnList_T_11[5:0] ? _wnList_res_re_T_855 : _GEN_1237; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1239 = 6'h16 == _wnList_T_11[5:0] ? _wnList_res_re_T_871 : _GEN_1238; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1240 = 6'h17 == _wnList_T_11[5:0] ? _wnList_res_re_T_887 : _GEN_1239; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1241 = 6'h18 == _wnList_T_11[5:0] ? _wnList_res_re_T_903 : _GEN_1240; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1242 = 6'h19 == _wnList_T_11[5:0] ? _wnList_res_re_T_919 : _GEN_1241; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1243 = 6'h1a == _wnList_T_11[5:0] ? _wnList_res_re_T_935 : _GEN_1242; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1244 = 6'h1b == _wnList_T_11[5:0] ? _wnList_res_re_T_951 : _GEN_1243; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1245 = 6'h1c == _wnList_T_11[5:0] ? _wnList_res_re_T_967 : _GEN_1244; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1246 = 6'h1d == _wnList_T_11[5:0] ? _wnList_res_re_T_983 : _GEN_1245; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1247 = 6'h1e == _wnList_T_11[5:0] ? _wnList_res_re_T_999 : _GEN_1246; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1248 = 6'h1f == _wnList_T_11[5:0] ? _wnList_res_re_T_1015 : _GEN_1247; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1249 = 6'h20 == _wnList_T_11[5:0] ? _wnList_res_im_T_519 : _GEN_1248; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1250 = 6'h21 == _wnList_T_11[5:0] ? _wnList_res_re_T_1015 : _GEN_1249; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1251 = 6'h22 == _wnList_T_11[5:0] ? _wnList_res_re_T_999 : _GEN_1250; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1252 = 6'h23 == _wnList_T_11[5:0] ? _wnList_res_re_T_983 : _GEN_1251; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1253 = 6'h24 == _wnList_T_11[5:0] ? _wnList_res_re_T_967 : _GEN_1252; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1254 = 6'h25 == _wnList_T_11[5:0] ? _wnList_res_re_T_951 : _GEN_1253; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1255 = 6'h26 == _wnList_T_11[5:0] ? _wnList_res_re_T_935 : _GEN_1254; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1256 = 6'h27 == _wnList_T_11[5:0] ? _wnList_res_re_T_919 : _GEN_1255; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1257 = 6'h28 == _wnList_T_11[5:0] ? _wnList_res_re_T_903 : _GEN_1256; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1258 = 6'h29 == _wnList_T_11[5:0] ? _wnList_res_re_T_887 : _GEN_1257; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1259 = 6'h2a == _wnList_T_11[5:0] ? _wnList_res_re_T_871 : _GEN_1258; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1260 = 6'h2b == _wnList_T_11[5:0] ? _wnList_res_re_T_855 : _GEN_1259; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1261 = 6'h2c == _wnList_T_11[5:0] ? _wnList_res_re_T_839 : _GEN_1260; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1262 = 6'h2d == _wnList_T_11[5:0] ? _wnList_res_re_T_823 : _GEN_1261; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1263 = 6'h2e == _wnList_T_11[5:0] ? _wnList_res_re_T_807 : _GEN_1262; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1264 = 6'h2f == _wnList_T_11[5:0] ? _wnList_res_re_T_791 : _GEN_1263; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1265 = 6'h30 == _wnList_T_11[5:0] ? _wnList_res_re_T_775 : _GEN_1264; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1266 = 6'h31 == _wnList_T_11[5:0] ? _wnList_res_re_T_759 : _GEN_1265; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1267 = 6'h32 == _wnList_T_11[5:0] ? _wnList_res_re_T_743 : _GEN_1266; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1268 = 6'h33 == _wnList_T_11[5:0] ? _wnList_res_re_T_727 : _GEN_1267; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1269 = 6'h34 == _wnList_T_11[5:0] ? _wnList_res_re_T_711 : _GEN_1268; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1270 = 6'h35 == _wnList_T_11[5:0] ? _wnList_res_re_T_695 : _GEN_1269; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1271 = 6'h36 == _wnList_T_11[5:0] ? _wnList_res_re_T_679 : _GEN_1270; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1272 = 6'h37 == _wnList_T_11[5:0] ? _wnList_res_re_T_663 : _GEN_1271; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1273 = 6'h38 == _wnList_T_11[5:0] ? _wnList_res_re_T_647 : _GEN_1272; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1274 = 6'h39 == _wnList_T_11[5:0] ? _wnList_res_re_T_631 : _GEN_1273; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1275 = 6'h3a == _wnList_T_11[5:0] ? _wnList_res_re_T_615 : _GEN_1274; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1276 = 6'h3b == _wnList_T_11[5:0] ? _wnList_res_re_T_599 : _GEN_1275; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1277 = 6'h3c == _wnList_T_11[5:0] ? _wnList_res_re_T_583 : _GEN_1276; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1278 = 6'h3d == _wnList_T_11[5:0] ? _wnList_res_re_T_567 : _GEN_1277; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1279 = 6'h3e == _wnList_T_11[5:0] ? _wnList_res_re_T_551 : _GEN_1278; // @[FFT.scala 105:{12,12}]
  wire [4:0] wnCtrl = cnt_2[4:0]; // @[FFT.scala 131:23]
  wire [5:0] _wnList_T_16 = {{1'd0}, wnCtrl}; // @[FFT.scala 135:96]
  wire [16:0] _GEN_1538 = 5'h1 == _wnList_T_16[4:0] ? _wnList_res_re_T_39 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1539 = 5'h2 == _wnList_T_16[4:0] ? _wnList_res_re_T_71 : _GEN_1538; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1540 = 5'h3 == _wnList_T_16[4:0] ? _wnList_res_re_T_103 : _GEN_1539; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1541 = 5'h4 == _wnList_T_16[4:0] ? _wnList_res_re_T_135 : _GEN_1540; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1542 = 5'h5 == _wnList_T_16[4:0] ? _wnList_res_re_T_167 : _GEN_1541; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1543 = 5'h6 == _wnList_T_16[4:0] ? _wnList_res_re_T_199 : _GEN_1542; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1544 = 5'h7 == _wnList_T_16[4:0] ? _wnList_res_re_T_231 : _GEN_1543; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1545 = 5'h8 == _wnList_T_16[4:0] ? _wnList_res_re_T_263 : _GEN_1544; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1546 = 5'h9 == _wnList_T_16[4:0] ? _wnList_res_re_T_295 : _GEN_1545; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1547 = 5'ha == _wnList_T_16[4:0] ? _wnList_res_re_T_327 : _GEN_1546; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1548 = 5'hb == _wnList_T_16[4:0] ? _wnList_res_re_T_359 : _GEN_1547; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1549 = 5'hc == _wnList_T_16[4:0] ? _wnList_res_re_T_391 : _GEN_1548; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1550 = 5'hd == _wnList_T_16[4:0] ? _wnList_res_re_T_423 : _GEN_1549; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1551 = 5'he == _wnList_T_16[4:0] ? _wnList_res_re_T_455 : _GEN_1550; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1552 = 5'hf == _wnList_T_16[4:0] ? _wnList_res_re_T_487 : _GEN_1551; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1553 = 5'h10 == _wnList_T_16[4:0] ? _wnList_res_re_T_519 : _GEN_1552; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1554 = 5'h11 == _wnList_T_16[4:0] ? _wnList_res_re_T_551 : _GEN_1553; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1555 = 5'h12 == _wnList_T_16[4:0] ? _wnList_res_re_T_583 : _GEN_1554; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1556 = 5'h13 == _wnList_T_16[4:0] ? _wnList_res_re_T_615 : _GEN_1555; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1557 = 5'h14 == _wnList_T_16[4:0] ? _wnList_res_re_T_647 : _GEN_1556; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1558 = 5'h15 == _wnList_T_16[4:0] ? _wnList_res_re_T_679 : _GEN_1557; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1559 = 5'h16 == _wnList_T_16[4:0] ? _wnList_res_re_T_711 : _GEN_1558; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1560 = 5'h17 == _wnList_T_16[4:0] ? _wnList_res_re_T_743 : _GEN_1559; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1561 = 5'h18 == _wnList_T_16[4:0] ? _wnList_res_re_T_775 : _GEN_1560; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1562 = 5'h19 == _wnList_T_16[4:0] ? _wnList_res_re_T_807 : _GEN_1561; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1563 = 5'h1a == _wnList_T_16[4:0] ? _wnList_res_re_T_839 : _GEN_1562; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1564 = 5'h1b == _wnList_T_16[4:0] ? _wnList_res_re_T_871 : _GEN_1563; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1565 = 5'h1c == _wnList_T_16[4:0] ? _wnList_res_re_T_903 : _GEN_1564; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1566 = 5'h1d == _wnList_T_16[4:0] ? _wnList_res_re_T_935 : _GEN_1565; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1567 = 5'h1e == _wnList_T_16[4:0] ? _wnList_res_re_T_967 : _GEN_1566; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1570 = 5'h1 == _wnList_T_16[4:0] ? _wnList_res_re_T_551 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1571 = 5'h2 == _wnList_T_16[4:0] ? _wnList_res_re_T_583 : _GEN_1570; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1572 = 5'h3 == _wnList_T_16[4:0] ? _wnList_res_re_T_615 : _GEN_1571; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1573 = 5'h4 == _wnList_T_16[4:0] ? _wnList_res_re_T_647 : _GEN_1572; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1574 = 5'h5 == _wnList_T_16[4:0] ? _wnList_res_re_T_679 : _GEN_1573; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1575 = 5'h6 == _wnList_T_16[4:0] ? _wnList_res_re_T_711 : _GEN_1574; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1576 = 5'h7 == _wnList_T_16[4:0] ? _wnList_res_re_T_743 : _GEN_1575; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1577 = 5'h8 == _wnList_T_16[4:0] ? _wnList_res_re_T_775 : _GEN_1576; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1578 = 5'h9 == _wnList_T_16[4:0] ? _wnList_res_re_T_807 : _GEN_1577; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1579 = 5'ha == _wnList_T_16[4:0] ? _wnList_res_re_T_839 : _GEN_1578; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1580 = 5'hb == _wnList_T_16[4:0] ? _wnList_res_re_T_871 : _GEN_1579; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1581 = 5'hc == _wnList_T_16[4:0] ? _wnList_res_re_T_903 : _GEN_1580; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1582 = 5'hd == _wnList_T_16[4:0] ? _wnList_res_re_T_935 : _GEN_1581; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1583 = 5'he == _wnList_T_16[4:0] ? _wnList_res_re_T_967 : _GEN_1582; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1584 = 5'hf == _wnList_T_16[4:0] ? _wnList_res_re_T_999 : _GEN_1583; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1585 = 5'h10 == _wnList_T_16[4:0] ? _wnList_res_im_T_519 : _GEN_1584; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1586 = 5'h11 == _wnList_T_16[4:0] ? _wnList_res_re_T_999 : _GEN_1585; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1587 = 5'h12 == _wnList_T_16[4:0] ? _wnList_res_re_T_967 : _GEN_1586; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1588 = 5'h13 == _wnList_T_16[4:0] ? _wnList_res_re_T_935 : _GEN_1587; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1589 = 5'h14 == _wnList_T_16[4:0] ? _wnList_res_re_T_903 : _GEN_1588; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1590 = 5'h15 == _wnList_T_16[4:0] ? _wnList_res_re_T_871 : _GEN_1589; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1591 = 5'h16 == _wnList_T_16[4:0] ? _wnList_res_re_T_839 : _GEN_1590; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1592 = 5'h17 == _wnList_T_16[4:0] ? _wnList_res_re_T_807 : _GEN_1591; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1593 = 5'h18 == _wnList_T_16[4:0] ? _wnList_res_re_T_775 : _GEN_1592; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1594 = 5'h19 == _wnList_T_16[4:0] ? _wnList_res_re_T_743 : _GEN_1593; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1595 = 5'h1a == _wnList_T_16[4:0] ? _wnList_res_re_T_711 : _GEN_1594; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1596 = 5'h1b == _wnList_T_16[4:0] ? _wnList_res_re_T_679 : _GEN_1595; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1597 = 5'h1c == _wnList_T_16[4:0] ? _wnList_res_re_T_647 : _GEN_1596; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1598 = 5'h1d == _wnList_T_16[4:0] ? _wnList_res_re_T_615 : _GEN_1597; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1599 = 5'h1e == _wnList_T_16[4:0] ? _wnList_res_re_T_583 : _GEN_1598; // @[FFT.scala 105:{12,12}]
  wire [3:0] wnCtrl_1 = cnt_2[3:0]; // @[FFT.scala 131:23]
  wire [4:0] _wnList_T_24 = {{1'd0}, wnCtrl_1}; // @[FFT.scala 135:96]
  wire [16:0] _GEN_1794 = 4'h1 == _wnList_T_24[3:0] ? _wnList_res_re_T_71 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1795 = 4'h2 == _wnList_T_24[3:0] ? _wnList_res_re_T_135 : _GEN_1794; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1796 = 4'h3 == _wnList_T_24[3:0] ? _wnList_res_re_T_199 : _GEN_1795; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1797 = 4'h4 == _wnList_T_24[3:0] ? _wnList_res_re_T_263 : _GEN_1796; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1798 = 4'h5 == _wnList_T_24[3:0] ? _wnList_res_re_T_327 : _GEN_1797; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1799 = 4'h6 == _wnList_T_24[3:0] ? _wnList_res_re_T_391 : _GEN_1798; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1800 = 4'h7 == _wnList_T_24[3:0] ? _wnList_res_re_T_455 : _GEN_1799; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1801 = 4'h8 == _wnList_T_24[3:0] ? _wnList_res_re_T_519 : _GEN_1800; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1802 = 4'h9 == _wnList_T_24[3:0] ? _wnList_res_re_T_583 : _GEN_1801; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1803 = 4'ha == _wnList_T_24[3:0] ? _wnList_res_re_T_647 : _GEN_1802; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1804 = 4'hb == _wnList_T_24[3:0] ? _wnList_res_re_T_711 : _GEN_1803; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1805 = 4'hc == _wnList_T_24[3:0] ? _wnList_res_re_T_775 : _GEN_1804; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1806 = 4'hd == _wnList_T_24[3:0] ? _wnList_res_re_T_839 : _GEN_1805; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1807 = 4'he == _wnList_T_24[3:0] ? _wnList_res_re_T_903 : _GEN_1806; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1810 = 4'h1 == _wnList_T_24[3:0] ? _wnList_res_re_T_583 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1811 = 4'h2 == _wnList_T_24[3:0] ? _wnList_res_re_T_647 : _GEN_1810; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1812 = 4'h3 == _wnList_T_24[3:0] ? _wnList_res_re_T_711 : _GEN_1811; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1813 = 4'h4 == _wnList_T_24[3:0] ? _wnList_res_re_T_775 : _GEN_1812; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1814 = 4'h5 == _wnList_T_24[3:0] ? _wnList_res_re_T_839 : _GEN_1813; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1815 = 4'h6 == _wnList_T_24[3:0] ? _wnList_res_re_T_903 : _GEN_1814; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1816 = 4'h7 == _wnList_T_24[3:0] ? _wnList_res_re_T_967 : _GEN_1815; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1817 = 4'h8 == _wnList_T_24[3:0] ? _wnList_res_im_T_519 : _GEN_1816; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1818 = 4'h9 == _wnList_T_24[3:0] ? _wnList_res_re_T_967 : _GEN_1817; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1819 = 4'ha == _wnList_T_24[3:0] ? _wnList_res_re_T_903 : _GEN_1818; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1820 = 4'hb == _wnList_T_24[3:0] ? _wnList_res_re_T_839 : _GEN_1819; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1821 = 4'hc == _wnList_T_24[3:0] ? _wnList_res_re_T_775 : _GEN_1820; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1822 = 4'hd == _wnList_T_24[3:0] ? _wnList_res_re_T_711 : _GEN_1821; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1823 = 4'he == _wnList_T_24[3:0] ? _wnList_res_re_T_647 : _GEN_1822; // @[FFT.scala 105:{12,12}]
  wire [2:0] wnCtrl_2 = cnt_2[2:0]; // @[FFT.scala 131:23]
  wire [3:0] _wnList_T_32 = {{1'd0}, wnCtrl_2}; // @[FFT.scala 135:96]
  wire [16:0] _GEN_1922 = 3'h1 == _wnList_T_32[2:0] ? _wnList_res_re_T_135 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1923 = 3'h2 == _wnList_T_32[2:0] ? _wnList_res_re_T_263 : _GEN_1922; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1924 = 3'h3 == _wnList_T_32[2:0] ? _wnList_res_re_T_391 : _GEN_1923; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1925 = 3'h4 == _wnList_T_32[2:0] ? _wnList_res_re_T_519 : _GEN_1924; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1926 = 3'h5 == _wnList_T_32[2:0] ? _wnList_res_re_T_647 : _GEN_1925; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1927 = 3'h6 == _wnList_T_32[2:0] ? _wnList_res_re_T_775 : _GEN_1926; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1930 = 3'h1 == _wnList_T_32[2:0] ? _wnList_res_re_T_647 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1931 = 3'h2 == _wnList_T_32[2:0] ? _wnList_res_re_T_775 : _GEN_1930; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1932 = 3'h3 == _wnList_T_32[2:0] ? _wnList_res_re_T_903 : _GEN_1931; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1933 = 3'h4 == _wnList_T_32[2:0] ? _wnList_res_im_T_519 : _GEN_1932; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1934 = 3'h5 == _wnList_T_32[2:0] ? _wnList_res_re_T_903 : _GEN_1933; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1935 = 3'h6 == _wnList_T_32[2:0] ? _wnList_res_re_T_775 : _GEN_1934; // @[FFT.scala 105:{12,12}]
  wire [1:0] wnCtrl_3 = cnt_2[1:0]; // @[FFT.scala 131:23]
  wire [2:0] _wnList_T_40 = {{1'd0}, wnCtrl_3}; // @[FFT.scala 135:96]
  wire [16:0] _GEN_1986 = 2'h1 == _wnList_T_40[1:0] ? _wnList_res_re_T_263 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1987 = 2'h2 == _wnList_T_40[1:0] ? _wnList_res_re_T_519 : _GEN_1986; // @[FFT.scala 104:{12,12}]
  wire [16:0] _GEN_1990 = 2'h1 == _wnList_T_40[1:0] ? _wnList_res_re_T_775 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  wire [16:0] _GEN_1991 = 2'h2 == _wnList_T_40[1:0] ? _wnList_res_im_T_519 : _GEN_1990; // @[FFT.scala 105:{12,12}]
  wire  wnCtrl_4 = cnt_2[0]; // @[FFT.scala 131:23]
  wire [1:0] _wnList_T_48 = {{1'd0}, wnCtrl_4}; // @[FFT.scala 135:96]
  reg [16:0] REG__0_re; // @[FFT.scala 157:67]
  reg [16:0] REG__0_im; // @[FFT.scala 157:67]
  reg [16:0] REG__1_re; // @[FFT.scala 157:67]
  reg [16:0] REG__1_im; // @[FFT.scala 157:67]
  reg [16:0] REG_1_0_re; // @[FFT.scala 157:67]
  reg [16:0] REG_1_0_im; // @[FFT.scala 157:67]
  reg [16:0] REG_1_1_re; // @[FFT.scala 157:67]
  reg [16:0] REG_1_1_im; // @[FFT.scala 157:67]
  reg [16:0] REG_2_0_re; // @[FFT.scala 157:67]
  reg [16:0] REG_2_0_im; // @[FFT.scala 157:67]
  reg [16:0] REG_2_1_re; // @[FFT.scala 157:67]
  reg [16:0] REG_2_1_im; // @[FFT.scala 157:67]
  reg [16:0] REG_3_0_re; // @[FFT.scala 157:67]
  reg [16:0] REG_3_0_im; // @[FFT.scala 157:67]
  reg [16:0] REG_3_1_re; // @[FFT.scala 157:67]
  reg [16:0] REG_3_1_im; // @[FFT.scala 157:67]
  reg [16:0] REG_4_0_re; // @[FFT.scala 157:67]
  reg [16:0] REG_4_0_im; // @[FFT.scala 157:67]
  reg [16:0] REG_4_1_re; // @[FFT.scala 157:67]
  reg [16:0] REG_4_1_im; // @[FFT.scala 157:67]
  reg [16:0] REG_5_0_re; // @[FFT.scala 157:67]
  reg [16:0] REG_5_0_im; // @[FFT.scala 157:67]
  reg [16:0] REG_5_1_re; // @[FFT.scala 157:67]
  reg [16:0] REG_5_1_im; // @[FFT.scala 157:67]
  reg [16:0] REG_6_0_re; // @[FFT.scala 157:67]
  reg [16:0] REG_6_0_im; // @[FFT.scala 157:67]
  reg [16:0] REG_6_1_re; // @[FFT.scala 157:67]
  reg [16:0] REG_6_1_im; // @[FFT.scala 157:67]
  reg [16:0] REG_7_0_re; // @[FFT.scala 157:67]
  reg [16:0] REG_7_0_im; // @[FFT.scala 157:67]
  reg [16:0] REG_7_1_re; // @[FFT.scala 157:67]
  reg [16:0] REG_7_1_im; // @[FFT.scala 157:67]
  wire [31:0] _T_1 = {io_dIn_0_re,io_dIn_0_im}; // @[FFT.scala 170:91]
  wire [31:0] _T_4 = {io_dIn_1_re,io_dIn_1_im}; // @[FFT.scala 170:91]
  wire [31:0] _T_7 = {io_dIn_2_re,io_dIn_2_im}; // @[FFT.scala 170:91]
  wire [31:0] _T_10 = {io_dIn_3_re,io_dIn_3_im}; // @[FFT.scala 170:91]
  wire [31:0] _T_13 = {io_dIn_4_re,io_dIn_4_im}; // @[FFT.scala 170:91]
  wire [31:0] _T_16 = {io_dIn_5_re,io_dIn_5_im}; // @[FFT.scala 170:91]
  wire [31:0] _T_19 = {io_dIn_6_re,io_dIn_6_im}; // @[FFT.scala 170:91]
  wire [31:0] _T_22 = {io_dIn_7_re,io_dIn_7_im}; // @[FFT.scala 170:91]
  reg [6:0] io_dout_valid_REG; // @[FFT.scala 179:27]
  wire [16:0] datao_0_re = dataotemp_inst_io_out_0_re; // @[FFT.scala 124:22 141:9]
  wire [16:0] datao_0_im = dataotemp_inst_io_out_0_im; // @[FFT.scala 124:22 141:9]
  wire [33:0] _T_25 = {datao_0_re,datao_0_im}; // @[FFT.scala 181:96]
  reg [15:0] REG_8_re; // @[FFT.scala 181:64]
  reg [15:0] REG_8_im; // @[FFT.scala 181:64]
  wire [16:0] datao_1_re = dataotemp_inst_io_out_1_re; // @[FFT.scala 124:22 141:9]
  wire [16:0] datao_1_im = dataotemp_inst_io_out_1_im; // @[FFT.scala 124:22 141:9]
  wire [33:0] _T_28 = {datao_1_re,datao_1_im}; // @[FFT.scala 181:96]
  reg [15:0] REG_9_re; // @[FFT.scala 181:64]
  reg [15:0] REG_9_im; // @[FFT.scala 181:64]
  wire [16:0] datao_2_re = dataotemp_inst_1_io_out_0_re; // @[FFT.scala 124:22 141:9]
  wire [16:0] datao_2_im = dataotemp_inst_1_io_out_0_im; // @[FFT.scala 124:22 141:9]
  wire [33:0] _T_31 = {datao_2_re,datao_2_im}; // @[FFT.scala 181:96]
  reg [15:0] REG_10_re; // @[FFT.scala 181:64]
  reg [15:0] REG_10_im; // @[FFT.scala 181:64]
  wire [16:0] datao_3_re = dataotemp_inst_1_io_out_1_re; // @[FFT.scala 124:22 141:9]
  wire [16:0] datao_3_im = dataotemp_inst_1_io_out_1_im; // @[FFT.scala 124:22 141:9]
  wire [33:0] _T_34 = {datao_3_re,datao_3_im}; // @[FFT.scala 181:96]
  reg [15:0] REG_11_re; // @[FFT.scala 181:64]
  reg [15:0] REG_11_im; // @[FFT.scala 181:64]
  wire [16:0] datao_4_re = dataotemp_inst_2_io_out_0_re; // @[FFT.scala 124:22 141:9]
  wire [16:0] datao_4_im = dataotemp_inst_2_io_out_0_im; // @[FFT.scala 124:22 141:9]
  wire [33:0] _T_37 = {datao_4_re,datao_4_im}; // @[FFT.scala 181:96]
  reg [15:0] REG_12_re; // @[FFT.scala 181:64]
  reg [15:0] REG_12_im; // @[FFT.scala 181:64]
  wire [16:0] datao_5_re = dataotemp_inst_2_io_out_1_re; // @[FFT.scala 124:22 141:9]
  wire [16:0] datao_5_im = dataotemp_inst_2_io_out_1_im; // @[FFT.scala 124:22 141:9]
  wire [33:0] _T_40 = {datao_5_re,datao_5_im}; // @[FFT.scala 181:96]
  reg [15:0] REG_13_re; // @[FFT.scala 181:64]
  reg [15:0] REG_13_im; // @[FFT.scala 181:64]
  wire [16:0] datao_6_re = dataotemp_inst_3_io_out_0_re; // @[FFT.scala 124:22 141:9]
  wire [16:0] datao_6_im = dataotemp_inst_3_io_out_0_im; // @[FFT.scala 124:22 141:9]
  wire [33:0] _T_43 = {datao_6_re,datao_6_im}; // @[FFT.scala 181:96]
  reg [15:0] REG_14_re; // @[FFT.scala 181:64]
  reg [15:0] REG_14_im; // @[FFT.scala 181:64]
  wire [16:0] datao_7_re = dataotemp_inst_3_io_out_1_re; // @[FFT.scala 124:22 141:9]
  wire [16:0] datao_7_im = dataotemp_inst_3_io_out_1_im; // @[FFT.scala 124:22 141:9]
  wire [33:0] _T_46 = {datao_7_re,datao_7_im}; // @[FFT.scala 181:96]
  reg [15:0] REG_15_re; // @[FFT.scala 181:64]
  reg [15:0] REG_15_im; // @[FFT.scala 181:64]
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
  ButterflyMul inst_10 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_10_io_in_0_re),
    .io_in_0_im(inst_10_io_in_0_im),
    .io_in_1_re(inst_10_io_in_1_re),
    .io_in_1_im(inst_10_io_in_1_im),
    .io_out_0_re(inst_10_io_out_0_re),
    .io_out_0_im(inst_10_io_out_0_im),
    .io_out_1_re(inst_10_io_out_1_re),
    .io_out_1_im(inst_10_io_out_1_im),
    .io_wn_0_re(inst_10_io_wn_0_re),
    .io_wn_0_im(inst_10_io_wn_0_im)
  );
  ButterflyMul inst_11 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_11_io_in_0_re),
    .io_in_0_im(inst_11_io_in_0_im),
    .io_in_1_re(inst_11_io_in_1_re),
    .io_in_1_im(inst_11_io_in_1_im),
    .io_out_0_re(inst_11_io_out_0_re),
    .io_out_0_im(inst_11_io_out_0_im),
    .io_out_1_re(inst_11_io_out_1_re),
    .io_out_1_im(inst_11_io_out_1_im),
    .io_wn_0_re(inst_11_io_wn_0_re),
    .io_wn_0_im(inst_11_io_wn_0_im)
  );
  ButterflyMul inst_12 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_12_io_in_0_re),
    .io_in_0_im(inst_12_io_in_0_im),
    .io_in_1_re(inst_12_io_in_1_re),
    .io_in_1_im(inst_12_io_in_1_im),
    .io_out_0_re(inst_12_io_out_0_re),
    .io_out_0_im(inst_12_io_out_0_im),
    .io_out_1_re(inst_12_io_out_1_re),
    .io_out_1_im(inst_12_io_out_1_im),
    .io_wn_0_re(inst_12_io_wn_0_re),
    .io_wn_0_im(inst_12_io_wn_0_im)
  );
  ButterflyMul inst_13 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_13_io_in_0_re),
    .io_in_0_im(inst_13_io_in_0_im),
    .io_in_1_re(inst_13_io_in_1_re),
    .io_in_1_im(inst_13_io_in_1_im),
    .io_out_0_re(inst_13_io_out_0_re),
    .io_out_0_im(inst_13_io_out_0_im),
    .io_out_1_re(inst_13_io_out_1_re),
    .io_out_1_im(inst_13_io_out_1_im),
    .io_wn_0_re(inst_13_io_wn_0_re),
    .io_wn_0_im(inst_13_io_wn_0_im)
  );
  ButterflyMul inst_14 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_14_io_in_0_re),
    .io_in_0_im(inst_14_io_in_0_im),
    .io_in_1_re(inst_14_io_in_1_re),
    .io_in_1_im(inst_14_io_in_1_im),
    .io_out_0_re(inst_14_io_out_0_re),
    .io_out_0_im(inst_14_io_out_0_im),
    .io_out_1_re(inst_14_io_out_1_re),
    .io_out_1_im(inst_14_io_out_1_im),
    .io_wn_0_re(inst_14_io_wn_0_re),
    .io_wn_0_im(inst_14_io_wn_0_im)
  );
  ButterflyMul inst_15 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_15_io_in_0_re),
    .io_in_0_im(inst_15_io_in_0_im),
    .io_in_1_re(inst_15_io_in_1_re),
    .io_in_1_im(inst_15_io_in_1_im),
    .io_out_0_re(inst_15_io_out_0_re),
    .io_out_0_im(inst_15_io_out_0_im),
    .io_out_1_re(inst_15_io_out_1_re),
    .io_out_1_im(inst_15_io_out_1_im),
    .io_wn_0_re(inst_15_io_wn_0_re),
    .io_wn_0_im(inst_15_io_wn_0_im)
  );
  ButterflyMul inst_16 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_16_io_in_0_re),
    .io_in_0_im(inst_16_io_in_0_im),
    .io_in_1_re(inst_16_io_in_1_re),
    .io_in_1_im(inst_16_io_in_1_im),
    .io_out_0_re(inst_16_io_out_0_re),
    .io_out_0_im(inst_16_io_out_0_im),
    .io_out_1_re(inst_16_io_out_1_re),
    .io_out_1_im(inst_16_io_out_1_im),
    .io_wn_0_re(inst_16_io_wn_0_re),
    .io_wn_0_im(inst_16_io_wn_0_im)
  );
  ButterflyMul inst_17 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_17_io_in_0_re),
    .io_in_0_im(inst_17_io_in_0_im),
    .io_in_1_re(inst_17_io_in_1_re),
    .io_in_1_im(inst_17_io_in_1_im),
    .io_out_0_re(inst_17_io_out_0_re),
    .io_out_0_im(inst_17_io_out_0_im),
    .io_out_1_re(inst_17_io_out_1_re),
    .io_out_1_im(inst_17_io_out_1_im),
    .io_wn_0_re(inst_17_io_wn_0_re),
    .io_wn_0_im(inst_17_io_wn_0_im)
  );
  ButterflyMul inst_18 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_18_io_in_0_re),
    .io_in_0_im(inst_18_io_in_0_im),
    .io_in_1_re(inst_18_io_in_1_re),
    .io_in_1_im(inst_18_io_in_1_im),
    .io_out_0_re(inst_18_io_out_0_re),
    .io_out_0_im(inst_18_io_out_0_im),
    .io_out_1_re(inst_18_io_out_1_re),
    .io_out_1_im(inst_18_io_out_1_im),
    .io_wn_0_re(inst_18_io_wn_0_re),
    .io_wn_0_im(inst_18_io_wn_0_im)
  );
  ButterflyMul inst_19 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_19_io_in_0_re),
    .io_in_0_im(inst_19_io_in_0_im),
    .io_in_1_re(inst_19_io_in_1_re),
    .io_in_1_im(inst_19_io_in_1_im),
    .io_out_0_re(inst_19_io_out_0_re),
    .io_out_0_im(inst_19_io_out_0_im),
    .io_out_1_re(inst_19_io_out_1_re),
    .io_out_1_im(inst_19_io_out_1_im),
    .io_wn_0_re(inst_19_io_wn_0_re),
    .io_wn_0_im(inst_19_io_wn_0_im)
  );
  ButterflyMul inst_20 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_20_io_in_0_re),
    .io_in_0_im(inst_20_io_in_0_im),
    .io_in_1_re(inst_20_io_in_1_re),
    .io_in_1_im(inst_20_io_in_1_im),
    .io_out_0_re(inst_20_io_out_0_re),
    .io_out_0_im(inst_20_io_out_0_im),
    .io_out_1_re(inst_20_io_out_1_re),
    .io_out_1_im(inst_20_io_out_1_im),
    .io_wn_0_re(inst_20_io_wn_0_re),
    .io_wn_0_im(inst_20_io_wn_0_im)
  );
  ButterflyMul inst_21 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_21_io_in_0_re),
    .io_in_0_im(inst_21_io_in_0_im),
    .io_in_1_re(inst_21_io_in_1_re),
    .io_in_1_im(inst_21_io_in_1_im),
    .io_out_0_re(inst_21_io_out_0_re),
    .io_out_0_im(inst_21_io_out_0_im),
    .io_out_1_re(inst_21_io_out_1_re),
    .io_out_1_im(inst_21_io_out_1_im),
    .io_wn_0_re(inst_21_io_wn_0_re),
    .io_wn_0_im(inst_21_io_wn_0_im)
  );
  ButterflyMul inst_22 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_22_io_in_0_re),
    .io_in_0_im(inst_22_io_in_0_im),
    .io_in_1_re(inst_22_io_in_1_re),
    .io_in_1_im(inst_22_io_in_1_im),
    .io_out_0_re(inst_22_io_out_0_re),
    .io_out_0_im(inst_22_io_out_0_im),
    .io_out_1_re(inst_22_io_out_1_re),
    .io_out_1_im(inst_22_io_out_1_im),
    .io_wn_0_re(inst_22_io_wn_0_re),
    .io_wn_0_im(inst_22_io_wn_0_im)
  );
  ButterflyMul inst_23 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_23_io_in_0_re),
    .io_in_0_im(inst_23_io_in_0_im),
    .io_in_1_re(inst_23_io_in_1_re),
    .io_in_1_im(inst_23_io_in_1_im),
    .io_out_0_re(inst_23_io_out_0_re),
    .io_out_0_im(inst_23_io_out_0_im),
    .io_out_1_re(inst_23_io_out_1_re),
    .io_out_1_im(inst_23_io_out_1_im),
    .io_wn_0_re(inst_23_io_wn_0_re),
    .io_wn_0_im(inst_23_io_wn_0_im)
  );
  ButterflyMul inst_24 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_24_io_in_0_re),
    .io_in_0_im(inst_24_io_in_0_im),
    .io_in_1_re(inst_24_io_in_1_re),
    .io_in_1_im(inst_24_io_in_1_im),
    .io_out_0_re(inst_24_io_out_0_re),
    .io_out_0_im(inst_24_io_out_0_im),
    .io_out_1_re(inst_24_io_out_1_re),
    .io_out_1_im(inst_24_io_out_1_im),
    .io_wn_0_re(inst_24_io_wn_0_re),
    .io_wn_0_im(inst_24_io_wn_0_im)
  );
  ButterflyMul inst_25 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_25_io_in_0_re),
    .io_in_0_im(inst_25_io_in_0_im),
    .io_in_1_re(inst_25_io_in_1_re),
    .io_in_1_im(inst_25_io_in_1_im),
    .io_out_0_re(inst_25_io_out_0_re),
    .io_out_0_im(inst_25_io_out_0_im),
    .io_out_1_re(inst_25_io_out_1_re),
    .io_out_1_im(inst_25_io_out_1_im),
    .io_wn_0_re(inst_25_io_wn_0_re),
    .io_wn_0_im(inst_25_io_wn_0_im)
  );
  ButterflyMul inst_26 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_26_io_in_0_re),
    .io_in_0_im(inst_26_io_in_0_im),
    .io_in_1_re(inst_26_io_in_1_re),
    .io_in_1_im(inst_26_io_in_1_im),
    .io_out_0_re(inst_26_io_out_0_re),
    .io_out_0_im(inst_26_io_out_0_im),
    .io_out_1_re(inst_26_io_out_1_re),
    .io_out_1_im(inst_26_io_out_1_im),
    .io_wn_0_re(inst_26_io_wn_0_re),
    .io_wn_0_im(inst_26_io_wn_0_im)
  );
  ButterflyMul inst_27 ( // @[Modules.scala 287:22]
    .io_in_0_re(inst_27_io_in_0_re),
    .io_in_0_im(inst_27_io_in_0_im),
    .io_in_1_re(inst_27_io_in_1_re),
    .io_in_1_im(inst_27_io_in_1_im),
    .io_out_0_re(inst_27_io_out_0_re),
    .io_out_0_im(inst_27_io_out_0_im),
    .io_out_1_re(inst_27_io_out_1_re),
    .io_out_1_im(inst_27_io_out_1_im),
    .io_wn_0_re(inst_27_io_wn_0_re),
    .io_wn_0_im(inst_27_io_wn_0_im)
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
  ButterflyAdd dataotemp_inst_2 ( // @[Modules.scala 213:22]
    .io_in_0_re(dataotemp_inst_2_io_in_0_re),
    .io_in_0_im(dataotemp_inst_2_io_in_0_im),
    .io_in_1_re(dataotemp_inst_2_io_in_1_re),
    .io_in_1_im(dataotemp_inst_2_io_in_1_im),
    .io_out_0_re(dataotemp_inst_2_io_out_0_re),
    .io_out_0_im(dataotemp_inst_2_io_out_0_im),
    .io_out_1_re(dataotemp_inst_2_io_out_1_re),
    .io_out_1_im(dataotemp_inst_2_io_out_1_im)
  );
  ButterflyAdd dataotemp_inst_3 ( // @[Modules.scala 213:22]
    .io_in_0_re(dataotemp_inst_3_io_in_0_re),
    .io_in_0_im(dataotemp_inst_3_io_in_0_im),
    .io_in_1_re(dataotemp_inst_3_io_in_1_re),
    .io_in_1_im(dataotemp_inst_3_io_in_1_im),
    .io_out_0_re(dataotemp_inst_3_io_out_0_re),
    .io_out_0_im(dataotemp_inst_3_io_out_0_im),
    .io_out_1_re(dataotemp_inst_3_io_out_1_re),
    .io_out_1_im(dataotemp_inst_3_io_out_1_im)
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
  Exchange exdata_inst_1 ( // @[Modules.scala 331:22]
    .io_in_0_0_re(exdata_inst_1_io_in_0_0_re),
    .io_in_0_0_im(exdata_inst_1_io_in_0_0_im),
    .io_in_0_1_re(exdata_inst_1_io_in_0_1_re),
    .io_in_0_1_im(exdata_inst_1_io_in_0_1_im),
    .io_in_1_0_re(exdata_inst_1_io_in_1_0_re),
    .io_in_1_0_im(exdata_inst_1_io_in_1_0_im),
    .io_in_1_1_re(exdata_inst_1_io_in_1_1_re),
    .io_in_1_1_im(exdata_inst_1_io_in_1_1_im),
    .io_out_0_0_re(exdata_inst_1_io_out_0_0_re),
    .io_out_0_0_im(exdata_inst_1_io_out_0_0_im),
    .io_out_0_1_re(exdata_inst_1_io_out_0_1_re),
    .io_out_0_1_im(exdata_inst_1_io_out_0_1_im),
    .io_out_1_0_re(exdata_inst_1_io_out_1_0_re),
    .io_out_1_0_im(exdata_inst_1_io_out_1_0_im),
    .io_out_1_1_re(exdata_inst_1_io_out_1_1_re),
    .io_out_1_1_im(exdata_inst_1_io_out_1_1_im)
  );
  Exchange exdata_inst_2 ( // @[Modules.scala 331:22]
    .io_in_0_0_re(exdata_inst_2_io_in_0_0_re),
    .io_in_0_0_im(exdata_inst_2_io_in_0_0_im),
    .io_in_0_1_re(exdata_inst_2_io_in_0_1_re),
    .io_in_0_1_im(exdata_inst_2_io_in_0_1_im),
    .io_in_1_0_re(exdata_inst_2_io_in_1_0_re),
    .io_in_1_0_im(exdata_inst_2_io_in_1_0_im),
    .io_in_1_1_re(exdata_inst_2_io_in_1_1_re),
    .io_in_1_1_im(exdata_inst_2_io_in_1_1_im),
    .io_out_0_0_re(exdata_inst_2_io_out_0_0_re),
    .io_out_0_0_im(exdata_inst_2_io_out_0_0_im),
    .io_out_0_1_re(exdata_inst_2_io_out_0_1_re),
    .io_out_0_1_im(exdata_inst_2_io_out_0_1_im),
    .io_out_1_0_re(exdata_inst_2_io_out_1_0_re),
    .io_out_1_0_im(exdata_inst_2_io_out_1_0_im),
    .io_out_1_1_re(exdata_inst_2_io_out_1_1_re),
    .io_out_1_1_im(exdata_inst_2_io_out_1_1_im)
  );
  Exchange exdata_inst_3 ( // @[Modules.scala 331:22]
    .io_in_0_0_re(exdata_inst_3_io_in_0_0_re),
    .io_in_0_0_im(exdata_inst_3_io_in_0_0_im),
    .io_in_0_1_re(exdata_inst_3_io_in_0_1_re),
    .io_in_0_1_im(exdata_inst_3_io_in_0_1_im),
    .io_in_1_0_re(exdata_inst_3_io_in_1_0_re),
    .io_in_1_0_im(exdata_inst_3_io_in_1_0_im),
    .io_in_1_1_re(exdata_inst_3_io_in_1_1_re),
    .io_in_1_1_im(exdata_inst_3_io_in_1_1_im),
    .io_out_0_0_re(exdata_inst_3_io_out_0_0_re),
    .io_out_0_0_im(exdata_inst_3_io_out_0_0_im),
    .io_out_0_1_re(exdata_inst_3_io_out_0_1_re),
    .io_out_0_1_im(exdata_inst_3_io_out_0_1_im),
    .io_out_1_0_re(exdata_inst_3_io_out_1_0_re),
    .io_out_1_0_im(exdata_inst_3_io_out_1_0_im),
    .io_out_1_1_re(exdata_inst_3_io_out_1_1_re),
    .io_out_1_1_im(exdata_inst_3_io_out_1_1_im)
  );
  Switch inst_28 ( // @[Modules.scala 311:22]
    .clock(inst_28_clock),
    .io_in_0_re(inst_28_io_in_0_re),
    .io_in_0_im(inst_28_io_in_0_im),
    .io_in_1_re(inst_28_io_in_1_re),
    .io_in_1_im(inst_28_io_in_1_im),
    .io_out_0_re(inst_28_io_out_0_re),
    .io_out_0_im(inst_28_io_out_0_im),
    .io_out_1_re(inst_28_io_out_1_re),
    .io_out_1_im(inst_28_io_out_1_im),
    .io_sel(inst_28_io_sel)
  );
  Switch inst_29 ( // @[Modules.scala 311:22]
    .clock(inst_29_clock),
    .io_in_0_re(inst_29_io_in_0_re),
    .io_in_0_im(inst_29_io_in_0_im),
    .io_in_1_re(inst_29_io_in_1_re),
    .io_in_1_im(inst_29_io_in_1_im),
    .io_out_0_re(inst_29_io_out_0_re),
    .io_out_0_im(inst_29_io_out_0_im),
    .io_out_1_re(inst_29_io_out_1_re),
    .io_out_1_im(inst_29_io_out_1_im),
    .io_sel(inst_29_io_sel)
  );
  Switch inst_30 ( // @[Modules.scala 311:22]
    .clock(inst_30_clock),
    .io_in_0_re(inst_30_io_in_0_re),
    .io_in_0_im(inst_30_io_in_0_im),
    .io_in_1_re(inst_30_io_in_1_re),
    .io_in_1_im(inst_30_io_in_1_im),
    .io_out_0_re(inst_30_io_out_0_re),
    .io_out_0_im(inst_30_io_out_0_im),
    .io_out_1_re(inst_30_io_out_1_re),
    .io_out_1_im(inst_30_io_out_1_im),
    .io_sel(inst_30_io_sel)
  );
  Switch inst_31 ( // @[Modules.scala 311:22]
    .clock(inst_31_clock),
    .io_in_0_re(inst_31_io_in_0_re),
    .io_in_0_im(inst_31_io_in_0_im),
    .io_in_1_re(inst_31_io_in_1_re),
    .io_in_1_im(inst_31_io_in_1_im),
    .io_out_0_re(inst_31_io_out_0_re),
    .io_out_0_im(inst_31_io_out_0_im),
    .io_out_1_re(inst_31_io_out_1_re),
    .io_out_1_im(inst_31_io_out_1_im),
    .io_sel(inst_31_io_sel)
  );
  Switch_4 inst_32 ( // @[Modules.scala 311:22]
    .clock(inst_32_clock),
    .io_in_0_re(inst_32_io_in_0_re),
    .io_in_0_im(inst_32_io_in_0_im),
    .io_in_1_re(inst_32_io_in_1_re),
    .io_in_1_im(inst_32_io_in_1_im),
    .io_out_0_re(inst_32_io_out_0_re),
    .io_out_0_im(inst_32_io_out_0_im),
    .io_out_1_re(inst_32_io_out_1_re),
    .io_out_1_im(inst_32_io_out_1_im),
    .io_sel(inst_32_io_sel)
  );
  Switch_4 inst_33 ( // @[Modules.scala 311:22]
    .clock(inst_33_clock),
    .io_in_0_re(inst_33_io_in_0_re),
    .io_in_0_im(inst_33_io_in_0_im),
    .io_in_1_re(inst_33_io_in_1_re),
    .io_in_1_im(inst_33_io_in_1_im),
    .io_out_0_re(inst_33_io_out_0_re),
    .io_out_0_im(inst_33_io_out_0_im),
    .io_out_1_re(inst_33_io_out_1_re),
    .io_out_1_im(inst_33_io_out_1_im),
    .io_sel(inst_33_io_sel)
  );
  Switch_4 inst_34 ( // @[Modules.scala 311:22]
    .clock(inst_34_clock),
    .io_in_0_re(inst_34_io_in_0_re),
    .io_in_0_im(inst_34_io_in_0_im),
    .io_in_1_re(inst_34_io_in_1_re),
    .io_in_1_im(inst_34_io_in_1_im),
    .io_out_0_re(inst_34_io_out_0_re),
    .io_out_0_im(inst_34_io_out_0_im),
    .io_out_1_re(inst_34_io_out_1_re),
    .io_out_1_im(inst_34_io_out_1_im),
    .io_sel(inst_34_io_sel)
  );
  Switch_4 inst_35 ( // @[Modules.scala 311:22]
    .clock(inst_35_clock),
    .io_in_0_re(inst_35_io_in_0_re),
    .io_in_0_im(inst_35_io_in_0_im),
    .io_in_1_re(inst_35_io_in_1_re),
    .io_in_1_im(inst_35_io_in_1_im),
    .io_out_0_re(inst_35_io_out_0_re),
    .io_out_0_im(inst_35_io_out_0_im),
    .io_out_1_re(inst_35_io_out_1_re),
    .io_out_1_im(inst_35_io_out_1_im),
    .io_sel(inst_35_io_sel)
  );
  Switch_8 inst_36 ( // @[Modules.scala 311:22]
    .clock(inst_36_clock),
    .io_in_0_re(inst_36_io_in_0_re),
    .io_in_0_im(inst_36_io_in_0_im),
    .io_in_1_re(inst_36_io_in_1_re),
    .io_in_1_im(inst_36_io_in_1_im),
    .io_out_0_re(inst_36_io_out_0_re),
    .io_out_0_im(inst_36_io_out_0_im),
    .io_out_1_re(inst_36_io_out_1_re),
    .io_out_1_im(inst_36_io_out_1_im),
    .io_sel(inst_36_io_sel)
  );
  Switch_8 inst_37 ( // @[Modules.scala 311:22]
    .clock(inst_37_clock),
    .io_in_0_re(inst_37_io_in_0_re),
    .io_in_0_im(inst_37_io_in_0_im),
    .io_in_1_re(inst_37_io_in_1_re),
    .io_in_1_im(inst_37_io_in_1_im),
    .io_out_0_re(inst_37_io_out_0_re),
    .io_out_0_im(inst_37_io_out_0_im),
    .io_out_1_re(inst_37_io_out_1_re),
    .io_out_1_im(inst_37_io_out_1_im),
    .io_sel(inst_37_io_sel)
  );
  Switch_8 inst_38 ( // @[Modules.scala 311:22]
    .clock(inst_38_clock),
    .io_in_0_re(inst_38_io_in_0_re),
    .io_in_0_im(inst_38_io_in_0_im),
    .io_in_1_re(inst_38_io_in_1_re),
    .io_in_1_im(inst_38_io_in_1_im),
    .io_out_0_re(inst_38_io_out_0_re),
    .io_out_0_im(inst_38_io_out_0_im),
    .io_out_1_re(inst_38_io_out_1_re),
    .io_out_1_im(inst_38_io_out_1_im),
    .io_sel(inst_38_io_sel)
  );
  Switch_8 inst_39 ( // @[Modules.scala 311:22]
    .clock(inst_39_clock),
    .io_in_0_re(inst_39_io_in_0_re),
    .io_in_0_im(inst_39_io_in_0_im),
    .io_in_1_re(inst_39_io_in_1_re),
    .io_in_1_im(inst_39_io_in_1_im),
    .io_out_0_re(inst_39_io_out_0_re),
    .io_out_0_im(inst_39_io_out_0_im),
    .io_out_1_re(inst_39_io_out_1_re),
    .io_out_1_im(inst_39_io_out_1_im),
    .io_sel(inst_39_io_sel)
  );
  Switch_12 inst_40 ( // @[Modules.scala 311:22]
    .clock(inst_40_clock),
    .io_in_0_re(inst_40_io_in_0_re),
    .io_in_0_im(inst_40_io_in_0_im),
    .io_in_1_re(inst_40_io_in_1_re),
    .io_in_1_im(inst_40_io_in_1_im),
    .io_out_0_re(inst_40_io_out_0_re),
    .io_out_0_im(inst_40_io_out_0_im),
    .io_out_1_re(inst_40_io_out_1_re),
    .io_out_1_im(inst_40_io_out_1_im),
    .io_sel(inst_40_io_sel)
  );
  Switch_12 inst_41 ( // @[Modules.scala 311:22]
    .clock(inst_41_clock),
    .io_in_0_re(inst_41_io_in_0_re),
    .io_in_0_im(inst_41_io_in_0_im),
    .io_in_1_re(inst_41_io_in_1_re),
    .io_in_1_im(inst_41_io_in_1_im),
    .io_out_0_re(inst_41_io_out_0_re),
    .io_out_0_im(inst_41_io_out_0_im),
    .io_out_1_re(inst_41_io_out_1_re),
    .io_out_1_im(inst_41_io_out_1_im),
    .io_sel(inst_41_io_sel)
  );
  Switch_12 inst_42 ( // @[Modules.scala 311:22]
    .clock(inst_42_clock),
    .io_in_0_re(inst_42_io_in_0_re),
    .io_in_0_im(inst_42_io_in_0_im),
    .io_in_1_re(inst_42_io_in_1_re),
    .io_in_1_im(inst_42_io_in_1_im),
    .io_out_0_re(inst_42_io_out_0_re),
    .io_out_0_im(inst_42_io_out_0_im),
    .io_out_1_re(inst_42_io_out_1_re),
    .io_out_1_im(inst_42_io_out_1_im),
    .io_sel(inst_42_io_sel)
  );
  Switch_12 inst_43 ( // @[Modules.scala 311:22]
    .clock(inst_43_clock),
    .io_in_0_re(inst_43_io_in_0_re),
    .io_in_0_im(inst_43_io_in_0_im),
    .io_in_1_re(inst_43_io_in_1_re),
    .io_in_1_im(inst_43_io_in_1_im),
    .io_out_0_re(inst_43_io_out_0_re),
    .io_out_0_im(inst_43_io_out_0_im),
    .io_out_1_re(inst_43_io_out_1_re),
    .io_out_1_im(inst_43_io_out_1_im),
    .io_sel(inst_43_io_sel)
  );
  Switch_16 inst_44 ( // @[Modules.scala 311:22]
    .clock(inst_44_clock),
    .io_in_0_re(inst_44_io_in_0_re),
    .io_in_0_im(inst_44_io_in_0_im),
    .io_in_1_re(inst_44_io_in_1_re),
    .io_in_1_im(inst_44_io_in_1_im),
    .io_out_0_re(inst_44_io_out_0_re),
    .io_out_0_im(inst_44_io_out_0_im),
    .io_out_1_re(inst_44_io_out_1_re),
    .io_out_1_im(inst_44_io_out_1_im),
    .io_sel(inst_44_io_sel)
  );
  Switch_16 inst_45 ( // @[Modules.scala 311:22]
    .clock(inst_45_clock),
    .io_in_0_re(inst_45_io_in_0_re),
    .io_in_0_im(inst_45_io_in_0_im),
    .io_in_1_re(inst_45_io_in_1_re),
    .io_in_1_im(inst_45_io_in_1_im),
    .io_out_0_re(inst_45_io_out_0_re),
    .io_out_0_im(inst_45_io_out_0_im),
    .io_out_1_re(inst_45_io_out_1_re),
    .io_out_1_im(inst_45_io_out_1_im),
    .io_sel(inst_45_io_sel)
  );
  Switch_16 inst_46 ( // @[Modules.scala 311:22]
    .clock(inst_46_clock),
    .io_in_0_re(inst_46_io_in_0_re),
    .io_in_0_im(inst_46_io_in_0_im),
    .io_in_1_re(inst_46_io_in_1_re),
    .io_in_1_im(inst_46_io_in_1_im),
    .io_out_0_re(inst_46_io_out_0_re),
    .io_out_0_im(inst_46_io_out_0_im),
    .io_out_1_re(inst_46_io_out_1_re),
    .io_out_1_im(inst_46_io_out_1_im),
    .io_sel(inst_46_io_sel)
  );
  Switch_16 inst_47 ( // @[Modules.scala 311:22]
    .clock(inst_47_clock),
    .io_in_0_re(inst_47_io_in_0_re),
    .io_in_0_im(inst_47_io_in_0_im),
    .io_in_1_re(inst_47_io_in_1_re),
    .io_in_1_im(inst_47_io_in_1_im),
    .io_out_0_re(inst_47_io_out_0_re),
    .io_out_0_im(inst_47_io_out_0_im),
    .io_out_1_re(inst_47_io_out_1_re),
    .io_out_1_im(inst_47_io_out_1_im),
    .io_sel(inst_47_io_sel)
  );
  ComplexRecode inst_48 ( // @[Modules.scala 40:22]
    .io_in_re(inst_48_io_in_re),
    .io_in_im(inst_48_io_in_im),
    .io_out_re(inst_48_io_out_re),
    .io_out_im(inst_48_io_out_im)
  );
  ComplexRecode inst_49 ( // @[Modules.scala 40:22]
    .io_in_re(inst_49_io_in_re),
    .io_in_im(inst_49_io_in_im),
    .io_out_re(inst_49_io_out_re),
    .io_out_im(inst_49_io_out_im)
  );
  ComplexRecode inst_50 ( // @[Modules.scala 40:22]
    .io_in_re(inst_50_io_in_re),
    .io_in_im(inst_50_io_in_im),
    .io_out_re(inst_50_io_out_re),
    .io_out_im(inst_50_io_out_im)
  );
  ComplexRecode inst_51 ( // @[Modules.scala 40:22]
    .io_in_re(inst_51_io_in_re),
    .io_in_im(inst_51_io_in_im),
    .io_out_re(inst_51_io_out_re),
    .io_out_im(inst_51_io_out_im)
  );
  ComplexRecode inst_52 ( // @[Modules.scala 40:22]
    .io_in_re(inst_52_io_in_re),
    .io_in_im(inst_52_io_in_im),
    .io_out_re(inst_52_io_out_re),
    .io_out_im(inst_52_io_out_im)
  );
  ComplexRecode inst_53 ( // @[Modules.scala 40:22]
    .io_in_re(inst_53_io_in_re),
    .io_in_im(inst_53_io_in_im),
    .io_out_re(inst_53_io_out_re),
    .io_out_im(inst_53_io_out_im)
  );
  ComplexRecode inst_54 ( // @[Modules.scala 40:22]
    .io_in_re(inst_54_io_in_re),
    .io_in_im(inst_54_io_in_im),
    .io_out_re(inst_54_io_out_re),
    .io_out_im(inst_54_io_out_im)
  );
  ComplexRecode inst_55 ( // @[Modules.scala 40:22]
    .io_in_re(inst_55_io_in_re),
    .io_in_im(inst_55_io_in_im),
    .io_out_re(inst_55_io_out_re),
    .io_out_im(inst_55_io_out_im)
  );
  ComplexDecode inst_56 ( // @[Modules.scala 56:22]
    .io_in_re(inst_56_io_in_re),
    .io_in_im(inst_56_io_in_im),
    .io_out_re(inst_56_io_out_re),
    .io_out_im(inst_56_io_out_im)
  );
  ComplexDecode inst_57 ( // @[Modules.scala 56:22]
    .io_in_re(inst_57_io_in_re),
    .io_in_im(inst_57_io_in_im),
    .io_out_re(inst_57_io_out_re),
    .io_out_im(inst_57_io_out_im)
  );
  ComplexDecode inst_58 ( // @[Modules.scala 56:22]
    .io_in_re(inst_58_io_in_re),
    .io_in_im(inst_58_io_in_im),
    .io_out_re(inst_58_io_out_re),
    .io_out_im(inst_58_io_out_im)
  );
  ComplexDecode inst_59 ( // @[Modules.scala 56:22]
    .io_in_re(inst_59_io_in_re),
    .io_in_im(inst_59_io_in_im),
    .io_out_re(inst_59_io_out_re),
    .io_out_im(inst_59_io_out_im)
  );
  ComplexDecode inst_60 ( // @[Modules.scala 56:22]
    .io_in_re(inst_60_io_in_re),
    .io_in_im(inst_60_io_in_im),
    .io_out_re(inst_60_io_out_re),
    .io_out_im(inst_60_io_out_im)
  );
  ComplexDecode inst_61 ( // @[Modules.scala 56:22]
    .io_in_re(inst_61_io_in_re),
    .io_in_im(inst_61_io_in_im),
    .io_out_re(inst_61_io_out_re),
    .io_out_im(inst_61_io_out_im)
  );
  ComplexDecode inst_62 ( // @[Modules.scala 56:22]
    .io_in_re(inst_62_io_in_re),
    .io_in_im(inst_62_io_in_im),
    .io_out_re(inst_62_io_out_re),
    .io_out_im(inst_62_io_out_im)
  );
  ComplexDecode inst_63 ( // @[Modules.scala 56:22]
    .io_in_re(inst_63_io_in_re),
    .io_in_im(inst_63_io_in_im),
    .io_out_re(inst_63_io_out_re),
    .io_out_im(inst_63_io_out_im)
  );
  assign io_dOut_0_re = REG_8_re; // @[FFT.scala 181:13]
  assign io_dOut_0_im = REG_8_im; // @[FFT.scala 181:13]
  assign io_dOut_1_re = REG_9_re; // @[FFT.scala 181:13]
  assign io_dOut_1_im = REG_9_im; // @[FFT.scala 181:13]
  assign io_dOut_2_re = REG_10_re; // @[FFT.scala 181:13]
  assign io_dOut_2_im = REG_10_im; // @[FFT.scala 181:13]
  assign io_dOut_3_re = REG_11_re; // @[FFT.scala 181:13]
  assign io_dOut_3_im = REG_11_im; // @[FFT.scala 181:13]
  assign io_dOut_4_re = REG_12_re; // @[FFT.scala 181:13]
  assign io_dOut_4_im = REG_12_im; // @[FFT.scala 181:13]
  assign io_dOut_5_re = REG_13_re; // @[FFT.scala 181:13]
  assign io_dOut_5_im = REG_13_im; // @[FFT.scala 181:13]
  assign io_dOut_6_re = REG_14_re; // @[FFT.scala 181:13]
  assign io_dOut_6_im = REG_14_im; // @[FFT.scala 181:13]
  assign io_dOut_7_re = REG_15_re; // @[FFT.scala 181:13]
  assign io_dOut_7_im = REG_15_im; // @[FFT.scala 181:13]
  assign io_dout_valid = io_dout_valid_REG == 7'h21; // @[FFT.scala 179:36]
  assign io_busy = cnt_0 != 7'h0; // @[FFT.scala 114:21]
  assign inst_io_in_0_re = inst_48_io_out_re; // @[FFT.scala 122:65 170:19]
  assign inst_io_in_0_im = inst_48_io_out_im; // @[FFT.scala 122:65 170:19]
  assign inst_io_in_1_re = inst_49_io_out_re; // @[FFT.scala 122:65 170:19]
  assign inst_io_in_1_im = inst_49_io_out_im; // @[FFT.scala 122:65 170:19]
  assign inst_io_wn_0_re = 7'h7f == _wnList_T[6:0] ? _wnList_res_re_T_1023 : _GEN_127; // @[FFT.scala 104:{12,12}]
  assign inst_io_wn_0_im = 7'h7f == _wnList_T[6:0] ? _wnList_res_re_T_527 : _GEN_255; // @[FFT.scala 105:{12,12}]
  assign inst_1_io_in_0_re = inst_50_io_out_re; // @[FFT.scala 122:65 170:19]
  assign inst_1_io_in_0_im = inst_50_io_out_im; // @[FFT.scala 122:65 170:19]
  assign inst_1_io_in_1_re = inst_51_io_out_re; // @[FFT.scala 122:65 170:19]
  assign inst_1_io_in_1_im = inst_51_io_out_im; // @[FFT.scala 122:65 170:19]
  assign inst_1_io_wn_0_re = 7'h7f == _wnList_T_3 ? _wnList_res_re_T_1023 : _GEN_383; // @[FFT.scala 104:{12,12}]
  assign inst_1_io_wn_0_im = 7'h7f == _wnList_T_3 ? _wnList_res_re_T_527 : _GEN_511; // @[FFT.scala 105:{12,12}]
  assign inst_2_io_in_0_re = inst_52_io_out_re; // @[FFT.scala 122:65 170:19]
  assign inst_2_io_in_0_im = inst_52_io_out_im; // @[FFT.scala 122:65 170:19]
  assign inst_2_io_in_1_re = inst_53_io_out_re; // @[FFT.scala 122:65 170:19]
  assign inst_2_io_in_1_im = inst_53_io_out_im; // @[FFT.scala 122:65 170:19]
  assign inst_2_io_wn_0_re = 7'h7f == _wnList_T_5 ? _wnList_res_re_T_1023 : _GEN_639; // @[FFT.scala 104:{12,12}]
  assign inst_2_io_wn_0_im = 7'h7f == _wnList_T_5 ? _wnList_res_re_T_527 : _GEN_767; // @[FFT.scala 105:{12,12}]
  assign inst_3_io_in_0_re = inst_54_io_out_re; // @[FFT.scala 122:65 170:19]
  assign inst_3_io_in_0_im = inst_54_io_out_im; // @[FFT.scala 122:65 170:19]
  assign inst_3_io_in_1_re = inst_55_io_out_re; // @[FFT.scala 122:65 170:19]
  assign inst_3_io_in_1_im = inst_55_io_out_im; // @[FFT.scala 122:65 170:19]
  assign inst_3_io_wn_0_re = 7'h7f == _wnList_T_7 ? _wnList_res_re_T_1023 : _GEN_895; // @[FFT.scala 104:{12,12}]
  assign inst_3_io_wn_0_im = 7'h7f == _wnList_T_7 ? _wnList_res_re_T_527 : _GEN_1023; // @[FFT.scala 105:{12,12}]
  assign inst_4_io_in_0_re = REG__0_re; // @[FFT.scala 122:65 157:57]
  assign inst_4_io_in_0_im = REG__0_im; // @[FFT.scala 122:65 157:57]
  assign inst_4_io_in_1_re = REG__1_re; // @[FFT.scala 122:65 157:57]
  assign inst_4_io_in_1_im = REG__1_im; // @[FFT.scala 122:65 157:57]
  assign inst_4_io_wn_0_re = 6'h3f == _wnList_T_8[5:0] ? _wnList_res_re_T_1015 : _GEN_1087; // @[FFT.scala 104:{12,12}]
  assign inst_4_io_wn_0_im = 6'h3f == _wnList_T_8[5:0] ? _wnList_res_re_T_535 : _GEN_1151; // @[FFT.scala 105:{12,12}]
  assign inst_5_io_in_0_re = REG_2_0_re; // @[FFT.scala 122:65 157:57]
  assign inst_5_io_in_0_im = REG_2_0_im; // @[FFT.scala 122:65 157:57]
  assign inst_5_io_in_1_re = REG_2_1_re; // @[FFT.scala 122:65 157:57]
  assign inst_5_io_in_1_im = REG_2_1_im; // @[FFT.scala 122:65 157:57]
  assign inst_5_io_wn_0_re = 6'h3f == _wnList_T_11[5:0] ? _wnList_res_re_T_1015 : _GEN_1215; // @[FFT.scala 104:{12,12}]
  assign inst_5_io_wn_0_im = 6'h3f == _wnList_T_11[5:0] ? _wnList_res_re_T_535 : _GEN_1279; // @[FFT.scala 105:{12,12}]
  assign inst_6_io_in_0_re = REG_1_0_re; // @[FFT.scala 122:65 157:57]
  assign inst_6_io_in_0_im = REG_1_0_im; // @[FFT.scala 122:65 157:57]
  assign inst_6_io_in_1_re = REG_1_1_re; // @[FFT.scala 122:65 157:57]
  assign inst_6_io_in_1_im = REG_1_1_im; // @[FFT.scala 122:65 157:57]
  assign inst_6_io_wn_0_re = 6'h3f == _wnList_T_8[5:0] ? _wnList_res_re_T_1015 : _GEN_1087; // @[FFT.scala 104:{12,12}]
  assign inst_6_io_wn_0_im = 6'h3f == _wnList_T_8[5:0] ? _wnList_res_re_T_535 : _GEN_1151; // @[FFT.scala 105:{12,12}]
  assign inst_7_io_in_0_re = REG_3_0_re; // @[FFT.scala 122:65 157:57]
  assign inst_7_io_in_0_im = REG_3_0_im; // @[FFT.scala 122:65 157:57]
  assign inst_7_io_in_1_re = REG_3_1_re; // @[FFT.scala 122:65 157:57]
  assign inst_7_io_in_1_im = REG_3_1_im; // @[FFT.scala 122:65 157:57]
  assign inst_7_io_wn_0_re = 6'h3f == _wnList_T_11[5:0] ? _wnList_res_re_T_1015 : _GEN_1215; // @[FFT.scala 104:{12,12}]
  assign inst_7_io_wn_0_im = 6'h3f == _wnList_T_11[5:0] ? _wnList_res_re_T_535 : _GEN_1279; // @[FFT.scala 105:{12,12}]
  assign inst_8_io_in_0_re = REG_4_0_re; // @[FFT.scala 122:65 157:57]
  assign inst_8_io_in_0_im = REG_4_0_im; // @[FFT.scala 122:65 157:57]
  assign inst_8_io_in_1_re = REG_4_1_re; // @[FFT.scala 122:65 157:57]
  assign inst_8_io_in_1_im = REG_4_1_im; // @[FFT.scala 122:65 157:57]
  assign inst_8_io_wn_0_re = 5'h1f == _wnList_T_16[4:0] ? _wnList_res_re_T_999 : _GEN_1567; // @[FFT.scala 104:{12,12}]
  assign inst_8_io_wn_0_im = 5'h1f == _wnList_T_16[4:0] ? _wnList_res_re_T_551 : _GEN_1599; // @[FFT.scala 105:{12,12}]
  assign inst_9_io_in_0_re = REG_5_0_re; // @[FFT.scala 122:65 157:57]
  assign inst_9_io_in_0_im = REG_5_0_im; // @[FFT.scala 122:65 157:57]
  assign inst_9_io_in_1_re = REG_5_1_re; // @[FFT.scala 122:65 157:57]
  assign inst_9_io_in_1_im = REG_5_1_im; // @[FFT.scala 122:65 157:57]
  assign inst_9_io_wn_0_re = 5'h1f == _wnList_T_16[4:0] ? _wnList_res_re_T_999 : _GEN_1567; // @[FFT.scala 104:{12,12}]
  assign inst_9_io_wn_0_im = 5'h1f == _wnList_T_16[4:0] ? _wnList_res_re_T_551 : _GEN_1599; // @[FFT.scala 105:{12,12}]
  assign inst_10_io_in_0_re = REG_6_0_re; // @[FFT.scala 122:65 157:57]
  assign inst_10_io_in_0_im = REG_6_0_im; // @[FFT.scala 122:65 157:57]
  assign inst_10_io_in_1_re = REG_6_1_re; // @[FFT.scala 122:65 157:57]
  assign inst_10_io_in_1_im = REG_6_1_im; // @[FFT.scala 122:65 157:57]
  assign inst_10_io_wn_0_re = 5'h1f == _wnList_T_16[4:0] ? _wnList_res_re_T_999 : _GEN_1567; // @[FFT.scala 104:{12,12}]
  assign inst_10_io_wn_0_im = 5'h1f == _wnList_T_16[4:0] ? _wnList_res_re_T_551 : _GEN_1599; // @[FFT.scala 105:{12,12}]
  assign inst_11_io_in_0_re = REG_7_0_re; // @[FFT.scala 122:65 157:57]
  assign inst_11_io_in_0_im = REG_7_0_im; // @[FFT.scala 122:65 157:57]
  assign inst_11_io_in_1_re = REG_7_1_re; // @[FFT.scala 122:65 157:57]
  assign inst_11_io_in_1_im = REG_7_1_im; // @[FFT.scala 122:65 157:57]
  assign inst_11_io_wn_0_re = 5'h1f == _wnList_T_16[4:0] ? _wnList_res_re_T_999 : _GEN_1567; // @[FFT.scala 104:{12,12}]
  assign inst_11_io_wn_0_im = 5'h1f == _wnList_T_16[4:0] ? _wnList_res_re_T_551 : _GEN_1599; // @[FFT.scala 105:{12,12}]
  assign inst_12_io_in_0_re = inst_28_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_12_io_in_0_im = inst_28_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_12_io_in_1_re = inst_28_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_12_io_in_1_im = inst_28_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_12_io_wn_0_re = 4'hf == _wnList_T_24[3:0] ? _wnList_res_re_T_967 : _GEN_1807; // @[FFT.scala 104:{12,12}]
  assign inst_12_io_wn_0_im = 4'hf == _wnList_T_24[3:0] ? _wnList_res_re_T_583 : _GEN_1823; // @[FFT.scala 105:{12,12}]
  assign inst_13_io_in_0_re = inst_29_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_13_io_in_0_im = inst_29_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_13_io_in_1_re = inst_29_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_13_io_in_1_im = inst_29_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_13_io_wn_0_re = 4'hf == _wnList_T_24[3:0] ? _wnList_res_re_T_967 : _GEN_1807; // @[FFT.scala 104:{12,12}]
  assign inst_13_io_wn_0_im = 4'hf == _wnList_T_24[3:0] ? _wnList_res_re_T_583 : _GEN_1823; // @[FFT.scala 105:{12,12}]
  assign inst_14_io_in_0_re = inst_30_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_14_io_in_0_im = inst_30_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_14_io_in_1_re = inst_30_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_14_io_in_1_im = inst_30_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_14_io_wn_0_re = 4'hf == _wnList_T_24[3:0] ? _wnList_res_re_T_967 : _GEN_1807; // @[FFT.scala 104:{12,12}]
  assign inst_14_io_wn_0_im = 4'hf == _wnList_T_24[3:0] ? _wnList_res_re_T_583 : _GEN_1823; // @[FFT.scala 105:{12,12}]
  assign inst_15_io_in_0_re = inst_31_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_15_io_in_0_im = inst_31_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_15_io_in_1_re = inst_31_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_15_io_in_1_im = inst_31_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_15_io_wn_0_re = 4'hf == _wnList_T_24[3:0] ? _wnList_res_re_T_967 : _GEN_1807; // @[FFT.scala 104:{12,12}]
  assign inst_15_io_wn_0_im = 4'hf == _wnList_T_24[3:0] ? _wnList_res_re_T_583 : _GEN_1823; // @[FFT.scala 105:{12,12}]
  assign inst_16_io_in_0_re = inst_32_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_16_io_in_0_im = inst_32_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_16_io_in_1_re = inst_32_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_16_io_in_1_im = inst_32_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_16_io_wn_0_re = 3'h7 == _wnList_T_32[2:0] ? _wnList_res_re_T_903 : _GEN_1927; // @[FFT.scala 104:{12,12}]
  assign inst_16_io_wn_0_im = 3'h7 == _wnList_T_32[2:0] ? _wnList_res_re_T_647 : _GEN_1935; // @[FFT.scala 105:{12,12}]
  assign inst_17_io_in_0_re = inst_33_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_17_io_in_0_im = inst_33_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_17_io_in_1_re = inst_33_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_17_io_in_1_im = inst_33_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_17_io_wn_0_re = 3'h7 == _wnList_T_32[2:0] ? _wnList_res_re_T_903 : _GEN_1927; // @[FFT.scala 104:{12,12}]
  assign inst_17_io_wn_0_im = 3'h7 == _wnList_T_32[2:0] ? _wnList_res_re_T_647 : _GEN_1935; // @[FFT.scala 105:{12,12}]
  assign inst_18_io_in_0_re = inst_34_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_18_io_in_0_im = inst_34_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_18_io_in_1_re = inst_34_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_18_io_in_1_im = inst_34_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_18_io_wn_0_re = 3'h7 == _wnList_T_32[2:0] ? _wnList_res_re_T_903 : _GEN_1927; // @[FFT.scala 104:{12,12}]
  assign inst_18_io_wn_0_im = 3'h7 == _wnList_T_32[2:0] ? _wnList_res_re_T_647 : _GEN_1935; // @[FFT.scala 105:{12,12}]
  assign inst_19_io_in_0_re = inst_35_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_19_io_in_0_im = inst_35_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_19_io_in_1_re = inst_35_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_19_io_in_1_im = inst_35_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_19_io_wn_0_re = 3'h7 == _wnList_T_32[2:0] ? _wnList_res_re_T_903 : _GEN_1927; // @[FFT.scala 104:{12,12}]
  assign inst_19_io_wn_0_im = 3'h7 == _wnList_T_32[2:0] ? _wnList_res_re_T_647 : _GEN_1935; // @[FFT.scala 105:{12,12}]
  assign inst_20_io_in_0_re = inst_36_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_20_io_in_0_im = inst_36_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_20_io_in_1_re = inst_36_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_20_io_in_1_im = inst_36_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_20_io_wn_0_re = 2'h3 == _wnList_T_40[1:0] ? _wnList_res_re_T_775 : _GEN_1987; // @[FFT.scala 104:{12,12}]
  assign inst_20_io_wn_0_im = 2'h3 == _wnList_T_40[1:0] ? _wnList_res_re_T_775 : _GEN_1991; // @[FFT.scala 105:{12,12}]
  assign inst_21_io_in_0_re = inst_37_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_21_io_in_0_im = inst_37_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_21_io_in_1_re = inst_37_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_21_io_in_1_im = inst_37_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_21_io_wn_0_re = 2'h3 == _wnList_T_40[1:0] ? _wnList_res_re_T_775 : _GEN_1987; // @[FFT.scala 104:{12,12}]
  assign inst_21_io_wn_0_im = 2'h3 == _wnList_T_40[1:0] ? _wnList_res_re_T_775 : _GEN_1991; // @[FFT.scala 105:{12,12}]
  assign inst_22_io_in_0_re = inst_38_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_22_io_in_0_im = inst_38_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_22_io_in_1_re = inst_38_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_22_io_in_1_im = inst_38_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_22_io_wn_0_re = 2'h3 == _wnList_T_40[1:0] ? _wnList_res_re_T_775 : _GEN_1987; // @[FFT.scala 104:{12,12}]
  assign inst_22_io_wn_0_im = 2'h3 == _wnList_T_40[1:0] ? _wnList_res_re_T_775 : _GEN_1991; // @[FFT.scala 105:{12,12}]
  assign inst_23_io_in_0_re = inst_39_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_23_io_in_0_im = inst_39_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_23_io_in_1_re = inst_39_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_23_io_in_1_im = inst_39_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_23_io_wn_0_re = 2'h3 == _wnList_T_40[1:0] ? _wnList_res_re_T_775 : _GEN_1987; // @[FFT.scala 104:{12,12}]
  assign inst_23_io_wn_0_im = 2'h3 == _wnList_T_40[1:0] ? _wnList_res_re_T_775 : _GEN_1991; // @[FFT.scala 105:{12,12}]
  assign inst_24_io_in_0_re = inst_40_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_24_io_in_0_im = inst_40_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_24_io_in_1_re = inst_40_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_24_io_in_1_im = inst_40_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_24_io_wn_0_re = _wnList_T_48[0] ? _wnList_res_re_T_519 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  assign inst_24_io_wn_0_im = _wnList_T_48[0] ? _wnList_res_im_T_519 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  assign inst_25_io_in_0_re = inst_41_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_25_io_in_0_im = inst_41_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_25_io_in_1_re = inst_41_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_25_io_in_1_im = inst_41_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_25_io_wn_0_re = _wnList_T_48[0] ? _wnList_res_re_T_519 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  assign inst_25_io_wn_0_im = _wnList_T_48[0] ? _wnList_res_im_T_519 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  assign inst_26_io_in_0_re = inst_42_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_26_io_in_0_im = inst_42_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_26_io_in_1_re = inst_42_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_26_io_in_1_im = inst_42_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_26_io_wn_0_re = _wnList_T_48[0] ? _wnList_res_re_T_519 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  assign inst_26_io_wn_0_im = _wnList_T_48[0] ? _wnList_res_im_T_519 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  assign inst_27_io_in_0_re = inst_43_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign inst_27_io_in_0_im = inst_43_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign inst_27_io_in_1_re = inst_43_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign inst_27_io_in_1_im = inst_43_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign inst_27_io_wn_0_re = _wnList_T_48[0] ? _wnList_res_re_T_519 : _wnList_res_re_T_7; // @[FFT.scala 104:{12,12}]
  assign inst_27_io_wn_0_im = _wnList_T_48[0] ? _wnList_res_im_T_519 : _wnList_res_re_T_519; // @[FFT.scala 105:{12,12}]
  assign dataotemp_inst_io_in_0_re = inst_44_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_io_in_0_im = inst_44_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_io_in_1_re = inst_44_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_io_in_1_im = inst_44_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_1_io_in_0_re = inst_45_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_1_io_in_0_im = inst_45_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_1_io_in_1_re = inst_45_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_1_io_in_1_im = inst_45_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_2_io_in_0_re = inst_46_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_2_io_in_0_im = inst_46_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_2_io_in_1_re = inst_46_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_2_io_in_1_im = inst_46_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_3_io_in_0_re = inst_47_io_out_0_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_3_io_in_0_im = inst_47_io_out_0_im; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_3_io_in_1_re = inst_47_io_out_1_re; // @[FFT.scala 122:65 164:54]
  assign dataotemp_inst_3_io_in_1_im = inst_47_io_out_1_im; // @[FFT.scala 122:65 164:54]
  assign exdata_inst_io_in_0_0_re = inst_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_0_0_im = inst_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_0_1_re = inst_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_0_1_im = inst_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_1_0_re = inst_2_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_1_0_im = inst_2_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_1_1_re = inst_2_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_io_in_1_1_im = inst_2_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_1_io_in_0_0_re = inst_1_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_1_io_in_0_0_im = inst_1_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_1_io_in_0_1_re = inst_1_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_1_io_in_0_1_im = inst_1_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_1_io_in_1_0_re = inst_3_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_1_io_in_1_0_im = inst_3_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_1_io_in_1_1_re = inst_3_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_1_io_in_1_1_im = inst_3_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_2_io_in_0_0_re = inst_4_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_2_io_in_0_0_im = inst_4_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_2_io_in_0_1_re = inst_4_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_2_io_in_0_1_im = inst_4_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_2_io_in_1_0_re = inst_5_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_2_io_in_1_0_im = inst_5_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_2_io_in_1_1_re = inst_5_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_2_io_in_1_1_im = inst_5_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_3_io_in_0_0_re = inst_6_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_3_io_in_0_0_im = inst_6_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_3_io_in_0_1_re = inst_6_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_3_io_in_0_1_im = inst_6_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_3_io_in_1_0_re = inst_7_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_3_io_in_1_0_im = inst_7_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_3_io_in_1_1_re = inst_7_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign exdata_inst_3_io_in_1_1_im = inst_7_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_28_clock = clock;
  assign inst_28_io_in_0_re = inst_8_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_28_io_in_0_im = inst_8_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_28_io_in_1_re = inst_8_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_28_io_in_1_im = inst_8_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_28_io_sel = cnt_2[4]; // @[FFT.scala 163:31]
  assign inst_29_clock = clock;
  assign inst_29_io_in_0_re = inst_9_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_29_io_in_0_im = inst_9_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_29_io_in_1_re = inst_9_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_29_io_in_1_im = inst_9_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_29_io_sel = cnt_2[4]; // @[FFT.scala 163:31]
  assign inst_30_clock = clock;
  assign inst_30_io_in_0_re = inst_10_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_30_io_in_0_im = inst_10_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_30_io_in_1_re = inst_10_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_30_io_in_1_im = inst_10_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_30_io_sel = cnt_2[4]; // @[FFT.scala 163:31]
  assign inst_31_clock = clock;
  assign inst_31_io_in_0_re = inst_11_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_31_io_in_0_im = inst_11_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_31_io_in_1_re = inst_11_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_31_io_in_1_im = inst_11_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_31_io_sel = cnt_2[4]; // @[FFT.scala 163:31]
  assign inst_32_clock = clock;
  assign inst_32_io_in_0_re = inst_12_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_32_io_in_0_im = inst_12_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_32_io_in_1_re = inst_12_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_32_io_in_1_im = inst_12_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_32_io_sel = cnt_2[3]; // @[FFT.scala 163:31]
  assign inst_33_clock = clock;
  assign inst_33_io_in_0_re = inst_13_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_33_io_in_0_im = inst_13_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_33_io_in_1_re = inst_13_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_33_io_in_1_im = inst_13_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_33_io_sel = cnt_2[3]; // @[FFT.scala 163:31]
  assign inst_34_clock = clock;
  assign inst_34_io_in_0_re = inst_14_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_34_io_in_0_im = inst_14_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_34_io_in_1_re = inst_14_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_34_io_in_1_im = inst_14_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_34_io_sel = cnt_2[3]; // @[FFT.scala 163:31]
  assign inst_35_clock = clock;
  assign inst_35_io_in_0_re = inst_15_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_35_io_in_0_im = inst_15_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_35_io_in_1_re = inst_15_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_35_io_in_1_im = inst_15_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_35_io_sel = cnt_2[3]; // @[FFT.scala 163:31]
  assign inst_36_clock = clock;
  assign inst_36_io_in_0_re = inst_16_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_36_io_in_0_im = inst_16_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_36_io_in_1_re = inst_16_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_36_io_in_1_im = inst_16_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_36_io_sel = cnt_2[2]; // @[FFT.scala 163:31]
  assign inst_37_clock = clock;
  assign inst_37_io_in_0_re = inst_17_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_37_io_in_0_im = inst_17_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_37_io_in_1_re = inst_17_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_37_io_in_1_im = inst_17_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_37_io_sel = cnt_2[2]; // @[FFT.scala 163:31]
  assign inst_38_clock = clock;
  assign inst_38_io_in_0_re = inst_18_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_38_io_in_0_im = inst_18_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_38_io_in_1_re = inst_18_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_38_io_in_1_im = inst_18_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_38_io_sel = cnt_2[2]; // @[FFT.scala 163:31]
  assign inst_39_clock = clock;
  assign inst_39_io_in_0_re = inst_19_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_39_io_in_0_im = inst_19_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_39_io_in_1_re = inst_19_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_39_io_in_1_im = inst_19_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_39_io_sel = cnt_2[2]; // @[FFT.scala 163:31]
  assign inst_40_clock = clock;
  assign inst_40_io_in_0_re = inst_20_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_40_io_in_0_im = inst_20_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_40_io_in_1_re = inst_20_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_40_io_in_1_im = inst_20_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_40_io_sel = cnt_2[1]; // @[FFT.scala 163:31]
  assign inst_41_clock = clock;
  assign inst_41_io_in_0_re = inst_21_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_41_io_in_0_im = inst_21_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_41_io_in_1_re = inst_21_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_41_io_in_1_im = inst_21_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_41_io_sel = cnt_2[1]; // @[FFT.scala 163:31]
  assign inst_42_clock = clock;
  assign inst_42_io_in_0_re = inst_22_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_42_io_in_0_im = inst_22_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_42_io_in_1_re = inst_22_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_42_io_in_1_im = inst_22_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_42_io_sel = cnt_2[1]; // @[FFT.scala 163:31]
  assign inst_43_clock = clock;
  assign inst_43_io_in_0_re = inst_23_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_43_io_in_0_im = inst_23_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_43_io_in_1_re = inst_23_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_43_io_in_1_im = inst_23_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_43_io_sel = cnt_2[1]; // @[FFT.scala 163:31]
  assign inst_44_clock = clock;
  assign inst_44_io_in_0_re = inst_24_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_44_io_in_0_im = inst_24_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_44_io_in_1_re = inst_24_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_44_io_in_1_im = inst_24_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_44_io_sel = cnt_2[0]; // @[FFT.scala 163:31]
  assign inst_45_clock = clock;
  assign inst_45_io_in_0_re = inst_25_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_45_io_in_0_im = inst_25_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_45_io_in_1_re = inst_25_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_45_io_in_1_im = inst_25_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_45_io_sel = cnt_2[0]; // @[FFT.scala 163:31]
  assign inst_46_clock = clock;
  assign inst_46_io_in_0_re = inst_26_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_46_io_in_0_im = inst_26_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_46_io_in_1_re = inst_26_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_46_io_in_1_im = inst_26_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_46_io_sel = cnt_2[0]; // @[FFT.scala 163:31]
  assign inst_47_clock = clock;
  assign inst_47_io_in_0_re = inst_27_io_out_0_re; // @[FFT.scala 123:69 136:19]
  assign inst_47_io_in_0_im = inst_27_io_out_0_im; // @[FFT.scala 123:69 136:19]
  assign inst_47_io_in_1_re = inst_27_io_out_1_re; // @[FFT.scala 123:69 136:19]
  assign inst_47_io_in_1_im = inst_27_io_out_1_im; // @[FFT.scala 123:69 136:19]
  assign inst_47_io_sel = cnt_2[0]; // @[FFT.scala 163:31]
  assign inst_48_io_in_re = _T_1[31:16]; // @[FFT.scala 170:91]
  assign inst_48_io_in_im = _T_1[15:0]; // @[FFT.scala 170:91]
  assign inst_49_io_in_re = _T_4[31:16]; // @[FFT.scala 170:91]
  assign inst_49_io_in_im = _T_4[15:0]; // @[FFT.scala 170:91]
  assign inst_50_io_in_re = _T_7[31:16]; // @[FFT.scala 170:91]
  assign inst_50_io_in_im = _T_7[15:0]; // @[FFT.scala 170:91]
  assign inst_51_io_in_re = _T_10[31:16]; // @[FFT.scala 170:91]
  assign inst_51_io_in_im = _T_10[15:0]; // @[FFT.scala 170:91]
  assign inst_52_io_in_re = _T_13[31:16]; // @[FFT.scala 170:91]
  assign inst_52_io_in_im = _T_13[15:0]; // @[FFT.scala 170:91]
  assign inst_53_io_in_re = _T_16[31:16]; // @[FFT.scala 170:91]
  assign inst_53_io_in_im = _T_16[15:0]; // @[FFT.scala 170:91]
  assign inst_54_io_in_re = _T_19[31:16]; // @[FFT.scala 170:91]
  assign inst_54_io_in_im = _T_19[15:0]; // @[FFT.scala 170:91]
  assign inst_55_io_in_re = _T_22[31:16]; // @[FFT.scala 170:91]
  assign inst_55_io_in_im = _T_22[15:0]; // @[FFT.scala 170:91]
  assign inst_56_io_in_re = _T_25[33:17]; // @[FFT.scala 181:96]
  assign inst_56_io_in_im = _T_25[16:0]; // @[FFT.scala 181:96]
  assign inst_57_io_in_re = _T_28[33:17]; // @[FFT.scala 181:96]
  assign inst_57_io_in_im = _T_28[16:0]; // @[FFT.scala 181:96]
  assign inst_58_io_in_re = _T_31[33:17]; // @[FFT.scala 181:96]
  assign inst_58_io_in_im = _T_31[16:0]; // @[FFT.scala 181:96]
  assign inst_59_io_in_re = _T_34[33:17]; // @[FFT.scala 181:96]
  assign inst_59_io_in_im = _T_34[16:0]; // @[FFT.scala 181:96]
  assign inst_60_io_in_re = _T_37[33:17]; // @[FFT.scala 181:96]
  assign inst_60_io_in_im = _T_37[16:0]; // @[FFT.scala 181:96]
  assign inst_61_io_in_re = _T_40[33:17]; // @[FFT.scala 181:96]
  assign inst_61_io_in_im = _T_40[16:0]; // @[FFT.scala 181:96]
  assign inst_62_io_in_re = _T_43[33:17]; // @[FFT.scala 181:96]
  assign inst_62_io_in_im = _T_43[16:0]; // @[FFT.scala 181:96]
  assign inst_63_io_in_re = _T_46[33:17]; // @[FFT.scala 181:96]
  assign inst_63_io_in_im = _T_46[16:0]; // @[FFT.scala 181:96]
  always @(posedge clock) begin
    if (reset) begin // @[FFT.scala 110:46]
      cnt_0 <= 7'h0; // @[FFT.scala 110:46]
    end else if (io_din_valid | busy) begin // @[FFT.scala 115:30]
      if (cnt_0 == 7'h41) begin // @[FFT.scala 116:18]
        cnt_0 <= 7'h0;
      end else begin
        cnt_0 <= _cnt_0_T_2;
      end
    end
    if (reset) begin // @[FFT.scala 110:46]
      cnt_1 <= 7'h0; // @[FFT.scala 110:46]
    end else begin
      cnt_1 <= cnt_0; // @[FFT.scala 112:16]
    end
    if (reset) begin // @[FFT.scala 110:46]
      cnt_2 <= 7'h0; // @[FFT.scala 110:46]
    end else begin
      cnt_2 <= cnt_1; // @[FFT.scala 112:16]
    end
    REG__0_re <= exdata_inst_io_out_0_0_re; // @[FFT.scala 157:67]
    REG__0_im <= exdata_inst_io_out_0_0_im; // @[FFT.scala 157:67]
    REG__1_re <= exdata_inst_io_out_0_1_re; // @[FFT.scala 157:67]
    REG__1_im <= exdata_inst_io_out_0_1_im; // @[FFT.scala 157:67]
    REG_1_0_re <= exdata_inst_io_out_1_0_re; // @[FFT.scala 157:67]
    REG_1_0_im <= exdata_inst_io_out_1_0_im; // @[FFT.scala 157:67]
    REG_1_1_re <= exdata_inst_io_out_1_1_re; // @[FFT.scala 157:67]
    REG_1_1_im <= exdata_inst_io_out_1_1_im; // @[FFT.scala 157:67]
    REG_2_0_re <= exdata_inst_1_io_out_0_0_re; // @[FFT.scala 157:67]
    REG_2_0_im <= exdata_inst_1_io_out_0_0_im; // @[FFT.scala 157:67]
    REG_2_1_re <= exdata_inst_1_io_out_0_1_re; // @[FFT.scala 157:67]
    REG_2_1_im <= exdata_inst_1_io_out_0_1_im; // @[FFT.scala 157:67]
    REG_3_0_re <= exdata_inst_1_io_out_1_0_re; // @[FFT.scala 157:67]
    REG_3_0_im <= exdata_inst_1_io_out_1_0_im; // @[FFT.scala 157:67]
    REG_3_1_re <= exdata_inst_1_io_out_1_1_re; // @[FFT.scala 157:67]
    REG_3_1_im <= exdata_inst_1_io_out_1_1_im; // @[FFT.scala 157:67]
    REG_4_0_re <= exdata_inst_2_io_out_0_0_re; // @[FFT.scala 157:67]
    REG_4_0_im <= exdata_inst_2_io_out_0_0_im; // @[FFT.scala 157:67]
    REG_4_1_re <= exdata_inst_2_io_out_0_1_re; // @[FFT.scala 157:67]
    REG_4_1_im <= exdata_inst_2_io_out_0_1_im; // @[FFT.scala 157:67]
    REG_5_0_re <= exdata_inst_2_io_out_1_0_re; // @[FFT.scala 157:67]
    REG_5_0_im <= exdata_inst_2_io_out_1_0_im; // @[FFT.scala 157:67]
    REG_5_1_re <= exdata_inst_2_io_out_1_1_re; // @[FFT.scala 157:67]
    REG_5_1_im <= exdata_inst_2_io_out_1_1_im; // @[FFT.scala 157:67]
    REG_6_0_re <= exdata_inst_3_io_out_0_0_re; // @[FFT.scala 157:67]
    REG_6_0_im <= exdata_inst_3_io_out_0_0_im; // @[FFT.scala 157:67]
    REG_6_1_re <= exdata_inst_3_io_out_0_1_re; // @[FFT.scala 157:67]
    REG_6_1_im <= exdata_inst_3_io_out_0_1_im; // @[FFT.scala 157:67]
    REG_7_0_re <= exdata_inst_3_io_out_1_0_re; // @[FFT.scala 157:67]
    REG_7_0_im <= exdata_inst_3_io_out_1_0_im; // @[FFT.scala 157:67]
    REG_7_1_re <= exdata_inst_3_io_out_1_1_re; // @[FFT.scala 157:67]
    REG_7_1_im <= exdata_inst_3_io_out_1_1_im; // @[FFT.scala 157:67]
    io_dout_valid_REG <= cnt_0; // @[FFT.scala 179:27]
    REG_8_re <= inst_56_io_out_re; // @[FFT.scala 181:64]
    REG_8_im <= inst_56_io_out_im; // @[FFT.scala 181:64]
    REG_9_re <= inst_57_io_out_re; // @[FFT.scala 181:64]
    REG_9_im <= inst_57_io_out_im; // @[FFT.scala 181:64]
    REG_10_re <= inst_58_io_out_re; // @[FFT.scala 181:64]
    REG_10_im <= inst_58_io_out_im; // @[FFT.scala 181:64]
    REG_11_re <= inst_59_io_out_re; // @[FFT.scala 181:64]
    REG_11_im <= inst_59_io_out_im; // @[FFT.scala 181:64]
    REG_12_re <= inst_60_io_out_re; // @[FFT.scala 181:64]
    REG_12_im <= inst_60_io_out_im; // @[FFT.scala 181:64]
    REG_13_re <= inst_61_io_out_re; // @[FFT.scala 181:64]
    REG_13_im <= inst_61_io_out_im; // @[FFT.scala 181:64]
    REG_14_re <= inst_62_io_out_re; // @[FFT.scala 181:64]
    REG_14_im <= inst_62_io_out_im; // @[FFT.scala 181:64]
    REG_15_re <= inst_63_io_out_re; // @[FFT.scala 181:64]
    REG_15_im <= inst_63_io_out_im; // @[FFT.scala 181:64]
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
  cnt_0 = _RAND_0[6:0];
  _RAND_1 = {1{`RANDOM}};
  cnt_1 = _RAND_1[6:0];
  _RAND_2 = {1{`RANDOM}};
  cnt_2 = _RAND_2[6:0];
  _RAND_3 = {1{`RANDOM}};
  REG__0_re = _RAND_3[16:0];
  _RAND_4 = {1{`RANDOM}};
  REG__0_im = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  REG__1_re = _RAND_5[16:0];
  _RAND_6 = {1{`RANDOM}};
  REG__1_im = _RAND_6[16:0];
  _RAND_7 = {1{`RANDOM}};
  REG_1_0_re = _RAND_7[16:0];
  _RAND_8 = {1{`RANDOM}};
  REG_1_0_im = _RAND_8[16:0];
  _RAND_9 = {1{`RANDOM}};
  REG_1_1_re = _RAND_9[16:0];
  _RAND_10 = {1{`RANDOM}};
  REG_1_1_im = _RAND_10[16:0];
  _RAND_11 = {1{`RANDOM}};
  REG_2_0_re = _RAND_11[16:0];
  _RAND_12 = {1{`RANDOM}};
  REG_2_0_im = _RAND_12[16:0];
  _RAND_13 = {1{`RANDOM}};
  REG_2_1_re = _RAND_13[16:0];
  _RAND_14 = {1{`RANDOM}};
  REG_2_1_im = _RAND_14[16:0];
  _RAND_15 = {1{`RANDOM}};
  REG_3_0_re = _RAND_15[16:0];
  _RAND_16 = {1{`RANDOM}};
  REG_3_0_im = _RAND_16[16:0];
  _RAND_17 = {1{`RANDOM}};
  REG_3_1_re = _RAND_17[16:0];
  _RAND_18 = {1{`RANDOM}};
  REG_3_1_im = _RAND_18[16:0];
  _RAND_19 = {1{`RANDOM}};
  REG_4_0_re = _RAND_19[16:0];
  _RAND_20 = {1{`RANDOM}};
  REG_4_0_im = _RAND_20[16:0];
  _RAND_21 = {1{`RANDOM}};
  REG_4_1_re = _RAND_21[16:0];
  _RAND_22 = {1{`RANDOM}};
  REG_4_1_im = _RAND_22[16:0];
  _RAND_23 = {1{`RANDOM}};
  REG_5_0_re = _RAND_23[16:0];
  _RAND_24 = {1{`RANDOM}};
  REG_5_0_im = _RAND_24[16:0];
  _RAND_25 = {1{`RANDOM}};
  REG_5_1_re = _RAND_25[16:0];
  _RAND_26 = {1{`RANDOM}};
  REG_5_1_im = _RAND_26[16:0];
  _RAND_27 = {1{`RANDOM}};
  REG_6_0_re = _RAND_27[16:0];
  _RAND_28 = {1{`RANDOM}};
  REG_6_0_im = _RAND_28[16:0];
  _RAND_29 = {1{`RANDOM}};
  REG_6_1_re = _RAND_29[16:0];
  _RAND_30 = {1{`RANDOM}};
  REG_6_1_im = _RAND_30[16:0];
  _RAND_31 = {1{`RANDOM}};
  REG_7_0_re = _RAND_31[16:0];
  _RAND_32 = {1{`RANDOM}};
  REG_7_0_im = _RAND_32[16:0];
  _RAND_33 = {1{`RANDOM}};
  REG_7_1_re = _RAND_33[16:0];
  _RAND_34 = {1{`RANDOM}};
  REG_7_1_im = _RAND_34[16:0];
  _RAND_35 = {1{`RANDOM}};
  io_dout_valid_REG = _RAND_35[6:0];
  _RAND_36 = {1{`RANDOM}};
  REG_8_re = _RAND_36[15:0];
  _RAND_37 = {1{`RANDOM}};
  REG_8_im = _RAND_37[15:0];
  _RAND_38 = {1{`RANDOM}};
  REG_9_re = _RAND_38[15:0];
  _RAND_39 = {1{`RANDOM}};
  REG_9_im = _RAND_39[15:0];
  _RAND_40 = {1{`RANDOM}};
  REG_10_re = _RAND_40[15:0];
  _RAND_41 = {1{`RANDOM}};
  REG_10_im = _RAND_41[15:0];
  _RAND_42 = {1{`RANDOM}};
  REG_11_re = _RAND_42[15:0];
  _RAND_43 = {1{`RANDOM}};
  REG_11_im = _RAND_43[15:0];
  _RAND_44 = {1{`RANDOM}};
  REG_12_re = _RAND_44[15:0];
  _RAND_45 = {1{`RANDOM}};
  REG_12_im = _RAND_45[15:0];
  _RAND_46 = {1{`RANDOM}};
  REG_13_re = _RAND_46[15:0];
  _RAND_47 = {1{`RANDOM}};
  REG_13_im = _RAND_47[15:0];
  _RAND_48 = {1{`RANDOM}};
  REG_14_re = _RAND_48[15:0];
  _RAND_49 = {1{`RANDOM}};
  REG_14_im = _RAND_49[15:0];
  _RAND_50 = {1{`RANDOM}};
  REG_15_re = _RAND_50[15:0];
  _RAND_51 = {1{`RANDOM}};
  REG_15_im = _RAND_51[15:0];
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
  input  [15:0] io_dIn_0_re,
  input  [15:0] io_dIn_0_im,
  input  [15:0] io_dIn_1_re,
  input  [15:0] io_dIn_1_im,
  input  [15:0] io_dIn_2_re,
  input  [15:0] io_dIn_2_im,
  input  [15:0] io_dIn_3_re,
  input  [15:0] io_dIn_3_im,
  input  [15:0] io_dIn_4_re,
  input  [15:0] io_dIn_4_im,
  input  [15:0] io_dIn_5_re,
  input  [15:0] io_dIn_5_im,
  input  [15:0] io_dIn_6_re,
  input  [15:0] io_dIn_6_im,
  input  [15:0] io_dIn_7_re,
  input  [15:0] io_dIn_7_im,
  output [15:0] io_dOut_0_re,
  output [15:0] io_dOut_0_im,
  output [15:0] io_dOut_1_re,
  output [15:0] io_dOut_1_im,
  output [15:0] io_dOut_2_re,
  output [15:0] io_dOut_2_im,
  output [15:0] io_dOut_3_re,
  output [15:0] io_dOut_3_im,
  output [15:0] io_dOut_4_re,
  output [15:0] io_dOut_4_im,
  output [15:0] io_dOut_5_re,
  output [15:0] io_dOut_5_im,
  output [15:0] io_dOut_6_re,
  output [15:0] io_dOut_6_im,
  output [15:0] io_dOut_7_re,
  output [15:0] io_dOut_7_im,
  input         io_din_valid,
  output        io_dout_valid,
  output        io_busy
);
  wire  fft_clock; // @[Top.scala 15:19]
  wire  fft_reset; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_0_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_0_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_1_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_1_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_2_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_2_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_3_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_3_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_4_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_4_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_5_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_5_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_6_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_6_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_7_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dIn_7_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_0_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_0_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_1_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_1_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_2_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_2_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_3_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_3_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_4_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_4_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_5_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_5_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_6_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_6_im; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_7_re; // @[Top.scala 15:19]
  wire [15:0] fft_io_dOut_7_im; // @[Top.scala 15:19]
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
    .io_dIn_2_re(fft_io_dIn_2_re),
    .io_dIn_2_im(fft_io_dIn_2_im),
    .io_dIn_3_re(fft_io_dIn_3_re),
    .io_dIn_3_im(fft_io_dIn_3_im),
    .io_dIn_4_re(fft_io_dIn_4_re),
    .io_dIn_4_im(fft_io_dIn_4_im),
    .io_dIn_5_re(fft_io_dIn_5_re),
    .io_dIn_5_im(fft_io_dIn_5_im),
    .io_dIn_6_re(fft_io_dIn_6_re),
    .io_dIn_6_im(fft_io_dIn_6_im),
    .io_dIn_7_re(fft_io_dIn_7_re),
    .io_dIn_7_im(fft_io_dIn_7_im),
    .io_dOut_0_re(fft_io_dOut_0_re),
    .io_dOut_0_im(fft_io_dOut_0_im),
    .io_dOut_1_re(fft_io_dOut_1_re),
    .io_dOut_1_im(fft_io_dOut_1_im),
    .io_dOut_2_re(fft_io_dOut_2_re),
    .io_dOut_2_im(fft_io_dOut_2_im),
    .io_dOut_3_re(fft_io_dOut_3_re),
    .io_dOut_3_im(fft_io_dOut_3_im),
    .io_dOut_4_re(fft_io_dOut_4_re),
    .io_dOut_4_im(fft_io_dOut_4_im),
    .io_dOut_5_re(fft_io_dOut_5_re),
    .io_dOut_5_im(fft_io_dOut_5_im),
    .io_dOut_6_re(fft_io_dOut_6_re),
    .io_dOut_6_im(fft_io_dOut_6_im),
    .io_dOut_7_re(fft_io_dOut_7_re),
    .io_dOut_7_im(fft_io_dOut_7_im),
    .io_din_valid(fft_io_din_valid),
    .io_dout_valid(fft_io_dout_valid),
    .io_busy(fft_io_busy)
  );
  assign io_dOut_0_re = fft_io_dOut_0_re; // @[Top.scala 27:13]
  assign io_dOut_0_im = fft_io_dOut_0_im; // @[Top.scala 27:13]
  assign io_dOut_1_re = fft_io_dOut_1_re; // @[Top.scala 27:13]
  assign io_dOut_1_im = fft_io_dOut_1_im; // @[Top.scala 27:13]
  assign io_dOut_2_re = fft_io_dOut_2_re; // @[Top.scala 27:13]
  assign io_dOut_2_im = fft_io_dOut_2_im; // @[Top.scala 27:13]
  assign io_dOut_3_re = fft_io_dOut_3_re; // @[Top.scala 27:13]
  assign io_dOut_3_im = fft_io_dOut_3_im; // @[Top.scala 27:13]
  assign io_dOut_4_re = fft_io_dOut_4_re; // @[Top.scala 27:13]
  assign io_dOut_4_im = fft_io_dOut_4_im; // @[Top.scala 27:13]
  assign io_dOut_5_re = fft_io_dOut_5_re; // @[Top.scala 27:13]
  assign io_dOut_5_im = fft_io_dOut_5_im; // @[Top.scala 27:13]
  assign io_dOut_6_re = fft_io_dOut_6_re; // @[Top.scala 27:13]
  assign io_dOut_6_im = fft_io_dOut_6_im; // @[Top.scala 27:13]
  assign io_dOut_7_re = fft_io_dOut_7_re; // @[Top.scala 27:13]
  assign io_dOut_7_im = fft_io_dOut_7_im; // @[Top.scala 27:13]
  assign io_dout_valid = fft_io_dout_valid; // @[Top.scala 28:19]
  assign io_busy = fft_io_busy; // @[Top.scala 29:13]
  assign fft_clock = clock;
  assign fft_reset = reset;
  assign fft_io_dIn_0_re = io_dIn_0_re; // @[Top.scala 16:14]
  assign fft_io_dIn_0_im = io_dIn_0_im; // @[Top.scala 16:14]
  assign fft_io_dIn_1_re = io_dIn_1_re; // @[Top.scala 16:14]
  assign fft_io_dIn_1_im = io_dIn_1_im; // @[Top.scala 16:14]
  assign fft_io_dIn_2_re = io_dIn_2_re; // @[Top.scala 16:14]
  assign fft_io_dIn_2_im = io_dIn_2_im; // @[Top.scala 16:14]
  assign fft_io_dIn_3_re = io_dIn_3_re; // @[Top.scala 16:14]
  assign fft_io_dIn_3_im = io_dIn_3_im; // @[Top.scala 16:14]
  assign fft_io_dIn_4_re = io_dIn_4_re; // @[Top.scala 16:14]
  assign fft_io_dIn_4_im = io_dIn_4_im; // @[Top.scala 16:14]
  assign fft_io_dIn_5_re = io_dIn_5_re; // @[Top.scala 16:14]
  assign fft_io_dIn_5_im = io_dIn_5_im; // @[Top.scala 16:14]
  assign fft_io_dIn_6_re = io_dIn_6_re; // @[Top.scala 16:14]
  assign fft_io_dIn_6_im = io_dIn_6_im; // @[Top.scala 16:14]
  assign fft_io_dIn_7_re = io_dIn_7_re; // @[Top.scala 16:14]
  assign fft_io_dIn_7_im = io_dIn_7_im; // @[Top.scala 16:14]
  assign fft_io_din_valid = io_din_valid; // @[Top.scala 17:20]
endmodule
