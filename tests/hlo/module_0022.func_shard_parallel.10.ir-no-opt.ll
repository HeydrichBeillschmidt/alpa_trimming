target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @fusion(i8* noalias align 16 dereferenceable(262144) %alloc0, i8* noalias align 128 dereferenceable(262144) %temp_buf) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [64 x [256 x [4 x float]]]*
  %2 = getelementptr inbounds i8, i8* %temp_buf, i64 0
  %3 = bitcast i8* %2 to [64 x [1024 x float]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !4
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !5
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 16384
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 1024
  %9 = udiv i32 %linear_index_base, 1024
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %10 = udiv i32 %linear_index1, 1
  %11 = urem i32 %10, 1024
  %12 = udiv i32 %linear_index1, 1024
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %13 = udiv i32 %linear_index2, 1
  %14 = urem i32 %13, 1024
  %15 = udiv i32 %linear_index2, 1024
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %16 = udiv i32 %linear_index3, 1
  %17 = urem i32 %16, 1024
  %18 = udiv i32 %linear_index3, 1024
  %19 = icmp ult i32 %linear_index_base, 65536
  br i1 %19, label %fusion.in_bounds-true, label %fusion.in_bounds-after

fusion.in_bounds-after:                           ; preds = %fusion.in_bounds-true, %entry
  ret void

fusion.in_bounds-true:                            ; preds = %entry
  %20 = mul nuw nsw i32 %8, 1
  %21 = add nuw nsw i32 0, %20
  %22 = urem i32 %21, 256
  %23 = udiv i32 %21, 256
  %24 = udiv i32 %23, 4
  %25 = mul nuw nsw i32 %9, 1
  %26 = add nuw nsw i32 0, %25
  %27 = udiv i32 %26, 64
  %28 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]]* %1, i32 0, i32 %26, i32 %22, i32 %23
  %29 = load float, float* %28, align 4, !invariant.load !6
  %30 = bitcast [64 x [1024 x float]]* %3 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index_base
  store float %29, float* %31, align 4
  %32 = mul nuw nsw i32 %11, 1
  %33 = add nuw nsw i32 0, %32
  %34 = urem i32 %33, 256
  %35 = udiv i32 %33, 256
  %36 = udiv i32 %35, 4
  %37 = mul nuw nsw i32 %12, 1
  %38 = add nuw nsw i32 0, %37
  %39 = udiv i32 %38, 64
  %40 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]]* %1, i32 0, i32 %38, i32 %34, i32 %35
  %41 = load float, float* %40, align 4, !invariant.load !6
  %42 = bitcast [64 x [1024 x float]]* %3 to float*
  %43 = getelementptr inbounds float, float* %42, i32 %linear_index1
  store float %41, float* %43, align 4
  %44 = mul nuw nsw i32 %14, 1
  %45 = add nuw nsw i32 0, %44
  %46 = urem i32 %45, 256
  %47 = udiv i32 %45, 256
  %48 = udiv i32 %47, 4
  %49 = mul nuw nsw i32 %15, 1
  %50 = add nuw nsw i32 0, %49
  %51 = udiv i32 %50, 64
  %52 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]]* %1, i32 0, i32 %50, i32 %46, i32 %47
  %53 = load float, float* %52, align 4, !invariant.load !6
  %54 = bitcast [64 x [1024 x float]]* %3 to float*
  %55 = getelementptr inbounds float, float* %54, i32 %linear_index2
  store float %53, float* %55, align 4
  %56 = mul nuw nsw i32 %17, 1
  %57 = add nuw nsw i32 0, %56
  %58 = urem i32 %57, 256
  %59 = udiv i32 %57, 256
  %60 = udiv i32 %59, 4
  %61 = mul nuw nsw i32 %18, 1
  %62 = add nuw nsw i32 0, %61
  %63 = udiv i32 %62, 64
  %64 = getelementptr inbounds [64 x [256 x [4 x float]]], [64 x [256 x [4 x float]]]* %1, i32 0, i32 %62, i32 %58, i32 %59
  %65 = load float, float* %64, align 4, !invariant.load !6
  %66 = bitcast [64 x [1024 x float]]* %3 to float*
  %67 = getelementptr inbounds float, float* %66, i32 %linear_index3
  store float %65, float* %67, align 4
  br label %fusion.in_bounds-after
}

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #0

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #1

define void @negate_0(i8* noalias align 128 dereferenceable(4096) %alloc2, i8* noalias align 128 dereferenceable(262144) %temp_buf) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %1 = bitcast i8* %0 to [64 x [16 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %3 = bitcast i8* %2 to [64 x [16 x float]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !7
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !5
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 256
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 16
  %9 = udiv i32 %linear_index_base, 16
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %10 = udiv i32 %linear_index1, 1
  %11 = urem i32 %10, 16
  %12 = udiv i32 %linear_index1, 16
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %13 = udiv i32 %linear_index2, 1
  %14 = urem i32 %13, 16
  %15 = udiv i32 %linear_index2, 16
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %16 = udiv i32 %linear_index3, 1
  %17 = urem i32 %16, 16
  %18 = udiv i32 %linear_index3, 16
  %19 = icmp ult i32 %linear_index_base, 1024
  br i1 %19, label %negate_0.in_bounds-true, label %negate_0.in_bounds-after

negate_0.in_bounds-after:                         ; preds = %negate_0.in_bounds-true, %entry
  ret void

negate_0.in_bounds-true:                          ; preds = %entry
  %20 = bitcast [64 x [16 x float]]* %1 to float*
  %21 = getelementptr inbounds float, float* %20, i32 %linear_index_base
  %22 = load float, float* %21, align 4
  %23 = fneg float %22
  %24 = bitcast [64 x [16 x float]]* %3 to float*
  %25 = getelementptr inbounds float, float* %24, i32 %linear_index_base
  store float %23, float* %25, align 4
  %26 = bitcast [64 x [16 x float]]* %1 to float*
  %27 = getelementptr inbounds float, float* %26, i32 %linear_index1
  %28 = load float, float* %27, align 4
  %29 = fneg float %28
  %30 = bitcast [64 x [16 x float]]* %3 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index1
  store float %29, float* %31, align 4
  %32 = bitcast [64 x [16 x float]]* %1 to float*
  %33 = getelementptr inbounds float, float* %32, i32 %linear_index2
  %34 = load float, float* %33, align 4
  %35 = fneg float %34
  %36 = bitcast [64 x [16 x float]]* %3 to float*
  %37 = getelementptr inbounds float, float* %36, i32 %linear_index2
  store float %35, float* %37, align 4
  %38 = bitcast [64 x [16 x float]]* %1 to float*
  %39 = getelementptr inbounds float, float* %38, i32 %linear_index3
  %40 = load float, float* %39, align 4
  %41 = fneg float %40
  %42 = bitcast [64 x [16 x float]]* %3 to float*
  %43 = getelementptr inbounds float, float* %42, i32 %linear_index3
  store float %41, float* %43, align 4
  br label %negate_0.in_bounds-after
}

attributes #0 = { nounwind readnone speculatable }
attributes #1 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }

!nvvm.annotations = !{!0, !1, !2, !3}

!0 = !{void (i8*, i8*)* @fusion, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @fusion, !"reqntidx", i32 256}
!2 = !{void (i8*, i8*)* @negate_0, !"kernel", i32 1}
!3 = !{void (i8*, i8*)* @negate_0, !"reqntidx", i32 256}
!4 = !{i32 0, i32 64}
!5 = !{i32 0, i32 256}
!6 = !{}
!7 = !{i32 0, i32 1}
