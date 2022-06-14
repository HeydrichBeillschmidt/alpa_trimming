; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn writeonly
define void @iota_1(i8* noalias nocapture writeonly align 128 dereferenceable(64) %alloc0) local_unnamed_addr #0 {
entry:
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !3
  %linear_index_base = shl nuw nsw i32 %0, 2
  %linear_index3 = or i32 %linear_index_base, 3
  %linear_index2 = or i32 %linear_index_base, 2
  %linear_index1 = or i32 %linear_index_base, 1
  %1 = bitcast i8 addrspace(1)* %alloc01 to i32 addrspace(1)*
  %2 = zext i32 %linear_index_base to i64
  %3 = getelementptr i32, i32 addrspace(1)* %1, i64 %2
  %4 = insertelement <4 x i32> poison, i32 %linear_index_base, i32 0
  %5 = insertelement <4 x i32> %4, i32 %linear_index1, i32 1
  %6 = insertelement <4 x i32> %5, i32 %linear_index2, i32 2
  %7 = insertelement <4 x i32> %6, i32 %linear_index3, i32 3
  %8 = bitcast i32 addrspace(1)* %3 to <4 x i32> addrspace(1)*
  store <4 x i32> %7, <4 x i32> addrspace(1)* %8, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn writeonly }
attributes #1 = { nofree nosync nounwind readnone speculatable }

!nvvm.annotations = !{!0, !1}
!llvm.module.flags = !{!2}

!0 = !{void (i8*)* @iota_1, !"kernel", i32 1}
!1 = !{void (i8*)* @iota_1, !"reqntidx", i32 4}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{i32 0, i32 4}
