target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @add_0(i8* noalias align 16 dereferenceable(1024) %alloc0, i8* noalias align 16 dereferenceable(1024) %alloc1, i8* noalias align 128 dereferenceable(1024) %alloc2) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [8 x [32 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to [8 x [32 x float]]*
  %4 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %5 = bitcast i8* %4 to [8 x [32 x float]]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %7 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %8 = mul nuw nsw i32 %6, 64
  %linear_index = add nuw nsw i32 %8, %7
  %linear_index_in_range = icmp ult i32 %linear_index, 64
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %9 = udiv i32 %linear_index_base, 1
  %10 = urem i32 %9, 32
  %11 = udiv i32 %linear_index_base, 32
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %12 = udiv i32 %linear_index1, 1
  %13 = urem i32 %12, 32
  %14 = udiv i32 %linear_index1, 32
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %15 = udiv i32 %linear_index2, 1
  %16 = urem i32 %15, 32
  %17 = udiv i32 %linear_index2, 32
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %18 = udiv i32 %linear_index3, 1
  %19 = urem i32 %18, 32
  %20 = udiv i32 %linear_index3, 32
  %21 = icmp ult i32 %linear_index_base, 256
  br i1 %21, label %add_0.in_bounds-true, label %add_0.in_bounds-after

add_0.in_bounds-after:                            ; preds = %add_0.in_bounds-true, %entry
  ret void

add_0.in_bounds-true:                             ; preds = %entry
  %22 = bitcast [8 x [32 x float]]* %1 to float*
  %23 = getelementptr inbounds float, float* %22, i32 %linear_index_base
  %24 = load float, float* %23, align 4, !invariant.load !4
  %25 = bitcast [8 x [32 x float]]* %3 to float*
  %26 = getelementptr inbounds float, float* %25, i32 %linear_index_base
  %27 = load float, float* %26, align 4, !invariant.load !4
  %add.3 = fadd float %24, %27
  %28 = bitcast [8 x [32 x float]]* %5 to float*
  %29 = getelementptr inbounds float, float* %28, i32 %linear_index_base
  store float %add.3, float* %29, align 4
  %30 = bitcast [8 x [32 x float]]* %1 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index1
  %32 = load float, float* %31, align 4, !invariant.load !4
  %33 = bitcast [8 x [32 x float]]* %3 to float*
  %34 = getelementptr inbounds float, float* %33, i32 %linear_index1
  %35 = load float, float* %34, align 4, !invariant.load !4
  %add.31 = fadd float %32, %35
  %36 = bitcast [8 x [32 x float]]* %5 to float*
  %37 = getelementptr inbounds float, float* %36, i32 %linear_index1
  store float %add.31, float* %37, align 4
  %38 = bitcast [8 x [32 x float]]* %1 to float*
  %39 = getelementptr inbounds float, float* %38, i32 %linear_index2
  %40 = load float, float* %39, align 4, !invariant.load !4
  %41 = bitcast [8 x [32 x float]]* %3 to float*
  %42 = getelementptr inbounds float, float* %41, i32 %linear_index2
  %43 = load float, float* %42, align 4, !invariant.load !4
  %add.32 = fadd float %40, %43
  %44 = bitcast [8 x [32 x float]]* %5 to float*
  %45 = getelementptr inbounds float, float* %44, i32 %linear_index2
  store float %add.32, float* %45, align 4
  %46 = bitcast [8 x [32 x float]]* %1 to float*
  %47 = getelementptr inbounds float, float* %46, i32 %linear_index3
  %48 = load float, float* %47, align 4, !invariant.load !4
  %49 = bitcast [8 x [32 x float]]* %3 to float*
  %50 = getelementptr inbounds float, float* %49, i32 %linear_index3
  %51 = load float, float* %50, align 4, !invariant.load !4
  %add.33 = fadd float %48, %51
  %52 = bitcast [8 x [32 x float]]* %5 to float*
  %53 = getelementptr inbounds float, float* %52, i32 %linear_index3
  store float %add.33, float* %53, align 4
  br label %add_0.in_bounds-after
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

!0 = !{void (i8*, i8*, i8*)* @add_0, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @add_0, !"reqntidx", i32 64}
!2 = !{i32 0, i32 1}
!3 = !{i32 0, i32 64}
!4 = !{}
