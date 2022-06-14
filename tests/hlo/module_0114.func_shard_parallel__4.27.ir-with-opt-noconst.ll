target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

@shared_cache = external dso_local unnamed_addr addrspace(3) global [1 x [1 x [32 x [33 x float]]]]
@shared_cache1 = external dso_local unnamed_addr addrspace(3) global [1 x [1 x [32 x [33 x i32]]]]

; Function Attrs: nounwind
define void @input_fusion_reduce(i8* noalias nocapture readonly align 16 dereferenceable(20736) %alloc0, i8* noalias nocapture writeonly align 128 dereferenceable(144) %alloc1, i8* noalias nocapture writeonly align 128 dereferenceable(272) %temp_buf) local_unnamed_addr #0 {
entry:
  %temp_buf90 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %alloc188 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc086 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !3
  %1 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !4
  %thread_id.x = and i32 %1, 31
  %thread_id.y45 = lshr i32 %1, 5
  %2 = icmp eq i32 %0, 1
  %tile_bound3 = select i1 %2, i32 4, i32 32
  %tile_origin.2 = shl nuw nsw i32 %0, 5
  %3 = or i32 %tile_origin.2, %thread_id.x
  %4 = icmp ult i32 %thread_id.x, %tile_bound3
  %5 = zext i32 %3 to i64
  br i1 %4, label %y_in_tile.loop_body.us.preheader, label %y_in_tile.loop_exit

y_in_tile.loop_body.us.preheader:                 ; preds = %entry
  %6 = zext i32 %1 to i64
  %7 = lshr i64 %6, 5
  %8 = mul nuw nsw i64 %7, 144
  %9 = shl nuw nsw i64 %5, 2
  %10 = add i64 %8, %9
  %scevgep = getelementptr i8, i8 addrspace(1)* %alloc086, i64 %10
  br label %y_in_tile.loop_body.us

y_in_tile.loop_body.us:                           ; preds = %y_in_tile.loop_body.us, %y_in_tile.loop_body.us.preheader
  %lsr.iv = phi i8 addrspace(1)* [ %scevgep, %y_in_tile.loop_body.us.preheader ], [ %scevgep92, %y_in_tile.loop_body.us ]
  %y_in_tile.invar_address.078.us = phi i32 [ %invar.inc.us, %y_in_tile.loop_body.us ], [ %thread_id.y45, %y_in_tile.loop_body.us.preheader ]
  %partial_reduction_result2.177.us = phi i32 [ %15, %y_in_tile.loop_body.us ], [ 0, %y_in_tile.loop_body.us.preheader ]
  %partial_reduction_result.176.us = phi float [ %16, %y_in_tile.loop_body.us ], [ 0xFFF0000000000000, %y_in_tile.loop_body.us.preheader ]
  %invar.inc.us = add nuw nsw i32 %y_in_tile.invar_address.078.us, 32
  %lsr.iv93 = bitcast i8 addrspace(1)* %lsr.iv to float addrspace(1)*
  %Arg_0.15.us = load float, float addrspace(1)* %lsr.iv93, align 4, !invariant.load !5
  %compare.10.i60.us = fcmp ogt float %partial_reduction_result.176.us, %Arg_0.15.us
  %compare.11.i61.us = fcmp uno float %partial_reduction_result.176.us, 0.000000e+00
  %11 = or i1 %compare.11.i61.us, %compare.10.i60.us
  %compare.13.i62.us = fcmp oeq float %partial_reduction_result.176.us, %Arg_0.15.us
  %12 = icmp slt i32 %partial_reduction_result2.177.us, %y_in_tile.invar_address.078.us
  %13 = and i1 %12, %compare.13.i62.us
  %14 = or i1 %11, %13
  %15 = select i1 %14, i32 %partial_reduction_result2.177.us, i32 %y_in_tile.invar_address.078.us
  %16 = select i1 %11, float %partial_reduction_result.176.us, float %Arg_0.15.us
  %scevgep92 = getelementptr i8, i8 addrspace(1)* %lsr.iv, i64 4608
  %17 = icmp ugt i32 %y_in_tile.invar_address.078.us, 111
  br i1 %17, label %y_in_tile.loop_exit, label %y_in_tile.loop_body.us

