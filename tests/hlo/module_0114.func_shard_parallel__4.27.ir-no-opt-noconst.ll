target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

@0 = external dso_local unnamed_addr constant [4 x i8]
@shared_cache = external dso_local addrspace(3) global [1 x [1 x [32 x [33 x float]]]]
@1 = external dso_local unnamed_addr constant [4 x i8]
@shared_cache1 = external dso_local addrspace(3) global [1 x [1 x [32 x [33 x i32]]]]

define void @input_fusion_reduce(i8* noalias align 16 dereferenceable(20736) %alloc0, i8* noalias align 128 dereferenceable(144) %alloc1, i8* noalias align 128 dereferenceable(272) %temp_buf) {
entry:
  %tuple_element_041 = alloca float, align 4
  %tuple_element_142 = alloca i32, align 4
  %return_buffer40 = alloca [2 x i8*], align 8
  %result_from_other_lane38 = alloca i32, align 4
  %result_from_other_lane36 = alloca float, align 4
  %tuple_element_034 = alloca float, align 4
  %tuple_element_135 = alloca i32, align 4
  %return_buffer33 = alloca [2 x i8*], align 8
  %result_from_other_lane31 = alloca i32, align 4
  %result_from_other_lane29 = alloca float, align 4
  %tuple_element_027 = alloca float, align 4
  %tuple_element_128 = alloca i32, align 4
  %return_buffer26 = alloca [2 x i8*], align 8
  %result_from_other_lane24 = alloca i32, align 4
  %result_from_other_lane22 = alloca float, align 4
  %tuple_element_020 = alloca float, align 4
  %tuple_element_121 = alloca i32, align 4
  %return_buffer19 = alloca [2 x i8*], align 8
  %result_from_other_lane17 = alloca i32, align 4
  %result_from_other_lane15 = alloca float, align 4
  %tuple_element_013 = alloca float, align 4
  %tuple_element_114 = alloca i32, align 4
  %return_buffer12 = alloca [2 x i8*], align 8
  %result_from_other_lane10 = alloca i32, align 4
  %result_from_other_lane = alloca float, align 4
  %tuple_element_0 = alloca float, align 4
  %tuple_element_1 = alloca i32, align 4
  %return_buffer = alloca [2 x i8*], align 8
  %tile_loop.invar_address = alloca i32, align 4
  %y_in_tile.invar_address = alloca i32, align 4
  %partial_reduction_result2 = alloca i32, align 4
  %reduction_input_address1 = alloca i32, align 4
  %partial_reduction_result = alloca float, align 4
  %reduction_input_address = alloca float, align 4
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [144 x [36 x float]]*
  %2 = getelementptr inbounds i8, i8* %temp_buf, i64 0
  %3 = bitcast i8* %2 to [36 x float]*
  %4 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %5 = bitcast i8* %4 to [36 x i32]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.y(), !range !2
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %reduce-group-0-true, label %reduce-group-0-after

reduce-group-0-after:                             ; preds = %reduction_write_output-after, %entry
  ret void

reduce-group-0-true:                              ; preds = %entry
  %region_0_33_constant_3 = load float, float* bitcast ([4 x i8]* @0 to float*), align 4
  %8 = getelementptr inbounds float, float* %partial_reduction_result, i32 0
  store float %region_0_33_constant_3, float* %8, align 4
  %region_0_33_constant_4 = load i32, i32* bitcast ([4 x i8]* @1 to i32*), align 4
  %9 = getelementptr inbounds i32, i32* %partial_reduction_result2, i32 0
  store i32 %region_0_33_constant_4, i32* %9, align 4
  %10 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %11 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !4
  %12 = urem i32 %10, 1024
  %13 = udiv i32 %10, 1024
  %14 = mul i32 %11, 1
  %15 = add i32 %14, %13
  %16 = icmp ult i32 %15, 2
  br i1 %16, label %17, label %early_return

17:                                               ; preds = %reduce-group-0-true
  %thread_id.x = urem i32 %12, 32
  %thread_id.y = udiv i32 %12, 32
  %lane_id = urem i32 %12, 32
  %18 = udiv i32 %15, 1
  %19 = urem i32 %18, 2
  %20 = udiv i32 %15, 2
  %21 = urem i32 %20, 1
  %22 = udiv i32 %15, 2
  %block_origin.z = mul i32 %22, 1
  %23 = icmp eq i32 %21, 0
  %tile_bound = select i1 %23, i32 144, i32 4096
  %24 = icmp eq i32 %19, 1
  %tile_bound3 = select i1 %24, i32 4, i32 32
  %tile_origin.1 = mul i32 %21, 4096
  %tile_origin.2 = mul i32 %19, 32
  %25 = mul i32 %thread_id.x, 1
  %26 = add i32 %tile_origin.2, %25
  store i32 %thread_id.y, i32* %y_in_tile.invar_address, align 4
  br label %y_in_tile.loop_header

y_in_tile.loop_header:                            ; preds = %tile_loop.loop_exit, %17
  %y_in_tile.indvar = load i32, i32* %y_in_tile.invar_address, align 4
  %27 = icmp uge i32 %y_in_tile.indvar, %tile_bound
  br i1 %27, label %y_in_tile.loop_exit, label %y_in_tile.loop_body

y_in_tile.loop_body:                              ; preds = %y_in_tile.loop_header
  %invar.inc = add nuw nsw i32 %y_in_tile.indvar, 32
  store i32 %invar.inc, i32* %y_in_tile.invar_address, align 4
  %28 = icmp eq i32 %y_in_tile.indvar, %thread_id.y
  %29 = add i32 %tile_origin.1, %y_in_tile.indvar
  store i32 0, i32* %tile_loop.invar_address, align 4
  br label %tile_loop.loop_header

tile_loop.loop_header:                            ; preds = %x_in_tile-after, %y_in_tile.loop_body
  %tile_loop.indvar = load i32, i32* %tile_loop.invar_address, align 4
  %30 = icmp uge i32 %tile_loop.indvar, 1
  br i1 %30, label %tile_loop.loop_exit, label %tile_loop.loop_body

tile_loop.loop_body:                              ; preds = %tile_loop.loop_header
  %invar.inc4 = add nuw nsw i32 %tile_loop.indvar, 1
  store i32 %invar.inc4, i32* %tile_loop.invar_address, align 4
  %31 = icmp eq i32 %tile_loop.indvar, 0
  %32 = mul i32 %tile_loop.indvar, 1
  %33 = add i32 %32, 0
  %34 = mul i32 %tile_loop.indvar, 1
  %35 = add i32 %34, 0
  %x_loc = add i32 %35, %25
  %36 = mul i32 %tile_loop.indvar, 1
  %37 = add i32 %36, 0
  %38 = add i32 %26, %37
  %39 = icmp ult i32 %x_loc, %tile_bound3
  br i1 %39, label %x_in_tile-true, label %x_in_tile-after

x_in_tile-after:                                  ; preds = %x_in_tile-true, %tile_loop.loop_body
  br label %tile_loop.loop_header, !llvm.loop !5

tile_loop.loop_exit:                              ; preds = %tile_loop.loop_header
  br label %y_in_tile.loop_header, !llvm.loop !8

y_in_tile.loop_exit:                              ; preds = %y_in_tile.loop_header
  %shmem_output_address = getelementptr inbounds [1 x [1 x [32 x [33 x float]]]], [1 x [1 x [32 x [33 x float]]]] addrspace(3)* @shared_cache, i32 0, i32 %13, i32 0, i32 %thread_id.x, i32 %thread_id.y
  %40 = addrspacecast float addrspace(3)* %shmem_output_address to float*
  %current_output = getelementptr inbounds float, float* %partial_reduction_result, i32 0
  %41 = load float, float* %current_output, align 4
  store float %41, float* %40, align 4
  %shmem_output_address6 = getelementptr inbounds [1 x [1 x [32 x [33 x i32]]]], [1 x [1 x [32 x [33 x i32]]]] addrspace(3)* @shared_cache1, i32 0, i32 %13, i32 0, i32 %thread_id.x, i32 %thread_id.y
  %42 = addrspacecast i32 addrspace(3)* %shmem_output_address6 to i32*
  %current_output7 = getelementptr inbounds i32, i32* %partial_reduction_result2, i32 0
  %43 = load i32, i32* %current_output7, align 4
  store i32 %43, i32* %42, align 4
  call void @llvm.nvvm.barrier0()
  %shmem_transposed_addr = getelementptr inbounds [1 x [1 x [32 x [33 x float]]]], [1 x [1 x [32 x [33 x float]]]] addrspace(3)* @shared_cache, i32 0, i32 %13, i32 0, i32 %thread_id.y, i32 %thread_id.x
  %44 = addrspacecast float addrspace(3)* %shmem_transposed_addr to float*
  %shmem_transposed_addr8 = getelementptr inbounds [1 x [1 x [32 x [33 x i32]]]], [1 x [1 x [32 x [33 x i32]]]] addrspace(3)* @shared_cache1, i32 0, i32 %13, i32 0, i32 %thread_id.y, i32 %thread_id.x
  %45 = addrspacecast i32 addrspace(3)* %shmem_transposed_addr8 to i32*
  %partial_reduction_result9 = load float, float* %44, align 4
  %46 = call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %partial_reduction_result9, i32 16, i32 31)
  store float %46, float* %result_from_other_lane, align 4
  %partial_reduction_result11 = load i32, i32* %45, align 4
  %47 = bitcast i32 %partial_reduction_result11 to <1 x i32>
  %48 = extractelement <1 x i32> %47, i64 0
  %49 = call i32 @llvm.nvvm.shfl.sync.down.i32(i32 -1, i32 %48, i32 16, i32 31)
  %50 = insertelement <1 x i32> %47, i32 %49, i64 0
  %51 = bitcast <1 x i32> %50 to i32
  store i32 %51, i32* %result_from_other_lane10, align 4
  %52 = bitcast float* %tuple_element_013 to i8*
  %53 = getelementptr inbounds [2 x i8*], [2 x i8*]* %return_buffer12, i64 0, i64 0
  store i8* %52, i8** %53, align 8
  %54 = bitcast i32* %tuple_element_114 to i8*
  %55 = getelementptr inbounds [2 x i8*], [2 x i8*]* %return_buffer12, i64 0, i64 1
  store i8* %54, i8** %55, align 8
  call void @region_1_20(float* %44, i32* %45, float* %result_from_other_lane, i32* %result_from_other_lane10, [2 x i8*]* %return_buffer12)
  %56 = load float, float* %tuple_element_013, align 4
  %57 = load i32, i32* %tuple_element_114, align 4
  store float %56, float* %44, align 4
  store i32 %57, i32* %45, align 4
  %partial_reduction_result16 = load float, float* %44, align 4
  %58 = call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %partial_reduction_result16, i32 8, i32 31)
  store float %58, float* %result_from_other_lane15, align 4
  %partial_reduction_result18 = load i32, i32* %45, align 4
  %59 = bitcast i32 %partial_reduction_result18 to <1 x i32>
  %60 = extractelement <1 x i32> %59, i64 0
  %61 = call i32 @llvm.nvvm.shfl.sync.down.i32(i32 -1, i32 %60, i32 8, i32 31)
  %62 = insertelement <1 x i32> %59, i32 %61, i64 0
  %63 = bitcast <1 x i32> %62 to i32
  store i32 %63, i32* %result_from_other_lane17, align 4
  %64 = bitcast float* %tuple_element_020 to i8*
  %65 = getelementptr inbounds [2 x i8*], [2 x i8*]* %return_buffer19, i64 0, i64 0
  store i8* %64, i8** %65, align 8
  %66 = bitcast i32* %tuple_element_121 to i8*
  %67 = getelementptr inbounds [2 x i8*], [2 x i8*]* %return_buffer19, i64 0, i64 1
  store i8* %66, i8** %67, align 8
  call void @region_1_20(float* %44, i32* %45, float* %result_from_other_lane15, i32* %result_from_other_lane17, [2 x i8*]* %return_buffer19)
  %68 = load float, float* %tuple_element_020, align 4
  %69 = load i32, i32* %tuple_element_121, align 4
  store float %68, float* %44, align 4
  store i32 %69, i32* %45, align 4
  %partial_reduction_result23 = load float, float* %44, align 4
  %70 = call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %partial_reduction_result23, i32 4, i32 31)
  store float %70, float* %result_from_other_lane22, align 4
  %partial_reduction_result25 = load i32, i32* %45, align 4
  %71 = bitcast i32 %partial_reduction_result25 to <1 x i32>
  %72 = extractelement <1 x i32> %71, i64 0
  %73 = call i32 @llvm.nvvm.shfl.sync.down.i32(i32 -1, i32 %72, i32 4, i32 31)
  %74 = insertelement <1 x i32> %71, i32 %73, i64 0
  %75 = bitcast <1 x i32> %74 to i32
  store i32 %75, i32* %result_from_other_lane24, align 4
  %76 = bitcast float* %tuple_element_027 to i8*
  %77 = getelementptr inbounds [2 x i8*], [2 x i8*]* %return_buffer26, i64 0, i64 0
  store i8* %76, i8** %77, align 8
  %78 = bitcast i32* %tuple_element_128 to i8*
  %79 = getelementptr inbounds [2 x i8*], [2 x i8*]* %return_buffer26, i64 0, i64 1
  store i8* %78, i8** %79, align 8
  call void @region_1_20(float* %44, i32* %45, float* %result_from_other_lane22, i32* %result_from_other_lane24, [2 x i8*]* %return_buffer26)
  %80 = load float, float* %tuple_element_027, align 4
  %81 = load i32, i32* %tuple_element_128, align 4
  store float %80, float* %44, align 4
  store i32 %81, i32* %45, align 4
  %partial_reduction_result30 = load float, float* %44, align 4
  %82 = call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %partial_reduction_result30, i32 2, i32 31)
  store float %82, float* %result_from_other_lane29, align 4
  %partial_reduction_result32 = load i32, i32* %45, align 4
  %83 = bitcast i32 %partial_reduction_result32 to <1 x i32>
  %84 = extractelement <1 x i32> %83, i64 0
  %85 = call i32 @llvm.nvvm.shfl.sync.down.i32(i32 -1, i32 %84, i32 2, i32 31)
  %86 = insertelement <1 x i32> %83, i32 %85, i64 0
  %87 = bitcast <1 x i32> %86 to i32
  store i32 %87, i32* %result_from_other_lane31, align 4
  %88 = bitcast float* %tuple_element_034 to i8*
  %89 = getelementptr inbounds [2 x i8*], [2 x i8*]* %return_buffer33, i64 0, i64 0
  store i8* %88, i8** %89, align 8
  %90 = bitcast i32* %tuple_element_135 to i8*
  %91 = getelementptr inbounds [2 x i8*], [2 x i8*]* %return_buffer33, i64 0, i64 1
  store i8* %90, i8** %91, align 8
  call void @region_1_20(float* %44, i32* %45, float* %result_from_other_lane29, i32* %result_from_other_lane31, [2 x i8*]* %return_buffer33)
  %92 = load float, float* %tuple_element_034, align 4
  %93 = load i32, i32* %tuple_element_135, align 4
  store float %92, float* %44, align 4
  store i32 %93, i32* %45, align 4
  %partial_reduction_result37 = load float, float* %44, align 4
  %94 = call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %partial_reduction_result37, i32 1, i32 31)
  store float %94, float* %result_from_other_lane36, align 4
  %partial_reduction_result39 = load i32, i32* %45, align 4
  %95 = bitcast i32 %partial_reduction_result39 to <1 x i32>
  %96 = extractelement <1 x i32> %95, i64 0
  %97 = call i32 @llvm.nvvm.shfl.sync.down.i32(i32 -1, i32 %96, i32 1, i32 31)
  %98 = insertelement <1 x i32> %95, i32 %97, i64 0
  %99 = bitcast <1 x i32> %98 to i32
  store i32 %99, i32* %result_from_other_lane38, align 4
  %100 = bitcast float* %tuple_element_041 to i8*
  %101 = getelementptr inbounds [2 x i8*], [2 x i8*]* %return_buffer40, i64 0, i64 0
  store i8* %100, i8** %101, align 8
  %102 = bitcast i32* %tuple_element_142 to i8*
  %103 = getelementptr inbounds [2 x i8*], [2 x i8*]* %return_buffer40, i64 0, i64 1
  store i8* %102, i8** %103, align 8
  call void @region_1_20(float* %44, i32* %45, float* %result_from_other_lane36, i32* %result_from_other_lane38, [2 x i8*]* %return_buffer40)
  %104 = load float, float* %tuple_element_041, align 4
  %105 = load i32, i32* %tuple_element_142, align 4
  store float %104, float* %44, align 4
  store i32 %105, i32* %45, align 4
  %106 = icmp ult i32 %thread_id.x, %tile_bound
  %107 = mul i32 %thread_id.y, 1
  %108 = icmp ult i32 %107, %tile_bound3
  %109 = and i1 %108, %106
  %110 = icmp eq i32 %lane_id, 0
  %111 = and i1 %109, %110
  br i1 %111, label %reduction_write_output-true, label %reduction_write_output-after

