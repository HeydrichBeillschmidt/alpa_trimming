module attributes {hlo.unique_id = 10 : i32, mhlo.unique_id = 10 : i64} {
  func @main.3(%arg0: memref<4xi8> {lmhlo.params = 0 : index}, %arg1: memref<262144xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "f32[64,256,4]{2,1,0}"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<4xi8> to memref<f32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<262144xi8> to memref<64x256x4xf32>
    "lmhlo.fusion"() ({
      %2 = bufferization.to_tensor %0 : memref<f32>
      %3 = "mhlo.broadcast_in_dim"(%2) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<64x256x4xf32>
      memref.tensor_store %3, %1 : memref<64x256x4xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}