module attributes {hlo.unique_id = 80 : i32, mhlo.unique_id = 80 : i64} {
  func @main.4(%arg0: memref<16384xi8> {lmhlo.params = 0 : index}, %arg1: memref<1024xi8> {lmhlo.params = 1 : index}, %arg2: memref<16384xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "f32[256,16]{1,0}"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<16384xi8> to memref<256x16xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<1024xi8> to memref<16x16xf32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg2[%c0_1][] : memref<16384xi8> to memref<256x16xf32>
    "lmhlo_gpu.gemm"(%0, %1, %2) {algorithm = -1 : i64, alpha_imag = 0.000000e+00 : f64, alpha_real = 1.000000e+00 : f64, batch_size = 1 : i64, dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [1], rhs_contracting_dimensions = [0]>, lhs_stride = 4096 : i64, rhs_stride = 256 : i64} : (memref<256x16xf32>, memref<16x16xf32>, memref<256x16xf32>) -> ()
    "lmhlo.terminator"() : () -> ()
  }
}