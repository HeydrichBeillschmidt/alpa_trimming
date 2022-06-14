module attributes {hlo.unique_id = 46 : i32, mhlo.unique_id = 46 : i64} {
  func @main.5(%arg0: memref<4xi8> {lmhlo.params = 0 : index}, %arg1: memref<4xi8> {lmhlo.params = 1 : index}, %arg2: memref<4xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "s32[]"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<4xi8> to memref<i32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<4xi8> to memref<ui32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg2[%c0_1][] : memref<4xi8> to memref<i32>
    "lmhlo.fusion"() ({
      %3 = bufferization.to_tensor %0 : memref<i32>
      %4 = bufferization.to_tensor %1 : memref<ui32>
      %5 = "mhlo.convert"(%4) : (tensor<ui32>) -> tensor<i32>
      %6 = mhlo.and %3, %5 : tensor<i32>
      memref.tensor_store %6, %2 : memref<i32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}