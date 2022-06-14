target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @gather_3(i8* noalias align 16 dereferenceable(32768) %alloc0, i8* noalias align 16 dereferenceable(64) %alloc1, i8* noalias align 128 dereferenceable(16384) %alloc2) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [256 x [32 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to [16 x [1 x i32]]*
  %4 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %5 = bitcast i8* %4 to [256 x [16 x float]]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %7 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %8 = mul nuw nsw i32 %6, 256
  %linear_index = add nuw nsw i32 %8, %7
  %linear_index_in_range = icmp ult i32 %linear_index, 1024
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
  %21 = icmp ult i32 %linear_index_base, 4096
  br i1 %21, label %gather_3.in_bounds-true, label %gather_3.in_bounds-after

gather_3.in_bounds-after:                         ; preds = %gather_3.in_bounds-true, %entry
  ret void

gather_3.in_bounds-true:                          ; preds = %entry
  %22 = getelementptr inbounds [16 x [1 x i32]], [16 x [1 x i32]]* %3, i32 0, i32 %10, i32 0
  %23 = load i32, i32* %22, align 4, !invariant.load !4
  %24 = icmp sge i32 0, %23
  %25 = select i1 %24, i32 0, i32 %23
  %26 = icmp sle i32 31, %25
  %27 = select i1 %26, i32 31, i32 %25
  %28 = add i32 0, %27
  %29 = getelementptr inbounds [256 x [32 x float]], [256 x [32 x float]]* %1, i32 0, i32 %11, i32 %28
  %30 = load float, float* %29, align 4, !invariant.load !4
  %31 = bitcast [256 x [16 x float]]* %5 to float*
  %32 = getelementptr inbounds float, float* %31, i32 %linear_index_base
  store float %30, float* %32, align 4
  %33 = getelementptr inbounds [16 x [1 x i32]], [16 x [1 x i32]]* %3, i32 0, i32 %13, i32 0
  %34 = load i32, i32* %33, align 4, !invariant.load !4
  %35 = icmp sge i32 0, %34
  %36 = select i1 %35, i32 0, i32 %34
  %37 = icmp sle i32 31, %36
  %38 = select i1 %37, i32 31, i32 %36
  %39 = add i32 0, %38
  %40 = getelementptr inbounds [256 x [32 x float]], [256 x [32 x float]]* %1, i32 0, i32 %14, i32 %39
  %41 = load float, float* %40, align 4, !invariant.load !4
  %42 = bitcast [256 x [16 x float]]* %5 to float*
  %43 = getelementptr inbounds float, float* %42, i32 %linear_index1
  store float %41, float* %43, align 4
  %44 = getelementptr inbounds [16 x [1 x i32]], [16 x [1 x i32]]* %3, i32 0, i32 %16, i32 0
  %45 = load i32, i32* %44, align 4, !invariant.load !4
  %46 = icmp sge i32 0, %45
  %47 = select i1 %46, i32 0, i32 %45
  %48 = icmp sle i32 31, %47
  %49 = select i1 %48, i32 31, i32 %47
  %50 = add i32 0, %49
  %51 = getelementptr inbounds [256 x [32 x float]], [256 x [32 x float]]* %1, i32 0, i32 %17, i32 %50
  %52 = load float, float* %51, align 4, !invariant.load !4
  %53 = bitcast [256 x [16 x float]]* %5 to float*
  %54 = getelementptr inbounds float, float* %53, i32 %linear_index2
  store float %52, float* %54, align 4
  %55 = getelementptr inbounds [16 x [1 x i32]], [16 x [1 x i32]]* %3, i32 0, i32 %19, i32 0
  %56 = load i32, i32* %55, align 4, !invariant.load !4
  %57 = icmp sge i32 0, %56
  %58 = select i1 %57, i32 0, i32 %56
  %59 = icmp sle i32 31, %58
  %60 = select i1 %59, i32 31, i32 %58
  %61 = add i32 0, %60
  %62 = getelementptr inbounds [256 x [32 x float]], [256 x [32 x float]]* %1, i32 0, i32 %20, i32 %61
  %63 = load float, float* %62, align 4, !invariant.load !4
  %64 = bitcast [256 x [16 x float]]* %5 to float*
  %65 = getelementptr inbounds float, float* %64, i32 %linear_index3
  store float %63, float* %65, align 4
  br label %gather_3.in_bounds-after
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

!0 = !{void (i8*, i8*, i8*)* @gather_3, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @gather_3, !"reqntidx", i32 256}
!2 = !{i32 0, i32 4}
!3 = !{i32 0, i32 256}
!4 = !{}
