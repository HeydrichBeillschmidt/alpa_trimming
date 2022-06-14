target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

@buffer_for_constant_4 = external constant [4 x i8], align 128
@0 = external dso_local unnamed_addr constant [4 x i8]
@1 = external dso_local unnamed_addr constant [4 x i8]
@2 = external dso_local unnamed_addr constant [4 x i8]
@3 = external dso_local unnamed_addr constant [4 x i8]

define void @add_2(i8* noalias align 16 dereferenceable(4) %alloc0, i8* noalias align 128 dereferenceable(13456) %temp_buf) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to i32*
  %2 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %3 = bitcast i8* %2 to i32*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !20
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !20
  %6 = mul nuw nsw i32 %4, 1
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 1
  call void @llvm.assume(i1 %linear_index_in_range)
  %7 = icmp ult i32 %linear_index, 1
  br i1 %7, label %add_2.in_bounds-true, label %add_2.in_bounds-after

add_2.in_bounds-after:                            ; preds = %add_2.in_bounds-true, %entry
  ret void

add_2.in_bounds-true:                             ; preds = %entry
  %8 = load i32, i32* %1, align 4
  %9 = load i32, i32* bitcast ([4 x i8]* @buffer_for_constant_4 to i32*), align 4, !invariant.load !21
  %10 = add i32 %8, %9
  store i32 %10, i32* %3, align 4
  br label %add_2.in_bounds-after
}

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #0

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #1

define void @fusion_3(i8* noalias align 128 dereferenceable(13456) %temp_buf) {
entry:
  %0 = getelementptr inbounds i8, i8* %temp_buf, i64 128
  %1 = bitcast i8* %0 to i32*
  %2 = getelementptr inbounds i8, i8* %temp_buf, i64 0
  %3 = bitcast i8* %2 to [1 x [4 x [1 x i32]]]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !20
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !20
  %6 = mul nuw nsw i32 %4, 1
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 1
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %8 = urem i32 %7, 1
  %9 = udiv i32 %linear_index_base, 1
  %10 = urem i32 %9, 4
  %11 = udiv i32 %linear_index_base, 4
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %12 = udiv i32 %linear_index1, 1
  %13 = urem i32 %12, 1
  %14 = udiv i32 %linear_index1, 1
  %15 = urem i32 %14, 4
  %16 = udiv i32 %linear_index1, 4
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %17 = udiv i32 %linear_index2, 1
  %18 = urem i32 %17, 1
  %19 = udiv i32 %linear_index2, 1
  %20 = urem i32 %19, 4
  %21 = udiv i32 %linear_index2, 4
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %22 = udiv i32 %linear_index3, 1
  %23 = urem i32 %22, 1
  %24 = udiv i32 %linear_index3, 1
  %25 = urem i32 %24, 4
  %26 = udiv i32 %linear_index3, 4
  %27 = icmp ult i32 %linear_index_base, 4
  br i1 %27, label %fusion_3.in_bounds-true, label %fusion_3.in_bounds-after

fusion_3.in_bounds-after:                         ; preds = %fusion_3.in_bounds-true, %entry
  ret void

fusion_3.in_bounds-true:                          ; preds = %entry
  %28 = mul nuw nsw i32 %10, 1
  %29 = add nuw nsw i32 0, %28
  %30 = load i32, i32* %1, align 4, !invariant.load !21
  %region_0_9_constant_4 = load i32, i32* bitcast ([4 x i8]* @0 to i32*), align 4
  %31 = mul i32 %30, %region_0_9_constant_4
  %32 = add i32 %29, %31
  %33 = bitcast [1 x [4 x [1 x i32]]]* %3 to i32*
  %34 = getelementptr inbounds i32, i32* %33, i32 %linear_index_base
  store i32 %32, i32* %34, align 4
  %35 = mul nuw nsw i32 %15, 1
  %36 = add nuw nsw i32 0, %35
  %37 = add i32 %36, %31
  %38 = bitcast [1 x [4 x [1 x i32]]]* %3 to i32*
  %39 = getelementptr inbounds i32, i32* %38, i32 %linear_index1
  store i32 %37, i32* %39, align 4
  %40 = mul nuw nsw i32 %20, 1
  %41 = add nuw nsw i32 0, %40
  %42 = add i32 %41, %31
  %43 = bitcast [1 x [4 x [1 x i32]]]* %3 to i32*
  %44 = getelementptr inbounds i32, i32* %43, i32 %linear_index2
  store i32 %42, i32* %44, align 4
  %45 = mul nuw nsw i32 %25, 1
  %46 = add nuw nsw i32 0, %45
  %47 = add i32 %46, %31
  %48 = bitcast [1 x [4 x [1 x i32]]]* %3 to i32*
  %49 = getelementptr inbounds i32, i32* %48, i32 %linear_index3
  store i32 %47, i32* %49, align 4
  br label %fusion_3.in_bounds-after
}

