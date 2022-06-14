; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion(i8* noalias nocapture readonly align 16 dereferenceable(64) %alloc0, i8* noalias nocapture readonly align 16 dereferenceable(4) %alloc1, i8* noalias nocapture writeonly align 128 dereferenceable(64) %alloc2) local_unnamed_addr #0 {
entry:
  %alloc25 = addrspacecast i8* %alloc2 to i8 addrspace(1)*
  %alloc13 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %linear_index_base = shl nuw nsw i32 %0, 2
  %1 = bitcast i8 addrspace(1)* %alloc13 to i32 addrspace(1)*
  %2 = bitcast i8 addrspace(1)* %alloc01 to i32 addrspace(1)*
  %3 = zext i32 %linear_index_base to i64
  %4 = getelementptr i32, i32 addrspace(1)* %2, i64 %3
  %5 = bitcast i32 addrspace(1)* %4 to <4 x i32> addrspace(1)*
  %6 = load <4 x i32>, <4 x i32> addrspace(1)* %5, align 16, !invariant.load !4
  %7 = extractelement <4 x i32> %6, i32 0
  %8 = extractelement <4 x i32> %6, i32 1
  %9 = extractelement <4 x i32> %6, i32 2
  %10 = extractelement <4 x i32> %6, i32 3
  %11 = load i32, i32 addrspace(1)* %1, align 16, !invariant.load !4
  %12 = add i32 %11, %7
  %13 = bitcast i8 addrspace(1)* %alloc25 to i32 addrspace(1)*
  %14 = getelementptr i32, i32 addrspace(1)* %13, i64 %3
  %15 = add i32 %8, %11
  %16 = add i32 %9, %11
  %17 = add i32 %10, %11
  %18 = insertelement <4 x i32> poison, i32 %12, i32 0
  %19 = insertelement <4 x i32> %18, i32 %15, i32 1
  %20 = insertelement <4 x i32> %19, i32 %16, i32 2
  %21 = insertelement <4 x i32> %20, i32 %17, i32 3
  %22 = bitcast i32 addrspace(1)* %14 to <4 x i32> addrspace(1)*
  store <4 x i32> %21, <4 x i32> addrspace(1)* %22, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #1 = { nofree nosync nounwind readnone speculatable }

!nvvm.annotations = !{!0, !1}
!llvm.module.flags = !{!2}

!0 = !{void (i8*, i8*, i8*)* @fusion, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @fusion, !"reqntidx", i32 4}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{i32 0, i32 4}
!4 = !{}
