target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @fusion(i8* noalias align 16 dereferenceable(64) %alloc0, i8* noalias align 16 dereferenceable(4) %alloc1, i8* noalias align 128 dereferenceable(64) %alloc2) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [16 x i32]*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to i32*
  %4 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %5 = bitcast i8* %4 to [16 x i32]*
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
  %18 = add i32 %16, %17
  %19 = bitcast [16 x i32]* %5 to i32*
  %20 = getelementptr inbounds i32, i32* %19, i32 %linear_index_base
  store i32 %18, i32* %20, align 4
  %21 = bitcast [16 x i32]* %1 to i32*
  %22 = getelementptr inbounds i32, i32* %21, i32 %linear_index1
  %23 = load i32, i32* %22, align 4, !invariant.load !4
  %24 = load i32, i32* %3, align 4, !invariant.load !4
  %25 = add i32 %23, %24
  %26 = bitcast [16 x i32]* %5 to i32*
  %27 = getelementptr inbounds i32, i32* %26, i32 %linear_index1
  store i32 %25, i32* %27, align 4
  %28 = bitcast [16 x i32]* %1 to i32*
  %29 = getelementptr inbounds i32, i32* %28, i32 %linear_index2
  %30 = load i32, i32* %29, align 4, !invariant.load !4
  %31 = load i32, i32* %3, align 4, !invariant.load !4
  %32 = add i32 %30, %31
  %33 = bitcast [16 x i32]* %5 to i32*
  %34 = getelementptr inbounds i32, i32* %33, i32 %linear_index2
  store i32 %32, i32* %34, align 4
  %35 = bitcast [16 x i32]* %1 to i32*
  %36 = getelementptr inbounds i32, i32* %35, i32 %linear_index3
  %37 = load i32, i32* %36, align 4, !invariant.load !4
  %38 = load i32, i32* %3, align 4, !invariant.load !4
  %39 = add i32 %37, %38
  %40 = bitcast [16 x i32]* %5 to i32*
  %41 = getelementptr inbounds i32, i32* %40, i32 %linear_index3
  store i32 %39, i32* %41, align 4
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
