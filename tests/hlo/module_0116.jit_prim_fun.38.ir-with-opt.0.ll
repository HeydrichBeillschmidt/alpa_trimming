; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @broadcast_2(i8* noalias nocapture readonly align 16 dereferenceable(4) %alloc0, i8* noalias nocapture writeonly align 128 dereferenceable(4096) %alloc1) local_unnamed_addr #0 {
entry:
  %alloc13 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %linear_index_base = shl nuw nsw i32 %0, 2
  %1 = bitcast i8 addrspace(1)* %alloc01 to i32 addrspace(1)*
  %2 = load i32, i32 addrspace(1)* %1, align 16, !invariant.load !4
  %3 = bitcast i8 addrspace(1)* %alloc13 to i32 addrspace(1)*
  %4 = zext i32 %linear_index_base to i64
  %5 = getelementptr i32, i32 addrspace(1)* %3, i64 %4
  %6 = insertelement <4 x i32> poison, i32 %2, i32 0
  %7 = insertelement <4 x i32> %6, i32 %2, i32 1
  %8 = insertelement <4 x i32> %7, i32 %2, i32 2
  %9 = insertelement <4 x i32> %8, i32 %2, i32 3
  %10 = bitcast i32 addrspace(1)* %5 to <4 x i32> addrspace(1)*
  store <4 x i32> %9, <4 x i32> addrspace(1)* %10, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #1 = { nofree nosync nounwind readnone speculatable }

!nvvm.annotations = !{!0, !1}
!llvm.module.flags = !{!2}

!0 = !{void (i8*, i8*)* @broadcast_2, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @broadcast_2, !"reqntidx", i32 256}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{i32 0, i32 256}
!4 = !{}