common.ret:                                       ; preds = %reduction_write_output-true, %y_in_tile.loop_exit
  ret void

y_in_tile.loop_exit:                              ; preds = %y_in_tile.loop_body.us, %entry
  %partial_reduction_result.1.lcssa = phi float [ 0xFFF0000000000000, %entry ], [ %16, %y_in_tile.loop_body.us ]
  %partial_reduction_result2.1.lcssa = phi i32 [ 0, %entry ], [ %15, %y_in_tile.loop_body.us ]
  %18 = bitcast i8 addrspace(1)* %alloc188 to [36 x i32] addrspace(1)*
  %19 = bitcast i8 addrspace(1)* %temp_buf90 to [36 x float] addrspace(1)*
  %20 = zext i32 %thread_id.x to i64
  %21 = zext i32 %thread_id.y45 to i64
  %shmem_output_address = getelementptr inbounds [1 x [1 x [32 x [33 x float]]]], [1 x [1 x [32 x [33 x float]]]] addrspace(3)* @shared_cache, i64 0, i64 0, i64 0, i64 %20, i64 %21
  store float %partial_reduction_result.1.lcssa, float addrspace(3)* %shmem_output_address, align 4
  %shmem_output_address6 = getelementptr inbounds [1 x [1 x [32 x [33 x i32]]]], [1 x [1 x [32 x [33 x i32]]]] addrspace(3)* @shared_cache1, i64 0, i64 0, i64 0, i64 %20, i64 %21
  store i32 %partial_reduction_result2.1.lcssa, i32 addrspace(3)* %shmem_output_address6, align 4
  tail call void @llvm.nvvm.barrier0()
  %shmem_transposed_addr = getelementptr inbounds [1 x [1 x [32 x [33 x float]]]], [1 x [1 x [32 x [33 x float]]]] addrspace(3)* @shared_cache, i64 0, i64 0, i64 0, i64 %21, i64 %20
  %shmem_transposed_addr8 = getelementptr inbounds [1 x [1 x [32 x [33 x i32]]]], [1 x [1 x [32 x [33 x i32]]]] addrspace(3)* @shared_cache1, i64 0, i64 0, i64 0, i64 %21, i64 %20
  %partial_reduction_result9 = load float, float addrspace(3)* %shmem_transposed_addr, align 4
  %22 = tail call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %partial_reduction_result9, i32 16, i32 31)
  %23 = load i32, i32 addrspace(3)* %shmem_transposed_addr8, align 4
  %24 = tail call i32 @llvm.nvvm.shfl.sync.down.i32(i32 -1, i32 %23, i32 16, i32 31)
  %compare.10.i = fcmp ogt float %partial_reduction_result9, %22
  %compare.11.i = fcmp uno float %partial_reduction_result9, 0.000000e+00
  %25 = or i1 %compare.11.i, %compare.10.i
  %compare.13.i = fcmp oeq float %partial_reduction_result9, %22
  %26 = icmp slt i32 %23, %24
  %27 = and i1 %compare.13.i, %26
  %28 = or i1 %25, %27
  %29 = select i1 %28, i32 %23, i32 %24
  %30 = select i1 %25, float %partial_reduction_result9, float %22
  %31 = tail call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %30, i32 8, i32 31)
  %32 = tail call i32 @llvm.nvvm.shfl.sync.down.i32(i32 -1, i32 %29, i32 8, i32 31)
  %compare.10.i72 = fcmp ogt float %30, %31
  %compare.11.i73 = fcmp uno float %30, 0.000000e+00
  %33 = or i1 %compare.11.i73, %compare.10.i72
  %compare.13.i74 = fcmp oeq float %30, %31
  %34 = icmp slt i32 %29, %32
  %35 = and i1 %compare.13.i74, %34
  %36 = or i1 %33, %35
  %37 = select i1 %36, i32 %29, i32 %32
  %38 = select i1 %33, float %30, float %31
  %39 = tail call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %38, i32 4, i32 31)
  %40 = tail call i32 @llvm.nvvm.shfl.sync.down.i32(i32 -1, i32 %37, i32 4, i32 31)
  %compare.10.i69 = fcmp ogt float %38, %39
  %compare.11.i70 = fcmp uno float %38, 0.000000e+00
  %41 = or i1 %compare.11.i70, %compare.10.i69
  %compare.13.i71 = fcmp oeq float %38, %39
  %42 = icmp slt i32 %37, %40
  %43 = and i1 %compare.13.i71, %42
  %44 = or i1 %41, %43
  %45 = select i1 %44, i32 %37, i32 %40
  %46 = select i1 %41, float %38, float %39
  %47 = tail call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %46, i32 2, i32 31)
  %48 = tail call i32 @llvm.nvvm.shfl.sync.down.i32(i32 -1, i32 %45, i32 2, i32 31)
  %compare.10.i66 = fcmp ogt float %46, %47
  %compare.11.i67 = fcmp uno float %46, 0.000000e+00
  %49 = or i1 %compare.11.i67, %compare.10.i66
  %compare.13.i68 = fcmp oeq float %46, %47
  %50 = icmp slt i32 %45, %48
  %51 = and i1 %compare.13.i68, %50
  %52 = or i1 %49, %51
  %53 = select i1 %52, i32 %45, i32 %48
  %54 = select i1 %49, float %46, float %47
  %55 = tail call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %54, i32 1, i32 31)
  %56 = tail call i32 @llvm.nvvm.shfl.sync.down.i32(i32 -1, i32 %53, i32 1, i32 31)
  %compare.10.i63 = fcmp ogt float %54, %55
  %compare.11.i64 = fcmp uno float %54, 0.000000e+00
  %57 = or i1 %compare.11.i64, %compare.10.i63
  %compare.13.i65 = fcmp oeq float %54, %55
  %58 = icmp slt i32 %53, %56
  %59 = and i1 %compare.13.i65, %58
  %60 = or i1 %57, %59
  %61 = select i1 %60, i32 %53, i32 %56
  %62 = select i1 %57, float %54, float %55
  store float %62, float addrspace(3)* %shmem_transposed_addr, align 4
  store i32 %61, i32 addrspace(3)* %shmem_transposed_addr8, align 4
  %63 = icmp ult i32 %thread_id.y45, %tile_bound3
  %64 = icmp eq i32 %thread_id.x, 0
  %65 = and i1 %64, %63
  %66 = or i32 %tile_origin.2, %thread_id.y45
  %67 = zext i32 %66 to i64
  %output_element_address43 = getelementptr inbounds [36 x i32], [36 x i32] addrspace(1)* %18, i64 0, i64 %67
  %output_element_address = getelementptr inbounds [36 x float], [36 x float] addrspace(1)* %19, i64 0, i64 %67
  br i1 %65, label %reduction_write_output-true, label %common.ret

reduction_write_output-true:                      ; preds = %y_in_tile.loop_exit
  store float %62, float addrspace(1)* %output_element_address, align 4
  store i32 %61, i32 addrspace(1)* %output_element_address43, align 4
  br label %common.ret
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #1

; Function Attrs: convergent nounwind
declare void @llvm.nvvm.barrier0() #2

; Function Attrs: convergent inaccessiblememonly nounwind
declare float @llvm.nvvm.shfl.sync.down.f32(i32, float, i32, i32) #3

; Function Attrs: convergent inaccessiblememonly nounwind
declare i32 @llvm.nvvm.shfl.sync.down.i32(i32, i32, i32, i32) #3

attributes #0 = { nounwind }
attributes #1 = { nofree nosync nounwind readnone speculatable }
attributes #2 = { convergent nounwind }
attributes #3 = { convergent inaccessiblememonly nounwind }

!nvvm.annotations = !{!0, !1}
!llvm.module.flags = !{!2}

!0 = !{void (i8*, i8*, i8*)* @input_fusion_reduce, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @input_fusion_reduce, !"reqntidx", i32 1024}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{i32 0, i32 2}
!4 = !{i32 0, i32 1024}
!5 = !{}
