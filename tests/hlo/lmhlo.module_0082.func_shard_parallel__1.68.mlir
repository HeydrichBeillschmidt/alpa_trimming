module attributes {hlo.unique_id = 82 : i32, mhlo.unique_id = 82 : i64} {
  memref.global "private" constant @buffer_for_constant_4 : memref<i32> = dense<1> {lmhlo.alloc = 5 : index}
  func @func_shard_parallel__1.68_spmd(%arg0: memref<4xi8> {lmhlo.output_index = dense<0> : tensor<1xi64>, lmhlo.params = 0 : index}, %arg1: memref<4096xi8> {lmhlo.output_index = dense<1> : tensor<1xi64>, lmhlo.params = 1 : index}, %arg2: memref<1024xi8> {lmhlo.output_index = dense<2> : tensor<1xi64>, lmhlo.params = 2 : index}, %arg3: memref<8192xi8> {lmhlo.params = 3 : index}, %arg4: memref<4096xi8> {lmhlo.params = 4 : index}, %arg5: memref<4xi8> {lmhlo.constant_name = "buffer_for_constant_4"}, %arg6: memref<13456xi8>) attributes {result_xla_shape = "(s32[], f32[32,32]{1,0}, f32[16,16]{1,0})"} {
    %0 = memref.get_global @buffer_for_constant_4 : memref<i32>
    %c0 = arith.constant 0 : index
    %1 = memref.view %arg0[%c0][] : memref<4xi8> to memref<i32>
    %c0_0 = arith.constant 0 : index
    %2 = memref.view %arg0[%c0_0][] : memref<4xi8> to memref<i32>
    "lmhlo.fusion"() ({
      %30 = bufferization.to_tensor %1 : memref<i32>
      %31 = bufferization.to_tensor %0 : memref<i32>
      %32 = mhlo.add %30, %31 : tensor<i32>
      memref.tensor_store %32, %2 : memref<i32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c128 = arith.constant 128 : index
    %3 = memref.view %arg6[%c128][] : memref<13456xi8> to memref<ui32>
    "lmhlo.partition_id"(%3) : (memref<ui32>) -> ()
    %c0_1 = arith.constant 0 : index
    %4 = memref.view %arg6[%c0_1][] : memref<13456xi8> to memref<1x4x1xi32>
    "lmhlo.fusion"() ({
      %30 = bufferization.to_tensor %3 : memref<ui32>
      %31 = "mhlo.iota"() {iota_dimension = 0 : i64} : () -> tensor<4x1xi32>
      %32 = "mhlo.convert"(%30) : (tensor<ui32>) -> tensor<i32>
      %33 = mhlo.constant dense<4> : tensor<i32>
      %34 = mhlo.multiply %32, %33 : tensor<i32>
      %35 = "mhlo.broadcast_in_dim"(%34) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<i32>) -> tensor<4x1xi32>
      %36 = mhlo.add %31, %35 : tensor<4x1xi32>
      %37 = "mhlo.bitcast"(%36) {result_layout = dense<[2, 1, 0]> : tensor<3xindex>, source_layout = dense<[1, 0]> : tensor<2xindex>} : (tensor<4x1xi32>) -> tensor<1x4x1xi32>
      memref.tensor_store %37, %4 : memref<1x4x1xi32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c13312 = arith.constant 13312 : index
    %5 = memref.view %arg6[%c13312][] : memref<13456xi8> to memref<4x4x1xi32>
    "lmhlo.all_gather"(%4, %5) {all_gather_dimension = 0 : i64, channel_id = {handle = 1 : i64, type = 0 : i64}, constrain_layout = false, replica_groups = dense<[[0, 1, 2, 3]]> : tensor<1x4xi64>, use_global_device_ids = true} : (memref<1x4x1xi32>, memref<4x4x1xi32>) -> ()
    %c0_2 = arith.constant 0 : index
    %6 = memref.view %arg3[%c0_2][] : memref<8192xi8> to memref<64x32xf32>
    %c0_3 = arith.constant 0 : index
    %7 = memref.view %arg1[%c0_3][] : memref<4096xi8> to memref<32x32xf32>
    %c0_4 = arith.constant 0 : index
    %8 = memref.view %arg6[%c0_4][] : memref<13456xi8> to memref<64x32xf32>
    "lmhlo_gpu.gemm"(%6, %7, %8) {algorithm = 2 : i64, alpha_imag = 0.000000e+00 : f64, alpha_real = 1.000000e+00 : f64, batch_size = 1 : i64, dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [1], rhs_contracting_dimensions = [0]>, lhs_stride = 2048 : i64, rhs_stride = 1024 : i64} : (memref<64x32xf32>, memref<32x32xf32>, memref<64x32xf32>) -> ()
    %c8192 = arith.constant 8192 : index
    %9 = memref.view %arg6[%c8192][] : memref<13456xi8> to memref<64x16xf32>
    "lmhlo.fusion"() ({
      %30 = bufferization.to_tensor %8 : memref<64x32xf32>
      %31 = bufferization.to_tensor %5 : memref<4x4x1xi32>
      %32 = "mhlo.bitcast"(%31) {result_layout = dense<[0, 1]> : tensor<2xindex>, source_layout = dense<[2, 1, 0]> : tensor<3xindex>, xla_shape = "s32[16,1]{0,1}"} : (tensor<4x4x1xi32>) -> tensor<16x1xi32>
      %33 = "mhlo.gather"(%30, %32) {dimension_numbers = #mhlo.gather<offset_dims = [0], collapsed_slice_dims = [1], start_index_map = [1], index_vector_dim = 1>, indices_are_sorted = false, slice_sizes = dense<[64, 1]> : tensor<2xi64>} : (tensor<64x32xf32>, tensor<16x1xi32>) -> tensor<64x16xf32>
      memref.tensor_store %33, %9 : memref<64x16xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c0_5 = arith.constant 0 : index
    %10 = memref.view %arg2[%c0_5][] : memref<1024xi8> to memref<16x16xf32>
    %c0_6 = arith.constant 0 : index
    %11 = memref.view %arg6[%c0_6][] : memref<13456xi8> to memref<64x16xf32>
    "lmhlo_gpu.gemm"(%9, %10, %11) {algorithm = 2 : i64, alpha_imag = 0.000000e+00 : f64, alpha_real = 1.000000e+00 : f64, batch_size = 1 : i64, dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [1], rhs_contracting_dimensions = [0]>, lhs_stride = 1024 : i64, rhs_stride = 256 : i64} : (memref<64x16xf32>, memref<16x16xf32>, memref<64x16xf32>) -> ()
    %c0_7 = arith.constant 0 : index
    %12 = memref.view %arg4[%c0_7][] : memref<4096xi8> to memref<64x16xf32>
    %c0_8 = arith.constant 0 : index
    %13 = memref.view %arg6[%c0_8][] : memref<13456xi8> to memref<64x16xf32>
    "lmhlo.fusion"() ({
      %30 = bufferization.to_tensor %11 : memref<64x16xf32>
      %31 = bufferization.to_tensor %12 : memref<64x16xf32>
      %32 = mhlo.subtract %30, %31 : tensor<64x16xf32>
      %33 = mhlo.constant dense<4.8828125E-4> : tensor<f32>
      %34 = "mhlo.broadcast_in_dim"(%33) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<64x16xf32>
      %35 = mhlo.multiply %32, %34 : tensor<64x16xf32>
      memref.tensor_store %35, %13 : memref<64x16xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c12288 = arith.constant 12288 : index
    %14 = memref.view %arg6[%c12288][] : memref<13456xi8> to memref<16x16xf32>
    "lmhlo_gpu.gemm"(%9, %13, %14) {algorithm = -1 : i64, alpha_imag = 0.000000e+00 : f64, alpha_real = 1.000000e+00 : f64, batch_size = 1 : i64, dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [0], rhs_contracting_dimensions = [0]>, lhs_stride = 1024 : i64, rhs_stride = 1024 : i64} : (memref<64x16xf32>, memref<64x16xf32>, memref<16x16xf32>) -> ()
    %c8192_9 = arith.constant 8192 : index
    %15 = memref.view %arg6[%c8192_9][] : memref<13456xi8> to memref<16x64xf32>
    %16 = memref.reinterpret_cast %15 to offset: [0], sizes: [64, 16], strides: [1, 64] : memref<16x64xf32> to memref<64x16xf32, affine_map<(d0, d1) -> (d0 + d1 * 64)>>
    "lmhlo_gpu.gemm"(%13, %10, %16) {algorithm = 0 : i64, alpha_imag = 0.000000e+00 : f64, alpha_real = 1.000000e+00 : f64, batch_size = 1 : i64, dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [1], rhs_contracting_dimensions = [1]>, lhs_stride = 1024 : i64, rhs_stride = 256 : i64} : (memref<64x16xf32>, memref<16x16xf32>, memref<64x16xf32, affine_map<(d0, d1) -> (d0 + d1 * 64)>>) -> ()
    %c0_10 = arith.constant 0 : index
    %17 = memref.view %arg6[%c0_10][] : memref<13456xi8> to memref<32x64xf32>
    %18 = memref.reinterpret_cast %17 to offset: [0], sizes: [64, 32], strides: [1, 64] : memref<32x64xf32> to memref<64x32xf32, affine_map<(d0, d1) -> (d0 + d1 * 64)>>
    "lmhlo.fusion"() ({
      %30 = bufferization.to_tensor %16 {xla_shape = "f32[64,16]{0,1}"} : memref<64x16xf32, affine_map<(d0, d1) -> (d0 + d1 * 64)>>
      %31 = bufferization.to_tensor %5 : memref<4x4x1xi32>
      %32 = mhlo.constant dense<0.000000e+00> : tensor<f32>
      %33 = "mhlo.broadcast_in_dim"(%32) {broadcast_dimensions = dense<> : tensor<0xi64>, xla_shape = "f32[64,32]{0,1}"} : (tensor<f32>) -> tensor<64x32xf32>
      %34 = "mhlo.bitcast"(%31) {result_layout = dense<[0, 1]> : tensor<2xindex>, source_layout = dense<[2, 1, 0]> : tensor<3xindex>, xla_shape = "s32[16,1]{0,1}"} : (tensor<4x4x1xi32>) -> tensor<16x1xi32>
      %35 = "mhlo.scatter"(%33, %34, %30) ({
      ^bb0(%arg7: tensor<f32>, %arg8: tensor<f32>):
        %36 = mhlo.add %arg7, %arg8 : tensor<f32>
        "mhlo.return"(%36) : (tensor<f32>) -> ()
      }) {indices_are_sorted = false, scatter_dimension_numbers = #mhlo.scatter<update_window_dims = [0], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1], index_vector_dim = 1>, unique_indices = false, xla_shape = "f32[64,32]{0,1}"} : (tensor<64x32xf32>, tensor<16x1xi32>, tensor<64x16xf32>) -> tensor<64x32xf32>
      memref.tensor_store %35, %18 : memref<64x32xf32, affine_map<(d0, d1) -> (d0 + d1 * 64)>>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c8192_11 = arith.constant 8192 : index
    %19 = memref.view %arg6[%c8192_11][] : memref<13456xi8> to memref<32x32xf32>
    "lmhlo_gpu.gemm"(%6, %18, %19) {algorithm = -1 : i64, alpha_imag = 0.000000e+00 : f64, alpha_real = 1.000000e+00 : f64, batch_size = 1 : i64, dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [0], rhs_contracting_dimensions = [0]>, lhs_stride = 2048 : i64, rhs_stride = 2048 : i64} : (memref<64x32xf32>, memref<64x32xf32, affine_map<(d0, d1) -> (d0 + d1 * 64)>>, memref<32x32xf32>) -> ()
    %c8192_12 = arith.constant 8192 : index
    %20 = memref.view %arg6[%c8192_12][] : memref<13456xi8> to memref<1024xf32>
    %c12288_13 = arith.constant 12288 : index
    %21 = memref.view %arg6[%c12288_13][] : memref<13456xi8> to memref<256xf32>
    %c0_14 = arith.constant 0 : index
    %22 = memref.view %arg6[%c0_14][] : memref<13456xi8> to memref<1280xf32>
    "lmhlo.fusion"() ({
      %30 = bufferization.to_tensor %20 : memref<1024xf32>
      %31 = bufferization.to_tensor %21 : memref<256xf32>
      %32 = "mhlo.concatenate"(%30, %31) {dimension = 0 : i64} : (tensor<1024xf32>, tensor<256xf32>) -> tensor<1280xf32>
      memref.tensor_store %32, %22 : memref<1280xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c0_15 = arith.constant 0 : index
    %23 = memref.view %arg6[%c0_15][] : memref<13456xi8> to memref<1280xf32>
    "lmhlo.all_reduce"(%22, %23) ({
    ^bb0(%arg7: tensor<f32>, %arg8: tensor<f32>):
      %30 = mhlo.add %arg7, %arg8 : tensor<f32>
      "mhlo.return"(%30) : (tensor<f32>) -> ()
    }) {channel_id = {handle = 2 : i64, type = 0 : i64}, constrain_layout = false, replica_groups = dense<0> : tensor<1x1xi64>, use_global_device_ids = false} : (memref<1280xf32>, memref<1280xf32>) -> ()
    %c9216 = arith.constant 9216 : index
    %24 = memref.view %arg6[%c9216][] : memref<13456xi8> to memref<256xf32>
    "lmhlo.fusion"() ({
      %30 = bufferization.to_tensor %23 : memref<1280xf32>
      %31 = "mhlo.slice"(%30) {limit_indices = dense<1280> : tensor<1xi64>, start_indices = dense<1024> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<1280xf32>) -> tensor<256xf32>
      memref.tensor_store %31, %24 : memref<256xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c5120 = arith.constant 5120 : index
    %25 = memref.view %arg6[%c5120][] : memref<13456xi8> to memref<1024xf32>
    "lmhlo.fusion"() ({
      %30 = bufferization.to_tensor %23 : memref<1280xf32>
      %31 = "mhlo.slice"(%30) {limit_indices = dense<1024> : tensor<1xi64>, start_indices = dense<0> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<1280xf32>) -> tensor<1024xf32>
      memref.tensor_store %31, %25 : memref<1024xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c5120_16 = arith.constant 5120 : index
    %26 = memref.view %arg6[%c5120_16][] : memref<13456xi8> to memref<32x32xf32>
    %c9216_17 = arith.constant 9216 : index
    %27 = memref.view %arg6[%c9216_17][] : memref<13456xi8> to memref<16x16xf32>
    %c0_18 = arith.constant 0 : index
    %28 = memref.view %arg1[%c0_18][] : memref<4096xi8> to memref<1024xf32>
    %c0_19 = arith.constant 0 : index
    %29 = memref.view %arg2[%c0_19][] : memref<1024xi8> to memref<256xf32>
    "lmhlo.fusion"() ({
      %30 = bufferization.to_tensor %7 : memref<32x32xf32>
      %31 = bufferization.to_tensor %26 : memref<32x32xf32>
      %32 = bufferization.to_tensor %10 : memref<16x16xf32>
      %33 = bufferization.to_tensor %27 : memref<16x16xf32>
      %34 = mhlo.constant dense<0.00999999977> : tensor<f32>
      %35 = "mhlo.broadcast_in_dim"(%34) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<32x32xf32>
      %36 = mhlo.multiply %31, %35 : tensor<32x32xf32>
      %37 = mhlo.subtract %30, %36 : tensor<32x32xf32>
      %38 = "mhlo.reshape"(%37) : (tensor<32x32xf32>) -> tensor<1024xf32>
      %39 = "mhlo.broadcast_in_dim"(%34) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %40 = mhlo.multiply %33, %39 : tensor<16x16xf32>
      %41 = mhlo.subtract %32, %40 : tensor<16x16xf32>
      %42 = "mhlo.reshape"(%41) : (tensor<16x16xf32>) -> tensor<256xf32>
      %43 = "mhlo.concatenate"(%38, %42) {dimension = 0 : i64} : (tensor<1024xf32>, tensor<256xf32>) -> tensor<1280xf32>
      %44 = "mhlo.slice"(%43) {limit_indices = dense<1024> : tensor<1xi64>, start_indices = dense<0> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<1280xf32>) -> tensor<1024xf32>
      %45 = "mhlo.slice"(%43) {limit_indices = dense<1280> : tensor<1xi64>, start_indices = dense<1024> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<1280xf32>) -> tensor<256xf32>
      memref.tensor_store %44, %28 : memref<1024xf32>
      memref.tensor_store %45, %29 : memref<256xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}