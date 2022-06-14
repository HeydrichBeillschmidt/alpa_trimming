target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

@0 = private unnamed_addr constant [4 x i8] zeroinitializer
@shared_cache = private addrspace(3) global [1 x [1 x [32 x [33 x float]]]] undef

define void @input_fusion_reduce(i8* noalias align 16 dereferenceable(512) %alloc0, i8* noalias align 16 dereferenceable(32768) %alloc1, i8* noalias align 128 dereferenceable(256) %alloc2) {
entry:
  %return_buffer18 = alloca float, align 4
  %result_from_other_lane16 = alloca float, align 4
  %return_buffer15 = alloca float, align 4
  %result_from_other_lane13 = alloca float, align 4
  %return_buffer12 = alloca float, align 4
  %result_from_other_lane10 = alloca float, align 4
  %return_buffer9 = alloca float, align 4
  %result_from_other_lane7 = alloca float, align 4
  %return_buffer6 = alloca float, align 4
  %result_from_other_lane = alloca float, align 4
  %return_buffer = alloca float, align 4
  %tile_loop.invar_address = alloca i32, align 4
  %y_in_tile.invar_address = alloca i32, align 4
  %partial_reduction_result = alloca float, align 4
  %reduction_input_address = alloca float, align 4
  %0 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %1 = bitcast i8* %0 to [128 x [64 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %3 = bitcast i8* %2 to [128 x float]*
  %4 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %5 = bitcast i8* %4 to [64 x float]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.y(), !range !2
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %reduce-group-0-true, label %reduce-group-0-after

reduce-group-0-after:                             ; preds = %reduction_write_output-after, %entry
  ret void

reduce-group-0-true:                              ; preds = %entry
  %region_0_13_constant_7 = load float, float* bitcast ([4 x i8]* @0 to float*), align 4
  %8 = getelementptr inbounds float, float* %partial_reduction_result, i32 0
  store float %region_0_13_constant_7, float* %8, align 4
  %9 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %10 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !4
  %11 = urem i32 %9, 1024
  %12 = udiv i32 %9, 1024
  %13 = mul i32 %10, 1
  %14 = add i32 %13, %12
  %15 = icmp ult i32 %14, 2
  br i1 %15, label %16, label %early_return

16:                                               ; preds = %reduce-group-0-true
  %thread_id.x = urem i32 %11, 32
  %thread_id.y = udiv i32 %11, 32
  %lane_id = urem i32 %11, 32
  %17 = udiv i32 %14, 1
  %18 = urem i32 %17, 2
  %19 = udiv i32 %14, 2
  %20 = urem i32 %19, 1
  %21 = udiv i32 %14, 2
  %block_origin.z = mul i32 %21, 1
  %22 = icmp eq i32 %20, 0
  %tile_bound = select i1 %22, i32 128, i32 4096
  %23 = icmp eq i32 %18, 1
  %tile_bound1 = select i1 %23, i32 32, i32 32
  %tile_origin.1 = mul i32 %20, 4096
  %tile_origin.2 = mul i32 %18, 32
  %24 = mul i32 %thread_id.x, 1
  %25 = add i32 %tile_origin.2, %24
  store i32 %thread_id.y, i32* %y_in_tile.invar_address, align 4
  br label %y_in_tile.loop_header

y_in_tile.loop_header:                            ; preds = %tile_loop.loop_exit, %16
  %y_in_tile.indvar = load i32, i32* %y_in_tile.invar_address, align 4
  %26 = icmp uge i32 %y_in_tile.indvar, %tile_bound
  br i1 %26, label %y_in_tile.loop_exit, label %y_in_tile.loop_body

y_in_tile.loop_body:                              ; preds = %y_in_tile.loop_header
  %invar.inc = add nuw nsw i32 %y_in_tile.indvar, 32
  store i32 %invar.inc, i32* %y_in_tile.invar_address, align 4
  %27 = icmp eq i32 %y_in_tile.indvar, %thread_id.y
  %28 = add i32 %tile_origin.1, %y_in_tile.indvar
  store i32 0, i32* %tile_loop.invar_address, align 4
  br label %tile_loop.loop_header

tile_loop.loop_header:                            ; preds = %x_in_tile-after, %y_in_tile.loop_body
  %tile_loop.indvar = load i32, i32* %tile_loop.invar_address, align 4
  %29 = icmp uge i32 %tile_loop.indvar, 1
  br i1 %29, label %tile_loop.loop_exit, label %tile_loop.loop_body

tile_loop.loop_body:                              ; preds = %tile_loop.loop_header
  %invar.inc2 = add nuw nsw i32 %tile_loop.indvar, 1
  store i32 %invar.inc2, i32* %tile_loop.invar_address, align 4
  %30 = icmp eq i32 %tile_loop.indvar, 0
  %31 = mul i32 %tile_loop.indvar, 1
  %32 = add i32 %31, 0
  %33 = mul i32 %tile_loop.indvar, 1
  %34 = add i32 %33, 0
  %x_loc = add i32 %34, %24
  %35 = mul i32 %tile_loop.indvar, 1
  %36 = add i32 %35, 0
  %37 = add i32 %25, %36
  %38 = icmp ult i32 %x_loc, %tile_bound1
  br i1 %38, label %x_in_tile-true, label %x_in_tile-after

x_in_tile-after:                                  ; preds = %x_in_tile-true, %tile_loop.loop_body
  br label %tile_loop.loop_header, !llvm.loop !5

tile_loop.loop_exit:                              ; preds = %tile_loop.loop_header
  br label %y_in_tile.loop_header, !llvm.loop !8

y_in_tile.loop_exit:                              ; preds = %y_in_tile.loop_header
  %shmem_output_address = getelementptr inbounds [1 x [1 x [32 x [33 x float]]]], [1 x [1 x [32 x [33 x float]]]] addrspace(3)* @shared_cache, i32 0, i32 %12, i32 0, i32 %thread_id.x, i32 %thread_id.y
  %39 = addrspacecast float addrspace(3)* %shmem_output_address to float*
  %current_output = getelementptr inbounds float, float* %partial_reduction_result, i32 0
  %40 = load float, float* %current_output, align 4
  store float %40, float* %39, align 4
  call void @llvm.nvvm.barrier0()
  %shmem_transposed_addr = getelementptr inbounds [1 x [1 x [32 x [33 x float]]]], [1 x [1 x [32 x [33 x float]]]] addrspace(3)* @shared_cache, i32 0, i32 %12, i32 0, i32 %thread_id.y, i32 %thread_id.x
  %41 = addrspacecast float addrspace(3)* %shmem_transposed_addr to float*
  %partial_reduction_result5 = load float, float* %41, align 4
  %42 = call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %partial_reduction_result5, i32 16, i32 31)
  store float %42, float* %result_from_other_lane, align 4
  call void @region_1_8(float* %41, float* %result_from_other_lane, float* %return_buffer6)
  %43 = load float, float* %return_buffer6, align 4
  store float %43, float* %41, align 4
  %partial_reduction_result8 = load float, float* %41, align 4
  %44 = call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %partial_reduction_result8, i32 8, i32 31)
  store float %44, float* %result_from_other_lane7, align 4
  call void @region_1_8(float* %41, float* %result_from_other_lane7, float* %return_buffer9)
  %45 = load float, float* %return_buffer9, align 4
  store float %45, float* %41, align 4
  %partial_reduction_result11 = load float, float* %41, align 4
  %46 = call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %partial_reduction_result11, i32 4, i32 31)
  store float %46, float* %result_from_other_lane10, align 4
  call void @region_1_8(float* %41, float* %result_from_other_lane10, float* %return_buffer12)
  %47 = load float, float* %return_buffer12, align 4
  store float %47, float* %41, align 4
  %partial_reduction_result14 = load float, float* %41, align 4
  %48 = call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %partial_reduction_result14, i32 2, i32 31)
  store float %48, float* %result_from_other_lane13, align 4
  call void @region_1_8(float* %41, float* %result_from_other_lane13, float* %return_buffer15)
  %49 = load float, float* %return_buffer15, align 4
  store float %49, float* %41, align 4
  %partial_reduction_result17 = load float, float* %41, align 4
  %50 = call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %partial_reduction_result17, i32 1, i32 31)
  store float %50, float* %result_from_other_lane16, align 4
  call void @region_1_8(float* %41, float* %result_from_other_lane16, float* %return_buffer18)
  %51 = load float, float* %return_buffer18, align 4
  store float %51, float* %41, align 4
  %52 = icmp ult i32 %thread_id.x, %tile_bound
  %53 = mul i32 %thread_id.y, 1
  %54 = icmp ult i32 %53, %tile_bound1
  %55 = and i1 %54, %52
  %56 = icmp eq i32 %lane_id, 0
  %57 = and i1 %55, %56
  br i1 %57, label %reduction_write_output-true, label %reduction_write_output-after

