target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @concatenate_3(i8* noalias align 16 dereferenceable(4) %alloc0, i8* noalias align 16 dereferenceable(4) %alloc1, i8* noalias align 128 dereferenceable(8) %alloc2) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to [1 x i32]*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to [1 x i32]*
  %4 = getelementptr inbounds i8, i8* %alloc2, i64 0
  %5 = bitcast i8* %4 to [2 x i32]*
  %6 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %7 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !2
  %8 = mul nuw nsw i32 %6, 1
  %linear_index = add nuw nsw i32 %8, %7
  %linear_index_in_range = icmp ult i32 %linear_index, 1
  call void @llvm.assume(i1 %linear_index_in_range)
  %linear_index_base = mul nuw nsw i32 %linear_index, 2
  %9 = udiv i32 %linear_index_base, 1
  %linear_index1 = add nuw nsw i32 %linear_index_base, 1
  %10 = udiv i32 %linear_index1, 1
  %11 = icmp ult i32 %linear_index_base, 2
  br i1 %11, label %concatenate_3.in_bounds-true, label %concatenate_3.in_bounds-after

concatenate_3.in_bounds-after:                    ; preds = %concatenate.3.merge2, %entry
  ret void

concatenate_3.in_bounds-true:                     ; preds = %entry
  br label %concatenate.pivot.1.

concat_index_from_operand_id0:                    ; preds = %concatenate.pivot.0.
  %12 = phi i32 [ 0, %concatenate.pivot.0. ]
  %13 = sub nsw i32 %9, %12
  %14 = getelementptr inbounds [1 x i32], [1 x i32]* %1, i32 0, i32 0
  %15 = load i32, i32* %14, align 4, !invariant.load !3
  br label %concatenate.3.merge

concat_index_from_operand_id1:                    ; preds = %concatenate.pivot.1.1
  %16 = phi i32 [ 1, %concatenate.pivot.1.1 ]
  %17 = sub nsw i32 %9, %16
  %18 = getelementptr inbounds [1 x i32], [1 x i32]* %3, i32 0, i32 0
  %19 = load i32, i32* %18, align 4, !invariant.load !3
  br label %concatenate.3.merge

concatenate.pivot.1.:                             ; preds = %concatenate_3.in_bounds-true
  %20 = icmp ult i32 %9, 1
  br i1 %20, label %concatenate.pivot.0., label %concatenate.pivot.1.1

concatenate.pivot.0.:                             ; preds = %concatenate.pivot.1.
  br label %concat_index_from_operand_id0

concatenate.pivot.1.1:                            ; preds = %concatenate.pivot.1.
  br label %concat_index_from_operand_id1

concatenate.3.merge:                              ; preds = %concat_index_from_operand_id1, %concat_index_from_operand_id0
  %21 = phi i32 [ %15, %concat_index_from_operand_id0 ], [ %19, %concat_index_from_operand_id1 ]
  %22 = bitcast [2 x i32]* %5 to i32*
  %23 = getelementptr inbounds i32, i32* %22, i32 %linear_index_base
  store i32 %21, i32* %23, align 4
  br label %concatenate.pivot.1.5

concat_index_from_operand_id03:                   ; preds = %concatenate.pivot.0.6
  %24 = phi i32 [ 0, %concatenate.pivot.0.6 ]
  %25 = sub nsw i32 %10, %24
  %26 = getelementptr inbounds [1 x i32], [1 x i32]* %1, i32 0, i32 0
  %27 = load i32, i32* %26, align 4, !invariant.load !3
  br label %concatenate.3.merge2

concat_index_from_operand_id14:                   ; preds = %concatenate.pivot.1.7
  %28 = phi i32 [ 1, %concatenate.pivot.1.7 ]
  %29 = sub nsw i32 %10, %28
  %30 = getelementptr inbounds [1 x i32], [1 x i32]* %3, i32 0, i32 0
  %31 = load i32, i32* %30, align 4, !invariant.load !3
  br label %concatenate.3.merge2

concatenate.pivot.1.5:                            ; preds = %concatenate.3.merge
  %32 = icmp ult i32 %10, 1
  br i1 %32, label %concatenate.pivot.0.6, label %concatenate.pivot.1.7

concatenate.pivot.0.6:                            ; preds = %concatenate.pivot.1.5
  br label %concat_index_from_operand_id03

concatenate.pivot.1.7:                            ; preds = %concatenate.pivot.1.5
  br label %concat_index_from_operand_id14

concatenate.3.merge2:                             ; preds = %concat_index_from_operand_id14, %concat_index_from_operand_id03
  %33 = phi i32 [ %27, %concat_index_from_operand_id03 ], [ %31, %concat_index_from_operand_id14 ]
  %34 = bitcast [2 x i32]* %5 to i32*
  %35 = getelementptr inbounds i32, i32* %34, i32 %linear_index1
  store i32 %33, i32* %35, align 4
  br label %concatenate_3.in_bounds-after
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

!0 = !{void (i8*, i8*, i8*)* @concatenate_3, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @concatenate_3, !"reqntidx", i32 1}
!2 = !{i32 0, i32 1}
!3 = !{}
