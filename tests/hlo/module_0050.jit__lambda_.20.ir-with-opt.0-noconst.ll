; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @sqrt_2(i8* noalias nocapture readonly align 16 dereferenceable(4) %alloc0, i8* noalias nocapture writeonly align 128 dereferenceable(4) %alloc1) local_unnamed_addr #0 {
entry:
  %alloc13 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = bitcast i8 addrspace(1)* %alloc13 to float addrspace(1)*
  %1 = bitcast i8 addrspace(1)* %alloc01 to float addrspace(1)*
  %2 = load float, float addrspace(1)* %1, align 16, !invariant.load !4
  %3 = tail call float @llvm.nvvm.sqrt.approx.f(float %2) #2
  store float %3, float addrspace(1)* %0, align 128
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone willreturn
declare float @llvm.nvvm.sqrt.approx.f(float) #1

attributes #0 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #1 = { mustprogress nocallback nofree nosync nounwind readnone willreturn }
attributes #2 = { nounwind }

!nvvm.annotations = !{!0, !1}
!llvm.ident = !{!2}
!llvm.module.flags = !{!3}

!0 = !{void (i8*, i8*)* @sqrt_2, !"kernel", i32 1}
!1 = !{void (i8*, i8*)* @sqrt_2, !"reqntidx", i32 1}
!2 = !{!"clang version 3.8.0 (tags/RELEASE_380/final)"}
!3 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!4 = !{}
