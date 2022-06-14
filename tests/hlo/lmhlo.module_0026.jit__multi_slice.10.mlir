module attributes {hlo.unique_id = 26 : i32, mhlo.unique_id = 26 : i64} {
  func @main.7(%arg0: memref<262144xi8> {lmhlo.params = 0 : index}, %arg1: memref<65536xi8> {lmhlo.output_index = dense<0> : tensor<1xi64>}, %arg2: memref<65536xi8> {lmhlo.output_index = dense<1> : tensor<1xi64>}, %arg3: memref<65536xi8> {lmhlo.output_index = dense<2> : tensor<1xi64>}, %arg4: memref<65536xi8> {lmhlo.output_index = dense<3> : tensor<1xi64>}) attributes {result_xla_shape = "(f32[1024,4,4]{2,1,0}, f32[1024,4,4]{2,1,0}, f32[1024,4,4]{2,1,0}, f32[1024,4,4]{2,1,0})"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<262144xi8> to memref<1024x16x4xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg4[%c0_0][] : memref<65536xi8> to memref<1024x4x4xf32>
    "lmhlo.fusion"() ({
      %5 = bufferization.to_tensor %0 : memref<1024x16x4xf32>
      %6 = "mhlo.slice"(%5) {limit_indices = dense<[1024, 16, 4]> : tensor<3xi64>, start_indices = dense<[0, 12, 0]> : tensor<3xi64>, strides = dense<1> : tensor<3xi64>} : (tensor<1024x16x4xf32>) -> tensor<1024x4x4xf32>
      memref.tensor_store %6, %1 : memref<1024x4x4xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg2[%c0_1][] : memref<65536xi8> to memref<1024x4x4xf32>
    "lmhlo.fusion"() ({
      %5 = bufferization.to_tensor %0 : memref<1024x16x4xf32>
      %6 = "mhlo.slice"(%5) {limit_indices = dense<[1024, 8, 4]> : tensor<3xi64>, start_indices = dense<[0, 4, 0]> : tensor<3xi64>, strides = dense<1> : tensor<3xi64>} : (tensor<1024x16x4xf32>) -> tensor<1024x4x4xf32>
      memref.tensor_store %6, %2 : memref<1024x4x4xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c0_2 = arith.constant 0 : index
    %3 = memref.view %arg1[%c0_2][] : memref<65536xi8> to memref<1024x4x4xf32>
    "lmhlo.fusion"() ({
      %5 = bufferization.to_tensor %0 : memref<1024x16x4xf32>
      %6 = "mhlo.slice"(%5) {limit_indices = dense<[1024, 4, 4]> : tensor<3xi64>, start_indices = dense<0> : tensor<3xi64>, strides = dense<1> : tensor<3xi64>} : (tensor<1024x16x4xf32>) -> tensor<1024x4x4xf32>
      memref.tensor_store %6, %3 : memref<1024x4x4xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c0_3 = arith.constant 0 : index
    %4 = memref.view %arg3[%c0_3][] : memref<65536xi8> to memref<1024x4x4xf32>
    "lmhlo.fusion"() ({
      %5 = bufferization.to_tensor %0 : memref<1024x16x4xf32>
      %6 = "mhlo.slice"(%5) {limit_indices = dense<[1024, 12, 4]> : tensor<3xi64>, start_indices = dense<[0, 8, 0]> : tensor<3xi64>, strides = dense<1> : tensor<3xi64>} : (tensor<1024x16x4xf32>) -> tensor<1024x4x4xf32>
      memref.tensor_store %6, %4 : memref<1024x4x4xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}