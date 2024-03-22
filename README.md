# Chisel FFT-Generator

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
        wrap.scala
  test/
    scala/
      FFT/ <Chisel的测试代码文件>
        FFTTest.scala
```

## 适配接口（LJX）

接口是 warp.scala 文件，生成的文件是： generated/64Point_1parallel_truefloat_32width/fft_wrap/fft_wrap.v
