module attributes {hlo.unique_id = 114 : i32, mhlo.unique_id = 114 : i64} {
  func @func_shard_parallel__4.27_spmd(%arg0: memref<20736xi8> {lmhlo.params = 0 : index}, %arg1: memref<144xi8> {lmhlo.output_index = dense<0> : tensor<1xi64>}, %arg2: memref<272xi8>) attributes {result_xla_shape = "(s32[36]{0})"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<20736xi8> to memref<144x36xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg2[%c0_0][] : memref<272xi8> to memref<36xf32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg1[%c0_1][] : memref<144xi8> to memref<36xi32>
    "lmhlo.fusion"() ({
      %3 = bufferization.to_tensor %0 : memref<144x36xf32>
      %4 = "mhlo.iota"() {iota_dimension = 0 : i64} : () -> tensor<144x36xi32>
      %5 = mhlo.constant dense<0xFF800000> : tensor<f32>
      %6 = mhlo.constant dense<0> : tensor<i32>
      %7:2 = mhlo.reduce(%3 init: %5), (%4 init: %6) across dimensions = [0] : (tensor<144x36xf32>, tensor<144x36xi32>, tensor<f32>, tensor<i32>) -> (tensor<36xf32>, tensor<36xi32>)
       reducer(%arg3: tensor<f32>, %arg5: tensor<f32>) (%arg4: tensor<i32>, %arg6: tensor<i32>)  {
        %8:2 = "mhlo.fusion"(%arg4, %arg6, %arg3, %arg5) ({
        ^bb0(%arg7: tensor<i32>, %arg8: tensor<i32>, %arg9: tensor<f32>, %arg10: tensor<f32>):
          %9 = "mhlo.compare"(%arg9, %arg10) {comparison_direction = #mhlo<"comparison_direction GT">} : (tensor<f32>, tensor<f32>) -> tensor<i1>
          %10 = "mhlo.compare"(%arg9, %arg9) {comparison_direction = #mhlo<"comparison_direction NE">} : (tensor<f32>, tensor<f32>) -> tensor<i1>
          %11 = mhlo.or %9, %10 : tensor<i1>
          %12 = "mhlo.compare"(%arg9, %arg10) {comparison_direction = #mhlo<"comparison_direction EQ">} : (tensor<f32>, tensor<f32>) -> tensor<i1>
          %13 = "mhlo.compare"(%arg7, %arg8) {comparison_direction = #mhlo<"comparison_direction LT">} : (tensor<i32>, tensor<i32>) -> tensor<i1>
          %14 = mhlo.and %12, %13 : tensor<i1>
          %15 = mhlo.or %11, %14 : tensor<i1>
          %16 = "mhlo.select"(%15, %arg7, %arg8) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
          %17 = "mhlo.select"(%11, %arg9, %arg10) : (tensor<i1>, tensor<f32>, tensor<f32>) -> tensor<f32>
          "mhlo.return"(%16, %17) : (tensor<i32>, tensor<f32>) -> ()
        }) {fusion_kind = #mhlo<"fusion_kind kLoop">} : (tensor<i32>, tensor<i32>, tensor<f32>, tensor<f32>) -> (tensor<i32>, tensor<f32>)
        "mhlo.return"(%8#1, %8#0) : (tensor<f32>, tensor<i32>) -> ()
      }
      memref.tensor_store %7#0, %1 : memref<36xf32>
      memref.tensor_store %7#1, %2 : memref<36xi32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}