define void @fusion_4(i8* noalias align 128 dereferenceable(13456) %temp_buf) {
entry:
  %0 = getelementptr inbounds i8, i8* %temp_buf, i64 0
  %1 = bitcast i8* %0 to [64 x [32 x float]]*
  %2 = getelementptr inbounds i8, i8* %temp_buf, i64 13312
  %3 = bitcast i8* %2 to [4 x [4 x [1 x i32]]]*
  %4 = getelementptr inbounds i8, i8* %temp_buf, i64 8192
  %5 = bitcast i8* %4 to [64 x [16 x float]]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !20
  %7 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %8 = mul nuw nsw i32 %6, 256
  %linear_index = add nuw nsw i32 %8, %7
  %linear_index_in_range = icmp ult i32 %linear_index, 256
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
  %21 = icmp ult i32 %linear_index_base, 1024
  br i1 %21, label %fusion_4.in_bounds-true, label %fusion_4.in_bounds-after

fusion_4.in_bounds-after:                         ; preds = %fusion_4.in_bounds-true, %entry
  ret void

fusion_4.in_bounds-true:                          ; preds = %entry
  %22 = mul nuw nsw i32 %10, 1
  %23 = add nuw nsw i32 0, %22
  %24 = urem i32 %23, 4
  %25 = udiv i32 %23, 4
  %26 = udiv i32 %25, 4
  %27 = getelementptr inbounds [4 x [4 x [1 x i32]]], [4 x [4 x [1 x i32]]]* %3, i32 0, i32 %25, i32 %24, i32 0
  %28 = load i32, i32* %27, align 4, !invariant.load !21
  %29 = icmp sge i32 0, %28
  %30 = select i1 %29, i32 0, i32 %28
  %31 = icmp sle i32 31, %30
  %32 = select i1 %31, i32 31, i32 %30
  %33 = add i32 0, %32
  %34 = getelementptr inbounds [64 x [32 x float]], [64 x [32 x float]]* %1, i32 0, i32 %11, i32 %33
  %35 = load float, float* %34, align 4, !invariant.load !21
  %36 = bitcast [64 x [16 x float]]* %5 to float*
  %37 = getelementptr inbounds float, float* %36, i32 %linear_index_base
  store float %35, float* %37, align 4
  %38 = mul nuw nsw i32 %13, 1
  %39 = add nuw nsw i32 0, %38
  %40 = urem i32 %39, 4
  %41 = udiv i32 %39, 4
  %42 = udiv i32 %41, 4
  %43 = getelementptr inbounds [4 x [4 x [1 x i32]]], [4 x [4 x [1 x i32]]]* %3, i32 0, i32 %41, i32 %40, i32 0
  %44 = load i32, i32* %43, align 4, !invariant.load !21
  %45 = icmp sge i32 0, %44
  %46 = select i1 %45, i32 0, i32 %44
  %47 = icmp sle i32 31, %46
  %48 = select i1 %47, i32 31, i32 %46
  %49 = add i32 0, %48
  %50 = getelementptr inbounds [64 x [32 x float]], [64 x [32 x float]]* %1, i32 0, i32 %14, i32 %49
  %51 = load float, float* %50, align 4, !invariant.load !21
  %52 = bitcast [64 x [16 x float]]* %5 to float*
  %53 = getelementptr inbounds float, float* %52, i32 %linear_index1
  store float %51, float* %53, align 4
  %54 = mul nuw nsw i32 %16, 1
  %55 = add nuw nsw i32 0, %54
  %56 = urem i32 %55, 4
  %57 = udiv i32 %55, 4
  %58 = udiv i32 %57, 4
  %59 = getelementptr inbounds [4 x [4 x [1 x i32]]], [4 x [4 x [1 x i32]]]* %3, i32 0, i32 %57, i32 %56, i32 0
  %60 = load i32, i32* %59, align 4, !invariant.load !21
  %61 = icmp sge i32 0, %60
  %62 = select i1 %61, i32 0, i32 %60
  %63 = icmp sle i32 31, %62
  %64 = select i1 %63, i32 31, i32 %62
  %65 = add i32 0, %64
  %66 = getelementptr inbounds [64 x [32 x float]], [64 x [32 x float]]* %1, i32 0, i32 %17, i32 %65
  %67 = load float, float* %66, align 4, !invariant.load !21
  %68 = bitcast [64 x [16 x float]]* %5 to float*
  %69 = getelementptr inbounds float, float* %68, i32 %linear_index2
  store float %67, float* %69, align 4
  %70 = mul nuw nsw i32 %19, 1
  %71 = add nuw nsw i32 0, %70
  %72 = urem i32 %71, 4
  %73 = udiv i32 %71, 4
  %74 = udiv i32 %73, 4
  %75 = getelementptr inbounds [4 x [4 x [1 x i32]]], [4 x [4 x [1 x i32]]]* %3, i32 0, i32 %73, i32 %72, i32 0
  %76 = load i32, i32* %75, align 4, !invariant.load !21
  %77 = icmp sge i32 0, %76
  %78 = select i1 %77, i32 0, i32 %76
  %79 = icmp sle i32 31, %78
  %80 = select i1 %79, i32 31, i32 %78
  %81 = add i32 0, %80
  %82 = getelementptr inbounds [64 x [32 x float]], [64 x [32 x float]]* %1, i32 0, i32 %20, i32 %81
  %83 = load float, float* %82, align 4, !invariant.load !21
  %84 = bitcast [64 x [16 x float]]* %5 to float*
  %85 = getelementptr inbounds float, float* %84, i32 %linear_index3
  store float %83, float* %85, align 4
  br label %fusion_4.in_bounds-after
}

