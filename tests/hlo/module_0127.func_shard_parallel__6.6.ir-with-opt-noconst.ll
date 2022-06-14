target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

@shared_cache = external dso_local unnamed_addr addrspace(3) global [1 x [1 x [32 x [33 x float]]]]

; Function Attrs: nounwind
define void @input_fusion_reduce(i8* noalias nocapture readonly align 16 dereferenceable(512) %alloc0, i8* noalias nocapture readonly align 16 dereferenceable(32768) %alloc1, i8* noalias nocapture writeonly align 128 dereferenceable(256) %alloc2) local_unnamed_addr #0 {
entry:
  %alloc235 = addrspacecast i8* %alloc2 to i8 addrspace(1)*
  %alloc133 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc031 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !3
  %1 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !4
  %thread_id.x = and i32 %1, 31
  %thread_id.y19 = lshr i32 %1, 5
  %tile_origin.2 = shl nuw nsw i32 %0, 5
  %2 = or i32 %tile_origin.2, %thread_id.x
  %3 = add nuw nsw i32 %thread_id.y19, -32
  %4 = shl nuw nsw i32 %thread_id.y19, 6
  %5 = zext i32 %1 to i64
  %6 = lshr i64 %5, 5
  %7 = shl nuw nsw i64 %6, 2
  %scevgep = getelementptr i8, i8 addrspace(1)* %alloc031, i64 %7
  br label %y_in_tile.loop_body

common.ret:                                       ; preds = %reduction_write_output-true, %y_in_tile.loop_exit
  ret void

y_in_tile.loop_body:                              ; preds = %y_in_tile.loop_body, %entry
  %lsr.iv39 = phi i8 addrspace(1)* [ %scevgep, %entry ], [ %scevgep40, %y_in_tile.loop_body ]
  %lsr.iv37 = phi i32 [ %4, %entry ], [ %lsr.iv.next38, %y_in_tile.loop_body ]
  %lsr.iv = phi i32 [ %3, %entry ], [ %lsr.iv.next, %y_in_tile.loop_body ]
  %partial_reduction_result.029 = phi float [ 0.000000e+00, %entry ], [ %add.11.i, %y_in_tile.loop_body ]
  %8 = bitcast i8 addrspace(1)* %alloc133 to float addrspace(1)*
  %lsr.iv3941 = bitcast i8 addrspace(1)* %lsr.iv39 to float addrspace(1)*
  %9 = or i32 %lsr.iv37, %2
  %Arg_1.23 = load float, float addrspace(1)* %lsr.iv3941, align 4, !invariant.load !5
  %10 = zext i32 %9 to i64
  %Arg_0.1 = getelementptr inbounds float, float addrspace(1)* %8, i64 %10
  %Arg_0.14 = load float, float addrspace(1)* %Arg_0.1, align 4, !invariant.load !5
  %multiply.5 = fmul float %Arg_1.23, %Arg_0.14
  %add.11.i = fadd float %partial_reduction_result.029, %multiply.5
  %lsr.iv.next = add nsw i32 %lsr.iv, 32
  %lsr.iv.next38 = add nuw nsw i32 %lsr.iv37, 2048
  %scevgep40 = getelementptr i8, i8 addrspace(1)* %lsr.iv39, i64 128
  %11 = icmp ugt i32 %lsr.iv.next, 95
  br i1 %11, label %y_in_tile.loop_exit, label %y_in_tile.loop_body

y_in_tile.loop_exit:                              ; preds = %y_in_tile.loop_body
  %12 = bitcast i8 addrspace(1)* %alloc235 to [64 x float] addrspace(1)*
  %13 = zext i32 %thread_id.x to i64
  %14 = zext i32 %thread_id.y19 to i64
  %shmem_output_address = getelementptr inbounds [1 x [1 x [32 x [33 x float]]]], [1 x [1 x [32 x [33 x float]]]] addrspace(3)* @shared_cache, i64 0, i64 0, i64 0, i64 %13, i64 %14
  store float %add.11.i, float addrspace(3)* %shmem_output_address, align 4
  tail call void @llvm.nvvm.barrier0()
  %shmem_transposed_addr = getelementptr inbounds [1 x [1 x [32 x [33 x float]]]], [1 x [1 x [32 x [33 x float]]]] addrspace(3)* @shared_cache, i64 0, i64 0, i64 0, i64 %14, i64 %13
  %partial_reduction_result5 = load float, float addrspace(3)* %shmem_transposed_addr, align 4
  %15 = tail call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %partial_reduction_result5, i32 16, i32 31)
  %add.11.i28 = fadd float %partial_reduction_result5, %15
  %16 = tail call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %add.11.i28, i32 8, i32 31)
  %add.11.i27 = fadd float %add.11.i28, %16
  %17 = tail call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %add.11.i27, i32 4, i32 31)
  %add.11.i26 = fadd float %add.11.i27, %17
  %18 = tail call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %add.11.i26, i32 2, i32 31)
  %add.11.i25 = fadd float %add.11.i26, %18
  %19 = tail call float @llvm.nvvm.shfl.sync.down.f32(i32 -1, float %add.11.i25, i32 1, i32 31)
  %add.11.i24 = fadd float %add.11.i25, %19
  store float %add.11.i24, float addrspace(3)* %shmem_transposed_addr, align 4
  %20 = icmp eq i32 %thread_id.x, 0
  %21 = or i32 %tile_origin.2, %thread_id.y19
  %22 = zext i32 %21 to i64
  %output_element_address = getelementptr inbounds [64 x float], [64 x float] addrspace(1)* %12, i64 0, i64 %22
  br i1 %20, label %reduction_write_output-true, label %common.ret

reduction_write_output-true:                      ; preds = %y_in_tile.loop_exit
  store float %add.11.i24, float addrspace(1)* %output_element_address, align 4
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
