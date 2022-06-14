target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @fusion(i8* noalias align 16 dereferenceable(1024) %alloc0, i8* noalias align 16 dereferenceable(4) %alloc1, i8* noalias align 128 dereferenceable(1024) %alloc2) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [16 x [16 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to float*
  %4 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %5 = bitcast i8* %4 to [16 x [16 x float]]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %7 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %8 = mul nuw nsw i32 %6, 64
  %linear_index = add nuw nsw i32 %8, %7
  %linear_index_in_range = icmp ult i32 %linear_index, 64
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %9 = udiv i32 %linear_index_base, 1
  %10 = urem i32 %9, 16
  %11 = udiv i32 %linear_index_base, 16
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %12 = udiv i32 %linear_index1, 1
  %13 = urem i32 %12, 16
  %14 = udiv i32 %linear_index1, 16
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %15 = udiv i32 %linear_index2, 1
  %16 = urem i32 %15, 16
  %17 = udiv i32 %linear_index2, 16
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %18 = udiv i32 %linear_index3, 1
  %19 = urem i32 %18, 16
  %20 = udiv i32 %linear_index3, 16
  %21 = icmp ult i32 %linear_index_base, 256
  br i1 %21, label %fusion.in_bounds-true, label %fusion.in_bounds-after

fusion.in_bounds-after:                           ; preds = %fusion.in_bounds-true, %entry
  ret void

fusion.in_bounds-true:                            ; preds = %entry
  %22 = bitcast [16 x [16 x float]]* %1 to float*
  %23 = getelementptr inbounds float, float* %22, i32 %linear_index_base
  %24 = load float, float* %23, align 4, !invariant.load !4
  %25 = load float, float* %3, align 4, !invariant.load !4
  %multiply.4 = fmul float %24, %25
  %26 = bitcast [16 x [16 x float]]* %5 to float*
  %27 = getelementptr inbounds float, float* %26, i32 %linear_index_base
  store float %multiply.4, float* %27, align 4
  %28 = bitcast [16 x [16 x float]]* %1 to float*
  %29 = getelementptr inbounds float, float* %28, i32 %linear_index1
  %30 = load float, float* %29, align 4, !invariant.load !4
  %31 = load float, float* %3, align 4, !invariant.load !4
  %multiply.41 = fmul float %30, %31
  %32 = bitcast [16 x [16 x float]]* %5 to float*
  %33 = getelementptr inbounds float, float* %32, i32 %linear_index1
  store float %multiply.41, float* %33, align 4
  %34 = bitcast [16 x [16 x float]]* %1 to float*
  %35 = getelementptr inbounds float, float* %34, i32 %linear_index2
  %36 = load float, float* %35, align 4, !invariant.load !4
  %37 = load float, float* %3, align 4, !invariant.load !4
  %multiply.42 = fmul float %36, %37
  %38 = bitcast [16 x [16 x float]]* %5 to float*
  %39 = getelementptr inbounds float, float* %38, i32 %linear_index2
  store float %multiply.42, float* %39, align 4
  %40 = bitcast [16 x [16 x float]]* %1 to float*
  %41 = getelementptr inbounds float, float* %40, i32 %linear_index3
  %42 = load float, float* %41, align 4, !invariant.load !4
  %43 = load float, float* %3, align 4, !invariant.load !4
  %multiply.43 = fmul float %42, %43
  %44 = bitcast [16 x [16 x float]]* %5 to float*
  %45 = getelementptr inbounds float, float* %44, i32 %linear_index3
  store float %multiply.43, float* %45, align 4
  br label %fusion.in_bounds-after
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

!0 = !{void (i8*, i8*, i8*)* @fusion, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @fusion, !"reqntidx", i32 64}
!2 = !{i32 0, i32 1}
!3 = !{i32 0, i32 64}
!4 = !{}
