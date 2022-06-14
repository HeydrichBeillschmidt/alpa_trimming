target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @iota_1(i8* noalias align 128 dereferenceable(64) %alloc0) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [16 x i32]*
  %2 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %3 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %4 = mul nuw nsw i32 %2, 4
  %linear_index = add nuw nsw i32 %4, %3
  %linear_index_in_range = icmp ult i32 %linear_index, 4
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 4
  %5 = udiv i32 %linear_index_base, 1
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %6 = udiv i32 %linear_index1, 1
  %linear_index2 = add nuw nsw i32 %linear_index_base, 2
  %7 = udiv i32 %linear_index2, 1
  %linear_index3 = add nuw nsw i32 %linear_index_base, 3
  %8 = udiv i32 %linear_index3, 1
  %9 = icmp ult i32 %linear_index_base, 16
  br i1 %9, label %iota_1.in_bounds-true, label %iota_1.in_bounds-after

iota_1.in_bounds-after:                           ; preds = %iota_1.in_bounds-true, %entry
  ret void

iota_1.in_bounds-true:                            ; preds = %entry
  %10 = bitcast [16 x i32]* %1 to i32*
  %11 = getelementptr inbounds i32, i32* %10, i32 %linear_index_base
  store i32 %linear_index_base, i32* %11, align 4
  %12 = bitcast [16 x i32]* %1 to i32*
  %13 = getelementptr inbounds i32, i32* %12, i32 %linear_index1
  store i32 %linear_index1, i32* %13, align 4
  %14 = bitcast [16 x i32]* %1 to i32*
  %15 = getelementptr inbounds i32, i32* %14, i32 %linear_index2
  store i32 %linear_index2, i32* %15, align 4
  %16 = bitcast [16 x i32]* %1 to i32*
  %17 = getelementptr inbounds i32, i32* %16, i32 %linear_index3
  store i32 %linear_index3, i32* %17, align 4
  br label %iota_1.in_bounds-after
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

!0 = !{void (i8*)* @iota_1, !"kernel", i32 1}
!1 = !{void (i8*)* @iota_1, !"reqntidx", i32 4}
!2 = !{i32 0, i32 1}
!3 = !{i32 0, i32 4}
