module attributes {hlo.unique_id = 68 : i32, mhlo.unique_id = 68 : i64} {
  func @main.5(%arg0: memref<16xi8> {lmhlo.params = 0 : index}, %arg1: memref<64xi8> {lmhlo.params = 1 : index}, %arg2: memref<64xi8> {lmhlo.params = 2 : index}, %arg3: memref<64xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "s32[16]{0}"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<16xi8> to memref<16xi1>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg2[%c0_0][] : memref<64xi8> to memref<16xi32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg1[%c0_1][] : memref<64xi8> to memref<16xi32>
    %c0_2 = arith.constant 0 : index
    %3 = memref.view %arg3[%c0_2][] : memref<64xi8> to memref<16xi32>
    "lmhlo.fusion"() ({
      %4 = bufferization.to_tensor %0 : memref<16xi1>
      %5 = bufferization.to_tensor %1 : memref<16xi32>
      %6 = bufferization.to_tensor %2 : memref<16xi32>
      %7 = "mhlo.select"(%4, %5, %6) : (tensor<16xi1>, tensor<16xi32>, tensor<16xi32>) -> tensor<16xi32>
      memref.tensor_store %7, %3 : memref<16xi32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}