reduction_write_output-after:                     ; preds = %reduction_write_output-true, %y_in_tile.loop_exit
  br label %reduce-group-0-after

early_return:                                     ; preds = %reduce-group-0-true
  ret void

x_in_tile-true:                                   ; preds = %tile_loop.loop_body
  %Arg_0.1 = getelementptr inbounds [144 x [36 x float]], [144 x [36 x float]]* %1, i32 0, i32 %29, i32 %38
  %Arg_0.15 = load float, float* %Arg_0.1, align 4, !invariant.load !9
  store float %Arg_0.15, float* %reduction_input_address, align 4
  %112 = getelementptr inbounds float, float* %partial_reduction_result, i32 %33
  %113 = mul nuw nsw i32 %29, 1
  %114 = add nuw nsw i32 0, %113
  store i32 %114, i32* %reduction_input_address1, align 4
  %115 = getelementptr inbounds i32, i32* %partial_reduction_result2, i32 %33
  %116 = bitcast float* %tuple_element_0 to i8*
  %117 = getelementptr inbounds [2 x i8*], [2 x i8*]* %return_buffer, i64 0, i64 0
  store i8* %116, i8** %117, align 8
  %118 = bitcast i32* %tuple_element_1 to i8*
  %119 = getelementptr inbounds [2 x i8*], [2 x i8*]* %return_buffer, i64 0, i64 1
  store i8* %118, i8** %119, align 8
  call void @region_1_20(float* %112, i32* %115, float* %reduction_input_address, i32* %reduction_input_address1, [2 x i8*]* %return_buffer)
  %120 = load float, float* %tuple_element_0, align 4
  %121 = load i32, i32* %tuple_element_1, align 4
  store float %120, float* %112, align 4
  store i32 %121, i32* %115, align 4
  br label %x_in_tile-after