define void @fusion_2(i8* noalias align 16 dereferenceable(4096) %alloc4, i8* noalias align 128 dereferenceable(13456) %temp_buf) {
entry:
  %0 = getelementptr inbounds i8, i8* %temp_buf, i64 0
  %1 = bitcast i8* %0 to [64 x [16 x float]]*
  %2 = getelementptr inbounds i8, i8* %alloc4, i64 0
  %3 = bitcast i8* %2 to [64 x [16 x float]]*
  %4 = getelementptr inbounds i8, i8* %temp_buf, i64 0
  %5 = bitcast i8* %4 to [64 x [16 x float]]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !20
  %7 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %8 = mul nuw nsw i32 %6, 256
  %linear_index = add nuw nsw i32 %8, %7
  %linear_index_in_range = icmp ult i32 %linear_index, 256
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
  %21 = icmp ult i32 %linear_index_base, 1024
  br i1 %21, label %fusion_2.in_bounds-true, label %fusion_2.in_bounds-after

fusion_2.in_bounds-after:                         ; preds = %fusion_2.in_bounds-true, %entry
  ret void

fusion_2.in_bounds-true:                          ; preds = %entry
  %22 = bitcast [64 x [16 x float]]* %1 to float*
  %23 = getelementptr inbounds float, float* %22, i32 %linear_index_base
  %24 = load float, float* %23, align 4
  %25 = bitcast [64 x [16 x float]]* %3 to float*
  %26 = getelementptr inbounds float, float* %25, i32 %linear_index_base
  %27 = load float, float* %26, align 4, !invariant.load !21
  %subtract.3 = fsub float %24, %27
  %region_0_7_constant_4 = load float, float* bitcast ([4 x i8]* @1 to float*), align 4
  %multiply.6 = fmul float %subtract.3, %region_0_7_constant_4
  %28 = bitcast [64 x [16 x float]]* %5 to float*
  %29 = getelementptr inbounds float, float* %28, i32 %linear_index_base
  store float %multiply.6, float* %29, align 4
  %30 = bitcast [64 x [16 x float]]* %1 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index1
  %32 = load float, float* %31, align 4
  %33 = bitcast [64 x [16 x float]]* %3 to float*
  %34 = getelementptr inbounds float, float* %33, i32 %linear_index1
  %35 = load float, float* %34, align 4, !invariant.load !21
  %subtract.31 = fsub float %32, %35
  %region_0_7_constant_42 = load float, float* bitcast ([4 x i8]* @1 to float*), align 4
  %multiply.63 = fmul float %subtract.31, %region_0_7_constant_42
  %36 = bitcast [64 x [16 x float]]* %5 to float*
  %37 = getelementptr inbounds float, float* %36, i32 %linear_index1
  store float %multiply.63, float* %37, align 4
  %38 = bitcast [64 x [16 x float]]* %1 to float*
  %39 = getelementptr inbounds float, float* %38, i32 %linear_index2
  %40 = load float, float* %39, align 4
  %41 = bitcast [64 x [16 x float]]* %3 to float*
  %42 = getelementptr inbounds float, float* %41, i32 %linear_index2
  %43 = load float, float* %42, align 4, !invariant.load !21
  %subtract.34 = fsub float %40, %43
  %region_0_7_constant_45 = load float, float* bitcast ([4 x i8]* @1 to float*), align 4
  %multiply.66 = fmul float %subtract.34, %region_0_7_constant_45
  %44 = bitcast [64 x [16 x float]]* %5 to float*
  %45 = getelementptr inbounds float, float* %44, i32 %linear_index2
  store float %multiply.66, float* %45, align 4
  %46 = bitcast [64 x [16 x float]]* %1 to float*
  %47 = getelementptr inbounds float, float* %46, i32 %linear_index3
  %48 = load float, float* %47, align 4
  %49 = bitcast [64 x [16 x float]]* %3 to float*
  %50 = getelementptr inbounds float, float* %49, i32 %linear_index3
  %51 = load float, float* %50, align 4, !invariant.load !21
  %subtract.37 = fsub float %48, %51
  %region_0_7_constant_48 = load float, float* bitcast ([4 x i8]* @1 to float*), align 4
  %multiply.69 = fmul float %subtract.37, %region_0_7_constant_48
  %52 = bitcast [64 x [16 x float]]* %5 to float*
  %53 = getelementptr inbounds float, float* %52, i32 %linear_index3
  store float %multiply.69, float* %53, align 4
  br label %fusion_2.in_bounds-after
}

