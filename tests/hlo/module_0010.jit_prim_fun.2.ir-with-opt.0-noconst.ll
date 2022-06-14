; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @broadcast_2(i8* noalias nocapture readonly align 16 dereferenceable(4) %alloc0, i8* noalias nocapture writeonly align 128 dereferenceable(262144) %alloc1) local_unnamed_addr #0 {
entry:
  %alloc13 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !3
  %1 = shl nuw nsw i32 %0, 10
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !4
  %3 = shl nuw nsw i32 %2, 2
  %linear_index_base = or i32 %1, %3
  %4 = bitcast i8 addrspace(1)* %alloc01 to float addrspace(1)*
  %5 = load float, float addrspace(1)* %4, align 16, !invariant.load !5
  %6 = bitcast i8 addrspace(1)* %alloc13 to float addrspace(1)*
  %7 = zext i32 %linear_index_base to i64
  %8 = getelementptr float, float addrspace(1)* %6, i64 %7
  %9 = insertelement <4 x float> poison, float %5, i32 0
  %10 = insertelement <4 x float> %9, float %5, i32 1
  %11 = insertelement <4 x float> %10, float %5, i32 2
  %12 = insertelement <4 x float> %11, float %5, i32 3
  %13 = bitcast float addrspace(1)* %8 to <4 x float> addrspace(1)*
  store <4 x float> %12, <4 x float> addrspace(1)* %13, align 16
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

!0 = !{void (i8*, i8*)* @broadcast_2, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @broadcast_2, !"reqntidx", i32 256}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{i32 0, i32 64}
!4 = !{i32 0, i32 256}
!5 = !{}
