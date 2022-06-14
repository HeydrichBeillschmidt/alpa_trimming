target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

@0 = external dso_local unnamed_addr constant [4 x i8]

define void @fusion(i8* noalias align 16 dereferenceable(16384) %alloc0) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [32 x [128 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %3 = bitcast i8* %2 to [32 x [128 x float]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
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
  br i1 %19, label %fusion.in_bounds-true, label %fusion.in_bounds-after

fusion.in_bounds-after:                           ; preds = %fusion.in_bounds-true, %entry
  ret void

fusion.in_bounds-true:                            ; preds = %entry
  %20 = bitcast [32 x [128 x float]]* %1 to float*
  %21 = getelementptr inbounds float, float* %20, i32 %linear_index_base
  %22 = load float, float* %21, align 4
  %region_0_5_constant_2 = load float, float* bitcast ([4 x i8]* @0 to float*), align 4
  %add.4 = fadd float %22, %region_0_5_constant_2
  %23 = bitcast [32 x [128 x float]]* %3 to float*
  %24 = getelementptr inbounds float, float* %23, i32 %linear_index_base
  store float %add.4, float* %24, align 4
  %25 = bitcast [32 x [128 x float]]* %1 to float*
  %26 = getelementptr inbounds float, float* %25, i32 %linear_index1
  %27 = load float, float* %26, align 4
  %region_0_5_constant_21 = load float, float* bitcast ([4 x i8]* @0 to float*), align 4
  %add.42 = fadd float %27, %region_0_5_constant_21
  %28 = bitcast [32 x [128 x float]]* %3 to float*
  %29 = getelementptr inbounds float, float* %28, i32 %linear_index1
  store float %add.42, float* %29, align 4
  %30 = bitcast [32 x [128 x float]]* %1 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index2
  %32 = load float, float* %31, align 4
  %region_0_5_constant_23 = load float, float* bitcast ([4 x i8]* @0 to float*), align 4
  %add.44 = fadd float %32, %region_0_5_constant_23
  %33 = bitcast [32 x [128 x float]]* %3 to float*
  %34 = getelementptr inbounds float, float* %33, i32 %linear_index2
  store float %add.44, float* %34, align 4
  %35 = bitcast [32 x [128 x float]]* %1 to float*
  %36 = getelementptr inbounds float, float* %35, i32 %linear_index3
  %37 = load float, float* %36, align 4
  %region_0_5_constant_25 = load float, float* bitcast ([4 x i8]* @0 to float*), align 4
  %add.46 = fadd float %37, %region_0_5_constant_25
  %38 = bitcast [32 x [128 x float]]* %3 to float*
  %39 = getelementptr inbounds float, float* %38, i32 %linear_index3
  store float %add.46, float* %39, align 4
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

!0 = !{void (i8*)* @fusion, !"kernel", i32 1}
!1 = !{void (i8*)* @fusion, !"reqntidx", i32 256}
!2 = !{i32 0, i32 4}
!3 = !{i32 0, i32 256}