reduction_write_output-after:                     ; preds = %reduction_write_output-true, %y_in_tile.loop_exit
  br label %reduce-group-0-after

early_return:                                     ; preds = %reduce-group-0-true
  ret void

x_in_tile-true:                                   ; preds = %tile_loop.loop_body
  %58 = mul nuw nsw i32 %37, 1
  %59 = add nuw nsw i32 0, %58
  %60 = mul nuw nsw i32 %28, 64
  %61 = add nuw nsw i32 %59, %60
  %62 = udiv i32 %61, 1
  %63 = urem i32 %62, 64
  %64 = udiv i32 %61, 64
  %Arg_1.2 = getelementptr inbounds [128 x float], [128 x float]* %3, i32 0, i32 %64
  %Arg_1.23 = load float, float* %Arg_1.2, align 4, !invariant.load !9
  %65 = bitcast [128 x [64 x float]]* %1 to float*
  %Arg_0.1 = getelementptr inbounds float, float* %65, i32 %61
  %Arg_0.14 = load float, float* %Arg_0.1, align 4, !invariant.load !9
  %multiply.5 = fmul float %Arg_1.23, %Arg_0.14
  store float %multiply.5, float* %reduction_input_address, align 4
  %66 = getelementptr inbounds float, float* %partial_reduction_result, i32 %32
  call void @region_1_8(float* %66, float* %reduction_input_address, float* %return_buffer)
  %67 = load float, float* %return_buffer, align 4
  store float %67, float* %66, align 4
  br label %x_in_tile-after

