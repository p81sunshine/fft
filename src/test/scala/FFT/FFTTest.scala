package FFT

import chisel3.iotesters
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}
import chisel3.util._
import scala.math._
import chisel3._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}

class Complex(val re: Double, val im: Double) {
  def +(rhs: Complex): Complex = new Complex(re + rhs.re, im + rhs.im)
  def -(rhs: Complex): Complex = new Complex(re - rhs.re, im - rhs.im)
  def *(rhs: Complex): Complex = new Complex(re * rhs.re - im * rhs.im, rhs.re * im + re * rhs.im)
  //def r = re

  def magnitude: Double = hypot(re, im)
  def phase: Double = atan2(im, re)

  override def toString: String = s"Complex($re, $im)"
}
class FFTtopTester(c: FFTtop) extends PeekPokeTester(c) {

  val inputs = Seq.fill(4){
    new IEEEComplex()
  }
  // for (i <- 0 until 4) {
  //   inputs(i).re := RegNext(i.U)
  //   inputs(i).im := RegNext(0.U)
  // }

  // 设置无效的din_valid
  poke(c.io.din_valid, false.B)
  step(1)

  // 设置输入
  for (i <- 0 until 2) {
    poke(c.io.dIn(i).re, i.U)
    poke(c.io.dIn(i).im, 0.U)
  }

  poke(c.io.din_valid, true.B)
  step(1)

  for (i <- 0 until 2) {
    poke(c.io.dIn(i).re, i.U)
    poke(c.io.dIn(i).im, 0.U)
  }

  // 设置din_valid有效
  poke(c.io.din_valid, true.B)

  // 等待运算完成
  while (peek(c.io.busy).toInt > 0) {
    step(1)
  }
  poke(c.io.din_valid, false.B)

  // 预期输出的计算在此处根据具体的FFT算法实现

  // 检查输出
  // for (i <- 0 until 4) {
  //   // printf("dOut(%d) = %f + %fi\n", i, peek(c.io.dOut(i).re).toFloat, peek(c.io.dOut(i).im).toFloat);
  //   printf(p"$i\n");
  // }
}

object FFTTestMain extends App {
  iotesters.Driver.execute(args, () => new FFTtop) {
    c => new FFTtopTester(c)
  }
}

