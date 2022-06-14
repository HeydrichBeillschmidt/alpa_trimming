; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion(i8* noalias nocapture readonly align 16 dereferenceable(1024) %alloc0, i8* noalias nocapture readonly align 16 dereferenceable(4) %alloc1, i8* noalias nocapture writeonly align 128 dereferenceable(1024) %alloc2) local_unnamed_addr #0 {
entry:
  %alloc25 = addrspacecast i8* %alloc2 to i8 addrspace(1)*
  %alloc13 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %linear_index_base = shl nuw nsw i32 %0, 2
  %1 = bitcast i8 addrspace(1)* %alloc13 to float addrspace(1)*
  %2 = bitcast i8 addrspace(1)* %alloc01 to float addrspace(1)*
  %3 = zext i32 %linear_index_base to i64
  %4 = getelementptr float, float addrspace(1)* %2, i64 %3
  %5 = bitcast float addrspace(1)* %4 to <4 x float> addrspace(1)*
  %6 = load <4 x float>, <4 x float> addrspace(1)* %5, align 16, !invariant.load !4
  %7 = extractelement <4 x float> %6, i32 0
  %8 = extractelement <4 x float> %6, i32 1
  %9 = extractelement <4 x float> %6, i32 2
  %10 = extractelement <4 x float> %6, i32 3
  %11 = load float, float addrspace(1)* %1, align 16, !invariant.load !4
  %multiply.4 = fmul float %7, %11
  %12 = bitcast i8 addrspace(1)* %alloc25 to float addrspace(1)*
  %13 = getelementptr float, float addrspace(1)* %12, i64 %3
  %multiply.41 = fmul float %11, %8
  %multiply.42 = fmul float %11, %9
  %multiply.43 = fmul float %11, %10
  %14 = insertelement <4 x float> poison, float %multiply.4, i32 0
  %15 = insertelement <4 x float> %14, float %multiply.41, i32 1
  %16 = insertelement <4 x float> %15, float %multiply.42, i32 2
  %17 = insertelement <4 x float> %16, float %multiply.43, i32 3
  %18 = bitcast float addrspace(1)* %13 to <4 x float> addrspace(1)*
  store <4 x float> %17, <4 x float> addrspace(1)* %18, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #1 = { nofree nosync nounwind readnone speculatable }

!nvvm.annotations = !{!0, !1}
!llvm.module.flags = !{!2}

!0 = !{void (i8*, i8*, i8*)* @fusion, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @fusion, !"reqntidx", i32 64}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{i32 0, i32 64}
!4 = !{}
