module attributes {hlo.unique_id = 127 : i32, mhlo.unique_id = 127 : i64} {
  func @func_shard_parallel__6.6_spmd(%arg0: memref<512xi8> {lmhlo.params = 0 : index}, %arg1: memref<32768xi8> {lmhlo.params = 1 : index}, %arg2: memref<256xi8> {lmhlo.output_index = dense<0> : tensor<1xi64>}) attributes {result_xla_shape = "(f32[64]{0})"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg1[%c0][] : memref<32768xi8> to memref<128x64xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg0[%c0_0][] : memref<512xi8> to memref<128xf32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg2[%c0_1][] : memref<256xi8> to memref<64xf32>
    "lmhlo.fusion"() ({
      %3 = bufferization.to_tensor %0 : memref<128x64xf32>
      %4 = bufferization.to_tensor %1 : memref<128xf32>
      %5 = "mhlo.broadcast_in_dim"(%4) {broadcast_dimensions = dense<1> : tensor<1xi64>, xla_shape = "f32[64,128]{0,1}"} : (tensor<128xf32>) -> tensor<64x128xf32>
      %6 = "mhlo.transpose"(%3) {permutation = dense<[1, 0]> : tensor<2xi64>, xla_shape = "f32[64,128]{0,1}"} : (tensor<128x64xf32>) -> tensor<64x128xf32>
      %7 = mhlo.multiply %5, %6 {xla_shape = "f32[64,128]{0,1}"} : tensor<64x128xf32>
      %8 = "mhlo.bitcast"(%7) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<[0, 1]> : tensor<2xindex>} : (tensor<64x128xf32>) -> tensor<128x64xf32>
      %9 = mhlo.constant dense<0.000000e+00> : tensor<f32>
      %10 = mhlo.reduce(%8 init: %9) across dimensions = [0] : (tensor<128x64xf32>, tensor<f32>) -> tensor<64xf32>
       reducer(%arg3: tensor<f32>, %arg4: tensor<f32>)  {
        %11 = mhlo.add %arg3, %arg4 : tensor<f32>
        "mhlo.return"(%11) : (tensor<f32>) -> ()
      }
      memref.tensor_store %10, %2 : memref<64xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}