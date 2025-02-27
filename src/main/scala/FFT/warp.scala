package FFT

import chisel3._
import chisel3.util._
import chisel3.util.{switch, is}

import chisel3.stage.ChiselStage
/*
* This module implements a 64-point FFT module
* The input is the address of the 64 complex numbers which are IEEE 32bit single precision floating point format

* For example:
* The first input data point is 1+2j and the address is 0x0
* address 0x0: 00111111100000000000000000000000(1.0)
* address 0x4: 01000000000000000000000000000000(2.0)
* ....


* Parameters:
	-  (64-bit) address
*/

/* 
description :
	data sample vector : 64 * (32 + 32) bit
	This module implements a 64-point FFT module
	The input is the address of the 64 complex numbers with real and imaginary parts being IEEE 32bit single precision floating point numbers

pargs:
| vector address(64bit) |

ags_len: 8 byte (constant)


* for example:
	* Assume the first input data point is 1+2j and the vector address is 0x0
	* address 0x0-0x3: 00111111100000000000000000000000(1.0)
	* address 0x4-0x7: 01000000000000000000000000000000(2.0)
	* ...
	* ...

    * Assume the value of pres : 0xf0000000 and the output of fft is -1+2j
	* address 0xf0000000-0xf0000003: 10111111100000000000000000000000(-1.0)
	* address 0xf0000004-0xf0000007: 01000000000000000000000000000000(2.0)


 */

class fft_wrap extends Module with Config{
	val io = IO(new Bundle{
		val start  		= Input(UInt(1.W))
		val done 		= Output(UInt(1.W))
		val pargs 		= Input(UInt(64.W))
    	val pdata 		= Input(UInt(64.W))
		val pres 		= Input(UInt(64.W))
		val args_len 	= Input(UInt(32.W))
		val data_len 	= Input(UInt(32.W))
		val ap_return 	= Output(UInt(32.W))
		 
		val m_axi_gmem_AWADDR    = Output(UInt(64.W))
        val m_axi_gmem_AWLEN     = Output(UInt(8.W))
        val m_axi_gmem_AWSIZE    = Output(UInt(3.W))
        val m_axi_gmem_AWBURST   = Output(UInt(2.W))
        val m_axi_gmem_AWLOCK    = Output(UInt(2.W))
        val m_axi_gmem_AWREGION  = Output(UInt(4.W))
        val m_axi_gmem_AWCACHE   = Output(UInt(4.W))
        val m_axi_gmem_AWPROT    = Output(UInt(3.W))
        val m_axi_gmem_AWQOS     = Output(UInt(4.W))
        val m_axi_gmem_AWVALID   = Output(UInt(1.W))
        val m_axi_gmem_AWREADY   = Input(UInt(1.W))
        val m_axi_gmem_WDATA     = Output(UInt(256.W))
        val m_axi_gmem_WSTRB     = Output(UInt(32.W))
        val m_axi_gmem_WLAST     = Output(UInt(1.W))
        val m_axi_gmem_WVALID    = Output(UInt(1.W))
        val m_axi_gmem_WREADY    = Input(UInt(1.W))
        val m_axi_gmem_BRESP     = Input(UInt(2.W))
        val m_axi_gmem_BVALID    = Input(UInt(1.W))
        val m_axi_gmem_BREADY    = Output(UInt(1.W))
        val m_axi_gmem_ARADDR    = Output(UInt(64.W))
        val m_axi_gmem_ARLEN     = Output(UInt(8.W))
        val m_axi_gmem_ARSIZE    = Output(UInt(3.W))
        val m_axi_gmem_ARBURST   = Output(UInt(2.W))
        val m_axi_gmem_ARLOCK    = Output(UInt(2.W))
        val m_axi_gmem_ARREGION  = Output(UInt(4.W))
        val m_axi_gmem_ARCACHE   = Output(UInt(4.W))
        val m_axi_gmem_ARPROT    = Output(UInt(3.W))
        val m_axi_gmem_ARQOS     = Output(UInt(4.W))
        val m_axi_gmem_ARVALID   = Output(UInt(1.W))
        val m_axi_gmem_ARREADY   = Input(UInt(1.W))
        val m_axi_gmem_RDATA     = Input(UInt(256.W))
        val m_axi_gmem_RRESP     = Input(UInt(2.W))
        val m_axi_gmem_RLAST     = Input(UInt(1.W))
        val m_axi_gmem_RVALID    = Input(UInt(1.W))
        val m_axi_gmem_RREADY    = Output(UInt(1.W))
		 
	})

