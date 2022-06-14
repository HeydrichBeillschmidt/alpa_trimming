module attributes {hlo.unique_id = 35 : i32, mhlo.unique_id = 35 : i64} {
  func @main.6(%arg0: memref<65536xi8> {lmhlo.params = 0 : index}, %arg1: memref<4xi8> {lmhlo.params = 1 : index}, %arg2: memref<65536xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "f32[128,128]{1,0}"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<65536xi8> to memref<128x128xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<4xi8> to memref<i32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg2[%c0_1][] : memref<65536xi8> to memref<128x128xf32>
    "lmhlo.fusion"() ({
      %3 = bufferization.to_tensor %0 : memref<128x128xf32>
      %4 = bufferization.to_tensor %1 : memref<i32>
      %5 = "mhlo.convert"(%4) : (tensor<i32>) -> tensor<f32>
      %6 = "mhlo.broadcast_in_dim"(%5) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<128x128xf32>
      %7 = mhlo.add %3, %6 : tensor<128x128xf32>
      memref.tensor_store %7, %2 : memref<128x128xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}