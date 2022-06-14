; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @slice_5(i8* noalias nocapture readonly align 16 dereferenceable(65536) %alloc0, i8* noalias nocapture writeonly align 128 dereferenceable(16384) %alloc4) local_unnamed_addr #0 {
entry:
  %alloc43 = addrspacecast i8* %alloc4 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !9
  %1 = shl nuw nsw i32 %0, 10
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !10
  %3 = shl nuw nsw i32 %2, 2
  %linear_index_base = or i32 %1, %3
  %linear_index3 = or i32 %linear_index_base, 3
  %4 = lshr i32 %linear_index_base, 7
  %5 = and i32 %linear_index3, 127
  %linear_index2 = or i32 %linear_index_base, 2
  %6 = and i32 %linear_index2, 126
  %linear_index1 = or i32 %linear_index_base, 1
  %7 = and i32 %linear_index1, 125
  %8 = and i32 %3, 124
  %9 = bitcast i8 addrspace(1)* %alloc01 to [128 x [128 x float]] addrspace(1)*
  %10 = zext i32 %8 to i64
  %11 = zext i32 %4 to i64
  %12 = getelementptr [128 x [128 x float]], [128 x [128 x float]] addrspace(1)* %9, i64 0, i64 %11, i64 %10
  %13 = getelementptr inbounds float, float addrspace(1)* %12, i64 12288
  %14 = load float, float addrspace(1)* %13, align 16, !invariant.load !11
  %15 = bitcast i8 addrspace(1)* %alloc43 to float addrspace(1)*
  %16 = zext i32 %linear_index_base to i64
  %17 = getelementptr float, float addrspace(1)* %15, i64 %16
  %18 = zext i32 %7 to i64
  %19 = getelementptr [128 x [128 x float]], [128 x [128 x float]] addrspace(1)* %9, i64 0, i64 %11, i64 %18
  %20 = getelementptr inbounds float, float addrspace(1)* %19, i64 12288
  %21 = load float, float addrspace(1)* %20, align 4, !invariant.load !11
  %22 = zext i32 %6 to i64
  %23 = getelementptr [128 x [128 x float]], [128 x [128 x float]] addrspace(1)* %9, i64 0, i64 %11, i64 %22
  %24 = getelementptr inbounds float, float addrspace(1)* %23, i64 12288
  %25 = load float, float addrspace(1)* %24, align 8, !invariant.load !11
  %26 = zext i32 %5 to i64
  %27 = getelementptr [128 x [128 x float]], [128 x [128 x float]] addrspace(1)* %9, i64 0, i64 %11, i64 %26
  %28 = getelementptr inbounds float, float addrspace(1)* %27, i64 12288
  %29 = load float, float addrspace(1)* %28, align 4, !invariant.load !11
  %30 = insertelement <4 x float> poison, float %14, i32 0
  %31 = insertelement <4 x float> %30, float %21, i32 1
  %32 = insertelement <4 x float> %31, float %25, i32 2
  %33 = insertelement <4 x float> %32, float %29, i32 3
  %34 = bitcast float addrspace(1)* %17 to <4 x float> addrspace(1)*
  store <4 x float> %33, <4 x float> addrspace(1)* %34, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #1

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @slice_2(i8* noalias nocapture readonly align 16 dereferenceable(65536) %alloc0, i8* noalias nocapture writeonly align 128 dereferenceable(16384) %alloc1) local_unnamed_addr #0 {
entry:
  %alloc13 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !9
  %1 = shl nuw nsw i32 %0, 10
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !10
  %3 = shl nuw nsw i32 %2, 2
  %linear_index_base = or i32 %1, %3
  %linear_index3 = or i32 %linear_index_base, 3
  %4 = lshr i32 %linear_index_base, 7
  %5 = and i32 %linear_index3, 127
  %linear_index2 = or i32 %linear_index_base, 2
  %6 = and i32 %linear_index2, 126
  %linear_index1 = or i32 %linear_index_base, 1
  %7 = and i32 %linear_index1, 125
  %8 = and i32 %3, 124
  %9 = bitcast i8 addrspace(1)* %alloc01 to [128 x [128 x float]] addrspace(1)*
  %10 = zext i32 %4 to i64
  %11 = zext i32 %8 to i64
  %12 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]] addrspace(1)* %9, i64 0, i64 %10, i64 %11
  %13 = load float, float addrspace(1)* %12, align 16, !invariant.load !11
  %14 = bitcast i8 addrspace(1)* %alloc13 to float addrspace(1)*
  %15 = zext i32 %linear_index_base to i64
  %16 = getelementptr float, float addrspace(1)* %14, i64 %15
  %17 = zext i32 %7 to i64
  %18 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]] addrspace(1)* %9, i64 0, i64 %10, i64 %17
  %19 = load float, float addrspace(1)* %18, align 4, !invariant.load !11
  %20 = zext i32 %6 to i64
  %21 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]] addrspace(1)* %9, i64 0, i64 %10, i64 %20
  %22 = load float, float addrspace(1)* %21, align 8, !invariant.load !11
  %23 = zext i32 %5 to i64
  %24 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]] addrspace(1)* %9, i64 0, i64 %10, i64 %23
  %25 = load float, float addrspace(1)* %24, align 4, !invariant.load !11
  %26 = insertelement <4 x float> poison, float %13, i32 0
  %27 = insertelement <4 x float> %26, float %19, i32 1
  %28 = insertelement <4 x float> %27, float %22, i32 2
  %29 = insertelement <4 x float> %28, float %25, i32 3
  %30 = bitcast float addrspace(1)* %16 to <4 x float> addrspace(1)*
  store <4 x float> %29, <4 x float> addrspace(1)* %30, align 16
  ret void
}

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #1 = { nofree nosync nounwind readnone speculatable }

!nvvm.annotations = !{!0, !1, !2, !3, !4, !5, !6, !7}
!llvm.module.flags = !{!8}

!0 = !{void (i8*, i8*)* @slice_5, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @slice_5, !"reqntidx", i32 256}
!2 = distinct !{null, !"kernel", i32 1}
!3 = distinct !{null, !"reqntidx", i32 256}
!4 = !{void (i8*, i8*)* @slice_2, !"kernel", i32 1}
!5 = !{void (i8*, i8*)* @slice_2, !"reqntidx", i32 256}
!6 = distinct !{null, !"kernel", i32 1}
!7 = distinct !{null, !"reqntidx", i32 256}
!8 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!9 = !{i32 0, i32 4}
!10 = !{i32 0, i32 256}
!11 = !{}