	val startreg1 = RegInit(1.U(1.W))
	val signal_addr = Reg(UInt(64.W))


	io.ap_return := 0.U
	startreg1 := io.start
	//state machine 1: total control
	//val s_waiting :: s_computing :: s_computing_done :: Nil = Enum(3)
	val s1_0 :: s1_1 :: s1_2 :: s1_3 :: Nil = Enum(4)

	val state1 = RegInit(s1_0)
	var compute_done = Wire(UInt(1.W))

	switch(state1){
		is(s1_0){
			when(startreg1 === 0.U && io.start === 1.U){   // at start rising edge
				state1:=s1_1
			}
		}
		is(s1_1){
			when(io.m_axi_gmem_ARVALID ===1.U && io.m_axi_gmem_ARREADY === 1.U ){
				state1:=s1_2 
			}
		}
		// Q:2 Why do not it change?
		is(s1_2){ // start reading vector addr
			when(io.m_axi_gmem_RVALID ===1.U && io.m_axi_gmem_RREADY === 1.U && io.m_axi_gmem_RLAST === 1.U){
				state1:=s1_3 // read donw
			}
		}
		is(s1_3){
			when(compute_done=== 1.U ){
				state1:=s1_0
			}
		}
	}
	
	when((state1 === s1_2 )&& io.m_axi_gmem_RREADY === 1.U && io.m_axi_gmem_RVALID === 1.U){
		signal_addr := io.m_axi_gmem_RDATA(63,0)
	}
	when(state1 === s1_0){
		io.done := 1.U
	}.otherwise{
		io.done := 0.U
	}

	
	// Wait for FFT computing
	// res

	val s3_1 :: s3_2 :: s3_3 :: Nil = Enum(3)
	val state3 = RegInit(s3_1)


	// state machine 2: computing
	val s1 :: s2 :: s3 :: s4  :: Nil = Enum(4)
	val state2 = RegInit(s1)
	val result = Wire(UInt(256.W))

	val cnt = RegInit(16.U(32.W))

	switch(state2){
		is(s1){
			when(state1 === s1_3 && io.m_axi_gmem_ARVALID === 1.U && io.m_axi_gmem_ARREADY === 1.U){ 
				state2:=s2 // read data address
			}
		}
		is(s2){
			when(io. m_axi_gmem_RVALID === 1.U && io. m_axi_gmem_RREADY  === 1.U && io.m_axi_gmem_RLAST === 1.U){
				state2:=s3 // read data done
			}
		}
		is(s3){
			when(state3 === s3_3){
				state2:=s4
			}
		}
		is(s4){
			when(state1 === s1_1 ){
				state2:=s1
			}
		}
	}

    /* Compute process*/
    val FFTtop_u = Module(new FFT)
	val last_busy = RegNext(FFTtop_u.io.busy)




	val res_r = Wire(UInt(1.W))
	res_r := (last_busy === 1.U && FFTtop_u.io.busy === 0.U)
	val res_valid = Wire(UInt(1.W))
	res_valid := (res_r === 1.U || state3 === s3_2)

	switch(state3){
		is(s3_1){ // Compute done
			when(last_busy === 1.U && FFTtop_u.io.busy === 0.U){ 
				state3 := s3_2;
			}
		}
		is(s3_2) {
			when(cnt === 1.U){
				state3 := s3_3
			}
		}
		is(s3_3){
			when (state2 === s4){
				state3 := s3_1
			}
		}
	}

	
	when(state2 === s4){
		compute_done := 1.U
	}.otherwise{
		compute_done := 0.U
	}

	io.m_axi_gmem_BREADY := 1.U
	
	when(state1 === s1_1 || state2 === s1){
		io.m_axi_gmem_ARVALID := 1.U
	}.otherwise{
		io.m_axi_gmem_ARVALID := 0.U
	}

	when(state1 === s1_2 || state2 === s2){
		io.m_axi_gmem_RREADY := 1.U
	}.otherwise{
		io.m_axi_gmem_RREADY := 0.U
	}
	
	when(state2 === s3 && state3 === s3_2){//算完了，可以写
		io.m_axi_gmem_AWVALID := 1.U
		io.m_axi_gmem_WVALID := 1.U
	}.otherwise{
		io.m_axi_gmem_AWVALID := 0.U
		io.m_axi_gmem_WVALID := 0.U
	}



