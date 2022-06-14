target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @broadcast_2(i8* noalias align 16 dereferenceable(4) %alloc0, i8* noalias align 128 dereferenceable(262144) %alloc1) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to float*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to [1024 x [16 x [4 x float]]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 16384
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 4
  %9 = udiv i32 %linear_index_base, 4
  %10 = urem i32 %9, 16
  %11 = udiv i32 %linear_index_base, 64
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %12 = udiv i32 %linear_index1, 1
  %13 = urem i32 %12, 4
  %14 = udiv i32 %linear_index1, 4
  %15 = urem i32 %14, 16
  %16 = udiv i32 %linear_index1, 64
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %17 = udiv i32 %linear_index2, 1
  %18 = urem i32 %17, 4
  %19 = udiv i32 %linear_index2, 4
  %20 = urem i32 %19, 16
  %21 = udiv i32 %linear_index2, 64
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %22 = udiv i32 %linear_index3, 1
  %23 = urem i32 %22, 4
  %24 = udiv i32 %linear_index3, 4
  %25 = urem i32 %24, 16
  %26 = udiv i32 %linear_index3, 64
  %27 = icmp ult i32 %linear_index_base, 65536
  br i1 %27, label %broadcast_2.in_bounds-true, label %broadcast_2.in_bounds-after

broadcast_2.in_bounds-after:                      ; preds = %broadcast_2.in_bounds-true, %entry
  ret void

broadcast_2.in_bounds-true:                       ; preds = %entry
  %28 = load float, float* %1, align 4, !invariant.load !4
  %29 = bitcast [1024 x [16 x [4 x float]]]* %3 to float*
  %30 = getelementptr inbounds float, float* %29, i32 %linear_index_base
  store float %28, float* %30, align 4
  %31 = load float, float* %1, align 4, !invariant.load !4
  %32 = bitcast [1024 x [16 x [4 x float]]]* %3 to float*
  %33 = getelementptr inbounds float, float* %32, i32 %linear_index1
  store float %31, float* %33, align 4
  %34 = load float, float* %1, align 4, !invariant.load !4
  %35 = bitcast [1024 x [16 x [4 x float]]]* %3 to float*
  %36 = getelementptr inbounds float, float* %35, i32 %linear_index2
  store float %34, float* %36, align 4
  %37 = load float, float* %1, align 4, !invariant.load !4
  %38 = bitcast [1024 x [16 x [4 x float]]]* %3 to float*
  %39 = getelementptr inbounds float, float* %38, i32 %linear_index3
  store float %37, float* %39, align 4
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
!1 = !{void (i8*, i8*)* @broadcast_2, !"reqntidx", i32 256}
!2 = !{i32 0, i32 64}
!3 = !{i32 0, i32 256}
!4 = !{}
