target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @add_0(i8* noalias nocapture readonly align 16 dereferenceable(1024) %alloc0, i8* noalias nocapture readonly align 16 dereferenceable(1024) %alloc1, i8* noalias nocapture writeonly align 128 dereferenceable(1024) %alloc2) local_unnamed_addr #0 {
entry:
  %alloc28 = addrspacecast i8* %alloc2 to i8 addrspace(1)*
  %alloc16 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc04 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %linear_index_base = shl nuw nsw i32 %0, 2
  %1 = bitcast i8 addrspace(1)* %alloc04 to float addrspace(1)*
  %2 = zext i32 %linear_index_base to i64
  %3 = getelementptr float, float addrspace(1)* %1, i64 %2
  %4 = bitcast float addrspace(1)* %3 to <4 x float> addrspace(1)*
  %5 = load <4 x float>, <4 x float> addrspace(1)* %4, align 16, !invariant.load !4
  %6 = extractelement <4 x float> %5, i32 0
  %7 = extractelement <4 x float> %5, i32 1
  %8 = extractelement <4 x float> %5, i32 2
  %9 = extractelement <4 x float> %5, i32 3
  %10 = bitcast i8 addrspace(1)* %alloc16 to float addrspace(1)*
  %11 = getelementptr float, float addrspace(1)* %10, i64 %2
  %12 = bitcast float addrspace(1)* %11 to <4 x float> addrspace(1)*
  %13 = load <4 x float>, <4 x float> addrspace(1)* %12, align 16, !invariant.load !4
  %14 = extractelement <4 x float> %13, i32 0
  %15 = extractelement <4 x float> %13, i32 1
  %16 = extractelement <4 x float> %13, i32 2
  %17 = extractelement <4 x float> %13, i32 3
  %add.3 = fadd float %6, %14
  %18 = bitcast i8 addrspace(1)* %alloc28 to float addrspace(1)*
  %19 = getelementptr float, float addrspace(1)* %18, i64 %2
  %add.31 = fadd float %7, %15
  %add.32 = fadd float %8, %16
  %add.33 = fadd float %9, %17
  %20 = insertelement <4 x float> poison, float %add.3, i32 0
  %21 = insertelement <4 x float> %20, float %add.31, i32 1
  %22 = insertelement <4 x float> %21, float %add.32, i32 2
  %23 = insertelement <4 x float> %22, float %add.33, i32 3
  %24 = bitcast float addrspace(1)* %19 to <4 x float> addrspace(1)*
  store <4 x float> %23, <4 x float> addrspace(1)* %24, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #1 = { nofree nosync nounwind readnone speculatable }

!nvvm.annotations = !{!0, !1}
!llvm.module.flags = !{!2}

!0 = !{void (i8*, i8*, i8*)* @add_0, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @add_0, !"reqntidx", i32 64}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{i32 0, i32 64}
!4 = !{}
