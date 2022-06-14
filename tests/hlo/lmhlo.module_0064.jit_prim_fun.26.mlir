module attributes {hlo.unique_id = 64 : i32, mhlo.unique_id = 64 : i64} {
  func @main.5(%arg0: memref<64xi8> {lmhlo.params = 0 : index}, %arg1: memref<4xi8> {lmhlo.params = 1 : index}, %arg2: memref<16xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "pred[16]{0}"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<64xi8> to memref<16xi32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<4xi8> to memref<i32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg2[%c0_1][] : memref<16xi8> to memref<16xi1>
    "lmhlo.fusion"() ({
      %3 = bufferization.to_tensor %0 : memref<16xi32>
      %4 = bufferization.to_tensor %1 : memref<i32>
      %5 = "mhlo.broadcast_in_dim"(%4) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<i32>) -> tensor<16xi32>
      %6 = "mhlo.compare"(%3, %5) {comparison_direction = #mhlo<"comparison_direction LT">} : (tensor<16xi32>, tensor<16xi32>) -> tensor<16xi1>
      memref.tensor_store %6, %2 : memref<16xi1>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}