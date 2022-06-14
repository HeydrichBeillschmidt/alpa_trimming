target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @slice_5(i8* noalias align 16 dereferenceable(262144) %alloc0, i8* noalias align 128 dereferenceable(65536) %alloc4) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [1024 x [16 x [4 x float]]]*
  %2 = getelementptr inbounds i8, i8* %alloc4, i64 0
  %3 = bitcast i8* %2 to [1024 x [4 x [4 x float]]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !8
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !9
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 4096
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 4
  %9 = udiv i32 %linear_index_base, 4
  %10 = urem i32 %9, 4
  %11 = udiv i32 %linear_index_base, 16
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %12 = udiv i32 %linear_index1, 1
  %13 = urem i32 %12, 4
  %14 = udiv i32 %linear_index1, 4
  %15 = urem i32 %14, 4
  %16 = udiv i32 %linear_index1, 16
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %17 = udiv i32 %linear_index2, 1
  %18 = urem i32 %17, 4
  %19 = udiv i32 %linear_index2, 4
  %20 = urem i32 %19, 4
  %21 = udiv i32 %linear_index2, 16
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %22 = udiv i32 %linear_index3, 1
  %23 = urem i32 %22, 4
  %24 = udiv i32 %linear_index3, 4
  %25 = urem i32 %24, 4
  %26 = udiv i32 %linear_index3, 16
  %27 = icmp ult i32 %linear_index_base, 16384
  br i1 %27, label %slice_5.in_bounds-true, label %slice_5.in_bounds-after

slice_5.in_bounds-after:                          ; preds = %slice_5.in_bounds-true, %entry
  ret void

slice_5.in_bounds-true:                           ; preds = %entry
  %28 = add i32 %11, 0
  %29 = add i32 %10, 12
  %30 = add i32 %8, 0
  %31 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %28, i32 %29, i32 %30
  %32 = load float, float* %31, align 4, !invariant.load !10
  %33 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %34 = getelementptr inbounds float, float* %33, i32 %linear_index_base
  store float %32, float* %34, align 4
  %35 = add i32 %16, 0
  %36 = add i32 %15, 12
  %37 = add i32 %13, 0
  %38 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %35, i32 %36, i32 %37
  %39 = load float, float* %38, align 4, !invariant.load !10
  %40 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %41 = getelementptr inbounds float, float* %40, i32 %linear_index1
  store float %39, float* %41, align 4
  %42 = add i32 %21, 0
  %43 = add i32 %20, 12
  %44 = add i32 %18, 0
  %45 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %42, i32 %43, i32 %44
  %46 = load float, float* %45, align 4, !invariant.load !10
  %47 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %48 = getelementptr inbounds float, float* %47, i32 %linear_index2
  store float %46, float* %48, align 4
  %49 = add i32 %26, 0
  %50 = add i32 %25, 12
  %51 = add i32 %23, 0
  %52 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %49, i32 %50, i32 %51
  %53 = load float, float* %52, align 4, !invariant.load !10
  %54 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %55 = getelementptr inbounds float, float* %54, i32 %linear_index3
  store float %53, float* %55, align 4
  br label %slice_5.in_bounds-after
}

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #0

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #1

