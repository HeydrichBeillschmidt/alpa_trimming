; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion(i8* noalias nocapture readonly align 16 dereferenceable(262144) %alloc0, i8* noalias nocapture writeonly align 128 dereferenceable(262144) %alloc1) local_unnamed_addr #0 {
entry:
  %alloc13 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !3
  %1 = shl nuw nsw i32 %0, 10
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !4
  %3 = shl nuw nsw i32 %2, 2
  %linear_index_base = or i32 %1, %3
  %linear_index3 = or i32 %linear_index_base, 3
  %4 = lshr i32 %2, 6
  %5 = and i32 %linear_index3, 255
  %linear_index2 = or i32 %linear_index_base, 2
  %6 = and i32 %linear_index2, 254
  %linear_index1 = or i32 %linear_index_base, 1
  %7 = and i32 %linear_index1, 253
  %8 = and i32 %3, 252
  %9 = bitcast i8 addrspace(1)* %alloc01 to [64 x [256 x [4 x float]]] addrspace(1)*
  %10 = zext i32 %0 to i64
  %11 = zext i32 %8 to i64
  %12 = zext i32 %4 to i64
  %13 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]] addrspace(1)* %9, i64 0, i64 %10, i64 %11, i64 %12
  %14 = load float, float addrspace(1)* %13, align 4, !invariant.load !5
  %15 = bitcast i8 addrspace(1)* %alloc13 to float addrspace(1)*
  %16 = zext i32 %linear_index_base to i64
  %17 = getelementptr float, float addrspace(1)* %15, i64 %16
  %18 = zext i32 %7 to i64
  %19 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]] addrspace(1)* %9, i64 0, i64 %10, i64 %18, i64 %12
  %20 = load float, float addrspace(1)* %19, align 4, !invariant.load !5
  %21 = zext i32 %6 to i64
  %22 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]] addrspace(1)* %9, i64 0, i64 %10, i64 %21, i64 %12
  %23 = load float, float addrspace(1)* %22, align 4, !invariant.load !5
  %24 = zext i32 %5 to i64
  %25 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]] addrspace(1)* %9, i64 0, i64 %10, i64 %24, i64 %12
  %26 = load float, float addrspace(1)* %25, align 4, !invariant.load !5
  %27 = insertelement <4 x float> poison, float %14, i32 0
  %28 = insertelement <4 x float> %27, float %20, i32 1
  %29 = insertelement <4 x float> %28, float %23, i32 2
  %30 = insertelement <4 x float> %29, float %26, i32 3
  %31 = bitcast float addrspace(1)* %17 to <4 x float> addrspace(1)*
  store <4 x float> %30, <4 x float> addrspace(1)* %31, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #1

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #1 = { nofree nosync nounwind readnone speculatable }

!nvvm.annotations = !{!0, !1}
!llvm.module.flags = !{!2}

!0 = !{void (i8*, i8*)* @fusion, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @fusion, !"reqntidx", i32 256}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{i32 0, i32 64}
!4 = !{i32 0, i32 256}
!5 = !{}
