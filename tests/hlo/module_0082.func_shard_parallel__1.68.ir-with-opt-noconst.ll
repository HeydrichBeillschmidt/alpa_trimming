target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

@buffer_for_constant_4 = external local_unnamed_addr addrspace(1) constant [4 x i8], align 128

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn
define void @add_2(i8* noalias nocapture align 16 dereferenceable(4) %alloc0, i8* noalias nocapture readnone align 128 dereferenceable(13456) %temp_buf) local_unnamed_addr #0 {
entry:
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = bitcast i8 addrspace(1)* %alloc01 to i32 addrspace(1)*
  %1 = load i32, i32 addrspace(1)* %0, align 16
  %2 = add i32 %1, 1
  store i32 %2, i32 addrspace(1)* %0, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #1

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn
define void @fusion_3(i8* noalias nocapture align 128 dereferenceable(13456) %temp_buf) local_unnamed_addr #0 {
entry:
  %temp_buf1 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf1, i64 128
  %1 = bitcast i8 addrspace(1)* %0 to i32 addrspace(1)*
  %2 = load i32, i32 addrspace(1)* %1, align 128, !invariant.load !21
  %3 = shl i32 %2, 2
  %4 = bitcast i8 addrspace(1)* %temp_buf1 to i32 addrspace(1)*
  %5 = or i32 %3, 1
  %6 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf1, i64 4
  %7 = or i32 %3, 2
  %8 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf1, i64 8
  %9 = or i32 %3, 3
  %10 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf1, i64 12
  %11 = insertelement <4 x i32> poison, i32 %3, i32 0
  %12 = insertelement <4 x i32> %11, i32 %5, i32 1
  %13 = insertelement <4 x i32> %12, i32 %7, i32 2
  %14 = insertelement <4 x i32> %13, i32 %9, i32 3
  %15 = bitcast i32 addrspace(1)* %4 to <4 x i32> addrspace(1)*
  store <4 x i32> %14, <4 x i32> addrspace(1)* %15, align 128
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion_4(i8* noalias nocapture align 128 dereferenceable(13456) %temp_buf) local_unnamed_addr #2 {
entry:
  %temp_buf1 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %linear_index_base = shl nuw nsw i32 %0, 2
  %1 = lshr i32 %0, 2
  %2 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf1, i64 8192
  %3 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf1, i64 13312
  %4 = bitcast i8 addrspace(1)* %3 to [4 x [4 x [1 x i32]]] addrspace(1)*
  %5 = bitcast i8 addrspace(1)* %temp_buf1 to [64 x [32 x float]] addrspace(1)*
  %6 = and i32 %0, 3
  %7 = zext i32 %6 to i64
  %8 = getelementptr inbounds [4 x [4 x [1 x i32]]], [4 x [4 x [1 x i32]]] addrspace(1)* %4, i64 0, i64 %7, i64 0, i64 0
  %9 = bitcast i32 addrspace(1)* %8 to <4 x i32> addrspace(1)*
  %10 = load <4 x i32>, <4 x i32> addrspace(1)* %9, align 16, !invariant.load !21
  %11 = extractelement <4 x i32> %10, i32 0
  %12 = extractelement <4 x i32> %10, i32 1
  %13 = extractelement <4 x i32> %10, i32 2
  %14 = extractelement <4 x i32> %10, i32 3
  %15 = tail call i32 @llvm.smax.i32(i32 %11, i32 0)
  %16 = tail call i32 @llvm.umin.i32(i32 %15, i32 31)
  %17 = zext i32 %1 to i64
  %18 = zext i32 %16 to i64
  %19 = getelementptr inbounds [64 x [32 x float]], [64 x [32 x float]] addrspace(1)* %5, i64 0, i64 %17, i64 %18
  %20 = load float, float addrspace(1)* %19, align 4, !invariant.load !21
  %21 = bitcast i8 addrspace(1)* %2 to float addrspace(1)*
  %22 = zext i32 %linear_index_base to i64
  %23 = getelementptr float, float addrspace(1)* %21, i64 %22
  %24 = tail call i32 @llvm.smax.i32(i32 %12, i32 0)
  %25 = tail call i32 @llvm.umin.i32(i32 %24, i32 31)
  %26 = zext i32 %25 to i64
  %27 = getelementptr inbounds [64 x [32 x float]], [64 x [32 x float]] addrspace(1)* %5, i64 0, i64 %17, i64 %26
  %28 = load float, float addrspace(1)* %27, align 4, !invariant.load !21
  %29 = tail call i32 @llvm.smax.i32(i32 %13, i32 0)
  %30 = tail call i32 @llvm.umin.i32(i32 %29, i32 31)
  %31 = zext i32 %30 to i64
  %32 = getelementptr inbounds [64 x [32 x float]], [64 x [32 x float]] addrspace(1)* %5, i64 0, i64 %17, i64 %31
  %33 = load float, float addrspace(1)* %32, align 4, !invariant.load !21
  %34 = tail call i32 @llvm.smax.i32(i32 %14, i32 0)
  %35 = tail call i32 @llvm.umin.i32(i32 %34, i32 31)
  %36 = zext i32 %35 to i64
  %37 = getelementptr inbounds [64 x [32 x float]], [64 x [32 x float]] addrspace(1)* %5, i64 0, i64 %17, i64 %36
  %38 = load float, float addrspace(1)* %37, align 4, !invariant.load !21
  %39 = insertelement <4 x float> poison, float %20, i32 0
  %40 = insertelement <4 x float> %39, float %28, i32 1
  %41 = insertelement <4 x float> %40, float %33, i32 2
  %42 = insertelement <4 x float> %41, float %38, i32 3
  %43 = bitcast float addrspace(1)* %23 to <4 x float> addrspace(1)*
  store <4 x float> %42, <4 x float> addrspace(1)* %43, align 16
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion_2(i8* noalias nocapture readonly align 16 dereferenceable(4096) %alloc4, i8* noalias nocapture align 128 dereferenceable(13456) %temp_buf) local_unnamed_addr #2 {
entry:
  %temp_buf12 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %alloc410 = addrspacecast i8* %alloc4 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %linear_index_base = shl nuw nsw i32 %0, 2
  %1 = bitcast i8 addrspace(1)* %temp_buf12 to float addrspace(1)*
  %2 = zext i32 %linear_index_base to i64
  %3 = getelementptr float, float addrspace(1)* %1, i64 %2
  %4 = bitcast float addrspace(1)* %3 to <4 x float> addrspace(1)*
  %5 = load <4 x float>, <4 x float> addrspace(1)* %4, align 16
  %6 = extractelement <4 x float> %5, i32 0
  %7 = extractelement <4 x float> %5, i32 1
  %8 = extractelement <4 x float> %5, i32 2
  %9 = extractelement <4 x float> %5, i32 3
  %10 = bitcast i8 addrspace(1)* %alloc410 to float addrspace(1)*
  %11 = getelementptr float, float addrspace(1)* %10, i64 %2
  %12 = bitcast float addrspace(1)* %11 to <4 x float> addrspace(1)*
  %13 = load <4 x float>, <4 x float> addrspace(1)* %12, align 16, !invariant.load !21
  %14 = extractelement <4 x float> %13, i32 0
  %15 = extractelement <4 x float> %13, i32 1
  %16 = extractelement <4 x float> %13, i32 2
  %17 = extractelement <4 x float> %13, i32 3
  %subtract.3 = fsub float %6, %14
  %multiply.6 = fmul float %subtract.3, 0x3F40000000000000
  %subtract.31 = fsub float %7, %15
  %multiply.63 = fmul float %subtract.31, 0x3F40000000000000
  %subtract.34 = fsub float %8, %16
  %multiply.66 = fmul float %subtract.34, 0x3F40000000000000
  %subtract.37 = fsub float %9, %17
  %multiply.69 = fmul float %subtract.37, 0x3F40000000000000
  %18 = insertelement <4 x float> poison, float %multiply.6, i32 0
  %19 = insertelement <4 x float> %18, float %multiply.63, i32 1
  %20 = insertelement <4 x float> %19, float %multiply.66, i32 2
  %21 = insertelement <4 x float> %20, float %multiply.69, i32 3
  %22 = bitcast float addrspace(1)* %3 to <4 x float> addrspace(1)*
  store <4 x float> %21, <4 x float> addrspace(1)* %22, align 16
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn writeonly
define void @input_fusion_scatter(i8* noalias nocapture writeonly align 128 dereferenceable(13456) %temp_buf) local_unnamed_addr #3 {
entry:
  %temp_buf4 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !23
  %1 = shl nuw nsw i32 %0, 10
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %3 = shl nuw nsw i32 %2, 2
  %linear_index_base = or i32 %1, %3
  %4 = bitcast i8 addrspace(1)* %temp_buf4 to float addrspace(1)*
  %5 = zext i32 %linear_index_base to i64
  %6 = getelementptr float, float addrspace(1)* %4, i64 %5
  %7 = bitcast float addrspace(1)* %6 to <4 x float> addrspace(1)*
  store <4 x float> zeroinitializer, <4 x float> addrspace(1)* %7, align 16
  ret void
}