reduction_write_output-true:                      ; preds = %y_in_tile.loop_exit
  %68 = mul i32 %thread_id.y, 1
  %69 = add i32 %tile_origin.1, %thread_id.x
  %70 = add i32 %tile_origin.2, %68
  %71 = add i32 %70, 0
  %72 = mul i32 %block_origin.z, 64
  %73 = add i32 %72, %71
  %74 = udiv i32 %73, 1
  %output_element_address = getelementptr inbounds [64 x float], [64 x float]* %5, i32 0, i32 %74
  %output_value = load float, float* %41, align 4
  store float %output_value, float* %output_element_address, align 4
  br label %reduction_write_output-after
}

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.y() #0

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #0

define internal void @region_1_8(float* dereferenceable(4) %Arg_0.9.typed, float* dereferenceable(4) %Arg_1.10.typed, float* dereferenceable(4) %output_arg) {
entry:
  %add.11.typed = alloca float, align 4
  %Arg_0.9 = load float, float* %Arg_0.9.typed, align 4
  %Arg_1.10 = load float, float* %Arg_1.10.typed, align 4
  %add.11 = fadd float %Arg_0.9, %Arg_1.10
  store float %add.11, float* %add.11.typed, align 4
  %load_ret_value = load float, float* %add.11.typed, align 4
  store float %load_ret_value, float* %output_arg, align 4
  ret void
}

; Function Attrs: convergent nounwind
declare void @llvm.nvvm.barrier0() #1

; Function Attrs: convergent inaccessiblememonly nounwind
declare float @llvm.nvvm.shfl.sync.down.f32(i32, float, i32, i32) #2

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