define void @input_fusion_scatter(i8* noalias align 128 dereferenceable(13456) %temp_buf) {
entry:
  %0 = getelementptr inbounds i8, i8* %temp_buf, i64 8192
  %1 = bitcast i8* %0 to [16 x [64 x float]]*
  %2 = getelementptr inbounds i8, i8* %temp_buf, i64 13312
  %3 = bitcast i8* %2 to [4 x [4 x [1 x i32]]]*
  %4 = getelementptr inbounds i8, i8* %temp_buf, i64 0
  %5 = bitcast i8* %4 to [32 x [64 x float]]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !23
  %7 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %8 = mul nuw nsw i32 %6, 256
  %linear_index = add nuw nsw i32 %8, %7
  %linear_index_in_range = icmp ult i32 %linear_index, 512
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %9 = udiv i32 %linear_index_base, 1
  %10 = urem i32 %9, 64
  %11 = udiv i32 %linear_index_base, 64
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %12 = udiv i32 %linear_index1, 1
  %13 = urem i32 %12, 64
  %14 = udiv i32 %linear_index1, 64
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %15 = udiv i32 %linear_index2, 1
  %16 = urem i32 %15, 64
  %17 = udiv i32 %linear_index2, 64
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %18 = udiv i32 %linear_index3, 1
  %19 = urem i32 %18, 64
  %20 = udiv i32 %linear_index3, 64
  %21 = icmp ult i32 %linear_index_base, 2048
  br i1 %21, label %input_fusion_scatter.in_bounds-true, label %input_fusion_scatter.in_bounds-after

input_fusion_scatter.in_bounds-after:             ; preds = %input_fusion_scatter.in_bounds-true, %entry
  ret void

input_fusion_scatter.in_bounds-true:              ; preds = %entry
  %region_0_11_constant_3 = load float, float* bitcast ([4 x i8]* @2 to float*), align 4
  %22 = bitcast [32 x [64 x float]]* %5 to float*
  %23 = getelementptr inbounds float, float* %22, i32 %linear_index_base
  store float %region_0_11_constant_3, float* %23, align 4
  %region_0_11_constant_31 = load float, float* bitcast ([4 x i8]* @2 to float*), align 4
  %24 = bitcast [32 x [64 x float]]* %5 to float*
  %25 = getelementptr inbounds float, float* %24, i32 %linear_index1
  store float %region_0_11_constant_31, float* %25, align 4
  %region_0_11_constant_32 = load float, float* bitcast ([4 x i8]* @2 to float*), align 4
  %26 = bitcast [32 x [64 x float]]* %5 to float*
  %27 = getelementptr inbounds float, float* %26, i32 %linear_index2
  store float %region_0_11_constant_32, float* %27, align 4
  %region_0_11_constant_33 = load float, float* bitcast ([4 x i8]* @2 to float*), align 4
  %28 = bitcast [32 x [64 x float]]* %5 to float*
  %29 = getelementptr inbounds float, float* %28, i32 %linear_index3
  store float %region_0_11_constant_33, float* %29, align 4
  br label %input_fusion_scatter.in_bounds-after
}

define void @input_fusion_scatter__1(i8* noalias align 128 dereferenceable(13456) %temp_buf) {
entry:
  %input_address = alloca float, align 4
  %0 = getelementptr inbounds i8, i8* %temp_buf, i64 8192
  %1 = bitcast i8* %0 to [16 x [64 x float]]*
  %2 = getelementptr inbounds i8, i8* %temp_buf, i64 13312
  %3 = bitcast i8* %2 to [4 x [4 x [1 x i32]]]*
  %4 = getelementptr inbounds i8, i8* %temp_buf, i64 0
  %5 = bitcast i8* %4 to [32 x [64 x float]]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !20
  %7 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !24
  %8 = mul nuw nsw i32 %6, 1024
  %linear_index = add nuw nsw i32 %8, %7
  %linear_index_in_range = icmp ult i32 %linear_index, 1024
  call void @llvm.assume(i1 %linear_index_in_range)
  %9 = udiv i32 %linear_index, 1
  %10 = urem i32 %9, 64
  %11 = udiv i32 %linear_index, 64
  %12 = icmp ult i32 %linear_index, 1024
  br i1 %12, label %scatter.10.in_bounds-true, label %scatter.10.in_bounds-after

scatter.10.in_bounds-after:                       ; preds = %scatter.in_bounds-after, %entry
  ret void

scatter.10.in_bounds-true:                        ; preds = %entry
  %13 = mul nuw nsw i32 %11, 1
  %14 = add nuw nsw i32 0, %13
  %15 = urem i32 %14, 4
  %16 = udiv i32 %14, 4
  %17 = udiv i32 %16, 4
  %Arg_1.2 = getelementptr inbounds [4 x [4 x [1 x i32]]], [4 x [4 x [1 x i32]]]* %3, i32 0, i32 %16, i32 %15, i32 0
  %Arg_1.21 = load i32, i32* %Arg_1.2, align 4, !invariant.load !21
  %18 = add i32 0, %Arg_1.21
  %19 = icmp ult i32 %Arg_1.21, 32
  %20 = and i1 true, %19
  br i1 %20, label %scatter.in_bounds-true, label %scatter.in_bounds-after

scatter.in_bounds-after:                          ; preds = %scatter.in_bounds-true, %scatter.10.in_bounds-true
  br label %scatter.10.in_bounds-after

scatter.in_bounds-true:                           ; preds = %scatter.10.in_bounds-true
  %21 = getelementptr inbounds [32 x [64 x float]], [32 x [64 x float]]* %5, i32 0, i32 %18, i32 %10
  %22 = bitcast [16 x [64 x float]]* %1 to float*
  %Arg_0.1 = getelementptr inbounds float, float* %22, i32 %linear_index
  %Arg_0.12 = load float, float* %Arg_0.1, align 4, !invariant.load !21
  store float %Arg_0.12, float* %input_address, align 4
  %source = load float, float* %input_address, align 4
  %23 = atomicrmw fadd float* %21, float %source seq_cst, align 4
  br label %scatter.in_bounds-after
}

