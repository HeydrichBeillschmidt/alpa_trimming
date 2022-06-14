; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @slice_5(i8* noalias nocapture readonly align 16 dereferenceable(4096) %alloc0, i8* noalias nocapture writeonly align 128 dereferenceable(1024) %alloc4) local_unnamed_addr #0 {
entry:
  %alloc43 = addrspacecast i8* %alloc4 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !9
  %linear_index_base = shl nuw nsw i32 %0, 2
  %linear_index3 = or i32 %linear_index_base, 3
  %1 = lshr i32 %0, 3
  %2 = and i32 %linear_index3, 31
  %linear_index2 = or i32 %linear_index_base, 2
  %3 = and i32 %linear_index2, 30
  %linear_index1 = or i32 %linear_index_base, 1
  %4 = and i32 %linear_index1, 29
  %5 = and i32 %linear_index_base, 28
  %6 = bitcast i8 addrspace(1)* %alloc01 to [32 x [32 x float]] addrspace(1)*
  %7 = zext i32 %5 to i64
  %8 = zext i32 %1 to i64
  %9 = getelementptr [32 x [32 x float]], [32 x [32 x float]] addrspace(1)* %6, i64 0, i64 %8, i64 %7
  %10 = getelementptr inbounds float, float addrspace(1)* %9, i64 768
  %11 = bitcast float addrspace(1)* %10 to <4 x float> addrspace(1)*
  %12 = load <4 x float>, <4 x float> addrspace(1)* %11, align 16, !invariant.load !10
  %13 = extractelement <4 x float> %12, i32 0
  %14 = extractelement <4 x float> %12, i32 1
  %15 = extractelement <4 x float> %12, i32 2
  %16 = extractelement <4 x float> %12, i32 3
  %17 = bitcast i8 addrspace(1)* %alloc43 to float addrspace(1)*
  %18 = zext i32 %linear_index_base to i64
  %19 = getelementptr float, float addrspace(1)* %17, i64 %18
  %20 = zext i32 %4 to i64
  %21 = getelementptr [32 x [32 x float]], [32 x [32 x float]] addrspace(1)* %6, i64 0, i64 %8, i64 %20
  %22 = zext i32 %3 to i64
  %23 = getelementptr [32 x [32 x float]], [32 x [32 x float]] addrspace(1)* %6, i64 0, i64 %8, i64 %22
  %24 = zext i32 %2 to i64
  %25 = getelementptr [32 x [32 x float]], [32 x [32 x float]] addrspace(1)* %6, i64 0, i64 %8, i64 %24
  %26 = insertelement <4 x float> poison, float %13, i32 0
  %27 = insertelement <4 x float> %26, float %14, i32 1
  %28 = insertelement <4 x float> %27, float %15, i32 2
  %29 = insertelement <4 x float> %28, float %16, i32 3
  %30 = bitcast float addrspace(1)* %19 to <4 x float> addrspace(1)*
  store <4 x float> %29, <4 x float> addrspace(1)* %30, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @slice_2(i8* noalias nocapture readonly align 16 dereferenceable(4096) %alloc0, i8* noalias nocapture writeonly align 128 dereferenceable(1024) %alloc1) local_unnamed_addr #0 {
entry:
  %alloc13 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !9
  %linear_index_base = shl nuw nsw i32 %0, 2
  %linear_index3 = or i32 %linear_index_base, 3
  %1 = lshr i32 %0, 3
  %2 = and i32 %linear_index3, 31
  %linear_index2 = or i32 %linear_index_base, 2
  %3 = and i32 %linear_index2, 30
  %linear_index1 = or i32 %linear_index_base, 1
  %4 = and i32 %linear_index1, 29
  %5 = and i32 %linear_index_base, 28
  %6 = bitcast i8 addrspace(1)* %alloc01 to [32 x [32 x float]] addrspace(1)*
  %7 = zext i32 %1 to i64
  %8 = zext i32 %5 to i64
  %9 = getelementptr inbounds [32 x [32 x float]], [32 x [32 x float]] addrspace(1)* %6, i64 0, i64 %7, i64 %8
  %10 = bitcast float addrspace(1)* %9 to <4 x float> addrspace(1)*
  %11 = load <4 x float>, <4 x float> addrspace(1)* %10, align 16, !invariant.load !10
  %12 = extractelement <4 x float> %11, i32 0
  %13 = extractelement <4 x float> %11, i32 1
  %14 = extractelement <4 x float> %11, i32 2
  %15 = extractelement <4 x float> %11, i32 3
  %16 = bitcast i8 addrspace(1)* %alloc13 to float addrspace(1)*
  %17 = zext i32 %linear_index_base to i64
  %18 = getelementptr float, float addrspace(1)* %16, i64 %17
  %19 = zext i32 %4 to i64
  %20 = zext i32 %3 to i64
  %21 = zext i32 %2 to i64
  %22 = insertelement <4 x float> poison, float %12, i32 0
  %23 = insertelement <4 x float> %22, float %13, i32 1
  %24 = insertelement <4 x float> %23, float %14, i32 2
  %25 = insertelement <4 x float> %24, float %15, i32 3
  %26 = bitcast float addrspace(1)* %18 to <4 x float> addrspace(1)*
  store <4 x float> %25, <4 x float> addrspace(1)* %26, align 16
  ret void
}

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #1 = { nofree nosync nounwind readnone speculatable }

!nvvm.annotations = !{!0, !1, !2, !3, !4, !5, !6, !7}
!llvm.module.flags = !{!8}

!0 = !{void (i8*, i8*)* @slice_5, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @slice_5, !"reqntidx", i32 64}
!2 = distinct !{null, !"kernel", i32 1}
!3 = distinct !{null, !"reqntidx", i32 64}
!4 = !{void (i8*, i8*)* @slice_2, !"kernel", i32 1}
!5 = !{void (i8*, i8*)* @slice_2, !"reqntidx", i32 64}
!6 = distinct !{null, !"kernel", i32 1}
!7 = distinct !{null, !"reqntidx", i32 64}
!8 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!9 = !{i32 0, i32 64}
!10 = !{}