; Function Attrs: mustprogress nofree nounwind willreturn
define void @input_fusion_scatter__1(i8* noalias nocapture align 128 dereferenceable(13456) %temp_buf) local_unnamed_addr #4 {
entry:
  %temp_buf3 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !24
  %1 = lshr i32 %0, 6
  %2 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf3, i64 13312
  %3 = bitcast i8 addrspace(1)* %2 to [4 x [4 x [1 x i32]]] addrspace(1)*
  %4 = and i32 %1, 3
  %5 = lshr i32 %0, 8
  %6 = zext i32 %5 to i64
  %7 = zext i32 %4 to i64
  %Arg_1.2 = getelementptr inbounds [4 x [4 x [1 x i32]]], [4 x [4 x [1 x i32]]] addrspace(1)* %3, i64 0, i64 %6, i64 %7, i64 0
  %Arg_1.21 = load i32, i32 addrspace(1)* %Arg_1.2, align 4, !invariant.load !21
  %8 = icmp ult i32 %Arg_1.21, 32
  %9 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf3, i64 8192
  %10 = bitcast i8 addrspace(1)* %9 to float addrspace(1)*
  %11 = zext i32 %0 to i64
  %Arg_0.1 = getelementptr inbounds float, float addrspace(1)* %10, i64 %11
  %12 = bitcast i8 addrspace(1)* %temp_buf3 to [32 x [64 x float]] addrspace(1)*
  %13 = zext i32 %Arg_1.21 to i64
  %14 = and i32 %0, 63
  %15 = zext i32 %14 to i64
  %16 = getelementptr inbounds [32 x [64 x float]], [32 x [64 x float]] addrspace(1)* %12, i64 0, i64 %13, i64 %15
  br i1 %8, label %scatter.in_bounds-true, label %scatter.10.in_bounds-after

