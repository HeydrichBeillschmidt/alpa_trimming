target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @broadcast_2(i8* noalias align 16 dereferenceable(4) %alloc0, i8* noalias align 128 dereferenceable(512) %alloc1) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to float*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to [128 x float]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %6 = mul nuw nsw i32 %4, 32
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 32
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %8 = udiv i32 %linear_index1, 1
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %9 = udiv i32 %linear_index2, 1
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %10 = udiv i32 %linear_index3, 1
  %11 = icmp ult i32 %linear_index_base, 128
  br i1 %11, label %broadcast_2.in_bounds-true, label %broadcast_2.in_bounds-after

broadcast_2.in_bounds-after:                      ; preds = %broadcast_2.in_bounds-true, %entry
  ret void

broadcast_2.in_bounds-true:                       ; preds = %entry
  %12 = load float, float* %1, align 4, !invariant.load !4
  %13 = bitcast [128 x float]* %3 to float*
  %14 = getelementptr inbounds float, float* %13, i32 %linear_index_base
  store float %12, float* %14, align 4
  %15 = load float, float* %1, align 4, !invariant.load !4
  %16 = bitcast [128 x float]* %3 to float*
  %17 = getelementptr inbounds float, float* %16, i32 %linear_index1
  store float %15, float* %17, align 4
  %18 = load float, float* %1, align 4, !invariant.load !4
  %19 = bitcast [128 x float]* %3 to float*
  %20 = getelementptr inbounds float, float* %19, i32 %linear_index2
  store float %18, float* %20, align 4
  %21 = load float, float* %1, align 4, !invariant.load !4
  %22 = bitcast [128 x float]* %3 to float*
  %23 = getelementptr inbounds float, float* %22, i32 %linear_index3
  store float %21, float* %23, align 4
  br label %broadcast_2.in_bounds-after
}

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #0

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #1

attributes #0 = { nounwind readnone speculatable }
attributes #1 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }

!nvvm.annotations = !{!0, !1}

!0 = !{void (i8*, i8*)* @broadcast_2, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @broadcast_2, !"reqntidx", i32 32}
!2 = !{i32 0, i32 1}
!3 = !{i32 0, i32 32}
!4 = !{}
