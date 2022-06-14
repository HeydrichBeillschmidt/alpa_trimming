target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @fusion(i8* noalias align 16 dereferenceable(262144) %alloc0, i8* noalias align 128 dereferenceable(262144) %alloc1) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [64 x [256 x [4 x float]]]*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to [64 x [4 x [256 x float]]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 16384
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 256
  %9 = udiv i32 %linear_index_base, 256
  %10 = urem i32 %9, 4
  %11 = udiv i32 %linear_index_base, 1024
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %12 = udiv i32 %linear_index1, 1
  %13 = urem i32 %12, 256
  %14 = udiv i32 %linear_index1, 256
  %15 = urem i32 %14, 4
  %16 = udiv i32 %linear_index1, 1024
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %17 = udiv i32 %linear_index2, 1
  %18 = urem i32 %17, 256
  %19 = udiv i32 %linear_index2, 256
  %20 = urem i32 %19, 4
  %21 = udiv i32 %linear_index2, 1024
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %22 = udiv i32 %linear_index3, 1
  %23 = urem i32 %22, 256
  %24 = udiv i32 %linear_index3, 256
  %25 = urem i32 %24, 4
  %26 = udiv i32 %linear_index3, 1024
  %27 = icmp ult i32 %linear_index_base, 65536
  br i1 %27, label %fusion.in_bounds-true, label %fusion.in_bounds-after

fusion.in_bounds-after:                           ; preds = %fusion.in_bounds-true, %entry
  ret void

fusion.in_bounds-true:                            ; preds = %entry
  %28 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]]* %1, i32 0, i32 %11, i32 %8, i32 %10
  %29 = load float, float* %28, align 4, !invariant.load !4
  %30 = bitcast [64 x [4 x [256 x float]]]* %3 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index_base
  store float %29, float* %31, align 4
  %32 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]]* %1, i32 0, i32 %16, i32 %13, i32 %15
  %33 = load float, float* %32, align 4, !invariant.load !4
  %34 = bitcast [64 x [4 x [256 x float]]]* %3 to float*
  %35 = getelementptr inbounds float, float* %34, i32 %linear_index1
  store float %33, float* %35, align 4
  %36 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]]* %1, i32 0, i32 %21, i32 %18, i32 %20
  %37 = load float, float* %36, align 4, !invariant.load !4
  %38 = bitcast [64 x [4 x [256 x float]]]* %3 to float*
  %39 = getelementptr inbounds float, float* %38, i32 %linear_index2
  store float %37, float* %39, align 4
  %40 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]]* %1, i32 0, i32 %26, i32 %23, i32 %25
  %41 = load float, float* %40, align 4, !invariant.load !4
  %42 = bitcast [64 x [4 x [256 x float]]]* %3 to float*
  %43 = getelementptr inbounds float, float* %42, i32 %linear_index3
  store float %41, float* %43, align 4
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

!0 = !{void (i8*, i8*)* @fusion, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @fusion, !"reqntidx", i32 256}
!2 = !{i32 0, i32 64}
!3 = !{i32 0, i32 256}
!4 = !{}
