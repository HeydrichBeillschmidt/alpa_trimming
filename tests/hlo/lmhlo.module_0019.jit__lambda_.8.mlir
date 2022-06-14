module attributes {hlo.unique_id = 19 : i32, mhlo.unique_id = 19 : i64} {
  func @main.3(%arg0: memref<16384xi8> {lmhlo.params = 0 : index}, %arg1: memref<16384xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "f32[64,64]{1,0}"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<16384xi8> to memref<64x64xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<16384xi8> to memref<64x64xf32>
    "lmhlo.fusion"() ({
      %2 = bufferization.to_tensor %0 : memref<64x64xf32>
      %3 = "mhlo.negate"(%2) : (tensor<64x64xf32>) -> tensor<64x64xf32>
      memref.tensor_store %3, %1 : memref<64x64xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}