scatter.10.in_bounds-after:                       ; preds = %scatter.in_bounds-true, %entry
  ret void

scatter.in_bounds-true:                           ; preds = %entry
  %Arg_0.12 = load float, float addrspace(1)* %Arg_0.1, align 4, !invariant.load !21
  %17 = atomicrmw fadd float addrspace(1)* %16, float %Arg_0.12 seq_cst, align 4
  br label %scatter.10.in_bounds-after
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define void @concatenate_1(i8* noalias nocapture align 128 dereferenceable(13456) %temp_buf) local_unnamed_addr #5 {
entry:
  %temp_buf29 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf29, i64 8192
  %1 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf29, i64 12288
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !23
  %3 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %4 = shl nuw nsw i32 %2, 10
  %5 = shl nuw nsw i32 %3, 2
  %linear_index_base = or i32 %4, %5
  %linear_index1 = or i32 %linear_index_base, 1
  %linear_index2 = or i32 %linear_index_base, 2
  %linear_index3 = or i32 %linear_index_base, 3
  %6 = icmp ult i32 %linear_index_base, 1280
  br i1 %6, label %concatenate.pivot.1024., label %concatenate_1.in_bounds-after

concatenate_1.in_bounds-after:                    ; preds = %concatenate.3.merge14, %entry
  ret void

concatenate.pivot.1024.:                          ; preds = %entry
  %7 = icmp ult i32 %linear_index_base, 1024
  br i1 %7, label %concatenate.pivot.0., label %concatenate.pivot.1024.1

