; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion(i8* noalias nocapture readonly align 16 dereferenceable(65536) %alloc0, i8* noalias nocapture writeonly align 128 dereferenceable(65536) %alloc1) local_unnamed_addr #0 {
entry:
  %alloc13 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !3
  %1 = shl nuw nsw i32 %0, 10
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !4
  %3 = shl nuw nsw i32 %2, 2
  %linear_index_base = or i32 %1, %3
  %4 = bitcast i8 addrspace(1)* %alloc01 to float addrspace(1)*
  %5 = zext i32 %linear_index_base to i64
  %6 = getelementptr float, float addrspace(1)* %4, i64 %5
  %7 = bitcast float addrspace(1)* %6 to <4 x float> addrspace(1)*
  %8 = load <4 x float>, <4 x float> addrspace(1)* %7, align 16, !invariant.load !5
  %9 = extractelement <4 x float> %8, i32 0
  %10 = extractelement <4 x float> %8, i32 1
  %11 = extractelement <4 x float> %8, i32 2
  %12 = extractelement <4 x float> %8, i32 3
  %add.4 = fadd float %9, 1.000000e+00
  %13 = bitcast i8 addrspace(1)* %alloc13 to float addrspace(1)*
  %14 = getelementptr float, float addrspace(1)* %13, i64 %5
  %add.42 = fadd float %10, 1.000000e+00
  %add.44 = fadd float %11, 1.000000e+00
  %add.46 = fadd float %12, 1.000000e+00
  %15 = insertelement <4 x float> poison, float %add.4, i32 0
  %16 = insertelement <4 x float> %15, float %add.42, i32 1
  %17 = insertelement <4 x float> %16, float %add.44, i32 2
  %18 = insertelement <4 x float> %17, float %add.46, i32 3
  %19 = bitcast float addrspace(1)* %14 to <4 x float> addrspace(1)*
  store <4 x float> %18, <4 x float> addrspace(1)* %19, align 16
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
!3 = !{i32 0, i32 16}
!4 = !{i32 0, i32 256}
!5 = !{}
