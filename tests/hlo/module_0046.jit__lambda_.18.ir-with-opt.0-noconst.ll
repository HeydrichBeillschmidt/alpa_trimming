; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn
define void @fusion(i8* noalias nocapture readonly align 16 dereferenceable(4) %alloc0, i8* noalias nocapture readonly align 16 dereferenceable(4) %alloc1, i8* noalias nocapture writeonly align 128 dereferenceable(4) %alloc2) local_unnamed_addr #0 {
entry:
  %alloc25 = addrspacecast i8* %alloc2 to i8 addrspace(1)*
  %alloc13 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = bitcast i8 addrspace(1)* %alloc25 to i32 addrspace(1)*
  %1 = bitcast i8 addrspace(1)* %alloc13 to i32 addrspace(1)*
  %2 = bitcast i8 addrspace(1)* %alloc01 to i32 addrspace(1)*
  %3 = load i32, i32 addrspace(1)* %2, align 16, !invariant.load !3
  %4 = load i32, i32 addrspace(1)* %1, align 16, !invariant.load !3
  %5 = and i32 %4, %3
  store i32 %5, i32 addrspace(1)* %0, align 128
  ret void
}

attributes #0 = { argmemonly mustprogress nofree norecurse nosync nounwind willreturn }

!nvvm.annotations = !{!0, !1}
!llvm.module.flags = !{!2}

!0 = !{void (i8*, i8*, i8*)* @fusion, !"kernel", i32 1}
!1 = !{void (i8*, i8*, i8*)* @fusion, !"reqntidx", i32 1}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{}