concatenate.pivot.0.:                             ; preds = %concatenate.pivot.1024.
  %8 = bitcast i8 addrspace(1)* %0 to [1024 x float] addrspace(1)*
  %9 = zext i32 %linear_index_base to i64
  %10 = getelementptr inbounds [1024 x float], [1024 x float] addrspace(1)* %8, i64 0, i64 %9
  br label %concatenate.3.merge

concatenate.pivot.1024.1:                         ; preds = %concatenate.pivot.1024.
  %11 = bitcast i8 addrspace(1)* %1 to [256 x float] addrspace(1)*
  %12 = add nsw i32 %linear_index_base, -1024
  %13 = zext i32 %12 to i64
  %14 = getelementptr inbounds [256 x float], [256 x float] addrspace(1)* %11, i64 0, i64 %13
  %.pre = zext i32 %linear_index_base to i64
  br label %concatenate.3.merge

concatenate.3.merge:                              ; preds = %concatenate.pivot.1024.1, %concatenate.pivot.0.
  %.pre-phi = phi i64 [ %.pre, %concatenate.pivot.1024.1 ], [ %9, %concatenate.pivot.0. ]
  %.in = phi float addrspace(1)* [ %14, %concatenate.pivot.1024.1 ], [ %10, %concatenate.pivot.0. ]
  %15 = load float, float addrspace(1)* %.in, align 4, !invariant.load !21
  %16 = bitcast i8 addrspace(1)* %temp_buf29 to float addrspace(1)*
  %17 = getelementptr inbounds float, float addrspace(1)* %16, i64 %.pre-phi
  store float %15, float addrspace(1)* %17, align 16
  %18 = icmp ult i32 %linear_index1, 1024
  br i1 %18, label %concatenate.pivot.0.6, label %concatenate.pivot.1024.7

concatenate.pivot.0.6:                            ; preds = %concatenate.3.merge
  %19 = bitcast i8 addrspace(1)* %0 to [1024 x float] addrspace(1)*
  %20 = zext i32 %linear_index1 to i64
  %21 = zext i32 %linear_index_base to i64
  %22 = getelementptr [1024 x float], [1024 x float] addrspace(1)* %19, i64 0, i64 %21
  %23 = getelementptr inbounds float, float addrspace(1)* %22, i64 1
  br label %concatenate.3.merge2

concatenate.pivot.1024.7:                         ; preds = %concatenate.3.merge
  %24 = bitcast i8 addrspace(1)* %1 to [256 x float] addrspace(1)*
  %25 = sext i32 %linear_index_base to i64
  %26 = getelementptr [256 x float], [256 x float] addrspace(1)* %24, i64 0, i64 %25
  %27 = getelementptr inbounds float, float addrspace(1)* %26, i64 -1023
  %.pre23 = zext i32 %linear_index1 to i64
  br label %concatenate.3.merge2

concatenate.3.merge2:                             ; preds = %concatenate.pivot.1024.7, %concatenate.pivot.0.6
  %.pre-phi24 = phi i64 [ %.pre23, %concatenate.pivot.1024.7 ], [ %20, %concatenate.pivot.0.6 ]
  %.in20 = phi float addrspace(1)* [ %27, %concatenate.pivot.1024.7 ], [ %23, %concatenate.pivot.0.6 ]
  %28 = bitcast i8 addrspace(1)* %temp_buf29 to float addrspace(1)*
  %29 = load float, float addrspace(1)* %.in20, align 4, !invariant.load !21
  %30 = getelementptr inbounds float, float addrspace(1)* %28, i64 %.pre-phi24
  store float %29, float addrspace(1)* %30, align 4
  %31 = icmp ult i32 %linear_index2, 1024
  br i1 %31, label %concatenate.pivot.0.12, label %concatenate.pivot.1024.13

concatenate.pivot.0.12:                           ; preds = %concatenate.3.merge2
  %32 = bitcast i8 addrspace(1)* %0 to [1024 x float] addrspace(1)*
  %33 = zext i32 %linear_index2 to i64
  %34 = zext i32 %linear_index_base to i64
  %35 = getelementptr [1024 x float], [1024 x float] addrspace(1)* %32, i64 0, i64 %34
  %36 = getelementptr inbounds float, float addrspace(1)* %35, i64 2
  br label %concatenate.3.merge8