define void @concatenate_1(i8* noalias align 128 dereferenceable(13456) %temp_buf) {
entry:
  %0 = getelementptr inbounds i8, i8* %temp_buf, i64 8192
  %1 = bitcast i8* %0 to [1024 x float]*
  %2 = getelementptr inbounds i8, i8* %temp_buf, i64 12288
  %3 = bitcast i8* %2 to [256 x float]*
  %4 = getelementptr inbounds i8, i8* %temp_buf, i64 0
  %5 = bitcast i8* %4 to [1280 x float]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !23
  %7 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %8 = mul nuw nsw i32 %6, 256
  %linear_index = add nuw nsw i32 %8, %7
  %linear_index_in_range = icmp ult i32 %linear_index, 512
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %9 = udiv i32 %linear_index_base, 1
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %10 = udiv i32 %linear_index1, 1
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %11 = udiv i32 %linear_index2, 1
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %12 = udiv i32 %linear_index3, 1
  %13 = icmp ult i32 %linear_index_base, 1280
  br i1 %13, label %concatenate_1.in_bounds-true, label %concatenate_1.in_bounds-after

concatenate_1.in_bounds-after:                    ; preds = %concatenate.3.merge14, %entry
  ret void

concatenate_1.in_bounds-true:                     ; preds = %entry
  br label %concatenate.pivot.1024.

concat_index_from_operand_id0:                    ; preds = %concatenate.pivot.0.
  %14 = phi i32 [ 0, %concatenate.pivot.0. ]
  %15 = sub nsw i32 %9, %14
  %16 = getelementptr inbounds [1024 x float], [1024 x float]* %1, i32 0, i32 %15
  %17 = load float, float* %16, align 4, !invariant.load !21
  br label %concatenate.3.merge

concat_index_from_operand_id1:                    ; preds = %concatenate.pivot.1024.1
  %18 = phi i32 [ 1024, %concatenate.pivot.1024.1 ]
  %19 = sub nsw i32 %9, %18
  %20 = getelementptr inbounds [256 x float], [256 x float]* %3, i32 0, i32 %19
  %21 = load float, float* %20, align 4, !invariant.load !21
  br label %concatenate.3.merge

concatenate.pivot.1024.:                          ; preds = %concatenate_1.in_bounds-true
  %22 = icmp ult i32 %9, 1024
  br i1 %22, label %concatenate.pivot.0., label %concatenate.pivot.1024.1

concatenate.pivot.0.:                             ; preds = %concatenate.pivot.1024.
  br label %concat_index_from_operand_id0

concatenate.pivot.1024.1:                         ; preds = %concatenate.pivot.1024.
  br label %concat_index_from_operand_id1

concatenate.3.merge:                              ; preds = %concat_index_from_operand_id1, %concat_index_from_operand_id0
  %23 = phi float [ %17, %concat_index_from_operand_id0 ], [ %21, %concat_index_from_operand_id1 ]
  %24 = bitcast [1280 x float]* %5 to float*
  %25 = getelementptr inbounds float, float* %24, i32 %linear_index_base
  store float %23, float* %25, align 4
  br label %concatenate.pivot.1024.5

concat_index_from_operand_id03:                   ; preds = %concatenate.pivot.0.6
  %26 = phi i32 [ 0, %concatenate.pivot.0.6 ]
  %27 = sub nsw i32 %10, %26
  %28 = getelementptr inbounds [1024 x float], [1024 x float]* %1, i32 0, i32 %27
  %29 = load float, float* %28, align 4, !invariant.load !21
  br label %concatenate.3.merge2

concat_index_from_operand_id14:                   ; preds = %concatenate.pivot.1024.7
  %30 = phi i32 [ 1024, %concatenate.pivot.1024.7 ]
  %31 = sub nsw i32 %10, %30
  %32 = getelementptr inbounds [256 x float], [256 x float]* %3, i32 0, i32 %31
  %33 = load float, float* %32, align 4, !invariant.load !21
  br label %concatenate.3.merge2

concatenate.pivot.1024.5:                         ; preds = %concatenate.3.merge
  %34 = icmp ult i32 %10, 1024
  br i1 %34, label %concatenate.pivot.0.6, label %concatenate.pivot.1024.7

concatenate.pivot.0.6:                            ; preds = %concatenate.pivot.1024.5
  br label %concat_index_from_operand_id03

concatenate.pivot.1024.7:                         ; preds = %concatenate.pivot.1024.5
  br label %concat_index_from_operand_id14

concatenate.3.merge2:                             ; preds = %concat_index_from_operand_id14, %concat_index_from_operand_id03
  %35 = phi float [ %29, %concat_index_from_operand_id03 ], [ %33, %concat_index_from_operand_id14 ]
  %36 = bitcast [1280 x float]* %5 to float*
  %37 = getelementptr inbounds float, float* %36, i32 %linear_index1
  store float %35, float* %37, align 4
  br label %concatenate.pivot.1024.11

concat_index_from_operand_id09:                   ; preds = %concatenate.pivot.0.12
  %38 = phi i32 [ 0, %concatenate.pivot.0.12 ]
  %39 = sub nsw i32 %11, %38
  %40 = getelementptr inbounds [1024 x float], [1024 x float]* %1, i32 0, i32 %39
  %41 = load float, float* %40, align 4, !invariant.load !21
  br label %concatenate.3.merge8

concat_index_from_operand_id110:                  ; preds = %concatenate.pivot.1024.13
  %42 = phi i32 [ 1024, %concatenate.pivot.1024.13 ]
  %43 = sub nsw i32 %11, %42
  %44 = getelementptr inbounds [256 x float], [256 x float]* %3, i32 0, i32 %43
  %45 = load float, float* %44, align 4, !invariant.load !21
  br label %concatenate.3.merge8

concatenate.pivot.1024.11:                        ; preds = %concatenate.3.merge2
  %46 = icmp ult i32 %11, 1024
  br i1 %46, label %concatenate.pivot.0.12, label %concatenate.pivot.1024.13

concatenate.pivot.0.12:                           ; preds = %concatenate.pivot.1024.11
  br label %concat_index_from_operand_id09

concatenate.pivot.1024.13:                        ; preds = %concatenate.pivot.1024.11
  br label %concat_index_from_operand_id110

concatenate.3.merge8:                             ; preds = %concat_index_from_operand_id110, %concat_index_from_operand_id09
  %47 = phi float [ %41, %concat_index_from_operand_id09 ], [ %45, %concat_index_from_operand_id110 ]
  %48 = bitcast [1280 x float]* %5 to float*
  %49 = getelementptr inbounds float, float* %48, i32 %linear_index2
  store float %47, float* %49, align 4
  br label %concatenate.pivot.1024.17

concat_index_from_operand_id015:                  ; preds = %concatenate.pivot.0.18
  %50 = phi i32 [ 0, %concatenate.pivot.0.18 ]
  %51 = sub nsw i32 %12, %50
  %52 = getelementptr inbounds [1024 x float], [1024 x float]* %1, i32 0, i32 %51
  %53 = load float, float* %52, align 4, !invariant.load !21
  br label %concatenate.3.merge14

concat_index_from_operand_id116:                  ; preds = %concatenate.pivot.1024.19
  %54 = phi i32 [ 1024, %concatenate.pivot.1024.19 ]
  %55 = sub nsw i32 %12, %54
  %56 = getelementptr inbounds [256 x float], [256 x float]* %3, i32 0, i32 %55
  %57 = load float, float* %56, align 4, !invariant.load !21
  br label %concatenate.3.merge14

concatenate.pivot.1024.17:                        ; preds = %concatenate.3.merge8
  %58 = icmp ult i32 %12, 1024
  br i1 %58, label %concatenate.pivot.0.18, label %concatenate.pivot.1024.19

concatenate.pivot.0.18:                           ; preds = %concatenate.pivot.1024.17
  br label %concat_index_from_operand_id015

concatenate.pivot.1024.19:                        ; preds = %concatenate.pivot.1024.17
  br label %concat_index_from_operand_id116

concatenate.3.merge14:                            ; preds = %concat_index_from_operand_id116, %concat_index_from_operand_id015
  %59 = phi float [ %53, %concat_index_from_operand_id015 ], [ %57, %concat_index_from_operand_id116 ]
  %60 = bitcast [1280 x float]* %5 to float*
  %61 = getelementptr inbounds float, float* %60, i32 %linear_index3
  store float %59, float* %61, align 4
  br label %concatenate_1.in_bounds-after
}

