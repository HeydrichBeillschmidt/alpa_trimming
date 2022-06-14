module attributes {hlo.unique_id = 62 : i32, mhlo.unique_id = 62 : i64} {
  func @main.2(%arg0: memref<64xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}) attributes {result_xla_shape = "s32[16]{0}"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg0[%c0][] : memref<64xi8> to memref<16xi32>
    "lmhlo.fusion"() ({
      %1 = "mhlo.iota"() {iota_dimension = 0 : i64} : () -> tensor<16xi32>
      memref.tensor_store %1, %0 : memref<16xi32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}