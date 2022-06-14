module attributes {hlo.unique_id = 119 : i32, mhlo.unique_id = 119 : i64} {
  func @func_shard_parallel__5.19_spmd(%arg0: memref<4096xi8> {lmhlo.params = 0 : index}, %arg1: memref<4096xi8> {lmhlo.output_index = dense<0> : tensor<1xi64>}, %arg2: memref<4112xi8>) attributes {result_xla_shape = "(s32[1024]{0})"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg1[%c0][] : memref<4096xi8> to memref<1024xi32>
    "lmhlo.fusion"() ({
      %4 = "mhlo.iota"() {iota_dimension = 0 : i64} : () -> tensor<1024xi32>
      memref.tensor_store %4, %0 : memref<1024xi32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg0[%c0_0][] : memref<4096xi8> to memref<1024xi32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg2[%c0_1][] : memref<4112xi8> to memref<1024xi32>
    %c0_2 = arith.constant 0 : index
    %3 = memref.view %arg1[%c0_2][] : memref<4096xi8> to memref<1024xi32>
    "lmhlo.sort"(%1, %0, %2, %3) ({
    ^bb0(%arg3: tensor<i32>, %arg4: tensor<i32>, %arg5: tensor<i32>, %arg6: tensor<i32>):
      %4 = "mhlo.fusion"(%arg5, %arg6, %arg4, %arg3) ({
      ^bb0(%arg7: tensor<i32>, %arg8: tensor<i32>, %arg9: tensor<i32>, %arg10: tensor<i32>):
        %5 = "mhlo.compare"(%arg10, %arg9) {comparison_direction = #mhlo<"comparison_direction LT">} : (tensor<i32>, tensor<i32>) -> tensor<i1>
        %6 = "mhlo.compare"(%arg9, %arg10) {comparison_direction = #mhlo<"comparison_direction LT">} : (tensor<i32>, tensor<i32>) -> tensor<i1>
        %7 = "mhlo.compare"(%5, %6) {comparison_direction = #mhlo<"comparison_direction EQ">} : (tensor<i1>, tensor<i1>) -> tensor<i1>
        %8 = "mhlo.compare"(%arg7, %arg8) {comparison_direction = #mhlo<"comparison_direction LT">} : (tensor<i32>, tensor<i32>) -> tensor<i1>
        %9 = "mhlo.select"(%7, %8, %5) : (tensor<i1>, tensor<i1>, tensor<i1>) -> tensor<i1>
        "mhlo.return"(%9) : (tensor<i1>) -> ()
      }) {fusion_kind = #mhlo<"fusion_kind kLoop">} : (tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>) -> tensor<i1>
      "mhlo.return"(%4) : (tensor<i1>) -> ()
    }) {dimension = 0 : i64, is_stable = true} : (memref<1024xi32>, memref<1024xi32>, memref<1024xi32>, memref<1024xi32>) -> ()
    "lmhlo.terminator"() : () -> ()
  }
}