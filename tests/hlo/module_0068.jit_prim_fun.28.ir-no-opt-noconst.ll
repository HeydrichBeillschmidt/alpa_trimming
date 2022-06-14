target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @select_4(i8* noalias align 16 dereferenceable(16) %alloc0, i8* noalias align 16 dereferenceable(64) %alloc1, i8* noalias align 16 dereferenceable(64) %alloc2, i8* noalias align 128 dereferenceable(64) %alloc3) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [16 x i8]*
  %2 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %3 = bitcast i8* %2 to [16 x i32]*
  %4 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %5 = bitcast i8* %4 to [16 x i32]*
  %6 = getelementptr inbounds i8, i8* %alloc3, i64 0
  %7 = bitcast i8* %6 to [16 x i32]*
  %8 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %9 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %10 = mul nuw nsw i32 %8, 4
  %linear_index = add nuw nsw i32 %10, %9
  %linear_index_in_range = icmp ult i32 %linear_index, 4
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %11 = udiv i32 %linear_index_base, 1
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %12 = udiv i32 %linear_index1, 1
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %13 = udiv i32 %linear_index2, 1
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %14 = udiv i32 %linear_index3, 1
  %15 = icmp ult i32 %linear_index_base, 16
  br i1 %15, label %select_4.in_bounds-true, label %select_4.in_bounds-after

select_4.in_bounds-after:                         ; preds = %select_4.in_bounds-true, %entry
  ret void

select_4.in_bounds-true:                          ; preds = %entry
  %16 = bitcast [16 x i8]* %1 to i8*
  %17 = getelementptr inbounds i8, i8* %16, i32 %linear_index_base
  %18 = load i8, i8* %17, align 1, !invariant.load !4
  %19 = bitcast [16 x i32]* %3 to i32*
  %20 = getelementptr inbounds i32, i32* %19, i32 %linear_index_base
  %21 = load i32, i32* %20, align 4, !invariant.load !4
  %22 = bitcast [16 x i32]* %5 to i32*
  %23 = getelementptr inbounds i32, i32* %22, i32 %linear_index_base
  %24 = load i32, i32* %23, align 4, !invariant.load !4
  %25 = trunc i8 %18 to i1
  %26 = select i1 %25, i32 %21, i32 %24
  %27 = bitcast [16 x i32]* %7 to i32*
  %28 = getelementptr inbounds i32, i32* %27, i32 %linear_index_base
  store i32 %26, i32* %28, align 4
  %29 = bitcast [16 x i8]* %1 to i8*
  %30 = getelementptr inbounds i8, i8* %29, i32 %linear_index1
  %31 = load i8, i8* %30, align 1, !invariant.load !4
  %32 = bitcast [16 x i32]* %3 to i32*
  %33 = getelementptr inbounds i32, i32* %32, i32 %linear_index1
  %34 = load i32, i32* %33, align 4, !invariant.load !4
  %35 = bitcast [16 x i32]* %5 to i32*
  %36 = getelementptr inbounds i32, i32* %35, i32 %linear_index1
  %37 = load i32, i32* %36, align 4, !invariant.load !4
  %38 = trunc i8 %31 to i1
  %39 = select i1 %38, i32 %34, i32 %37
  %40 = bitcast [16 x i32]* %7 to i32*
  %41 = getelementptr inbounds i32, i32* %40, i32 %linear_index1
  store i32 %39, i32* %41, align 4
  %42 = bitcast [16 x i8]* %1 to i8*
  %43 = getelementptr inbounds i8, i8* %42, i32 %linear_index2
  %44 = load i8, i8* %43, align 1, !invariant.load !4
  %45 = bitcast [16 x i32]* %3 to i32*
  %46 = getelementptr inbounds i32, i32* %45, i32 %linear_index2
  %47 = load i32, i32* %46, align 4, !invariant.load !4
  %48 = bitcast [16 x i32]* %5 to i32*
  %49 = getelementptr inbounds i32, i32* %48, i32 %linear_index2
  %50 = load i32, i32* %49, align 4, !invariant.load !4
  %51 = trunc i8 %44 to i1
  %52 = select i1 %51, i32 %47, i32 %50
  %53 = bitcast [16 x i32]* %7 to i32*
  %54 = getelementptr inbounds i32, i32* %53, i32 %linear_index2
  store i32 %52, i32* %54, align 4
  %55 = bitcast [16 x i8]* %1 to i8*
  %56 = getelementptr inbounds i8, i8* %55, i32 %linear_index3
  %57 = load i8, i8* %56, align 1, !invariant.load !4
  %58 = bitcast [16 x i32]* %3 to i32*
  %59 = getelementptr inbounds i32, i32* %58, i32 %linear_index3
  %60 = load i32, i32* %59, align 4, !invariant.load !4
  %61 = bitcast [16 x i32]* %5 to i32*
  %62 = getelementptr inbounds i32, i32* %61, i32 %linear_index3
  %63 = load i32, i32* %62, align 4, !invariant.load !4
  %64 = trunc i8 %57 to i1
  %65 = select i1 %64, i32 %60, i32 %63
  %66 = bitcast [16 x i32]* %7 to i32*
  %67 = getelementptr inbounds i32, i32* %66, i32 %linear_index3
  store i32 %65, i32* %67, align 4
  br label %select_4.in_bounds-after
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

!0 = !{void (i8*, i8*, i8*, i8*)* @select_4, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*, i8*)* @select_4, !"reqntidx", i32 4}
!2 = !{i32 0, i32 1}
!3 = !{i32 0, i32 4}
!4 = !{}
