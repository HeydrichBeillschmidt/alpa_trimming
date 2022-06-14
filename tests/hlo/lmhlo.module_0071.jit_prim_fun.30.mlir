module attributes {hlo.unique_id = 71 : i32, mhlo.unique_id = 71 : i64} {
  func @main.4(%arg0: memref<32768xi8> {lmhlo.params = 0 : index}, %arg1: memref<64xi8> {lmhlo.params = 1 : index}, %arg2: memref<16384xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "f32[256,16]{1,0}"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<32768xi8> to memref<256x32xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<64xi8> to memref<16x1xi32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg2[%c0_1][] : memref<16384xi8> to memref<256x16xf32>
    "lmhlo.fusion"() ({
      %3 = bufferization.to_tensor %0 : memref<256x32xf32>
      %4 = bufferization.to_tensor %1 : memref<16x1xi32>
      %5 = "mhlo.gather"(%3, %4) {dimension_numbers = #mhlo.gather<offset_dims = [0], collapsed_slice_dims = [1], start_index_map = [1], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = dense<[256, 1]> : tensor<2xi64>} : (tensor<256x32xf32>, tensor<16x1xi32>) -> tensor<256x16xf32>
      memref.tensor_store %5, %2 : memref<256x16xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}