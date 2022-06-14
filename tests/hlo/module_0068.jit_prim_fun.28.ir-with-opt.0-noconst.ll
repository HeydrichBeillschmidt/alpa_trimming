; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @select_4(i8* noalias nocapture readonly align 16 dereferenceable(16) %alloc0, i8* noalias nocapture readonly align 16 dereferenceable(64) %alloc1, i8* noalias nocapture readonly align 16 dereferenceable(64) %alloc2, i8* noalias nocapture writeonly align 128 dereferenceable(64) %alloc3) local_unnamed_addr #0 {
entry:
  %alloc310 = addrspacecast i8* %alloc3 to i8 addrspace(1)*
  %alloc28 = addrspacecast i8* %alloc2 to i8 addrspace(1)*
  %alloc16 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc04 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %linear_index_base = shl nuw nsw i32 %0, 2
  %1 = zext i32 %linear_index_base to i64
  %2 = getelementptr i8, i8 addrspace(1)* %alloc04, i64 %1
  %3 = bitcast i8 addrspace(1)* %2 to <4 x i8> addrspace(1)*
  %4 = load <4 x i8>, <4 x i8> addrspace(1)* %3, align 4, !invariant.load !4
  %5 = extractelement <4 x i8> %4, i32 0
  %6 = extractelement <4 x i8> %4, i32 1
  %7 = extractelement <4 x i8> %4, i32 2
  %8 = extractelement <4 x i8> %4, i32 3
  %9 = bitcast i8 addrspace(1)* %alloc28 to i32 addrspace(1)*
  %10 = getelementptr i32, i32 addrspace(1)* %9, i64 %1
  %11 = bitcast i32 addrspace(1)* %10 to <4 x i32> addrspace(1)*
  %12 = load <4 x i32>, <4 x i32> addrspace(1)* %11, align 16, !invariant.load !4
  %13 = extractelement <4 x i32> %12, i32 0
  %14 = extractelement <4 x i32> %12, i32 1
  %15 = extractelement <4 x i32> %12, i32 2
  %16 = extractelement <4 x i32> %12, i32 3
  %17 = bitcast i8 addrspace(1)* %alloc16 to i32 addrspace(1)*
  %18 = getelementptr i32, i32 addrspace(1)* %17, i64 %1
  %19 = bitcast i32 addrspace(1)* %18 to <4 x i32> addrspace(1)*
  %20 = load <4 x i32>, <4 x i32> addrspace(1)* %19, align 16, !invariant.load !4
  %21 = extractelement <4 x i32> %20, i32 0
  %22 = extractelement <4 x i32> %20, i32 1
  %23 = extractelement <4 x i32> %20, i32 2
  %24 = extractelement <4 x i32> %20, i32 3
  %25 = and i8 %5, 1
  %.not = icmp eq i8 %25, 0
  %26 = select i1 %.not, i32 %21, i32 %13
  %27 = bitcast i8 addrspace(1)* %alloc310 to i32 addrspace(1)*
  %28 = getelementptr i32, i32 addrspace(1)* %27, i64 %1
  %29 = and i8 %6, 1
  %.not1 = icmp eq i8 %29, 0
  %30 = select i1 %.not1, i32 %22, i32 %14
  %31 = and i8 %7, 1
  %.not2 = icmp eq i8 %31, 0
  %32 = select i1 %.not2, i32 %23, i32 %15
  %33 = and i8 %8, 1
  %.not3 = icmp eq i8 %33, 0
  %34 = select i1 %.not3, i32 %24, i32 %16
  %35 = insertelement <4 x i32> poison, i32 %26, i32 0
  %36 = insertelement <4 x i32> %35, i32 %30, i32 1
  %37 = insertelement <4 x i32> %36, i32 %32, i32 2
  %38 = insertelement <4 x i32> %37, i32 %34, i32 3
  %39 = bitcast i32 addrspace(1)* %28 to <4 x i32> addrspace(1)*
  store <4 x i32> %38, <4 x i32> addrspace(1)* %39, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #1 = { nofree nosync nounwind readnone speculatable }

!nvvm.annotations = !{!0, !1}
!llvm.module.flags = !{!2}

!0 = !{void (i8*, i8*, i8*, i8*)* @select_4, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*, i8*)* @select_4, !"reqntidx", i32 4}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{i32 0, i32 4}
!4 = !{}