reduction_write_output-true:                      ; preds = %y_in_tile.loop_exit
  %122 = mul i32 %thread_id.y, 1
  %123 = add i32 %tile_origin.1, %thread_id.x
  %124 = add i32 %tile_origin.2, %122
  %125 = add i32 %124, 0
  %126 = mul i32 %block_origin.z, 36
  %127 = add i32 %126, %125
  %128 = udiv i32 %127, 1
  %output_element_address = getelementptr inbounds [36 x float], [36 x float]* %3, i32 0, i32 %128
  %output_value = load float, float* %44, align 4
  store float %output_value, float* %output_element_address, align 4
  %129 = mul i32 %thread_id.y, 1
  %130 = add i32 %tile_origin.1, %thread_id.x
  %131 = add i32 %tile_origin.2, %129
  %132 = add i32 %131, 0
  %133 = mul i32 %block_origin.z, 36
  %134 = add i32 %133, %132
  %135 = udiv i32 %134, 1
  %output_element_address43 = getelementptr inbounds [36 x i32], [36 x i32]* %5, i32 0, i32 %135
  %output_value44 = load i32, i32* %45, align 4
  store i32 %output_value44, i32* %output_element_address43, align 4
  br label %reduction_write_output-after
}

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.y() #0

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #0

define internal void @region_1_20(float* dereferenceable(4) %Arg_0.21.typed, i32* dereferenceable(4) %Arg_1.22.typed, float* dereferenceable(4) %Arg_2.23.typed, i32* dereferenceable(4) %Arg_3.24.typed, [2 x i8*]* dereferenceable(16) %output_arg) {
entry:
  %fusion.25.raw5 = alloca [2 x i8*], align 8
  %fusion.25.raw = alloca [2 x i8*], align 8
  %fusion.25.typed = alloca [2 x i8*], align 8
  %tuple.28.raw2 = alloca [2 x i8*], align 8
  %tuple.28.raw = alloca [2 x i8*], align 8
  %tuple.28.typed = alloca [2 x i8*], align 8
  %tuple.28.typed1 = bitcast [2 x i8*]* %tuple.28.raw to float*
  %tuple.28.typed3 = bitcast [2 x i8*]* %tuple.28.raw2 to i32*
  %fusion.25.typed4 = bitcast [2 x i8*]* %fusion.25.raw to i32*
  %fusion.25.typed6 = bitcast [2 x i8*]* %fusion.25.raw5 to float*
  %Arg_0.21 = load float, float* %Arg_0.21.typed, align 4
  %Arg_2.23 = load float, float* %Arg_2.23.typed, align 4
  %compare.10 = fcmp ogt float %Arg_0.21, %Arg_2.23
  %0 = zext i1 %compare.10 to i8
  %Arg_0.217 = load float, float* %Arg_0.21.typed, align 4
  %Arg_0.218 = load float, float* %Arg_0.21.typed, align 4
  %compare.11 = fcmp une float %Arg_0.217, %Arg_0.218
  %1 = zext i1 %compare.11 to i8
  %2 = or i8 %0, %1
  %Arg_0.219 = load float, float* %Arg_0.21.typed, align 4
  %Arg_2.2310 = load float, float* %Arg_2.23.typed, align 4
  %compare.13 = fcmp oeq float %Arg_0.219, %Arg_2.2310
  %3 = zext i1 %compare.13 to i8
  %Arg_1.22 = load i32, i32* %Arg_1.22.typed, align 4
  %Arg_3.24 = load i32, i32* %Arg_3.24.typed, align 4
  %4 = icmp slt i32 %Arg_1.22, %Arg_3.24
  %5 = zext i1 %4 to i8
  %6 = and i8 %3, %5
  %7 = or i8 %2, %6
  %Arg_1.2211 = load i32, i32* %Arg_1.22.typed, align 4
  %Arg_3.2412 = load i32, i32* %Arg_3.24.typed, align 4
  %8 = trunc i8 %7 to i1
  %9 = select i1 %8, i32 %Arg_1.2211, i32 %Arg_3.2412
  %10 = insertvalue { i32, float } undef, i32 %9, 0
  %Arg_0.2113 = load float, float* %Arg_0.21.typed, align 4
  %Arg_2.2314 = load float, float* %Arg_2.23.typed, align 4
  %11 = trunc i8 %2 to i1
  %12 = select i1 %11, float %Arg_0.2113, float %Arg_2.2314
  %13 = insertvalue { i32, float } %10, float %12, 1
  %14 = extractvalue { i32, float } %13, 0
  store i32 %14, i32* %fusion.25.typed4, align 4
  %15 = extractvalue { i32, float } %13, 1
  store float %15, float* %fusion.25.typed6, align 4
  %16 = bitcast i32* %fusion.25.typed4 to i8*
  %17 = getelementptr inbounds [2 x i8*], [2 x i8*]* %fusion.25.typed, i64 0, i64 0
  store i8* %16, i8** %17, align 8
  %18 = bitcast float* %fusion.25.typed6 to i8*
  %19 = getelementptr inbounds [2 x i8*], [2 x i8*]* %fusion.25.typed, i64 0, i64 1
  store i8* %18, i8** %19, align 8
  %20 = getelementptr inbounds [2 x i8*], [2 x i8*]* %fusion.25.typed, i64 0, i64 1
  %21 = load i8*, i8** %20, align 8, !dereferenceable !10, !align !11
  %get-tuple-element.27.typed = bitcast i8* %21 to float*
  %22 = getelementptr inbounds [2 x i8*], [2 x i8*]* %fusion.25.typed, i64 0, i64 0
  %23 = load i8*, i8** %22, align 8, !dereferenceable !10, !align !11
  %get-tuple-element.26.typed = bitcast i8* %23 to i32*
  %24 = bitcast float* %get-tuple-element.27.typed to i8*
  %25 = getelementptr inbounds [2 x i8*], [2 x i8*]* %tuple.28.typed, i64 0, i64 0
  store i8* %24, i8** %25, align 8
  %26 = bitcast i32* %get-tuple-element.26.typed to i8*
  %27 = getelementptr inbounds [2 x i8*], [2 x i8*]* %tuple.28.typed, i64 0, i64 1
  store i8* %26, i8** %27, align 8
  %28 = getelementptr inbounds [2 x i8*], [2 x i8*]* %output_arg, i64 0, i64 0
  %29 = load i8*, i8** %28, align 8, !dereferenceable !10, !align !11
  %30 = bitcast i8* %29 to float*
  %31 = getelementptr inbounds [2 x i8*], [2 x i8*]* %tuple.28.typed, i64 0, i64 0
  %32 = load i8*, i8** %31, align 8, !dereferenceable !10, !align !11
  %33 = bitcast i8* %32 to float*
  %34 = load float, float* %33, align 4
  store float %34, float* %30, align 4
  %35 = getelementptr inbounds [2 x i8*], [2 x i8*]* %output_arg, i64 0, i64 1
  %36 = load i8*, i8** %35, align 8, !dereferenceable !10, !align !11
  %37 = bitcast i8* %36 to i32*
  %38 = getelementptr inbounds [2 x i8*], [2 x i8*]* %tuple.28.typed, i64 0, i64 1
  %39 = load i8*, i8** %38, align 8, !dereferenceable !10, !align !11
  %40 = bitcast i8* %39 to i32*
  %41 = load i32, i32* %40, align 4
  store i32 %41, i32* %37, align 4
  ret void
}

; Function Attrs: convergent nounwind
declare void @llvm.nvvm.barrier0() #1

; Function Attrs: convergent inaccessiblememonly nounwind
declare float @llvm.nvvm.shfl.sync.down.f32(i32, float, i32, i32) #2

; Function Attrs: convergent inaccessiblememonly nounwind
declare i32 @llvm.nvvm.shfl.sync.down.i32(i32, i32, i32, i32) #2

attributes #0 = { nounwind readnone speculatable }
attributes #1 = { convergent nounwind }
attributes #2 = { convergent inaccessiblememonly nounwind }

!nvvm.annotations = !{!0, !1}

!0 = !{void (i8*, i8*, i8*)* @input_fusion_reduce, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @input_fusion_reduce, !"reqntidx", i32 1024}
!2 = !{i32 0, i32 1}
!3 = !{i32 0, i32 1024}
!4 = !{i32 0, i32 2}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.vectorize.enable", i1 false}
!7 = !{!"llvm.loop.unroll.full"}
!8 = distinct !{!8, !6}
!9 = !{}
!10 = !{i64 4}
!11 = !{i64 1}
