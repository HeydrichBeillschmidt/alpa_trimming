target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion(i8* noalias nocapture readonly align 16 dereferenceable(262144) %alloc0, i8* noalias nocapture writeonly align 128 dereferenceable(262144) %temp_buf) local_unnamed_addr #0 {
entry:
  %temp_buf3 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !5
  %1 = shl nuw nsw i32 %0, 10
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !6
  %3 = shl nuw nsw i32 %2, 2
  %linear_index_base = or i32 %1, %3
  %linear_index2 = or i32 %linear_index_base, 2
  %linear_index1 = or i32 %linear_index_base, 1
  %4 = bitcast i8 addrspace(1)* %alloc01 to [64 x [256 x [4 x float]]] addrspace(1)*
  %5 = and i32 %3, 252
  %6 = lshr i32 %2, 6
  %7 = zext i32 %0 to i64
  %8 = zext i32 %5 to i64
  %9 = zext i32 %6 to i64
  %10 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]] addrspace(1)* %4, i64 0, i64 %7, i64 %8, i64 %9
  %11 = load float, float addrspace(1)* %10, align 4, !invariant.load !7
  %12 = bitcast i8 addrspace(1)* %temp_buf3 to float addrspace(1)*
  %13 = zext i32 %linear_index_base to i64
  %14 = getelementptr float, float addrspace(1)* %12, i64 %13
  %15 = and i32 %linear_index1, 253
  %16 = zext i32 %15 to i64
  %17 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]] addrspace(1)* %4, i64 0, i64 %7, i64 %16, i64 %9
  %18 = load float, float addrspace(1)* %17, align 4, !invariant.load !7
  %19 = and i32 %linear_index2, 254
  %20 = zext i32 %19 to i64
  %21 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]] addrspace(1)* %4, i64 0, i64 %7, i64 %20, i64 %9
  %22 = load float, float addrspace(1)* %21, align 4, !invariant.load !7
  %23 = getelementptr inbounds float, float addrspace(1)* %10, i64 12
  %24 = load float, float addrspace(1)* %23, align 4, !invariant.load !7
  %25 = insertelement <4 x float> poison, float %11, i32 0
  %26 = insertelement <4 x float> %25, float %18, i32 1
  %27 = insertelement <4 x float> %26, float %22, i32 2
  %28 = insertelement <4 x float> %27, float %24, i32 3
  %29 = bitcast float addrspace(1)* %14 to <4 x float> addrspace(1)*
  store <4 x float> %28, <4 x float> addrspace(1)* %29, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #1

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @negate_0(i8* noalias nocapture align 128 dereferenceable(4096) %alloc2, i8* noalias nocapture readnone align 128 dereferenceable(262144) %temp_buf) local_unnamed_addr #0 {
entry:
  %alloc21 = addrspacecast i8* %alloc2 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !6
  %linear_index_base = shl nuw nsw i32 %0, 2
  %1 = bitcast i8 addrspace(1)* %alloc21 to float addrspace(1)*
  %2 = zext i32 %linear_index_base to i64
  %3 = getelementptr float, float addrspace(1)* %1, i64 %2
  %4 = bitcast float addrspace(1)* %3 to <4 x float> addrspace(1)*
  %5 = load <4 x float>, <4 x float> addrspace(1)* %4, align 16
  %6 = extractelement <4 x float> %5, i32 0
  %7 = extractelement <4 x float> %5, i32 1
  %8 = extractelement <4 x float> %5, i32 2
  %9 = extractelement <4 x float> %5, i32 3
  %10 = fneg float %6
  %11 = fneg float %7
  %12 = fneg float %8
  %13 = fneg float %9
  %14 = insertelement <4 x float> poison, float %10, i32 0
  %15 = insertelement <4 x float> %14, float %11, i32 1
  %16 = insertelement <4 x float> %15, float %12, i32 2
  %17 = insertelement <4 x float> %16, float %13, i32 3
  %18 = bitcast float addrspace(1)* %3 to <4 x float> addrspace(1)*
  store <4 x float> %17, <4 x float> addrspace(1)* %18, align 16
  ret void
}

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #1 = { nofree nosync nounwind readnone speculatable }

!nvvm.annotations = !{!0, !1, !2, !3}
!llvm.module.flags = !{!4}

!0 = !{void (i8*, i8*)* @fusion, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @fusion, !"reqntidx", i32 256}
!2 = !{void (i8*, i8*)* @negate_0, !"kernel", i32 1}
!3 = !{void (i8*, i8*)* @negate_0, !"reqntidx", i32 256}
!4 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!5 = !{i32 0, i32 64}
!6 = !{i32 0, i32 256}
!7 = !{}
