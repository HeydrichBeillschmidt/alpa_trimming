target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

define void @sqrt_2(i8* noalias align 16 dereferenceable(4) %alloc0, i8* noalias align 128 dereferenceable(4) %alloc1) {
entry:
  %0 = getelementptr inbounds i8, i8* %alloc0, i64 0
  %1 = bitcast i8* %0 to float*
  %2 = getelementptr inbounds i8, i8* %alloc1, i64 0
  %3 = bitcast i8* %2 to float*
  %4 = call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !2
  %5 = call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !2
  %6 = mul nuw nsw i32 %4, 1
  %linear_index = add nuw nsw i32 %6, %5
  %linear_index_in_range = icmp ult i32 %linear_index, 1
  call void @llvm.assume(i1 %linear_index_in_range)
  %7 = icmp ult i32 %linear_index, 1
  br i1 %7, label %sqrt_2.in_bounds-true, label %sqrt_2.in_bounds-after

sqrt_2.in_bounds-after:                           ; preds = %sqrt_2.in_bounds-true, %entry
  ret void

sqrt_2.in_bounds-true:                            ; preds = %entry
  %8 = load float, float* %1, align 4, !invariant.load !3
  %9 = call float @__nv_sqrtf(float %8)
  store float %9, float* %3, align 4
  br label %sqrt_2.in_bounds-after
}

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #0

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #0

; Function Attrs: inaccessiblememonly nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #1

; Function Attrs: nounwind readnone
declare float @__nv_sqrtf(float) #2

attributes #0 = { nounwind readnone speculatable }
attributes #1 = { inaccessiblememonly nocallback nofree nosync nounwind willreturn }
attributes #2 = { nounwind readnone }

!nvvm.annotations = !{!0, !1}

!0 = !{void (i8*, i8*)* @sqrt_2, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @sqrt_2, !"reqntidx", i32 1}
!2 = !{i32 0, i32 1}
!3 = !{}
