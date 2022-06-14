module attributes {hlo.unique_id = 22 : i32, mhlo.unique_id = 22 : i64} {
  func @func_shard_parallel.10_spmd(%arg0: memref<262144xi8> {lmhlo.params = 0 : index}, %arg1: memref<65536xi8> {lmhlo.params = 1 : index}, %arg2: memref<4096xi8> {lmhlo.output_index = dense<0> : tensor<1xi64>}, %arg3: memref<262144xi8>) attributes {result_xla_shape = "(f32[64,16]{1,0})"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<262144xi8> to memref<64x256x4xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg3[%c0_0][] : memref<262144xi8> to memref<64x1024xf32>
    "lmhlo.fusion"() ({
      %5 = bufferization.to_tensor %0 : memref<64x256x4xf32>
      %6 = "mhlo.transpose"(%5) {permutation = dense<[0, 2, 1]> : tensor<3xi64>, xla_shape = "f32[64,4,256]{1,2,0}"} : (tensor<64x256x4xf32>) -> tensor<64x4x256xf32>
      %7 = "mhlo.copy"(%6) : (tensor<64x4x256xf32>) -> tensor<64x4x256xf32>
      %8 = "mhlo.bitcast"(%7) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<[2, 1, 0]> : tensor<3xindex>} : (tensor<64x4x256xf32>) -> tensor<64x1024xf32>
      memref.tensor_store %8, %1 : memref<64x1024xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg1[%c0_1][] : memref<65536xi8> to memref<1024x16xf32>
    %c0_2 = arith.constant 0 : index
    %3 = memref.view %arg2[%c0_2][] : memref<4096xi8> to memref<64x16xf32>
    "lmhlo_gpu.gemm"(%1, %2, %3) {algorithm = 21 : i64, alpha_imag = 0.000000e+00 : f64, alpha_real = 1.000000e+00 : f64, batch_size = 1 : i64, dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [1], rhs_contracting_dimensions = [0]>, lhs_stride = 65536 : i64, rhs_stride = 16384 : i64} : (memref<64x1024xf32>, memref<1024x16xf32>, memref<64x16xf32>) -> ()
    %c0_3 = arith.constant 0 : index
    %4 = memref.view %arg2[%c0_3][] : memref<4096xi8> to memref<64x16xf32>
    "lmhlo.fusion"() ({
      %5 = bufferization.to_tensor %3 : memref<64x16xf32>
      %6 = "mhlo.negate"(%5) : (tensor<64x16xf32>) -> tensor<64x16xf32>
      memref.tensor_store %6, %4 : memref<64x16xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}