module attributes {hlo.unique_id = 52 : i32, mhlo.unique_id = 52 : i64} {
  func @main.4(%arg0: memref<4xi8> {lmhlo.params = 0 : index}, %arg1: memref<4xi8> {lmhlo.params = 1 : index}, %arg2: memref<4xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "f32[]"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<4xi8> to memref<f32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<4xi8> to memref<f32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg2[%c0_1][] : memref<4xi8> to memref<f32>
    "lmhlo.fusion"() ({
      %3 = bufferization.to_tensor %0 : memref<f32>
      %4 = bufferization.to_tensor %1 : memref<f32>
      %5 = mhlo.divide %3, %4 : tensor<f32>
      memref.tensor_store %5, %2 : memref<f32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}