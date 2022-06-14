; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @gather_3(i8* noalias nocapture readonly align 16 dereferenceable(32768) %alloc0, i8* noalias nocapture readonly align 16 dereferenceable(64) %alloc1, i8* noalias nocapture writeonly align 128 dereferenceable(16384) %alloc2) local_unnamed_addr #0 {
entry:
  %alloc25 = addrspacecast i8* %alloc2 to i8 addrspace(1)*
  %alloc13 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !3
  %1 = shl nuw nsw i32 %0, 10
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !4
  %3 = shl nuw nsw i32 %2, 2
  %linear_index_base = or i32 %1, %3
  %linear_index3 = or i32 %linear_index_base, 3
  %4 = lshr i32 %linear_index_base, 4
  %5 = and i32 %linear_index3, 15
  %linear_index2 = or i32 %linear_index_base, 2
  %6 = and i32 %linear_index2, 14
  %linear_index1 = or i32 %linear_index_base, 1
  %7 = and i32 %linear_index1, 13
  %8 = and i32 %3, 12
  %9 = bitcast i8 addrspace(1)* %alloc13 to [16 x [1 x i32]] addrspace(1)*
  %10 = bitcast i8 addrspace(1)* %alloc01 to [256 x [32 x float]] addrspace(1)*
  %11 = zext i32 %8 to i64
  %12 = getelementptr inbounds [16 x [1 x i32]], [16 x [1 x i32]] addrspace(1)* %9, i64 0, i64 %11, i64 0
  %13 = load i32, i32 addrspace(1)* %12, align 16, !invariant.load !5
  %14 = tail call i32 @llvm.smax.i32(i32 %13, i32 0)
  %15 = tail call i32 @llvm.umin.i32(i32 %14, i32 31)
  %16 = zext i32 %4 to i64
  %17 = zext i32 %15 to i64
  %18 = getelementptr inbounds [256 x [32 x float]], [256 x [32 x float]] addrspace(1)* %10, i64 0, i64 %16, i64 %17
  %19 = load float, float addrspace(1)* %18, align 4, !invariant.load !5
  %20 = bitcast i8 addrspace(1)* %alloc25 to float addrspace(1)*
  %21 = zext i32 %linear_index_base to i64
  %22 = getelementptr float, float addrspace(1)* %20, i64 %21
  %23 = zext i32 %7 to i64
  %24 = getelementptr inbounds [16 x [1 x i32]], [16 x [1 x i32]] addrspace(1)* %9, i64 0, i64 %23, i64 0
  %25 = load i32, i32 addrspace(1)* %24, align 4, !invariant.load !5
  %26 = tail call i32 @llvm.smax.i32(i32 %25, i32 0)
  %27 = tail call i32 @llvm.umin.i32(i32 %26, i32 31)
  %28 = zext i32 %27 to i64
  %29 = getelementptr inbounds [256 x [32 x float]], [256 x [32 x float]] addrspace(1)* %10, i64 0, i64 %16, i64 %28
  %30 = load float, float addrspace(1)* %29, align 4, !invariant.load !5
  %31 = zext i32 %6 to i64
  %32 = getelementptr inbounds [16 x [1 x i32]], [16 x [1 x i32]] addrspace(1)* %9, i64 0, i64 %31, i64 0
  %33 = load i32, i32 addrspace(1)* %32, align 8, !invariant.load !5
  %34 = tail call i32 @llvm.smax.i32(i32 %33, i32 0)
  %35 = tail call i32 @llvm.umin.i32(i32 %34, i32 31)
  %36 = zext i32 %35 to i64
  %37 = getelementptr inbounds [256 x [32 x float]], [256 x [32 x float]] addrspace(1)* %10, i64 0, i64 %16, i64 %36
  %38 = load float, float addrspace(1)* %37, align 4, !invariant.load !5
  %39 = zext i32 %5 to i64
  %40 = getelementptr inbounds [16 x [1 x i32]], [16 x [1 x i32]] addrspace(1)* %9, i64 0, i64 %39, i64 0
  %41 = load i32, i32 addrspace(1)* %40, align 4, !invariant.load !5
  %42 = tail call i32 @llvm.smax.i32(i32 %41, i32 0)
  %43 = tail call i32 @llvm.umin.i32(i32 %42, i32 31)
  %44 = zext i32 %43 to i64
  %45 = getelementptr inbounds [256 x [32 x float]], [256 x [32 x float]] addrspace(1)* %10, i64 0, i64 %16, i64 %44
  %46 = load float, float addrspace(1)* %45, align 4, !invariant.load !5
  %47 = insertelement <4 x float> poison, float %19, i32 0
  %48 = insertelement <4 x float> %47, float %30, i32 1
  %49 = insertelement <4 x float> %48, float %38, i32 2
  %50 = insertelement <4 x float> %49, float %46, i32 3
  %51 = bitcast float addrspace(1)* %22 to <4 x float> addrspace(1)*
  store <4 x float> %50, <4 x float> addrspace(1)* %51, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #1

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.smax.i32(i32, i32) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.umin.i32(i32, i32) #2

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #1 = { nofree nosync nounwind readnone speculatable }
attributes #2 = { mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn }

!nvvm.annotations = !{!0, !1}
!llvm.module.flags = !{!2}

!0 = !{void (i8*, i8*, i8*)* @gather_3, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @gather_3, !"reqntidx", i32 256}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{i32 0, i32 4}
!4 = !{i32 0, i32 256}
!5 = !{}