concatenate.pivot.1024.13:                        ; preds = %concatenate.3.merge2
  %37 = bitcast i8 addrspace(1)* %1 to [256 x float] addrspace(1)*
  %38 = sext i32 %linear_index_base to i64
  %39 = getelementptr [256 x float], [256 x float] addrspace(1)* %37, i64 0, i64 %38
  %40 = getelementptr inbounds float, float addrspace(1)* %39, i64 -1022
  %.pre25 = zext i32 %linear_index2 to i64
  br label %concatenate.3.merge8

concatenate.3.merge8:                             ; preds = %concatenate.pivot.1024.13, %concatenate.pivot.0.12
  %.pre-phi26 = phi i64 [ %.pre25, %concatenate.pivot.1024.13 ], [ %33, %concatenate.pivot.0.12 ]
  %.in21 = phi float addrspace(1)* [ %40, %concatenate.pivot.1024.13 ], [ %36, %concatenate.pivot.0.12 ]
  %41 = bitcast i8 addrspace(1)* %temp_buf29 to float addrspace(1)*
  %42 = load float, float addrspace(1)* %.in21, align 4, !invariant.load !21
  %43 = getelementptr inbounds float, float addrspace(1)* %41, i64 %.pre-phi26
  store float %42, float addrspace(1)* %43, align 8
  %44 = icmp ult i32 %linear_index3, 1024
  br i1 %44, label %concatenate.pivot.0.18, label %concatenate.pivot.1024.19

concatenate.pivot.0.18:                           ; preds = %concatenate.3.merge8
  %45 = bitcast i8 addrspace(1)* %0 to [1024 x float] addrspace(1)*
  %46 = zext i32 %linear_index3 to i64
  %47 = zext i32 %linear_index_base to i64
  %48 = getelementptr [1024 x float], [1024 x float] addrspace(1)* %45, i64 0, i64 %47
  %49 = getelementptr inbounds float, float addrspace(1)* %48, i64 3
  br label %concatenate.3.merge14

concatenate.pivot.1024.19:                        ; preds = %concatenate.3.merge8
  %50 = bitcast i8 addrspace(1)* %1 to [256 x float] addrspace(1)*
  %51 = sext i32 %linear_index_base to i64
  %52 = getelementptr [256 x float], [256 x float] addrspace(1)* %50, i64 0, i64 %51
  %53 = getelementptr inbounds float, float addrspace(1)* %52, i64 -1021
  %.pre27 = zext i32 %linear_index3 to i64
  br label %concatenate.3.merge14

