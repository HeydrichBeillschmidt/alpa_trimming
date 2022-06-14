module attributes {hlo.unique_id = 3 : i32, mhlo.unique_id = 3 : i64} {
  func @add_one_shard_parallel.7_spmd(%arg0: memref<16384xi8> {lmhlo.output_index = dense<0> : tensor<1xi64>, lmhlo.params = 0 : index}) attributes {result_xla_shape = "(f32[32,128]{1,0})"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<16384xi8> to memref<32x128xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg0[%c0_0][] : memref<16384xi8> to memref<32x128xf32>
    "lmhlo.fusion"() ({
      %2 = bufferization.to_tensor %0 : memref<32x128xf32>
      %3 = mhlo.constant dense<1.000000e+00> : tensor<f32>
      %4 = "mhlo.broadcast_in_dim"(%3) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<32x128xf32>
      %5 = mhlo.add %2, %4 : tensor<32x128xf32>
      memref.tensor_store %5, %1 : memref<32x128xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}