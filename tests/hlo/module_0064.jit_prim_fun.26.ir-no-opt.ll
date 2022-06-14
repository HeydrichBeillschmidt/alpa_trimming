target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @fusion(i8* noalias align 16 dereferenceable(64) %alloc0, i8* noalias align 16 dereferenceable(4) %alloc1, i8* noalias align 128 dereferenceable(16) %alloc2) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [16 x i32]*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to i32*
  %4 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %5 = bitcast i8* %4 to [16 x i8]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %7 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %8 = mul nuw nsw i32 %6, 4
  %linear_index = add nuw nsw i32 %8, %7
  %linear_index_in_range = icmp ult i32 %linear_index, 4
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %9 = udiv i32 %linear_index_base, 1
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %10 = udiv i32 %linear_index1, 1
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %11 = udiv i32 %linear_index2, 1
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %12 = udiv i32 %linear_index3, 1
  %13 = icmp ult i32 %linear_index_base, 16
  br i1 %13, label %fusion.in_bounds-true, label %fusion.in_bounds-after

fusion.in_bounds-after:                           ; preds = %fusion.in_bounds-true, %entry
  ret void

fusion.in_bounds-true:                            ; preds = %entry
  %14 = bitcast [16 x i32]* %1 to i32*
  %15 = getelementptr inbounds i32, i32* %14, i32 %linear_index_base
  %16 = load i32, i32* %15, align 4, !invariant.load !4
  %17 = load i32, i32* %3, align 4, !invariant.load !4
  %18 = icmp slt i32 %16, %17
  %19 = zext i1 %18 to i8
  %20 = bitcast [16 x i8]* %5 to i8*
  %21 = getelementptr inbounds i8, i8* %20, i32 %linear_index_base
  store i8 %19, i8* %21, align 1
  %22 = bitcast [16 x i32]* %1 to i32*
  %23 = getelementptr inbounds i32, i32* %22, i32 %linear_index1
  %24 = load i32, i32* %23, align 4, !invariant.load !4
  %25 = load i32, i32* %3, align 4, !invariant.load !4
  %26 = icmp slt i32 %24, %25
  %27 = zext i1 %26 to i8
  %28 = bitcast [16 x i8]* %5 to i8*
  %29 = getelementptr inbounds i8, i8* %28, i32 %linear_index1
  store i8 %27, i8* %29, align 1
  %30 = bitcast [16 x i32]* %1 to i32*
  %31 = getelementptr inbounds i32, i32* %30, i32 %linear_index2
  %32 = load i32, i32* %31, align 4, !invariant.load !4
  %33 = load i32, i32* %3, align 4, !invariant.load !4
  %34 = icmp slt i32 %32, %33
  %35 = zext i1 %34 to i8
  %36 = bitcast [16 x i8]* %5 to i8*
  %37 = getelementptr inbounds i8, i8* %36, i32 %linear_index2
  store i8 %35, i8* %37, align 1
  %38 = bitcast [16 x i32]* %1 to i32*
  %39 = getelementptr inbounds i32, i32* %38, i32 %linear_index3
  %40 = load i32, i32* %39, align 4, !invariant.load !4
  %41 = load i32, i32* %3, align 4, !invariant.load !4
  %42 = icmp slt i32 %40, %41
  %43 = zext i1 %42 to i8
  %44 = bitcast [16 x i8]* %5 to i8*
  %45 = getelementptr inbounds i8, i8* %44, i32 %linear_index3
  store i8 %43, i8* %45, align 1
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
!1 = !{void (i8*, i8*, i8*)* @fusion, !"reqntidx", i32 4}
!2 = !{i32 0, i32 1}
!3 = !{i32 0, i32 4}
!4 = !{}