define void @slice_3(i8* noalias align 16 dereferenceable(262144) %alloc0, i8* noalias align 128 dereferenceable(65536) %alloc2) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [1024 x [16 x [4 x float]]]*
  %2 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %3 = bitcast i8* %2 to [1024 x [4 x [4 x float]]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !8
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !9
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 4096
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 4
  %9 = udiv i32 %linear_index_base, 4
  %10 = urem i32 %9, 4
  %11 = udiv i32 %linear_index_base, 16
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %12 = udiv i32 %linear_index1, 1
  %13 = urem i32 %12, 4
  %14 = udiv i32 %linear_index1, 4
  %15 = urem i32 %14, 4
  %16 = udiv i32 %linear_index1, 16
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %17 = udiv i32 %linear_index2, 1
  %18 = urem i32 %17, 4
  %19 = udiv i32 %linear_index2, 4
  %20 = urem i32 %19, 4
  %21 = udiv i32 %linear_index2, 16
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %22 = udiv i32 %linear_index3, 1
  %23 = urem i32 %22, 4
  %24 = udiv i32 %linear_index3, 4
  %25 = urem i32 %24, 4
  %26 = udiv i32 %linear_index3, 16
  %27 = icmp ult i32 %linear_index_base, 16384
  br i1 %27, label %slice_3.in_bounds-true, label %slice_3.in_bounds-after

slice_3.in_bounds-after:                          ; preds = %slice_3.in_bounds-true, %entry
  ret void

slice_3.in_bounds-true:                           ; preds = %entry
  %28 = add i32 %11, 0
  %29 = add i32 %10, 4
  %30 = add i32 %8, 0
  %31 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %28, i32 %29, i32 %30
  %32 = load float, float* %31, align 4, !invariant.load !10
  %33 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %34 = getelementptr inbounds float, float* %33, i32 %linear_index_base
  store float %32, float* %34, align 4
  %35 = add i32 %16, 0
  %36 = add i32 %15, 4
  %37 = add i32 %13, 0
  %38 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %35, i32 %36, i32 %37
  %39 = load float, float* %38, align 4, !invariant.load !10
  %40 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %41 = getelementptr inbounds float, float* %40, i32 %linear_index1
  store float %39, float* %41, align 4
  %42 = add i32 %21, 0
  %43 = add i32 %20, 4
  %44 = add i32 %18, 0
  %45 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %42, i32 %43, i32 %44
  %46 = load float, float* %45, align 4, !invariant.load !10
  %47 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %48 = getelementptr inbounds float, float* %47, i32 %linear_index2
  store float %46, float* %48, align 4
  %49 = add i32 %26, 0
  %50 = add i32 %25, 4
  %51 = add i32 %23, 0
  %52 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %49, i32 %50, i32 %51
  %53 = load float, float* %52, align 4, !invariant.load !10
  %54 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %55 = getelementptr inbounds float, float* %54, i32 %linear_index3
  store float %53, float* %55, align 4
  br label %slice_3.in_bounds-after
}

define void @slice_2(i8* noalias align 16 dereferenceable(262144) %alloc0, i8* noalias align 128 dereferenceable(65536) %alloc1) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [1024 x [16 x [4 x float]]]*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to [1024 x [4 x [4 x float]]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !8
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !9
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 4096
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 4
  %9 = udiv i32 %linear_index_base, 4
  %10 = urem i32 %9, 4
  %11 = udiv i32 %linear_index_base, 16
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %12 = udiv i32 %linear_index1, 1
  %13 = urem i32 %12, 4
  %14 = udiv i32 %linear_index1, 4
  %15 = urem i32 %14, 4
  %16 = udiv i32 %linear_index1, 16
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %17 = udiv i32 %linear_index2, 1
  %18 = urem i32 %17, 4
  %19 = udiv i32 %linear_index2, 4
  %20 = urem i32 %19, 4
  %21 = udiv i32 %linear_index2, 16
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %22 = udiv i32 %linear_index3, 1
  %23 = urem i32 %22, 4
  %24 = udiv i32 %linear_index3, 4
  %25 = urem i32 %24, 4
  %26 = udiv i32 %linear_index3, 16
  %27 = icmp ult i32 %linear_index_base, 16384
  br i1 %27, label %slice_2.in_bounds-true, label %slice_2.in_bounds-after

slice_2.in_bounds-after:                          ; preds = %slice_2.in_bounds-true, %entry
  ret void

slice_2.in_bounds-true:                           ; preds = %entry
  %28 = add i32 %11, 0
  %29 = add i32 %10, 0
  %30 = add i32 %8, 0
  %31 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %28, i32 %29, i32 %30
  %32 = load float, float* %31, align 4, !invariant.load !10
  %33 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %34 = getelementptr inbounds float, float* %33, i32 %linear_index_base
  store float %32, float* %34, align 4
  %35 = add i32 %16, 0
  %36 = add i32 %15, 0
  %37 = add i32 %13, 0
  %38 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %35, i32 %36, i32 %37
  %39 = load float, float* %38, align 4, !invariant.load !10
  %40 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %41 = getelementptr inbounds float, float* %40, i32 %linear_index1
  store float %39, float* %41, align 4
  %42 = add i32 %21, 0
  %43 = add i32 %20, 0
  %44 = add i32 %18, 0
  %45 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %42, i32 %43, i32 %44
  %46 = load float, float* %45, align 4, !invariant.load !10
  %47 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %48 = getelementptr inbounds float, float* %47, i32 %linear_index2
  store float %46, float* %48, align 4
  %49 = add i32 %26, 0
  %50 = add i32 %25, 0
  %51 = add i32 %23, 0
  %52 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %49, i32 %50, i32 %51
  %53 = load float, float* %52, align 4, !invariant.load !10
  %54 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %55 = getelementptr inbounds float, float* %54, i32 %linear_index3
  store float %53, float* %55, align 4
  br label %slice_2.in_bounds-after
}

