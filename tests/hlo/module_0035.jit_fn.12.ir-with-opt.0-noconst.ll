; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion(i8* noalias nocapture readonly align 16 dereferenceable(65536) %alloc0, i8* noalias nocapture readonly align 16 dereferenceable(4) %alloc1, i8* noalias nocapture writeonly align 128 dereferenceable(65536) %alloc2) local_unnamed_addr #0 {
entry:
  %alloc25 = addrspacecast i8* %alloc2 to i8 addrspace(1)*
  %alloc13 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !3
  %1 = shl nuw nsw i32 %0, 10
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !4
  %3 = shl nuw nsw i32 %2, 2
  %linear_index_base = or i32 %1, %3
  %4 = bitcast i8 addrspace(1)* %alloc13 to i32 addrspace(1)*
  %5 = bitcast i8 addrspace(1)* %alloc01 to float addrspace(1)*
  %6 = zext i32 %linear_index_base to i64
  %7 = getelementptr float, float addrspace(1)* %5, i64 %6
  %8 = bitcast float addrspace(1)* %7 to <4 x float> addrspace(1)*
  %9 = load <4 x float>, <4 x float> addrspace(1)* %8, align 16, !invariant.load !5
  %10 = extractelement <4 x float> %9, i32 0
  %11 = extractelement <4 x float> %9, i32 1
  %12 = extractelement <4 x float> %9, i32 2
  %13 = extractelement <4 x float> %9, i32 3
  %14 = load i32, i32 addrspace(1)* %4, align 16, !invariant.load !5
  %15 = sitofp i32 %14 to float
  %add.5 = fadd float %10, %15
  %16 = bitcast i8 addrspace(1)* %alloc25 to float addrspace(1)*
  %17 = getelementptr float, float addrspace(1)* %16, i64 %6
  %add.51 = fadd float %11, %15
  %add.52 = fadd float %12, %15
  %add.53 = fadd float %13, %15
  %18 = insertelement <4 x float> poison, float %add.5, i32 0
  %19 = insertelement <4 x float> %18, float %add.51, i32 1
  %20 = insertelement <4 x float> %19, float %add.52, i32 2
  %21 = insertelement <4 x float> %20, float %add.53, i32 3
  %22 = bitcast float addrspace(1)* %17 to <4 x float> addrspace(1)*
  store <4 x float> %21, <4 x float> addrspace(1)* %22, align 16
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

!0 = !{void (i8*, i8*, i8*)* @fusion, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @fusion, !"reqntidx", i32 256}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{i32 0, i32 16}
!4 = !{i32 0, i32 256}
!5 = !{}
