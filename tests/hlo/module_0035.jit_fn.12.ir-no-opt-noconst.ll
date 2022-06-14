target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @fusion(i8* noalias align 16 dereferenceable(65536) %alloc0, i8* noalias align 16 dereferenceable(4) %alloc1, i8* noalias align 128 dereferenceable(65536) %alloc2) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [128 x [128 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to i32*
  %4 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %5 = bitcast i8* %4 to [128 x [128 x float]]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %7 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %8 = mul nuw nsw i32 %6, 256
  %linear_index = add nuw nsw i32 %8, %7
  %linear_index_in_range = icmp ult i32 %linear_index, 4096
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %9 = udiv i32 %linear_index_base, 1
  %10 = urem i32 %9, 128
  %11 = udiv i32 %linear_index_base, 128
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %12 = udiv i32 %linear_index1, 1
  %13 = urem i32 %12, 128
  %14 = udiv i32 %linear_index1, 128
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %15 = udiv i32 %linear_index2, 1
  %16 = urem i32 %15, 128
  %17 = udiv i32 %linear_index2, 128
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %18 = udiv i32 %linear_index3, 1
  %19 = urem i32 %18, 128
  %20 = udiv i32 %linear_index3, 128
  %21 = icmp ult i32 %linear_index_base, 16384
  br i1 %21, label %fusion.in_bounds-true, label %fusion.in_bounds-after

fusion.in_bounds-after:                           ; preds = %fusion.in_bounds-true, %entry
  ret void

fusion.in_bounds-true:                            ; preds = %entry
  %22 = bitcast [128 x [128 x float]]* %1 to float*
  %23 = getelementptr inbounds float, float* %22, i32 %linear_index_base
  %24 = load float, float* %23, align 4, !invariant.load !4
  %25 = load i32, i32* %3, align 4, !invariant.load !4
  %26 = sitofp i32 %25 to float
  %add.5 = fadd float %24, %26
  %27 = bitcast [128 x [128 x float]]* %5 to float*
  %28 = getelementptr inbounds float, float* %27, i32 %linear_index_base
  store float %add.5, float* %28, align 4
  %29 = bitcast [128 x [128 x float]]* %1 to float*
  %30 = getelementptr inbounds float, float* %29, i32 %linear_index1
  %31 = load float, float* %30, align 4, !invariant.load !4
  %add.51 = fadd float %31, %26
  %32 = bitcast [128 x [128 x float]]* %5 to float*
  %33 = getelementptr inbounds float, float* %32, i32 %linear_index1
  store float %add.51, float* %33, align 4
  %34 = bitcast [128 x [128 x float]]* %1 to float*
  %35 = getelementptr inbounds float, float* %34, i32 %linear_index2
  %36 = load float, float* %35, align 4, !invariant.load !4
  %add.52 = fadd float %36, %26
  %37 = bitcast [128 x [128 x float]]* %5 to float*
  %38 = getelementptr inbounds float, float* %37, i32 %linear_index2
  store float %add.52, float* %38, align 4
  %39 = bitcast [128 x [128 x float]]* %1 to float*
  %40 = getelementptr inbounds float, float* %39, i32 %linear_index3
  %41 = load float, float* %40, align 4, !invariant.load !4
  %add.53 = fadd float %41, %26
  %42 = bitcast [128 x [128 x float]]* %5 to float*
  %43 = getelementptr inbounds float, float* %42, i32 %linear_index3
  store float %add.53, float* %43, align 4
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
!1 = !{void (i8*, i8*, i8*)* @fusion, !"reqntidx", i32 256}
!2 = !{i32 0, i32 16}
!3 = !{i32 0, i32 256}
!4 = !{}