define void @slice_3(i8* noalias align 128 dereferenceable(13456) %temp_buf) {
entry:
  %0 = getelementptr inbounds i8, i8* %temp_buf, i64 0
  %1 = bitcast i8* %0 to [1280 x float]*
  %2 = getelementptr inbounds i8, i8* %temp_buf, i64 9216
  %3 = bitcast i8* %2 to [256 x float]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !20
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !25
  %6 = mul nuw nsw i32 %4, 64
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 64
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %8 = udiv i32 %linear_index1, 1
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %9 = udiv i32 %linear_index2, 1
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %10 = udiv i32 %linear_index3, 1
  %11 = icmp ult i32 %linear_index_base, 256
  br i1 %11, label %slice_3.in_bounds-true, label %slice_3.in_bounds-after

slice_3.in_bounds-after:                          ; preds = %slice_3.in_bounds-true, %entry
  ret void

slice_3.in_bounds-true:                           ; preds = %entry
  %12 = add i32 %7, 1024
  %13 = getelementptr inbounds [1280 x float], [1280 x float]* %1, i32 0, i32 %12
  %14 = load float, float* %13, align 4, !invariant.load !21
  %15 = bitcast [256 x float]* %3 to float*
  %16 = getelementptr inbounds float, float* %15, i32 %linear_index_base
  store float %14, float* %16, align 4
  %17 = add i32 %8, 1024
  %18 = getelementptr inbounds [1280 x float], [1280 x float]* %1, i32 0, i32 %17
  %19 = load float, float* %18, align 4, !invariant.load !21
  %20 = bitcast [256 x float]* %3 to float*
  %21 = getelementptr inbounds float, float* %20, i32 %linear_index1
  store float %19, float* %21, align 4
  %22 = add i32 %9, 1024
  %23 = getelementptr inbounds [1280 x float], [1280 x float]* %1, i32 0, i32 %22
  %24 = load float, float* %23, align 4, !invariant.load !21
  %25 = bitcast [256 x float]* %3 to float*
  %26 = getelementptr inbounds float, float* %25, i32 %linear_index2
  store float %24, float* %26, align 4
  %27 = add i32 %10, 1024
  %28 = getelementptr inbounds [1280 x float], [1280 x float]* %1, i32 0, i32 %27
  %29 = load float, float* %28, align 4, !invariant.load !21
  %30 = bitcast [256 x float]* %3 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index3
  store float %29, float* %31, align 4
  br label %slice_3.in_bounds-after
}