concatenate.3.merge14:                            ; preds = %concatenate.pivot.1024.19, %concatenate.pivot.0.18
  %.pre-phi28 = phi i64 [ %.pre27, %concatenate.pivot.1024.19 ], [ %46, %concatenate.pivot.0.18 ]
  %.in22 = phi float addrspace(1)* [ %53, %concatenate.pivot.1024.19 ], [ %49, %concatenate.pivot.0.18 ]
  %54 = bitcast i8 addrspace(1)* %temp_buf29 to float addrspace(1)*
  %55 = load float, float addrspace(1)* %.in22, align 4, !invariant.load !21
  %56 = getelementptr inbounds float, float addrspace(1)* %54, i64 %.pre-phi28
  store float %55, float addrspace(1)* %56, align 4
  br label %concatenate_1.in_bounds-after
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @slice_3(i8* noalias nocapture align 128 dereferenceable(13456) %temp_buf) local_unnamed_addr #2 {
entry:
  %temp_buf1 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !25
  %linear_index_base = shl nuw nsw i32 %0, 2
  %1 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf1, i64 9216
  %2 = bitcast i8 addrspace(1)* %temp_buf1 to [1280 x float] addrspace(1)*
  %3 = zext i32 %linear_index_base to i64
  %4 = getelementptr [1280 x float], [1280 x float] addrspace(1)* %2, i64 0, i64 %3
  %5 = getelementptr inbounds float, float addrspace(1)* %4, i64 1024
  %6 = bitcast float addrspace(1)* %5 to <4 x float> addrspace(1)*
  %7 = load <4 x float>, <4 x float> addrspace(1)* %6, align 16, !invariant.load !21
  %8 = extractelement <4 x float> %7, i32 0
  %9 = extractelement <4 x float> %7, i32 1
  %10 = extractelement <4 x float> %7, i32 2
  %11 = extractelement <4 x float> %7, i32 3
  %12 = bitcast i8 addrspace(1)* %1 to float addrspace(1)*
  %13 = getelementptr float, float addrspace(1)* %12, i64 %3
  %14 = insertelement <4 x float> poison, float %8, i32 0
  %15 = insertelement <4 x float> %14, float %9, i32 1
  %16 = insertelement <4 x float> %15, float %10, i32 2
  %17 = insertelement <4 x float> %16, float %11, i32 3
  %18 = bitcast float addrspace(1)* %13 to <4 x float> addrspace(1)*
  store <4 x float> %17, <4 x float> addrspace(1)* %18, align 16
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @slice_2(i8* noalias nocapture align 128 dereferenceable(13456) %temp_buf) local_unnamed_addr #2 {
entry:
  %temp_buf1 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %linear_index_base = shl nuw nsw i32 %0, 2
  %1 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf1, i64 5120
  %2 = bitcast i8 addrspace(1)* %temp_buf1 to [1280 x float] addrspace(1)*
  %3 = zext i32 %linear_index_base to i64
  %4 = getelementptr inbounds [1280 x float], [1280 x float] addrspace(1)* %2, i64 0, i64 %3
  %5 = bitcast float addrspace(1)* %4 to <4 x float> addrspace(1)*
  %6 = load <4 x float>, <4 x float> addrspace(1)* %5, align 16, !invariant.load !21
  %7 = extractelement <4 x float> %6, i32 0
  %8 = extractelement <4 x float> %6, i32 1
  %9 = extractelement <4 x float> %6, i32 2
  %10 = extractelement <4 x float> %6, i32 3
  %11 = bitcast i8 addrspace(1)* %1 to float addrspace(1)*
  %12 = getelementptr float, float addrspace(1)* %11, i64 %3
  %13 = insertelement <4 x float> poison, float %7, i32 0
  %14 = insertelement <4 x float> %13, float %8, i32 1
  %15 = insertelement <4 x float> %14, float %9, i32 2
  %16 = insertelement <4 x float> %15, float %10, i32 3
  %17 = bitcast float addrspace(1)* %12 to <4 x float> addrspace(1)*
  store <4 x float> %16, <4 x float> addrspace(1)* %17, align 16
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion_5(i8* noalias nocapture align 16 dereferenceable(4096) %alloc1, i8* noalias nocapture align 16 dereferenceable(1024) %alloc2, i8* noalias nocapture readonly align 128 dereferenceable(13456) %temp_buf) local_unnamed_addr #2 {
entry:
  %temp_buf9 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %alloc27 = addrspacecast i8* %alloc2 to i8 addrspace(1)*
  %alloc15 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %0 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf9, i64 5120
  %1 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf9, i64 9216
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !23
  %3 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !24
  %4 = shl nuw nsw i32 %2, 10
  %linear_index = or i32 %4, %3
  %5 = icmp ult i32 %linear_index, 1280
  br i1 %5, label %concatenate.pivot.1024., label %fusion_5.in_bounds-after

fusion_5.in_bounds-after:                         ; preds = %slice1-true, %slice0-after, %entry
  ret void

concatenate.pivot.1024.:                          ; preds = %entry
  %6 = icmp ult i32 %linear_index, 1024
  br i1 %6, label %concatenate.pivot.0., label %concatenate.pivot.1024.2

