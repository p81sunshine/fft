circuit FFTtop :
  module ComplexAdd :
    input clock : Clock
    input reset : Reset
    output io : { flip op1 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}, flip op2 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}, res : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}}

    node _io_res_re_T = asFixedPoint(io.op1.re, 16) @[Modules.scala 74:40]
    node _io_res_re_T_1 = asFixedPoint(io.op2.re, 16) @[Modules.scala 74:81]
    node _io_res_re_T_2 = add(_io_res_re_T, _io_res_re_T_1) @[Modules.scala 74:57]
    node _io_res_re_T_3 = tail(_io_res_re_T_2, 1) @[Modules.scala 74:57]
    node _io_res_re_T_4 = asFixedPoint(_io_res_re_T_3, 16) @[Modules.scala 74:57]
    io.res.re <= _io_res_re_T_4 @[Modules.scala 74:15]
    node _io_res_im_T = asFixedPoint(io.op1.im, 16) @[Modules.scala 75:40]
    node _io_res_im_T_1 = asFixedPoint(io.op2.im, 16) @[Modules.scala 75:81]
    node _io_res_im_T_2 = add(_io_res_im_T, _io_res_im_T_1) @[Modules.scala 75:57]
    node _io_res_im_T_3 = tail(_io_res_im_T_2, 1) @[Modules.scala 75:57]
    node _io_res_im_T_4 = asFixedPoint(_io_res_im_T_3, 16) @[Modules.scala 75:57]
    io.res.im <= _io_res_im_T_4 @[Modules.scala 75:15]

  module ComplexSub :
    input clock : Clock
    input reset : Reset
    output io : { flip op1 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}, flip op2 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}, res : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}}

    node _io_res_re_T = asFixedPoint(io.op1.re, 16) @[Modules.scala 93:40]
    node _io_res_re_T_1 = asFixedPoint(io.op2.re, 16) @[Modules.scala 93:81]
    node _io_res_re_T_2 = sub(_io_res_re_T, _io_res_re_T_1) @[Modules.scala 93:57]
    node _io_res_re_T_3 = tail(_io_res_re_T_2, 1) @[Modules.scala 93:57]
    node _io_res_re_T_4 = asFixedPoint(_io_res_re_T_3, 16) @[Modules.scala 93:57]
    io.res.re <= _io_res_re_T_4 @[Modules.scala 93:15]
    node _io_res_im_T = asFixedPoint(io.op1.im, 16) @[Modules.scala 94:40]
    node _io_res_im_T_1 = asFixedPoint(io.op2.im, 16) @[Modules.scala 94:81]
    node _io_res_im_T_2 = sub(_io_res_im_T, _io_res_im_T_1) @[Modules.scala 94:57]
    node _io_res_im_T_3 = tail(_io_res_im_T_2, 1) @[Modules.scala 94:57]
    node _io_res_im_T_4 = asFixedPoint(_io_res_im_T_3, 16) @[Modules.scala 94:57]
    io.res.im <= _io_res_im_T_4 @[Modules.scala 94:15]

  module ComplexMul :
    input clock : Clock
    input reset : Reset
    output io : { flip op1 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}, flip op2 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}, res : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}}

    node _io_res_re_T = asFixedPoint(io.op1.re, 16) @[Modules.scala 150:42]
    node _io_res_re_T_1 = asFixedPoint(io.op2.re, 16) @[Modules.scala 150:83]
    node _io_res_re_T_2 = mul(_io_res_re_T, _io_res_re_T_1) @[Modules.scala 150:59]
    node _io_res_re_T_3 = asFixedPoint(io.op1.im, 16) @[Modules.scala 150:124]
    node _io_res_re_T_4 = asFixedPoint(io.op2.im, 16) @[Modules.scala 150:165]
    node _io_res_re_T_5 = mul(_io_res_re_T_3, _io_res_re_T_4) @[Modules.scala 150:141]
    node _io_res_re_T_6 = sub(_io_res_re_T_2, _io_res_re_T_5) @[Modules.scala 150:100]
    node _io_res_re_T_7 = tail(_io_res_re_T_6, 1) @[Modules.scala 150:100]
    node _io_res_re_T_8 = asFixedPoint(_io_res_re_T_7, 32) @[Modules.scala 150:100]
    io.res.re <= _io_res_re_T_8 @[Modules.scala 150:17]
    node _io_res_im_T = asFixedPoint(io.op1.re, 16) @[Modules.scala 151:42]
    node _io_res_im_T_1 = asFixedPoint(io.op2.im, 16) @[Modules.scala 151:83]
    node _io_res_im_T_2 = mul(_io_res_im_T, _io_res_im_T_1) @[Modules.scala 151:59]
    node _io_res_im_T_3 = asFixedPoint(io.op1.im, 16) @[Modules.scala 151:124]
    node _io_res_im_T_4 = asFixedPoint(io.op2.re, 16) @[Modules.scala 151:165]
    node _io_res_im_T_5 = mul(_io_res_im_T_3, _io_res_im_T_4) @[Modules.scala 151:141]
    node _io_res_im_T_6 = add(_io_res_im_T_2, _io_res_im_T_5) @[Modules.scala 151:100]
    node _io_res_im_T_7 = tail(_io_res_im_T_6, 1) @[Modules.scala 151:100]
    node _io_res_im_T_8 = asFixedPoint(_io_res_im_T_7, 32) @[Modules.scala 151:100]
    io.res.im <= _io_res_im_T_8 @[Modules.scala 151:17]

  module ButterflyMul :
    input clock : Clock
    input reset : Reset
    output io : { flip in : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2], out : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2], flip wn : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[1]}

    wire _temp_WIRE : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[Modules.scala 224:50]
    node _temp_T = asUInt(asSInt(UInt<1>("h0"))) @[Modules.scala 224:50]
    wire _temp_WIRE_1 : UInt<64> @[Modules.scala 224:50]
    _temp_WIRE_1 <= _temp_T @[Modules.scala 224:50]
    node _temp_T_1 = bits(_temp_WIRE_1, 31, 0) @[Modules.scala 224:50]
    node _temp_T_2 = asFixedPoint(_temp_T_1, 16) @[Modules.scala 224:50]
    _temp_WIRE.im <= _temp_T_2 @[Modules.scala 224:50]
    node _temp_T_3 = bits(_temp_WIRE_1, 63, 32) @[Modules.scala 224:50]
    node _temp_T_4 = asFixedPoint(_temp_T_3, 16) @[Modules.scala 224:50]
    _temp_WIRE.re <= _temp_T_4 @[Modules.scala 224:50]
    wire _temp_WIRE_2 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[Modules.scala 224:50]
    node _temp_T_5 = asUInt(asSInt(UInt<1>("h0"))) @[Modules.scala 224:50]
    wire _temp_WIRE_3 : UInt<64> @[Modules.scala 224:50]
    _temp_WIRE_3 <= _temp_T_5 @[Modules.scala 224:50]
    node _temp_T_6 = bits(_temp_WIRE_3, 31, 0) @[Modules.scala 224:50]
    node _temp_T_7 = asFixedPoint(_temp_T_6, 16) @[Modules.scala 224:50]
    _temp_WIRE_2.im <= _temp_T_7 @[Modules.scala 224:50]
    node _temp_T_8 = bits(_temp_WIRE_3, 63, 32) @[Modules.scala 224:50]
    node _temp_T_9 = asFixedPoint(_temp_T_8, 16) @[Modules.scala 224:50]
    _temp_WIRE_2.re <= _temp_T_9 @[Modules.scala 224:50]
    wire temp : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2] @[Modules.scala 224:21]
    temp[0] <= _temp_WIRE @[Modules.scala 224:21]
    temp[1] <= _temp_WIRE_2 @[Modules.scala 224:21]
    inst temp_0_inst of ComplexAdd @[Modules.scala 81:22]
    temp_0_inst.clock <= clock
    temp_0_inst.reset <= reset
    temp_0_inst.io.op1.im <= io.in[0].im @[Modules.scala 82:17]
    temp_0_inst.io.op1.re <= io.in[0].re @[Modules.scala 82:17]
    temp_0_inst.io.op2.im <= io.in[1].im @[Modules.scala 83:17]
    temp_0_inst.io.op2.re <= io.in[1].re @[Modules.scala 83:17]
    temp[0] <= temp_0_inst.io.res @[Modules.scala 226:13]
    inst temp_1_inst of ComplexSub @[Modules.scala 100:22]
    temp_1_inst.clock <= clock
    temp_1_inst.reset <= reset
    temp_1_inst.io.op1.im <= io.in[0].im @[Modules.scala 101:17]
    temp_1_inst.io.op1.re <= io.in[0].re @[Modules.scala 101:17]
    temp_1_inst.io.op2.im <= io.in[1].im @[Modules.scala 102:17]
    temp_1_inst.io.op2.re <= io.in[1].re @[Modules.scala 102:17]
    temp[1] <= temp_1_inst.io.res @[Modules.scala 227:13]
    io.out[0] <= temp[0] @[Modules.scala 266:15]
    inst io_out_1_inst of ComplexMul @[Modules.scala 158:22]
    io_out_1_inst.clock <= clock
    io_out_1_inst.reset <= reset
    io_out_1_inst.io.op1.im <= temp[1].im @[Modules.scala 159:17]
    io_out_1_inst.io.op1.re <= temp[1].re @[Modules.scala 159:17]
    io_out_1_inst.io.op2.im <= io.wn[0].im @[Modules.scala 160:17]
    io_out_1_inst.io.op2.re <= io.wn[0].re @[Modules.scala 160:17]
    io.out[1] <= io_out_1_inst.io.res @[Modules.scala 267:15]

  module ComplexAdd_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip op1 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}, flip op2 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}, res : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}}

    node _io_res_re_T = asFixedPoint(io.op1.re, 16) @[Modules.scala 74:40]
    node _io_res_re_T_1 = asFixedPoint(io.op2.re, 16) @[Modules.scala 74:81]
    node _io_res_re_T_2 = add(_io_res_re_T, _io_res_re_T_1) @[Modules.scala 74:57]
    node _io_res_re_T_3 = tail(_io_res_re_T_2, 1) @[Modules.scala 74:57]
    node _io_res_re_T_4 = asFixedPoint(_io_res_re_T_3, 16) @[Modules.scala 74:57]
    io.res.re <= _io_res_re_T_4 @[Modules.scala 74:15]
    node _io_res_im_T = asFixedPoint(io.op1.im, 16) @[Modules.scala 75:40]
    node _io_res_im_T_1 = asFixedPoint(io.op2.im, 16) @[Modules.scala 75:81]
    node _io_res_im_T_2 = add(_io_res_im_T, _io_res_im_T_1) @[Modules.scala 75:57]
    node _io_res_im_T_3 = tail(_io_res_im_T_2, 1) @[Modules.scala 75:57]
    node _io_res_im_T_4 = asFixedPoint(_io_res_im_T_3, 16) @[Modules.scala 75:57]
    io.res.im <= _io_res_im_T_4 @[Modules.scala 75:15]

  module ComplexSub_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip op1 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}, flip op2 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}, res : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}}

    node _io_res_re_T = asFixedPoint(io.op1.re, 16) @[Modules.scala 93:40]
    node _io_res_re_T_1 = asFixedPoint(io.op2.re, 16) @[Modules.scala 93:81]
    node _io_res_re_T_2 = sub(_io_res_re_T, _io_res_re_T_1) @[Modules.scala 93:57]
    node _io_res_re_T_3 = tail(_io_res_re_T_2, 1) @[Modules.scala 93:57]
    node _io_res_re_T_4 = asFixedPoint(_io_res_re_T_3, 16) @[Modules.scala 93:57]
    io.res.re <= _io_res_re_T_4 @[Modules.scala 93:15]
    node _io_res_im_T = asFixedPoint(io.op1.im, 16) @[Modules.scala 94:40]
    node _io_res_im_T_1 = asFixedPoint(io.op2.im, 16) @[Modules.scala 94:81]
    node _io_res_im_T_2 = sub(_io_res_im_T, _io_res_im_T_1) @[Modules.scala 94:57]
    node _io_res_im_T_3 = tail(_io_res_im_T_2, 1) @[Modules.scala 94:57]
    node _io_res_im_T_4 = asFixedPoint(_io_res_im_T_3, 16) @[Modules.scala 94:57]
    io.res.im <= _io_res_im_T_4 @[Modules.scala 94:15]

  module ButterflyAdd :
    input clock : Clock
    input reset : Reset
    output io : { flip in : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2], out : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2]}

    inst io_out_0_inst of ComplexAdd_1 @[Modules.scala 81:22]
    io_out_0_inst.clock <= clock
    io_out_0_inst.reset <= reset
    io_out_0_inst.io.op1.im <= io.in[0].im @[Modules.scala 82:17]
    io_out_0_inst.io.op1.re <= io.in[0].re @[Modules.scala 82:17]
    io_out_0_inst.io.op2.im <= io.in[1].im @[Modules.scala 83:17]
    io_out_0_inst.io.op2.re <= io.in[1].re @[Modules.scala 83:17]
    io.out[0] <= io_out_0_inst.io.res @[Modules.scala 170:15]
    inst io_out_1_inst of ComplexSub_1 @[Modules.scala 100:22]
    io_out_1_inst.clock <= clock
    io_out_1_inst.reset <= reset
    io_out_1_inst.io.op1.im <= io.in[0].im @[Modules.scala 101:17]
    io_out_1_inst.io.op1.re <= io.in[0].re @[Modules.scala 101:17]
    io_out_1_inst.io.op2.im <= io.in[1].im @[Modules.scala 102:17]
    io_out_1_inst.io.op2.re <= io.in[1].re @[Modules.scala 102:17]
    io.out[1] <= io_out_1_inst.io.res @[Modules.scala 171:15]

  module Switch :
    input clock : Clock
    input reset : Reset
    output io : { flip in : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2], out : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2], flip sel : UInt<1>}

    wire _swdata_WIRE : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[Modules.scala 304:71]
    node _swdata_T = asUInt(asSInt(UInt<64>("h0"))) @[Modules.scala 304:71]
    wire _swdata_WIRE_1 : UInt<64> @[Modules.scala 304:71]
    _swdata_WIRE_1 <= _swdata_T @[Modules.scala 304:71]
    node _swdata_T_1 = bits(_swdata_WIRE_1, 31, 0) @[Modules.scala 304:71]
    node _swdata_T_2 = asFixedPoint(_swdata_T_1, 16) @[Modules.scala 304:71]
    _swdata_WIRE.im <= _swdata_T_2 @[Modules.scala 304:71]
    node _swdata_T_3 = bits(_swdata_WIRE_1, 63, 32) @[Modules.scala 304:71]
    node _swdata_T_4 = asFixedPoint(_swdata_T_3, 16) @[Modules.scala 304:71]
    _swdata_WIRE.re <= _swdata_T_4 @[Modules.scala 304:71]
    wire _swdata_WIRE_2 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[Modules.scala 304:71]
    node _swdata_T_5 = asUInt(asSInt(UInt<64>("h0"))) @[Modules.scala 304:71]
    wire _swdata_WIRE_3 : UInt<64> @[Modules.scala 304:71]
    _swdata_WIRE_3 <= _swdata_T_5 @[Modules.scala 304:71]
    node _swdata_T_6 = bits(_swdata_WIRE_3, 31, 0) @[Modules.scala 304:71]
    node _swdata_T_7 = asFixedPoint(_swdata_T_6, 16) @[Modules.scala 304:71]
    _swdata_WIRE_2.im <= _swdata_T_7 @[Modules.scala 304:71]
    node _swdata_T_8 = bits(_swdata_WIRE_3, 63, 32) @[Modules.scala 304:71]
    node _swdata_T_9 = asFixedPoint(_swdata_T_8, 16) @[Modules.scala 304:71]
    _swdata_WIRE_2.re <= _swdata_T_9 @[Modules.scala 304:71]
    wire swdata : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2] @[Modules.scala 304:23]
    swdata[0] <= _swdata_WIRE @[Modules.scala 304:23]
    swdata[1] <= _swdata_WIRE_2 @[Modules.scala 304:23]
    swdata[0] <= io.in[0] @[Modules.scala 305:38]
    reg swdata_1_r : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}, clock with :
      reset => (UInt<1>("h0"), swdata_1_r) @[Reg.scala 19:16]
    when UInt<1>("h1") : @[Reg.scala 20:18]
      swdata_1_r <= io.in[1] @[Reg.scala 20:22]
    swdata[1] <= swdata_1_r @[Modules.scala 305:38]
    wire _io_out_0_WIRE : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2] @[Modules.scala 302:12]
    _io_out_0_WIRE[0] <= swdata[0] @[Modules.scala 302:12]
    _io_out_0_WIRE[1] <= swdata[1] @[Modules.scala 302:12]
    reg io_out_0_r : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}, clock with :
      reset => (UInt<1>("h0"), io_out_0_r) @[Reg.scala 19:16]
    when UInt<1>("h1") : @[Reg.scala 20:18]
      io_out_0_r <= _io_out_0_WIRE[io.sel] @[Reg.scala 20:22]
    io.out[0] <= io_out_0_r @[Modules.scala 306:38]
    wire _io_out_1_WIRE : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2] @[Modules.scala 302:12]
    _io_out_1_WIRE[0] <= swdata[1] @[Modules.scala 302:12]
    _io_out_1_WIRE[1] <= swdata[0] @[Modules.scala 302:12]
    io.out[1] <= _io_out_1_WIRE[io.sel] @[Modules.scala 306:38]

  module FFT :
    input clock : Clock
    input reset : Reset
    output io : { flip dIn : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2], dOut : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2], flip din_valid : UInt<1>, dout_valid : UInt<1>, busy : UInt<1>}

    reg cnt_0 : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[FFT.scala 110:46]
    node busy = neq(cnt_0, UInt<1>("h0")) @[FFT.scala 114:21]
    node _T = or(io.din_valid, busy) @[FFT.scala 115:21]
    when _T : @[FFT.scala 115:30]
      node _cnt_0_T = eq(cnt_0, UInt<2>("h3")) @[FFT.scala 116:26]
      node _cnt_0_T_1 = add(cnt_0, UInt<1>("h1")) @[FFT.scala 116:87]
      node _cnt_0_T_2 = tail(_cnt_0_T_1, 1) @[FFT.scala 116:87]
      node _cnt_0_T_3 = mux(_cnt_0_T, UInt<1>("h0"), _cnt_0_T_2) @[FFT.scala 116:18]
      cnt_0 <= _cnt_0_T_3 @[FFT.scala 116:12]
    wire _data1_WIRE : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[FFT.scala 122:113]
    node _data1_T = asUInt(asSInt(UInt<64>("h0"))) @[FFT.scala 122:113]
    wire _data1_WIRE_1 : UInt<64> @[FFT.scala 122:113]
    _data1_WIRE_1 <= _data1_T @[FFT.scala 122:113]
    node _data1_T_1 = bits(_data1_WIRE_1, 31, 0) @[FFT.scala 122:113]
    node _data1_T_2 = asFixedPoint(_data1_T_1, 16) @[FFT.scala 122:113]
    _data1_WIRE.im <= _data1_T_2 @[FFT.scala 122:113]
    node _data1_T_3 = bits(_data1_WIRE_1, 63, 32) @[FFT.scala 122:113]
    node _data1_T_4 = asFixedPoint(_data1_T_3, 16) @[FFT.scala 122:113]
    _data1_WIRE.re <= _data1_T_4 @[FFT.scala 122:113]
    wire _data1_WIRE_2 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[FFT.scala 122:113]
    node _data1_T_5 = asUInt(asSInt(UInt<64>("h0"))) @[FFT.scala 122:113]
    wire _data1_WIRE_3 : UInt<64> @[FFT.scala 122:113]
    _data1_WIRE_3 <= _data1_T_5 @[FFT.scala 122:113]
    node _data1_T_6 = bits(_data1_WIRE_3, 31, 0) @[FFT.scala 122:113]
    node _data1_T_7 = asFixedPoint(_data1_T_6, 16) @[FFT.scala 122:113]
    _data1_WIRE_2.im <= _data1_T_7 @[FFT.scala 122:113]
    node _data1_T_8 = bits(_data1_WIRE_3, 63, 32) @[FFT.scala 122:113]
    node _data1_T_9 = asFixedPoint(_data1_T_8, 16) @[FFT.scala 122:113]
    _data1_WIRE_2.re <= _data1_T_9 @[FFT.scala 122:113]
    wire data1_0_0 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2] @[FFT.scala 122:65]
    data1_0_0[0] <= _data1_WIRE @[FFT.scala 122:65]
    data1_0_0[1] <= _data1_WIRE_2 @[FFT.scala 122:65]
    wire _data1_WIRE_4 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[FFT.scala 122:113]
    node _data1_T_10 = asUInt(asSInt(UInt<64>("h0"))) @[FFT.scala 122:113]
    wire _data1_WIRE_5 : UInt<64> @[FFT.scala 122:113]
    _data1_WIRE_5 <= _data1_T_10 @[FFT.scala 122:113]
    node _data1_T_11 = bits(_data1_WIRE_5, 31, 0) @[FFT.scala 122:113]
    node _data1_T_12 = asFixedPoint(_data1_T_11, 16) @[FFT.scala 122:113]
    _data1_WIRE_4.im <= _data1_T_12 @[FFT.scala 122:113]
    node _data1_T_13 = bits(_data1_WIRE_5, 63, 32) @[FFT.scala 122:113]
    node _data1_T_14 = asFixedPoint(_data1_T_13, 16) @[FFT.scala 122:113]
    _data1_WIRE_4.re <= _data1_T_14 @[FFT.scala 122:113]
    wire _data1_WIRE_6 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[FFT.scala 122:113]
    node _data1_T_15 = asUInt(asSInt(UInt<64>("h0"))) @[FFT.scala 122:113]
    wire _data1_WIRE_7 : UInt<64> @[FFT.scala 122:113]
    _data1_WIRE_7 <= _data1_T_15 @[FFT.scala 122:113]
    node _data1_T_16 = bits(_data1_WIRE_7, 31, 0) @[FFT.scala 122:113]
    node _data1_T_17 = asFixedPoint(_data1_T_16, 16) @[FFT.scala 122:113]
    _data1_WIRE_6.im <= _data1_T_17 @[FFT.scala 122:113]
    node _data1_T_18 = bits(_data1_WIRE_7, 63, 32) @[FFT.scala 122:113]
    node _data1_T_19 = asFixedPoint(_data1_T_18, 16) @[FFT.scala 122:113]
    _data1_WIRE_6.re <= _data1_T_19 @[FFT.scala 122:113]
    wire data1_1_0 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2] @[FFT.scala 122:65]
    data1_1_0[0] <= _data1_WIRE_4 @[FFT.scala 122:65]
    data1_1_0[1] <= _data1_WIRE_6 @[FFT.scala 122:65]
    wire _data2_WIRE : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[FFT.scala 123:117]
    node _data2_T = asUInt(asSInt(UInt<64>("h0"))) @[FFT.scala 123:117]
    wire _data2_WIRE_1 : UInt<64> @[FFT.scala 123:117]
    _data2_WIRE_1 <= _data2_T @[FFT.scala 123:117]
    node _data2_T_1 = bits(_data2_WIRE_1, 31, 0) @[FFT.scala 123:117]
    node _data2_T_2 = asFixedPoint(_data2_T_1, 16) @[FFT.scala 123:117]
    _data2_WIRE.im <= _data2_T_2 @[FFT.scala 123:117]
    node _data2_T_3 = bits(_data2_WIRE_1, 63, 32) @[FFT.scala 123:117]
    node _data2_T_4 = asFixedPoint(_data2_T_3, 16) @[FFT.scala 123:117]
    _data2_WIRE.re <= _data2_T_4 @[FFT.scala 123:117]
    wire _data2_WIRE_2 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[FFT.scala 123:117]
    node _data2_T_5 = asUInt(asSInt(UInt<64>("h0"))) @[FFT.scala 123:117]
    wire _data2_WIRE_3 : UInt<64> @[FFT.scala 123:117]
    _data2_WIRE_3 <= _data2_T_5 @[FFT.scala 123:117]
    node _data2_T_6 = bits(_data2_WIRE_3, 31, 0) @[FFT.scala 123:117]
    node _data2_T_7 = asFixedPoint(_data2_T_6, 16) @[FFT.scala 123:117]
    _data2_WIRE_2.im <= _data2_T_7 @[FFT.scala 123:117]
    node _data2_T_8 = bits(_data2_WIRE_3, 63, 32) @[FFT.scala 123:117]
    node _data2_T_9 = asFixedPoint(_data2_T_8, 16) @[FFT.scala 123:117]
    _data2_WIRE_2.re <= _data2_T_9 @[FFT.scala 123:117]
    wire data2_0_0 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2] @[FFT.scala 123:69]
    data2_0_0[0] <= _data2_WIRE @[FFT.scala 123:69]
    data2_0_0[1] <= _data2_WIRE_2 @[FFT.scala 123:69]
    wire _datao_WIRE : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[FFT.scala 124:86]
    node _datao_T = asUInt(asSInt(UInt<64>("h0"))) @[FFT.scala 124:86]
    wire _datao_WIRE_1 : UInt<64> @[FFT.scala 124:86]
    _datao_WIRE_1 <= _datao_T @[FFT.scala 124:86]
    node _datao_T_1 = bits(_datao_WIRE_1, 31, 0) @[FFT.scala 124:86]
    node _datao_T_2 = asFixedPoint(_datao_T_1, 16) @[FFT.scala 124:86]
    _datao_WIRE.im <= _datao_T_2 @[FFT.scala 124:86]
    node _datao_T_3 = bits(_datao_WIRE_1, 63, 32) @[FFT.scala 124:86]
    node _datao_T_4 = asFixedPoint(_datao_T_3, 16) @[FFT.scala 124:86]
    _datao_WIRE.re <= _datao_T_4 @[FFT.scala 124:86]
    wire _datao_WIRE_2 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[FFT.scala 124:86]
    node _datao_T_5 = asUInt(asSInt(UInt<64>("h0"))) @[FFT.scala 124:86]
    wire _datao_WIRE_3 : UInt<64> @[FFT.scala 124:86]
    _datao_WIRE_3 <= _datao_T_5 @[FFT.scala 124:86]
    node _datao_T_6 = bits(_datao_WIRE_3, 31, 0) @[FFT.scala 124:86]
    node _datao_T_7 = asFixedPoint(_datao_T_6, 16) @[FFT.scala 124:86]
    _datao_WIRE_2.im <= _datao_T_7 @[FFT.scala 124:86]
    node _datao_T_8 = bits(_datao_WIRE_3, 63, 32) @[FFT.scala 124:86]
    node _datao_T_9 = asFixedPoint(_datao_T_8, 16) @[FFT.scala 124:86]
    _datao_WIRE_2.re <= _datao_T_9 @[FFT.scala 124:86]
    wire datao : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2] @[FFT.scala 124:22]
    datao[0] <= _datao_WIRE @[FFT.scala 124:22]
    datao[1] <= _datao_WIRE_2 @[FFT.scala 124:22]
    node wnCtrl = bits(cnt_0, 0, 0) @[FFT.scala 131:23]
    node _wnList_T = add(UInt<1>("h0"), wnCtrl) @[FFT.scala 135:148]
    node _wnList_T_1 = tail(_wnList_T, 1) @[FFT.scala 135:148]
    wire wnList_0 : { re : Fixed<32><<16>>, im : Fixed<32><<16>>} @[FFT.scala 71:19]
    wire _wnList_res_re_WIRE : Fixed<32><<16>>[2] @[FFT.scala 68:12]
    _wnList_res_re_WIRE[0] <= asFixedPoint(UInt<32>("h10000"), 16) @[FFT.scala 68:12]
    _wnList_res_re_WIRE[1] <= asFixedPoint(UInt<32>("h0"), 16) @[FFT.scala 68:12]
    wnList_0.re <= _wnList_res_re_WIRE[_wnList_T_1] @[FFT.scala 72:12]
    wire _wnList_res_im_WIRE : Fixed<32><<16>>[2] @[FFT.scala 64:12]
    _wnList_res_im_WIRE[0] <= asFixedPoint(UInt<32>("h0"), 16) @[FFT.scala 64:12]
    _wnList_res_im_WIRE[1] <= asFixedPoint(UInt<32>("hffff0000"), 16) @[FFT.scala 64:12]
    wnList_0.im <= _wnList_res_im_WIRE[_wnList_T_1] @[FFT.scala 73:12]
    inst inst of ButterflyMul @[Modules.scala 287:22]
    inst.clock <= clock
    inst.reset <= reset
    inst.io.in[0].im <= data1_0_0[0].im @[Modules.scala 288:16]
    inst.io.in[0].re <= data1_0_0[0].re @[Modules.scala 288:16]
    inst.io.in[1].im <= data1_0_0[1].im @[Modules.scala 288:16]
    inst.io.in[1].re <= data1_0_0[1].re @[Modules.scala 288:16]
    inst.io.wn[0].im <= wnList_0.im @[Modules.scala 289:16]
    inst.io.wn[0].re <= wnList_0.re @[Modules.scala 289:16]
    data2_0_0 <= inst.io.out @[FFT.scala 136:19]
    inst dataotemp_inst of ButterflyAdd @[Modules.scala 213:22]
    dataotemp_inst.clock <= clock
    dataotemp_inst.reset <= reset
    dataotemp_inst.io.in[0].im <= data1_1_0[0].im @[Modules.scala 214:16]
    dataotemp_inst.io.in[0].re <= data1_1_0[0].re @[Modules.scala 214:16]
    dataotemp_inst.io.in[1].im <= data1_1_0[1].im @[Modules.scala 214:16]
    dataotemp_inst.io.in[1].re <= data1_1_0[1].re @[Modules.scala 214:16]
    datao[0] <= dataotemp_inst.io.out[0] @[FFT.scala 141:9]
    datao[1] <= dataotemp_inst.io.out[1] @[FFT.scala 141:9]
    node sel = bits(cnt_0, 0, 0) @[FFT.scala 163:31]
    inst inst_1 of Switch @[Modules.scala 311:22]
    inst_1.clock <= clock
    inst_1.reset <= reset
    inst_1.io.in[0].im <= data2_0_0[0].im @[Modules.scala 312:16]
    inst_1.io.in[0].re <= data2_0_0[0].re @[Modules.scala 312:16]
    inst_1.io.in[1].im <= data2_0_0[1].im @[Modules.scala 312:16]
    inst_1.io.in[1].re <= data2_0_0[1].re @[Modules.scala 312:16]
    inst_1.io.sel <= sel @[Modules.scala 313:17]
    data1_1_0 <= inst_1.io.out @[FFT.scala 164:54]
    data1_0_0[0] <= io.dIn[0] @[FFT.scala 175:19]
    data1_0_0[1] <= io.dIn[1] @[FFT.scala 175:19]
    io.busy <= busy @[FFT.scala 178:11]
    reg io_dout_valid_REG : UInt, clock with :
      reset => (UInt<1>("h0"), io_dout_valid_REG) @[FFT.scala 179:27]
    io_dout_valid_REG <= cnt_0 @[FFT.scala 179:27]
    node _io_dout_valid_T = eq(io_dout_valid_REG, UInt<1>("h1")) @[FFT.scala 179:36]
    io.dout_valid <= _io_dout_valid_T @[FFT.scala 179:17]
    reg REG : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2], clock with :
      reset => (UInt<1>("h0"), REG) @[FFT.scala 184:23]
    REG <= datao @[FFT.scala 184:23]
    io.dOut <= REG @[FFT.scala 184:13]

  module FFTtop :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dIn : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2], dOut : { re : Fixed<32><<16>>, im : Fixed<32><<16>>}[2], flip din_valid : UInt<1>, dout_valid : UInt<1>, busy : UInt<1>}

    inst fft of FFT @[Top.scala 15:19]
    fft.clock <= clock
    fft.reset <= reset
    fft.io.dIn[0].im <= io.dIn[0].im @[Top.scala 16:14]
    fft.io.dIn[0].re <= io.dIn[0].re @[Top.scala 16:14]
    fft.io.dIn[1].im <= io.dIn[1].im @[Top.scala 16:14]
    fft.io.dIn[1].re <= io.dIn[1].re @[Top.scala 16:14]
    fft.io.din_valid <= io.din_valid @[Top.scala 17:20]
    io.dOut <= fft.io.dOut @[Top.scala 27:13]
    io.dout_valid <= fft.io.dout_valid @[Top.scala 28:19]
    io.busy <= fft.io.busy @[Top.scala 29:13]

