target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @shift_right_logical_3(i8* noalias align 16 dereferenceable(4) %alloc0, i8* noalias align 16 dereferenceable(4) %alloc1, i8* noalias align 128 dereferenceable(4) %alloc2) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to i32*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to i32*
  %4 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %5 = bitcast i8* %4 to i32*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %7 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !2
  %8 = mul nuw nsw i32 %6, 1
  %linear_index = add nuw nsw i32 %8, %7
  %linear_index_in_range = icmp ult i32 %linear_index, 1
  call void @llvm.assume(i1 %linear_index_in_range)
  %9 = icmp ult i32 %linear_index, 1
  br i1 %9, label %shift_right_logical_3.in_bounds-true, label %shift_right_logical_3.in_bounds-after

shift_right_logical_3.in_bounds-after:            ; preds = %shift_right_logical_3.in_bounds-true, %entry
  ret void

shift_right_logical_3.in_bounds-true:             ; preds = %entry
  %10 = load i32, i32* %1, align 4, !invariant.load !3
  %11 = load i32, i32* %3, align 4, !invariant.load !3
  %12 = lshr i32 %10, %11
  %shft.chk = icmp ult i32 %11, 32
  %13 = select i1 %shft.chk, i32 %12, i32 0
  store i32 %13, i32* %5, align 4
  br label %shift_right_logical_3.in_bounds-after
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

!0 = !{void (i8*, i8*, i8*)* @shift_right_logical_3, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @shift_right_logical_3, !"reqntidx", i32 1}
!2 = !{i32 0, i32 1}
!3 = !{}
