target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @negate_2(i8* noalias align 16 dereferenceable(16384) %alloc0, i8* noalias align 128 dereferenceable(16384) %alloc1) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [64 x [64 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to [64 x [64 x float]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 1024
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 64
  %9 = udiv i32 %linear_index_base, 64
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %10 = udiv i32 %linear_index1, 1
  %11 = urem i32 %10, 64
  %12 = udiv i32 %linear_index1, 64
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %13 = udiv i32 %linear_index2, 1
  %14 = urem i32 %13, 64
  %15 = udiv i32 %linear_index2, 64
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %16 = udiv i32 %linear_index3, 1
  %17 = urem i32 %16, 64
  %18 = udiv i32 %linear_index3, 64
  %19 = icmp ult i32 %linear_index_base, 4096
  br i1 %19, label %negate_2.in_bounds-true, label %negate_2.in_bounds-after

negate_2.in_bounds-after:                         ; preds = %negate_2.in_bounds-true, %entry
  ret void

negate_2.in_bounds-true:                          ; preds = %entry
  %20 = bitcast [64 x [64 x float]]* %1 to float*
  %21 = getelementptr inbounds float, float* %20, i32 %linear_index_base
  %22 = load float, float* %21, align 4, !invariant.load !4
  %23 = fneg float %22
  %24 = bitcast [64 x [64 x float]]* %3 to float*
  %25 = getelementptr inbounds float, float* %24, i32 %linear_index_base
  store float %23, float* %25, align 4
  %26 = bitcast [64 x [64 x float]]* %1 to float*
  %27 = getelementptr inbounds float, float* %26, i32 %linear_index1
  %28 = load float, float* %27, align 4, !invariant.load !4
  %29 = fneg float %28
  %30 = bitcast [64 x [64 x float]]* %3 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index1
  store float %29, float* %31, align 4
  %32 = bitcast [64 x [64 x float]]* %1 to float*
  %33 = getelementptr inbounds float, float* %32, i32 %linear_index2
  %34 = load float, float* %33, align 4, !invariant.load !4
  %35 = fneg float %34
  %36 = bitcast [64 x [64 x float]]* %3 to float*
  %37 = getelementptr inbounds float, float* %36, i32 %linear_index2
  store float %35, float* %37, align 4
  %38 = bitcast [64 x [64 x float]]* %1 to float*
  %39 = getelementptr inbounds float, float* %38, i32 %linear_index3
  %40 = load float, float* %39, align 4, !invariant.load !4
  %41 = fneg float %40
  %42 = bitcast [64 x [64 x float]]* %3 to float*
  %43 = getelementptr inbounds float, float* %42, i32 %linear_index3
  store float %41, float* %43, align 4
  br label %negate_2.in_bounds-after
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

!0 = !{void (i8*, i8*)* @negate_2, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @negate_2, !"reqntidx", i32 256}
!2 = !{i32 0, i32 4}
!3 = !{i32 0, i32 256}
!4 = !{}