define void @slice_4(i8* noalias align 16 dereferenceable(262144) %alloc0, i8* noalias align 128 dereferenceable(65536) %alloc3) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [1024 x [16 x [4 x float]]]*
  %2 = getelementptr inbounds i8, i8* %alloc3, i64 0
  %3 = bitcast i8* %2 to [1024 x [4 x [4 x float]]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !8
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !9
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 4096
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 4
  %9 = udiv i32 %linear_index_base, 4
  %10 = urem i32 %9, 4
  %11 = udiv i32 %linear_index_base, 16
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %12 = udiv i32 %linear_index1, 1
  %13 = urem i32 %12, 4
  %14 = udiv i32 %linear_index1, 4
  %15 = urem i32 %14, 4
  %16 = udiv i32 %linear_index1, 16
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %17 = udiv i32 %linear_index2, 1
  %18 = urem i32 %17, 4
  %19 = udiv i32 %linear_index2, 4
  %20 = urem i32 %19, 4
  %21 = udiv i32 %linear_index2, 16
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %22 = udiv i32 %linear_index3, 1
  %23 = urem i32 %22, 4
  %24 = udiv i32 %linear_index3, 4
  %25 = urem i32 %24, 4
  %26 = udiv i32 %linear_index3, 16
  %27 = icmp ult i32 %linear_index_base, 16384
  br i1 %27, label %slice_4.in_bounds-true, label %slice_4.in_bounds-after

slice_4.in_bounds-after:                          ; preds = %slice_4.in_bounds-true, %entry
  ret void

slice_4.in_bounds-true:                           ; preds = %entry
  %28 = add i32 %11, 0
  %29 = add i32 %10, 8
  %30 = add i32 %8, 0
  %31 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %28, i32 %29, i32 %30
  %32 = load float, float* %31, align 4, !invariant.load !10
  %33 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %34 = getelementptr inbounds float, float* %33, i32 %linear_index_base
  store float %32, float* %34, align 4
  %35 = add i32 %16, 0
  %36 = add i32 %15, 8
  %37 = add i32 %13, 0
  %38 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %35, i32 %36, i32 %37
  %39 = load float, float* %38, align 4, !invariant.load !10
  %40 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %41 = getelementptr inbounds float, float* %40, i32 %linear_index1
  store float %39, float* %41, align 4
  %42 = add i32 %21, 0
  %43 = add i32 %20, 8
  %44 = add i32 %18, 0
  %45 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %42, i32 %43, i32 %44
  %46 = load float, float* %45, align 4, !invariant.load !10
  %47 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %48 = getelementptr inbounds float, float* %47, i32 %linear_index2
  store float %46, float* %48, align 4
  %49 = add i32 %26, 0
  %50 = add i32 %25, 8
  %51 = add i32 %23, 0
  %52 = getelementptr inbounds [1024 x [16 x [4 x float]]], [1024 x [16 x [4 x float]]]* %1, i32 0, i32 %49, i32 %50, i32 %51
  %53 = load float, float* %52, align 4, !invariant.load !10
  %54 = bitcast [1024 x [4 x [4 x float]]]* %3 to float*
  %55 = getelementptr inbounds float, float* %54, i32 %linear_index3
  store float %53, float* %55, align 4
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
!8 = !{i32 0, i32 16}
!9 = !{i32 0, i32 256}
!10 = !{}