define void @slice_2(i8* noalias align 128 dereferenceable(13456) %temp_buf) {
entry:
  %0 = getelementptr inbounds i8, i8* %temp_buf, i64 0
  %1 = bitcast i8* %0 to [1280 x float]*
  %2 = getelementptr inbounds i8, i8* %temp_buf, i64 5120
  %3 = bitcast i8* %2 to [1024 x float]*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !20
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %6 = mul nuw nsw i32 %4, 256
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 256
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %7 = udiv i32 %linear_index_base, 1
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %8 = udiv i32 %linear_index1, 1
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %9 = udiv i32 %linear_index2, 1
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %10 = udiv i32 %linear_index3, 1
  %11 = icmp ult i32 %linear_index_base, 1024
  br i1 %11, label %slice_2.in_bounds-true, label %slice_2.in_bounds-after

slice_2.in_bounds-after:                          ; preds = %slice_2.in_bounds-true, %entry
  ret void

slice_2.in_bounds-true:                           ; preds = %entry
  %12 = add i32 %7, 0
  %13 = getelementptr inbounds [1280 x float], [1280 x float]* %1, i32 0, i32 %12
  %14 = load float, float* %13, align 4, !invariant.load !21
  %15 = bitcast [1024 x float]* %3 to float*
  %16 = getelementptr inbounds float, float* %15, i32 %linear_index_base
  store float %14, float* %16, align 4
  %17 = add i32 %8, 0
  %18 = getelementptr inbounds [1280 x float], [1280 x float]* %1, i32 0, i32 %17
  %19 = load float, float* %18, align 4, !invariant.load !21
  %20 = bitcast [1024 x float]* %3 to float*
  %21 = getelementptr inbounds float, float* %20, i32 %linear_index1
  store float %19, float* %21, align 4
  %22 = add i32 %9, 0
  %23 = getelementptr inbounds [1280 x float], [1280 x float]* %1, i32 0, i32 %22
  %24 = load float, float* %23, align 4, !invariant.load !21
  %25 = bitcast [1024 x float]* %3 to float*
  %26 = getelementptr inbounds float, float* %25, i32 %linear_index2
  store float %24, float* %26, align 4
  %27 = add i32 %10, 0
  %28 = getelementptr inbounds [1280 x float], [1280 x float]* %1, i32 0, i32 %27
  %29 = load float, float* %28, align 4, !invariant.load !21
  %30 = bitcast [1024 x float]* %3 to float*
  %31 = getelementptr inbounds float, float* %30, i32 %linear_index3
  store float %29, float* %31, align 4
  br label %slice_2.in_bounds-after
}

define void @fusion_5(i8* noalias align 16 dereferenceable(4096) %alloc1, i8* noalias align 16 dereferenceable(1024) %alloc2, i8* noalias align 128 dereferenceable(13456) %temp_buf) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %1 = bitcast i8* %0 to [32 x [32 x float]]*
  %2 = getelementptr inbounds i8, i8* %temp_buf, i64 5120
  %3 = bitcast i8* %2 to [32 x [32 x float]]*
  %4 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %5 = bitcast i8* %4 to [16 x [16 x float]]*
  %6 = getelementptr inbounds i8, i8* %temp_buf, i64 9216
  %7 = bitcast i8* %6 to [16 x [16 x float]]*
  %8 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %9 = bitcast i8* %8 to [1024 x float]*
  %10 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %11 = bitcast i8* %10 to [256 x float]*
  %12 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !23
  %13 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !24
  %14 = mul nuw nsw i32 %12, 1024
  %linear_index = add nuw nsw i32 %14, %13
  %linear_index_in_range = icmp ult i32 %linear_index, 2048
  call void @llvm.assume(i1 %linear_index_in_range)
  %15 = udiv i32 %linear_index, 1
  %16 = icmp ult i32 %linear_index, 1280
  br i1 %16, label %fusion_5.in_bounds-true, label %fusion_5.in_bounds-after

fusion_5.in_bounds-after:                         ; preds = %slice1-after, %entry
  ret void

fusion_5.in_bounds-true:                          ; preds = %entry
  br label %concatenate.pivot.1024.

concat_index_from_operand_id0:                    ; preds = %concatenate.pivot.0.
  %17 = phi i32 [ 0, %concatenate.pivot.0. ]
  %18 = sub nsw i32 %15, %17
  %19 = mul nuw nsw i32 %18, 1
  %20 = add nuw nsw i32 0, %19
  %21 = urem i32 %20, 32
  %22 = udiv i32 %20, 32
  %23 = udiv i32 %22, 32
  %24 = getelementptr inbounds [32 x [32 x float]], [32 x [32 x float]]* %1, i32 0, i32 %22, i32 %21
  %25 = load float, float* %24, align 4
  %26 = getelementptr inbounds [32 x [32 x float]], [32 x [32 x float]]* %3, i32 0, i32 %22, i32 %21
  %27 = load float, float* %26, align 4, !invariant.load !21
  %region_0_18_constant_5 = load float, float* bitcast ([4 x i8]* @3 to float*), align 4
  %multiply.7 = fmul float %27, %region_0_18_constant_5
  %subtract.8 = fsub float %25, %multiply.7
  br label %concatenate.14.merge

