module attributes {hlo.unique_id = 132 : i32, mhlo.unique_id = 132 : i64} {
  func @add_one_shard_parallel__2.6_spmd(%arg0: memref<1024xi8> {lmhlo.params = 0 : index}, %arg1: memref<1024xi8> {lmhlo.params = 1 : index}, %arg2: memref<1024xi8> {lmhlo.output_index = dense<0> : tensor<1xi64>}) attributes {result_xla_shape = "(f32[8,32]{1,0})"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<1024xi8> to memref<8x32xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<1024xi8> to memref<8x32xf32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg2[%c0_1][] : memref<1024xi8> to memref<8x32xf32>
    "lmhlo.fusion"() ({
      %3 = bufferization.to_tensor %0 : memref<8x32xf32>
      %4 = bufferization.to_tensor %1 : memref<8x32xf32>
      %5 = mhlo.add %3, %4 : tensor<8x32xf32>
      memref.tensor_store %5, %2 : memref<8x32xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}