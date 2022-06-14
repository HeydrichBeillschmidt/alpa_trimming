; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #0

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @slice_3(i8* noalias nocapture readonly align 16 dereferenceable(262144) %alloc0, i8* noalias nocapture writeonly align 128 dereferenceable(65536) %alloc2) local_unnamed_addr #1 {
entry:
  %alloc23 = addrspacecast i8* %alloc2 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !9
  %1 = shl nuw nsw i32 %0, 8
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !10
  %linear_index = or i32 %1, %2
  %linear_index_base = shl nuw nsw i32 %linear_index, 2
  %3 = lshr i32 %linear_index, 2
  %4 = and i32 %2, 3
  %5 = bitcast i8 addrspace(1)* %alloc01 to [1024 x [16 x [4 x float]]] addrspace(1)*
  %6 = zext i32 %3 to i64
  %7 = zext i32 %4 to i64
  %8 = getelementptr [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]] addrspace(1)* %5, i64 0, i64 %6, i64 %7, i64 0
  %9 = getelementptr inbounds float, float addrspace(1)* %8, i64 16
  %10 = bitcast float addrspace(1)* %9 to <4 x float> addrspace(1)*
  %11 = load <4 x float>, <4 x float> addrspace(1)* %10, align 16, !invariant.load !11
  %12 = extractelement <4 x float> %11, i32 0
  %13 = extractelement <4 x float> %11, i32 1
  %14 = extractelement <4 x float> %11, i32 2
  %15 = extractelement <4 x float> %11, i32 3
  %16 = bitcast i8 addrspace(1)* %alloc23 to float addrspace(1)*
  %17 = zext i32 %linear_index_base to i64
  %18 = getelementptr float, float addrspace(1)* %16, i64 %17
  %19 = insertelement <4 x float> poison, float %12, i32 0
  %20 = insertelement <4 x float> %19, float %13, i32 1
  %21 = insertelement <4 x float> %20, float %14, i32 2
  %22 = insertelement <4 x float> %21, float %15, i32 3
  %23 = bitcast float addrspace(1)* %18 to <4 x float> addrspace(1)*
  store <4 x float> %22, <4 x float> addrspace(1)* %23, align 16
  ret void
}

attributes #0 = { nofree nosync nounwind readnone speculatable }
attributes #1 = { argmemonly mustprogress nofree nosync nounwind willreturn }

!nvvm.annotations = !{!0, !1, !2, !3, !4, !5, !6, !7}
!llvm.module.flags = !{!8}

!0 = distinct !{null, !"kernel", i32 1}
!1 = distinct !{null, !"reqntidx", i32 256}
!2 = !{void (i8*, i8*)* @slice_3, !"kernel", i32 1}
!3 = !{void (i8*, i8*)* @slice_3, !"reqntidx", i32 256}
!4 = distinct !{null, !"kernel", i32 1}
!5 = distinct !{null, !"reqntidx", i32 256}
!6 = distinct !{null, !"kernel", i32 1}
!7 = distinct !{null, !"reqntidx", i32 256}
!8 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!9 = !{i32 0, i32 16}
!10 = !{i32 0, i32 256}
!11 = !{}
