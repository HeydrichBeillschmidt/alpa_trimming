; ModuleID = '<string>'
source_filename = "<string>"
target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

@buffer_for_constant_185 = local_unnamed_addr addrspace(1) constant [8 x i8] c" \00\00\00\00\00\00\00", align 128
@rng_state = private unnamed_addr addrspace(1) global i128 117515157

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn
define void @rng_get_and_update_state(i8* noalias nocapture writeonly align 128 dereferenceable(16) %temp_buf) local_unnamed_addr #0 {
entry:
  %temp_buf1 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %load_state = load i128, i128 addrspace(1)* @rng_state, align 16
  %0 = add i128 %load_state, 1024
  store i128 %0, i128 addrspace(1)* @rng_state, align 16
  %1 = bitcast i8 addrspace(1)* %temp_buf1 to i128 addrspace(1)*
  store i128 %load_state, i128 addrspace(1)* %1, align 128
  ret void
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn }

!nvvm.annotations = !{!0, !1, !2, !3}
!llvm.ident = !{!4}
!llvm.module.flags = !{!5}

!0 = !{void (i8*)* @rng_get_and_update_state, !"kernel", i32 1}
!1 = !{void (i8*)* @rng_get_and_update_state, !"reqntidx", i32 1}
!2 = distinct !{null, !"kernel", i32 1}
!3 = distinct !{null, !"reqntidx", i32 256}
!4 = !{!"clang version 3.8.0 (tags/RELEASE_380/final)"}
!5 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
