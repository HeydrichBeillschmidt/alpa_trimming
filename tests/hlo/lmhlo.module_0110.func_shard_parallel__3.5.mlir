module attributes {hlo.unique_id = 110 : i32, mhlo.unique_id = 110 : i64} {
  func @func_shard_parallel__3.5_spmd(%arg0: memref<144xi8> {lmhlo.params = 0 : index}, %arg1: memref<144xi8> {lmhlo.output_index = dense<0> : tensor<1xi64>}) attributes {result_xla_shape = "(f32[2,18]{1,0})"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<144xi8> to memref<2x18xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<144xi8> to memref<2x18xf32>
    "lmhlo.fusion"() ({
      %2 = bufferization.to_tensor %0 : memref<2x18xf32>
      %3 = "mhlo.copy"(%2) : (tensor<2x18xf32>) -> tensor<2x18xf32>
      memref.tensor_store %3, %1 : memref<2x18xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}