concatenate.pivot.0.:                             ; preds = %concatenate.pivot.1024.
  %7 = bitcast i8 addrspace(1)* %0 to [32 x [32 x float]] addrspace(1)*
  %8 = bitcast i8 addrspace(1)* %alloc15 to [32 x [32 x float]] addrspace(1)*
  %9 = and i32 %3, 31
  %10 = lshr i32 %linear_index, 5
  %11 = zext i32 %10 to i64
  %12 = zext i32 %9 to i64
  %13 = getelementptr inbounds [32 x [32 x float]], [32 x [32 x float]] addrspace(1)* %8, i64 0, i64 %11, i64 %12
  %14 = getelementptr inbounds [32 x [32 x float]], [32 x [32 x float]] addrspace(1)* %7, i64 0, i64 %11, i64 %12
  br label %concatenate.14.merge

concatenate.pivot.1024.2:                         ; preds = %concatenate.pivot.1024.
  %15 = bitcast i8 addrspace(1)* %1 to [16 x [16 x float]] addrspace(1)*
  %16 = bitcast i8 addrspace(1)* %alloc27 to [16 x [16 x float]] addrspace(1)*
  %17 = add nsw i32 %linear_index, -1024
  %18 = and i32 %3, 15
  %19 = lshr i32 %17, 4
  %20 = zext i32 %19 to i64
  %21 = zext i32 %18 to i64
  %22 = getelementptr inbounds [16 x [16 x float]], [16 x [16 x float]] addrspace(1)* %16, i64 0, i64 %20, i64 %21
  %23 = getelementptr inbounds [16 x [16 x float]], [16 x [16 x float]] addrspace(1)* %15, i64 0, i64 %20, i64 %21
  br label %concatenate.14.merge

concatenate.14.merge:                             ; preds = %concatenate.pivot.1024.2, %concatenate.pivot.0.
  %.sink4 = phi float addrspace(1)* [ %23, %concatenate.pivot.1024.2 ], [ %14, %concatenate.pivot.0. ]
  %.sink.in = phi float addrspace(1)* [ %22, %concatenate.pivot.1024.2 ], [ %13, %concatenate.pivot.0. ]
  %24 = icmp ult i32 %linear_index, 1024
  %25 = bitcast i8 addrspace(1)* %alloc15 to [1024 x float] addrspace(1)*
  %.sink = load float, float addrspace(1)* %.sink.in, align 4
  %26 = load float, float addrspace(1)* %.sink4, align 4, !invariant.load !21
  %multiply.11 = fmul float %26, 0x3F847AE140000000
  %subtract.12 = fsub float %.sink, %multiply.11
  %27 = zext i32 %linear_index to i64
  %28 = getelementptr inbounds [1024 x float], [1024 x float] addrspace(1)* %25, i64 0, i64 %27
  br i1 %24, label %slice0-true, label %slice0-after

slice0-after:                                     ; preds = %slice0-true, %concatenate.14.merge
  %29 = bitcast i8 addrspace(1)* %alloc27 to [256 x float] addrspace(1)*
  %30 = icmp ugt i32 %linear_index, 1023
  %31 = add nsw i32 %linear_index, -1024
  %32 = zext i32 %31 to i64
  %33 = getelementptr inbounds [256 x float], [256 x float] addrspace(1)* %29, i64 0, i64 %32
  br i1 %30, label %slice1-true, label %fusion_5.in_bounds-after

slice0-true:                                      ; preds = %concatenate.14.merge
  store float %subtract.12, float addrspace(1)* %28, align 4
  br label %slice0-after

slice1-true:                                      ; preds = %slice0-after
  store float %subtract.12, float addrspace(1)* %33, align 4
  br label %fusion_5.in_bounds-after
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.smax.i32(i32, i32) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.umin.i32(i32, i32) #6

attributes #0 = { argmemonly mustprogress nofree norecurse nosync nounwind willreturn }
attributes #1 = { nofree nosync nounwind readnone speculatable }
attributes #2 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #3 = { argmemonly mustprogress nofree nosync nounwind willreturn writeonly }
attributes #4 = { mustprogress nofree nounwind willreturn }
attributes #5 = { mustprogress nofree nosync nounwind willreturn }
attributes #6 = { mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn }

!nvvm.annotations = !{!0, !1, !2, !3, !4, !5, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19}
!llvm.module.flags = !{!20}

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
!20 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!21 = !{}
!22 = !{i32 0, i32 256}
!23 = !{i32 0, i32 2}
!24 = !{i32 0, i32 1024}
!25 = !{i32 0, i32 64}
