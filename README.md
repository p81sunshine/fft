# Chisel FFT-Generator

## Interface (By Liu Jiaxing)

- The interface file is : `src/scala/FFT/warp.scala` .
- The generated file is : `generated/64Point_1parallel_truefloat_32width/fft_wrap/fft_wrap.v`

## Usage

```sbt
sbt
run
# Then choose option 2 to run
```

## original README

This Chisel project implements a R2MDC (Radix-2 Multipath Delay Commutator) FFT hardware design, and the source and test files are organized as follows.

```
src/
  main/
    scala/
      FFT/ <Chisel的源代码文件>
        Modules.scala
        Config.scala
        FFT.scala
        Float.scala
        generator.scala
        reorder.scala
        Top.scala
        wrap.scala : 适配接口
  test/
    scala/
      FFT/ <Chisel的测试代码文件>
        FFTTest.scala
```