concat_index_from_operand_id1:                    ; preds = %concatenate.pivot.1024.2
  %28 = phi i32 [ 1024, %concatenate.pivot.1024.2 ]
  %29 = sub nsw i32 %15, %28
  %30 = mul nuw nsw i32 %29, 1
  %31 = add nuw nsw i32 0, %30
  %32 = urem i32 %31, 16
  %33 = udiv i32 %31, 16
  %34 = udiv i32 %33, 16
  %35 = getelementptr inbounds [16 x [16 x float]], [16 x [16 x float]]* %5, i32 0, i32 %33, i32 %32
  %36 = load float, float* %35, align 4
  %37 = getelementptr inbounds [16 x [16 x float]], [16 x [16 x float]]* %7, i32 0, i32 %33, i32 %32
  %38 = load float, float* %37, align 4, !invariant.load !21
  %region_0_18_constant_51 = load float, float* bitcast ([4 x i8]* @3 to float*), align 4
  %multiply.11 = fmul float %38, %region_0_18_constant_51
  %subtract.12 = fsub float %36, %multiply.11
  br label %concatenate.14.merge

concatenate.pivot.1024.:                          ; preds = %fusion_5.in_bounds-true
  %39 = icmp ult i32 %15, 1024
  br i1 %39, label %concatenate.pivot.0., label %concatenate.pivot.1024.2

concatenate.pivot.0.:                             ; preds = %concatenate.pivot.1024.
  br label %concat_index_from_operand_id0

concatenate.pivot.1024.2:                         ; preds = %concatenate.pivot.1024.
  br label %concat_index_from_operand_id1

concatenate.14.merge:                             ; preds = %concat_index_from_operand_id1, %concat_index_from_operand_id0
  %40 = phi float [ %subtract.8, %concat_index_from_operand_id0 ], [ %subtract.12, %concat_index_from_operand_id1 ]
  %41 = icmp sge i32 %15, 0
  %42 = icmp slt i32 %15, 1024
  %43 = and i1 %41, %42
  br i1 %43, label %slice0-true, label %slice0-after

slice0-after:                                     ; preds = %slice0-true, %concatenate.14.merge
  %44 = icmp sge i32 %15, 1024
  %45 = icmp slt i32 %15, 1280
  %46 = and i1 %44, %45
  br i1 %46, label %slice1-true, label %slice1-after

slice1-after:                                     ; preds = %slice1-true, %slice0-after
  br label %fusion_5.in_bounds-after

slice0-true:                                      ; preds = %concatenate.14.merge
  %47 = sub i32 %15, 0
  %48 = getelementptr inbounds [1024 x float], [1024 x float]* %9, i32 0, i32 %47
  store float %40, float* %48, align 4
  br label %slice0-after

slice1-true:                                      ; preds = %slice0-after
  %49 = sub i32 %15, 1024
  %50 = getelementptr inbounds [256 x float], [256 x float]* %11, i32 0, i32 %49
  store float %40, float* %50, align 4
  br label %slice1-after
}

attributes #0 = { nounwind readnone speculatable }
attributes #1 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }

!nvvm.annotations = !{!0, !1, !2, !3, !4, !5, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19}

!0 = !{void (i8*, i8*)* @add_2, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @add_2, !"reqntidx", i32 1}
!2 = !{void (i8*)* @fusion_3, !"kernel", i32 1}
!3 = !{void (i8*)* @fusion_3, !"reqntidx", i32 1}
!4 = !{void (i8*)* @fusion_4, !"kernel", i32 1}
!5 = !{void (i8*)* @fusion_4, !"reqntidx", i32 256}
!6 = !{void (i8*, i8*)* @fusion_2, !"kernel", i32 1}
!7 = !{void (i8*, i8*)* @fusion_2, !"reqntidx", i32 256}
!8 = !{void (i8*)* @input_fusion_scatter, !"kernel", i32 1}
!9 = !{void (i8*)* @input_fusion_scatter, !"reqntidx", i32 256}
!10 = !{void (i8*)* @input_fusion_scatter__1, !"kernel", i32 1}
!11 = !{void (i8*)* @input_fusion_scatter__1, !"reqntidx", i32 1024}
!12 = !{void (i8*)* @concatenate_1, !"kernel", i32 1}
!13 = !{void (i8*)* @concatenate_1, !"reqntidx", i32 256}
!14 = !{void (i8*)* @slice_3, !"kernel", i32 1}
!15 = !{void (i8*)* @slice_3, !"reqntidx", i32 64}
!16 = !{void (i8*)* @slice_2, !"kernel", i32 1}
!17 = !{void (i8*)* @slice_2, !"reqntidx", i32 256}
!18 = !{void (i8*, i8*, i8*)* @fusion_5, !"kernel", i32 1}
!19 = !{void (i8*, i8*, i8*)* @fusion_5, !"reqntidx", i32 1024}
!20 = !{i32 0, i32 1}
!21 = !{}
!22 = !{i32 0, i32 256}
!23 = !{i32 0, i32 2}
!24 = !{i32 0, i32 1024}
!25 = !{i32 0, i32 64}
