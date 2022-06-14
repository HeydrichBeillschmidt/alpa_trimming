module attributes {hlo.unique_id = 48 : i32, mhlo.unique_id = 48 : i64} {
  func @main.4(%arg0: memref<4xi8> {lmhlo.params = 0 : index}, %arg1: memref<4xi8> {lmhlo.params = 1 : index}, %arg2: memref<8xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "u32[2]{0}"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<4xi8> to memref<1xui32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<4xi8> to memref<1xui32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg2[%c0_1][] : memref<8xi8> to memref<2xui32>
    "lmhlo.fusion"() ({
      %3 = bufferization.to_tensor %0 : memref<1xui32>
      %4 = bufferization.to_tensor %1 : memref<1xui32>
      %5 = "mhlo.concatenate"(%3, %4) {dimension = 0 : i64} : (tensor<1xui32>, tensor<1xui32>) -> tensor<2xui32>
      memref.tensor_store %5, %2 : memref<2xui32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}