target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @slice_5(i8* noalias align 16 dereferenceable(65536) %alloc0, i8* noalias align 128 dereferenceable(16384) %alloc4) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [128 x [128 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc4, i64 0
  %3 = bitcast i8* %2 to [32 x [128 x float]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !8
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !9
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 1024
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 128
  %9 = udiv i32 %linear_index_base, 128
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %10 = udiv i32 %linear_index1, 1
  %11 = urem i32 %10, 128
  %12 = udiv i32 %linear_index1, 128
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %13 = udiv i32 %linear_index2, 1
  %14 = urem i32 %13, 128
  %15 = udiv i32 %linear_index2, 128
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %16 = udiv i32 %linear_index3, 1
  %17 = urem i32 %16, 128
  %18 = udiv i32 %linear_index3, 128
  %19 = icmp ult i32 %linear_index_base, 4096
  br i1 %19, label %slice_5.in_bounds-true, label %slice_5.in_bounds-after

slice_5.in_bounds-after:                          ; preds = %slice_5.in_bounds-true, %entry
  ret void

slice_5.in_bounds-true:                           ; preds = %entry
  %20 = add i32 %9, 96
  %21 = add i32 %8, 0
  %22 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %20, i32 %21
  %23 = load float, float* %22, align 4, !invariant.load !10
  %24 = bitcast [32 x [128 x float]]* %3 to float*
  %25 = getelementptr inbounds float, float* %24, i32 %linear_index_base
  store float %23, float* %25, align 4
  %26 = add i32 %12, 96
  %27 = add i32 %11, 0
  %28 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %26, i32 %27
  %29 = load float, float* %28, align 4, !invariant.load !10
  %30 = bitcast [32 x [128 x float]]* %3 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index1
  store float %29, float* %31, align 4
  %32 = add i32 %15, 96
  %33 = add i32 %14, 0
  %34 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %32, i32 %33
  %35 = load float, float* %34, align 4, !invariant.load !10
  %36 = bitcast [32 x [128 x float]]* %3 to float*
  %37 = getelementptr inbounds float, float* %36, i32 %linear_index2
  store float %35, float* %37, align 4
  %38 = add i32 %18, 96
  %39 = add i32 %17, 0
  %40 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %38, i32 %39
  %41 = load float, float* %40, align 4, !invariant.load !10
  %42 = bitcast [32 x [128 x float]]* %3 to float*
  %43 = getelementptr inbounds float, float* %42, i32 %linear_index3
  store float %41, float* %43, align 4
  br label %slice_5.in_bounds-after
}

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #0

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #1

define void @slice_3(i8* noalias align 16 dereferenceable(65536) %alloc0, i8* noalias align 128 dereferenceable(16384) %alloc2) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [128 x [128 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %3 = bitcast i8* %2 to [32 x [128 x float]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !8
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !9
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 1024
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 128
  %9 = udiv i32 %linear_index_base, 128
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %10 = udiv i32 %linear_index1, 1
  %11 = urem i32 %10, 128
  %12 = udiv i32 %linear_index1, 128
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %13 = udiv i32 %linear_index2, 1
  %14 = urem i32 %13, 128
  %15 = udiv i32 %linear_index2, 128
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %16 = udiv i32 %linear_index3, 1
  %17 = urem i32 %16, 128
  %18 = udiv i32 %linear_index3, 128
  %19 = icmp ult i32 %linear_index_base, 4096
  br i1 %19, label %slice_3.in_bounds-true, label %slice_3.in_bounds-after

slice_3.in_bounds-after:                          ; preds = %slice_3.in_bounds-true, %entry
  ret void

slice_3.in_bounds-true:                           ; preds = %entry
  %20 = add i32 %9, 32
  %21 = add i32 %8, 0
  %22 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %20, i32 %21
  %23 = load float, float* %22, align 4, !invariant.load !10
  %24 = bitcast [32 x [128 x float]]* %3 to float*
  %25 = getelementptr inbounds float, float* %24, i32 %linear_index_base
  store float %23, float* %25, align 4
  %26 = add i32 %12, 32
  %27 = add i32 %11, 0
  %28 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %26, i32 %27
  %29 = load float, float* %28, align 4, !invariant.load !10
  %30 = bitcast [32 x [128 x float]]* %3 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index1
  store float %29, float* %31, align 4
  %32 = add i32 %15, 32
  %33 = add i32 %14, 0
  %34 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %32, i32 %33
  %35 = load float, float* %34, align 4, !invariant.load !10
  %36 = bitcast [32 x [128 x float]]* %3 to float*
  %37 = getelementptr inbounds float, float* %36, i32 %linear_index2
  store float %35, float* %37, align 4
  %38 = add i32 %18, 32
  %39 = add i32 %17, 0
  %40 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %38, i32 %39
  %41 = load float, float* %40, align 4, !invariant.load !10
  %42 = bitcast [32 x [128 x float]]* %3 to float*
  %43 = getelementptr inbounds float, float* %42, i32 %linear_index3
  store float %41, float* %43, align 4
  br label %slice_3.in_bounds-after
}

define void @slice_2(i8* noalias align 16 dereferenceable(65536) %alloc0, i8* noalias align 128 dereferenceable(16384) %alloc1) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [128 x [128 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to [32 x [128 x float]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !8
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !9
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 1024
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 128
  %9 = udiv i32 %linear_index_base, 128
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %10 = udiv i32 %linear_index1, 1
  %11 = urem i32 %10, 128
  %12 = udiv i32 %linear_index1, 128
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %13 = udiv i32 %linear_index2, 1
  %14 = urem i32 %13, 128
  %15 = udiv i32 %linear_index2, 128
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %16 = udiv i32 %linear_index3, 1
  %17 = urem i32 %16, 128
  %18 = udiv i32 %linear_index3, 128
  %19 = icmp ult i32 %linear_index_base, 4096
  br i1 %19, label %slice_2.in_bounds-true, label %slice_2.in_bounds-after

slice_2.in_bounds-after:                          ; preds = %slice_2.in_bounds-true, %entry
  ret void

slice_2.in_bounds-true:                           ; preds = %entry
  %20 = add i32 %9, 0
  %21 = add i32 %8, 0
  %22 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %20, i32 %21
  %23 = load float, float* %22, align 4, !invariant.load !10
  %24 = bitcast [32 x [128 x float]]* %3 to float*
  %25 = getelementptr inbounds float, float* %24, i32 %linear_index_base
  store float %23, float* %25, align 4
  %26 = add i32 %12, 0
  %27 = add i32 %11, 0
  %28 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %26, i32 %27
  %29 = load float, float* %28, align 4, !invariant.load !10
  %30 = bitcast [32 x [128 x float]]* %3 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index1
  store float %29, float* %31, align 4
  %32 = add i32 %15, 0
  %33 = add i32 %14, 0
  %34 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %32, i32 %33
  %35 = load float, float* %34, align 4, !invariant.load !10
  %36 = bitcast [32 x [128 x float]]* %3 to float*
  %37 = getelementptr inbounds float, float* %36, i32 %linear_index2
  store float %35, float* %37, align 4
  %38 = add i32 %18, 0
  %39 = add i32 %17, 0
  %40 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %38, i32 %39
  %41 = load float, float* %40, align 4, !invariant.load !10
  %42 = bitcast [32 x [128 x float]]* %3 to float*
  %43 = getelementptr inbounds float, float* %42, i32 %linear_index3
  store float %41, float* %43, align 4
  br label %slice_2.in_bounds-after
}

define void @slice_4(i8* noalias align 16 dereferenceable(65536) %alloc0, i8* noalias align 128 dereferenceable(16384) %alloc3) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [128 x [128 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc3, i64 0
  %3 = bitcast i8* %2 to [32 x [128 x float]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !8
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !9
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 1024
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 128
  %9 = udiv i32 %linear_index_base, 128
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %10 = udiv i32 %linear_index1, 1
  %11 = urem i32 %10, 128
  %12 = udiv i32 %linear_index1, 128
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %13 = udiv i32 %linear_index2, 1
  %14 = urem i32 %13, 128
  %15 = udiv i32 %linear_index2, 128
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %16 = udiv i32 %linear_index3, 1
  %17 = urem i32 %16, 128
  %18 = udiv i32 %linear_index3, 128
  %19 = icmp ult i32 %linear_index_base, 4096
  br i1 %19, label %slice_4.in_bounds-true, label %slice_4.in_bounds-after

slice_4.in_bounds-after:                          ; preds = %slice_4.in_bounds-true, %entry
  ret void

slice_4.in_bounds-true:                           ; preds = %entry
  %20 = add i32 %9, 64
  %21 = add i32 %8, 0
  %22 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %20, i32 %21
  %23 = load float, float* %22, align 4, !invariant.load !10
  %24 = bitcast [32 x [128 x float]]* %3 to float*
  %25 = getelementptr inbounds float, float* %24, i32 %linear_index_base
  store float %23, float* %25, align 4
  %26 = add i32 %12, 64
  %27 = add i32 %11, 0
  %28 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %26, i32 %27
  %29 = load float, float* %28, align 4, !invariant.load !10
  %30 = bitcast [32 x [128 x float]]* %3 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index1
  store float %29, float* %31, align 4
  %32 = add i32 %15, 64
  %33 = add i32 %14, 0
  %34 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %32, i32 %33
  %35 = load float, float* %34, align 4, !invariant.load !10
  %36 = bitcast [32 x [128 x float]]* %3 to float*
  %37 = getelementptr inbounds float, float* %36, i32 %linear_index2
  store float %35, float* %37, align 4
  %38 = add i32 %18, 64
  %39 = add i32 %17, 0
  %40 = getelementptr inbounds [128 x [128 x float]], [128 x [128 x float]]* %1, i32 0, i32 %38, i32 %39
  %41 = load float, float* %40, align 4, !invariant.load !10
  %42 = bitcast [32 x [128 x float]]* %3 to float*
  %43 = getelementptr inbounds float, float* %42, i32 %linear_index3
  store float %41, float* %43, align 4
  br label %slice_4.in_bounds-after
}

attributes #0 = { nounwind readnone speculatable }
attributes #1 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }

!nvvm.annotations = !{!0, !1, !2, !3, !4, !5, !6, !7}

!0 = !{void (i8*, i8*)* @slice_5, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @slice_5, !"reqntidx", i32 256}
!2 = !{void (i8*, i8*)* @slice_3, !"kernel", i32 1}
!3 = !{void (i8*, i8*)* @slice_3, !"reqntidx", i32 256}
!4 = !{void (i8*, i8*)* @slice_2, !"kernel", i32 1}
!5 = !{void (i8*, i8*)* @slice_2, !"reqntidx", i32 256}
!6 = !{void (i8*, i8*)* @slice_4, !"kernel", i32 1}
!7 = !{void (i8*, i8*)* @slice_4, !"reqntidx", i32 256}
!8 = !{i32 0, i32 4}
!9 = !{i32 0, i32 256}
!10 = !{}