	val arglen = Wire(UInt(32.W))
	arglen := io.args_len
	io.m_axi_gmem_ARADDR := Mux((state1 === s1_3),signal_addr,io.pargs)  //io.pargs    //todo : length need to be checked
	io.m_axi_gmem_ARBURST := 1.U
	io.m_axi_gmem_ARCACHE := 0.U
	/*total:64*8byte*/
	io.m_axi_gmem_ARLEN  := Mux((state1 === s1_3),((16.U) -1.U ),(0.U) )
	io.m_axi_gmem_ARLOCK := 0.U
	io.m_axi_gmem_ARSIZE := 5.U  // 32 bytes
	io.m_axi_gmem_ARPROT := 0.U
	io.m_axi_gmem_ARQOS := 0.U
	io.m_axi_gmem_ARREGION := 0.U

	io.m_axi_gmem_AWADDR := io.pres
	io.m_axi_gmem_AWBURST := 1.U
	io.m_axi_gmem_AWCACHE := 0.U
	io.m_axi_gmem_AWLEN := 0.U
	io.m_axi_gmem_AWLOCK := 0.U
	io.m_axi_gmem_AWSIZE := 5.U
	io.m_axi_gmem_AWPROT := 0.U
	io.m_axi_gmem_AWQOS := 0.U
	io.m_axi_gmem_AWREGION := 0.U

	io.m_axi_gmem_WDATA  := result
	io.m_axi_gmem_WSTRB := "hffffffff".U(32.W)
	val wlast = RegInit(0.U(1.W))
	io.m_axi_gmem_WLAST  := wlast
	

	val din_valid_v = Wire(UInt(1.W))
	FFTtop_u.io.din_valid := din_valid_v
	val is_first_in = RegInit(1.U(1.W))
    when(din_valid_v === 1.U && state2 === s2){
		is_first_in := 0.U
    }
	din_valid_v :=  ((state2 === s2 )&& io.m_axi_gmem_RREADY === 1.U && io.m_axi_gmem_RVALID === 1.U)  
	when(state2 === s3){
		is_first_in := 1.U
	}

	val re1 = RegInit(32.U(32.W))
	val im1 = RegInit(0.U(32.W))
	FFTtop_u.io.dIn(0).re := io.m_axi_gmem_RDATA(31,0)
	FFTtop_u.io.dIn(0).im := io.m_axi_gmem_RDATA(63,32)
	FFTtop_u.io.dIn(1).re := io.m_axi_gmem_RDATA(95,64)
	FFTtop_u.io.dIn(1).im := io.m_axi_gmem_RDATA(127,96)
	FFTtop_u.io.dIn(2).re := io.m_axi_gmem_RDATA(95,64)
	FFTtop_u.io.dIn(2).im := io.m_axi_gmem_RDATA(127,96)
	FFTtop_u.io.dIn(3).re := io.m_axi_gmem_RDATA(95,64)
	FFTtop_u.io.dIn(3).im := io.m_axi_gmem_RDATA(127,96)
	
	


	val vec_entry = RegInit(VecInit(Seq.fill(8)(0.U(32.W))))
	/* WB */
	// 结果是否正确返回
	when ((res_valid === 1.U) && state2 === s3){ {
		vec_entry(0) := FFTtop_u.io.dOut(0).re
		vec_entry(1) := FFTtop_u.io.dOut(0).im
		vec_entry(2) := FFTtop_u.io.dOut(1).re
		vec_entry(3) := FFTtop_u.io.dOut(1).im
		vec_entry(4) := FFTtop_u.io.dOut(2).re
		vec_entry(5) := FFTtop_u.io.dOut(2).im
		vec_entry(6) := FFTtop_u.io.dOut(3).re
		vec_entry(7) := FFTtop_u.io.dOut(3).im
		cnt := cnt - 1.U
	}}

	when(cnt === 2.U){
		wlast := 1.U
	}.otherwise{
		wlast := 0.U
	}
	result := Cat(vec_entry(7),vec_entry(6),vec_entry(5),vec_entry(4),vec_entry(3),vec_entry(2),vec_entry(1),vec_entry(0))

	when(state2 === s1){
		vec_entry(0) := 0.U(32.W)
		vec_entry(1) := 0.U(32.W)
		vec_entry(2) := 0.U(32.W)
		vec_entry(3) := 0.U(32.W)
		vec_entry(4) := 0.U(32.W)
		vec_entry(5) := 0.U(32.W)
		vec_entry(6) := 0.U(32.W)
		vec_entry(7) := 0.U(32.W)
	}


}
object Warpgenerator extends App with Config {
  (new ChiselStage).emitVerilog(new fft_wrap,Array("--target-dir",s"generated/${FFTlength}Point_${FFTparallel}parallel_${use_float}float_${DataWidth-1}width/fft_wrap"))
}

