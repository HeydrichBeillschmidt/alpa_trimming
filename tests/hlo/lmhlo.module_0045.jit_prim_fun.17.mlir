module attributes {hlo.unique_id = 45 : i32, mhlo.unique_id = 45 : i64} {
  func @main.3(%arg0: memref<4xi8> {lmhlo.params = 0 : index}, %arg1: memref<4xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "u32[1]{0}"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<4xi8> to memref<1xui32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<4xi8> to memref<1xui32>
    "lmhlo.fusion"() ({
      %2 = bufferization.to_tensor %0 : memref<1xui32>
      %3 = "mhlo.copy"(%2) : (tensor<1xui32>) -> tensor<1xui32>
      memref.tensor_store %3, %1 : memref<1xui32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}