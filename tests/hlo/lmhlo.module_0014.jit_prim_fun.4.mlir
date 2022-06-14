module attributes {hlo.unique_id = 14 : i32, mhlo.unique_id = 14 : i64} {
  func @main.3(%arg0: memref<262144xi8> {lmhlo.params = 0 : index}, %arg1: memref<262144xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "f32[64,4,256]{2,1,0}"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<262144xi8> to memref<64x256x4xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<262144xi8> to memref<64x4x256xf32>
    "lmhlo.fusion"() ({
      %2 = bufferization.to_tensor %0 : memref<64x256x4xf32>
      %3 = "mhlo.copy"(%2) {xla_shape = "f32[64,256,4]{1,2,0}"} : (tensor<64x256x4xf32>) -> tensor<64x256x4xf32>
      %4 = "mhlo.transpose"(%3) {permutation = dense<[0, 2, 1]> : tensor<3xi64>} : (tensor<64x256x4xf32>) -> tensor<64x4x256xf32>
      memref.tensor_store %4, %1 : memref<64x4x256xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}