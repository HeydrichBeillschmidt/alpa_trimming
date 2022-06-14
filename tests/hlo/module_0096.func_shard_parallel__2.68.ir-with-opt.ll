target datalayout = "e-i64:64-i128:128-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

@rng_state = private unnamed_addr addrspace(1) global i128 117515157
@buffer_for_constant_3 = local_unnamed_addr addrspace(1) constant [8 x i8] c" \00\00\00\00\00\00\00", align 128
@buffer_for_constant_5 = local_unnamed_addr addrspace(1) constant [4 x i8] c"\01\00\00\00", align 128

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn
define void @rng_get_and_update_state(i8* noalias nocapture writeonly align 128 dereferenceable(50320) %temp_buf) local_unnamed_addr #0 {
entry:
  %temp_buf1 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf1, i64 50176
  %load_state = load i128, i128 addrspace(1)* @rng_state, align 16
  %1 = add i128 %load_state, 4096
  store i128 %1, i128 addrspace(1)* @rng_state, align 16
  %2 = bitcast i8 addrspace(1)* %0 to i128 addrspace(1)*
  store i128 %load_state, i128 addrspace(1)* %2, align 128
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion_5(i8* noalias nocapture align 128 dereferenceable(50320) %temp_buf) local_unnamed_addr #1 {
entry:
  %temp_buf976 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf976, i64 50176
  %1 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf976, i64 16384
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !21
  %3 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %4 = shl nuw nsw i32 %2, 10
  %5 = shl nuw nsw i32 %3, 2
  %linear_index_base = or i32 %4, %5
  %6 = lshr exact i32 %linear_index_base, 2
  %7 = bitcast i8 addrspace(1)* %0 to i64 addrspace(1)*
  %8 = bitcast i64 addrspace(1)* %7 to <2 x i64> addrspace(1)*
  %9 = load <2 x i64>, <2 x i64> addrspace(1)* %8, align 128, !invariant.load !23
  %10 = extractelement <2 x i64> %9, i32 0
  %11 = extractelement <2 x i64> %9, i32 1
  %12 = zext i32 %6 to i64
  %13 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %10, i64 %12)
  %math = extractvalue { i64, i1 } %13, 0
  %ov = extractvalue { i64, i1 } %13, 1
  %14 = and i64 %math, 4294967295
  %15 = mul nuw i64 %14, 3528531795
  %16 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf976, i64 50184
  %17 = zext i1 %ov to i64
  %18 = add i64 %11, %17
  %19 = xor i64 %18, %15
  %20 = lshr i64 %19, 32
  %21 = xor i64 %20, 3243368317
  %22 = mul nuw i64 %21, 3449720151
  %23 = lshr i64 %22, 32
  %24 = and i64 %18, 4294967295
  %25 = mul nuw i64 %24, 3449720151
  %.masked948 = and i64 %25, 4294967295
  %26 = xor i64 %.masked948, %23
  %27 = xor i64 %26, 220028085
  %28 = mul nuw i64 %27, 3528531795
  %29 = lshr i64 %28, 32
  %30 = xor i64 %25, %math
  %31 = lshr i64 %30, 32
  %32 = xor i64 %31, 1860559612
  %33 = mul nuw i64 %32, 3528531795
  %.masked949 = and i64 %33, 4294967295
  %34 = xor i64 %.masked949, %29
  %35 = xor i64 %34, 941702279
  %36 = mul nuw i64 %35, 3449720151
  %37 = lshr i64 %36, 32
  %38 = lshr i64 %33, 32
  %.masked950 = and i64 %15, 4294967295
  %39 = xor i64 %.masked950, %38
  %40 = xor i64 %39, 2092535298
  %41 = mul nuw i64 %40, 3449720151
  %.masked951 = and i64 %41, 4294967295
  %42 = xor i64 %.masked951, %37
  %43 = xor i64 %42, 1233932327
  %44 = mul nuw i64 %43, 3528531795
  %45 = lshr i64 %44, 32
  %46 = lshr i64 %41, 32
  %.masked952 = and i64 %22, 4294967295
  %47 = xor i64 %.masked952, %46
  %48 = xor i64 %47, 2874463854
  %49 = mul nuw i64 %48, 3528531795
  %.masked953 = and i64 %49, 4294967295
  %50 = xor i64 %.masked953, %45
  %51 = xor i64 %50, 2935003537
  %52 = mul nuw i64 %51, 3449720151
  %53 = lshr i64 %52, 32
  %54 = lshr i64 %49, 32
  %.masked954 = and i64 %28, 4294967295
  %55 = xor i64 %.masked954, %54
  %56 = xor i64 %55, 4085836556
  %57 = mul nuw i64 %56, 3449720151
  %.masked955 = and i64 %57, 4294967295
  %58 = xor i64 %.masked955, %53
  %59 = xor i64 %58, 2247836569
  %60 = mul nuw i64 %59, 3528531795
  %61 = lshr i64 %60, 32
  %62 = lshr i64 %57, 32
  %.masked956 = and i64 %36, 4294967295
  %63 = xor i64 %.masked956, %62
  %64 = xor i64 %63, 3888368096
  %65 = mul nuw i64 %64, 3528531795
  %.masked957 = and i64 %65, 4294967295
  %66 = xor i64 %61, %.masked957
  %67 = xor i64 %66, 633337499
  %68 = mul nuw i64 %67, 3449720151
  %69 = lshr i64 %68, 32
  %70 = lshr i64 %65, 32
  %.masked958 = and i64 %44, 4294967295
  %71 = xor i64 %.masked958, %70
  %72 = xor i64 %71, 1784170518
  %73 = mul nuw i64 %72, 3449720151
  %.masked959 = and i64 %73, 4294967295
  %74 = xor i64 %.masked959, %69
  %75 = xor i64 %74, 3261740811
  %76 = mul nuw i64 %75, 3528531795
  %77 = lshr i64 %76, 32
  %78 = lshr i64 %73, 32
  %.masked960 = and i64 %52, 4294967295
  %79 = xor i64 %78, %.masked960
  %80 = xor i64 %79, 607305042
  %81 = mul nuw i64 %80, 3528531795
  %.masked961 = and i64 %81, 4294967295
  %82 = xor i64 %.masked961, %77
  %83 = xor i64 %82, 2626638757
  %84 = mul nuw i64 %83, 3449720151
  %85 = lshr i64 %84, 32
  %86 = trunc i64 %85 to i32
  %87 = lshr i64 %81, 32
  %88 = xor i64 %87, %60
  %89 = trunc i64 %88 to i32
  %90 = xor i32 %89, -517495520
  %91 = mul i32 %90, -845247145
  %92 = xor i32 %91, %86
  %93 = lshr i32 %92, 9
  %phi.bo = xor i32 %93, 8350869
  %phi.cast = uitofp i32 %phi.bo to float
  %phi.bo963 = fmul float %phi.cast, 0x3E80000000000000
  %phi.cmp = fcmp olt float %phi.bo963, 0x3FECCCCCC0000000
  %94 = bitcast i8 addrspace(1)* %temp_buf976 to float addrspace(1)*
  %95 = zext i32 %linear_index_base to i64
  %96 = getelementptr float, float addrspace(1)* %94, i64 %95
  %97 = bitcast float addrspace(1)* %96 to <4 x float> addrspace(1)*
  %98 = load <4 x float>, <4 x float> addrspace(1)* %97, align 16, !invariant.load !23
  %99 = extractelement <4 x float> %98, i32 0
  %100 = extractelement <4 x float> %98, i32 1
  %101 = extractelement <4 x float> %98, i32 2
  %102 = extractelement <4 x float> %98, i32 3
  %103 = select i1 %phi.cmp, float %99, float 0.000000e+00
  %104 = bitcast i8 addrspace(1)* %1 to float addrspace(1)*
  %105 = getelementptr float, float addrspace(1)* %104, i64 %95
  %106 = xor i64 %78, %52
  %107 = xor i64 %106, 607305042
  %108 = mul i64 %107, 3528531795
  %109 = xor i64 %77, %108
  %110 = trunc i64 %109 to i32
  %111 = xor i32 %110, -1668328539
  %112 = mul i32 %111, -845247145
  %phi.bo964 = lshr i32 %112, 9
  %phi.cast965 = uitofp i32 %phi.bo964 to float
  %phi.bo966 = fmul float %phi.cast965, 0x3E80000000000000
  %phi.cmp967 = fcmp olt float %phi.bo966, 0x3FECCCCCC0000000
  %113 = select i1 %phi.cmp967, float %100, float 0.000000e+00
  %.masked842 = and i64 %60, 4294967295
  %114 = xor i64 %.masked842, %87
  %115 = xor i64 %114, 3777471776
  %116 = mul nuw i64 %115, 3449720151
  %117 = lshr i64 %116, 32
  %.masked844 = and i64 %68, 4294967295
  %118 = xor i64 %.masked844, %117
  %119 = xor i64 %118, 1621209284
  %120 = mul nuw i64 %119, 3528531795
  %121 = lshr i64 %120, 32
  %122 = trunc i64 %121 to i32
  %123 = xor i64 %69, %73
  %124 = trunc i64 %123 to i32
  %125 = xor i32 %124, -1033226485
  %126 = mul i32 %125, -766435501
  %127 = xor i32 %126, %122
  %128 = lshr i32 %127, 9
  %phi.bo968 = xor i32 %128, 2882433
  %phi.cast969 = uitofp i32 %phi.bo968 to float
  %phi.bo970 = fmul float %phi.cast969, 0x3E80000000000000
  %phi.cmp971 = fcmp olt float %phi.bo970, 0x3FECCCCCC0000000
  %129 = select i1 %phi.cmp971, float %101, float 0.000000e+00
  %130 = xor i64 %61, %65
  %131 = xor i64 %130, 633337499
  %132 = mul i64 %131, 3449720151
  %133 = xor i64 %117, %132
  %134 = trunc i64 %133 to i32
  %135 = xor i32 %134, 1621209284
  %136 = mul i32 %135, -766435501
  %phi.bo972 = lshr i32 %136, 9
  %phi.cast973 = uitofp i32 %phi.bo972 to float
  %phi.bo974 = fmul float %phi.cast973, 0x3E80000000000000
  %phi.cmp975 = fcmp olt float %phi.bo974, 0x3FECCCCCC0000000
  %137 = select i1 %phi.cmp975, float %102, float 0.000000e+00
  %138 = insertelement <4 x float> poison, float %103, i32 0
  %139 = insertelement <4 x float> %138, float %113, i32 1
  %140 = insertelement <4 x float> %139, float %129, i32 2
  %141 = insertelement <4 x float> %140, float %137, i32 3
  %142 = bitcast float addrspace(1)* %105 to <4 x float> addrspace(1)*
  store <4 x float> %141, <4 x float> addrspace(1)* %142, align 16
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #2

; Function Attrs: nofree nosync nounwind readnone speculatable
declare i32 @llvm.nvvm.read.ptx.sreg.tid.x() #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion_4(i8* noalias nocapture readonly align 16 dereferenceable(16384) %alloc4, i8* noalias nocapture align 128 dereferenceable(50320) %temp_buf) local_unnamed_addr #1 {
entry:
  %temp_buf12 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %alloc410 = addrspacecast i8* %alloc4 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !21
  %1 = shl nuw nsw i32 %0, 10
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %3 = shl nuw nsw i32 %2, 2
  %linear_index_base = or i32 %1, %3
  %4 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf12, i64 32768
  %5 = bitcast i8 addrspace(1)* %4 to float addrspace(1)*
  %6 = zext i32 %linear_index_base to i64
  %7 = getelementptr float, float addrspace(1)* %5, i64 %6
  %8 = bitcast float addrspace(1)* %7 to <4 x float> addrspace(1)*
  %9 = load <4 x float>, <4 x float> addrspace(1)* %8, align 16, !invariant.load !23
  %10 = extractelement <4 x float> %9, i32 0
  %11 = extractelement <4 x float> %9, i32 1
  %12 = extractelement <4 x float> %9, i32 2
  %13 = extractelement <4 x float> %9, i32 3
  %14 = bitcast i8 addrspace(1)* %alloc410 to float addrspace(1)*
  %15 = getelementptr float, float addrspace(1)* %14, i64 %6
  %16 = bitcast float addrspace(1)* %15 to <4 x float> addrspace(1)*
  %17 = load <4 x float>, <4 x float> addrspace(1)* %16, align 16, !invariant.load !23
  %18 = extractelement <4 x float> %17, i32 0
  %19 = extractelement <4 x float> %17, i32 1
  %20 = extractelement <4 x float> %17, i32 2
  %21 = extractelement <4 x float> %17, i32 3
  %subtract.4 = fsub float %10, %18
  %multiply.7 = fmul float %subtract.4, 0x3F20000000000000
  %22 = bitcast i8 addrspace(1)* %temp_buf12 to float addrspace(1)*
  %23 = getelementptr float, float addrspace(1)* %22, i64 %6
  %subtract.41 = fsub float %11, %19
  %multiply.73 = fmul float %subtract.41, 0x3F20000000000000
  %subtract.44 = fsub float %12, %20
  %multiply.76 = fmul float %subtract.44, 0x3F20000000000000
  %subtract.47 = fsub float %13, %21
  %multiply.79 = fmul float %subtract.47, 0x3F20000000000000
  %24 = insertelement <4 x float> poison, float %multiply.7, i32 0
  %25 = insertelement <4 x float> %24, float %multiply.73, i32 1
  %26 = insertelement <4 x float> %25, float %multiply.76, i32 2
  %27 = insertelement <4 x float> %26, float %multiply.79, i32 3
  %28 = bitcast float addrspace(1)* %23 to <4 x float> addrspace(1)*
  store <4 x float> %27, <4 x float> addrspace(1)* %28, align 16
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion_1(i8* noalias nocapture align 128 dereferenceable(50320) %temp_buf) local_unnamed_addr #1 {
entry:
  %temp_buf1 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !21
  %1 = shl nuw nsw i32 %0, 10
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %3 = shl nuw nsw i32 %2, 2
  %linear_index_base = or i32 %1, %3
  %4 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf1, i64 32768
  %5 = bitcast i8 addrspace(1)* %temp_buf1 to float addrspace(1)*
  %6 = zext i32 %linear_index_base to i64
  %7 = getelementptr float, float addrspace(1)* %5, i64 %6
  %8 = bitcast float addrspace(1)* %7 to <4 x float> addrspace(1)*
  %9 = load <4 x float>, <4 x float> addrspace(1)* %8, align 16, !invariant.load !23
  %10 = extractelement <4 x float> %9, i32 0
  %11 = extractelement <4 x float> %9, i32 1
  %12 = extractelement <4 x float> %9, i32 2
  %13 = extractelement <4 x float> %9, i32 3
  %14 = bitcast i8 addrspace(1)* %4 to float addrspace(1)*
  %15 = getelementptr float, float addrspace(1)* %14, i64 %6
  %16 = insertelement <4 x float> poison, float %10, i32 0
  %17 = insertelement <4 x float> %16, float %11, i32 1
  %18 = insertelement <4 x float> %17, float %12, i32 2
  %19 = insertelement <4 x float> %18, float %13, i32 3
  %20 = bitcast float addrspace(1)* %15 to <4 x float> addrspace(1)*
  store <4 x float> %19, <4 x float> addrspace(1)* %20, align 16
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @fusion_3(i8* noalias nocapture align 128 dereferenceable(50320) %temp_buf) local_unnamed_addr #1 {
entry:
  %temp_buf988 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf988, i64 16384
  %1 = bitcast i8 addrspace(1)* %0 to [256 x [16 x float]] addrspace(1)*
  %2 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf988, i64 50176
  %3 = bitcast i8 addrspace(1)* %temp_buf988 to [256 x [16 x float]] addrspace(1)*
  %4 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !range !21
  %5 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !22
  %6 = shl nuw nsw i32 %4, 2
  %7 = shl nuw nsw i32 %5, 4
  %8 = and i32 %7, 496
  %9 = or i32 %8, %6
  %10 = and i32 %7, 3584
  %11 = or i32 %9, %10
  %12 = lshr exact i32 %11, 2
  %13 = bitcast i8 addrspace(1)* %2 to i64 addrspace(1)*
  %14 = bitcast i64 addrspace(1)* %13 to <2 x i64> addrspace(1)*
  %15 = load <2 x i64>, <2 x i64> addrspace(1)* %14, align 128, !invariant.load !23
  %16 = extractelement <2 x i64> %15, i32 0
  %17 = extractelement <2 x i64> %15, i32 1
  %18 = zext i32 %12 to i64
  %19 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %16, i64 %18)
  %math = extractvalue { i64, i1 } %19, 0
  %ov = extractvalue { i64, i1 } %19, 1
  %20 = and i64 %math, 4294967295
  %21 = mul nuw i64 %20, 3528531795
  %22 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf988, i64 50184
  %23 = zext i1 %ov to i64
  %24 = add i64 %17, %23
  %25 = xor i64 %24, %21
  %26 = lshr i64 %25, 32
  %27 = xor i64 %26, 3243368317
  %28 = mul nuw i64 %27, 3449720151
  %29 = lshr i64 %28, 32
  %30 = and i64 %24, 4294967295
  %31 = mul nuw i64 %30, 3449720151
  %.masked960 = and i64 %31, 4294967295
  %32 = xor i64 %.masked960, %29
  %33 = xor i64 %32, 220028085
  %34 = mul nuw i64 %33, 3528531795
  %35 = lshr i64 %34, 32
  %36 = xor i64 %31, %math
  %37 = lshr i64 %36, 32
  %38 = xor i64 %37, 1860559612
  %39 = mul nuw i64 %38, 3528531795
  %.masked961 = and i64 %39, 4294967295
  %40 = xor i64 %.masked961, %35
  %41 = xor i64 %40, 941702279
  %42 = mul nuw i64 %41, 3449720151
  %43 = lshr i64 %42, 32
  %44 = lshr i64 %39, 32
  %.masked962 = and i64 %21, 4294967295
  %45 = xor i64 %.masked962, %44
  %46 = xor i64 %45, 2092535298
  %47 = mul nuw i64 %46, 3449720151
  %.masked963 = and i64 %47, 4294967295
  %48 = xor i64 %.masked963, %43
  %49 = xor i64 %48, 1233932327
  %50 = mul nuw i64 %49, 3528531795
  %51 = lshr i64 %50, 32
  %52 = lshr i64 %47, 32
  %.masked964 = and i64 %28, 4294967295
  %53 = xor i64 %.masked964, %52
  %54 = xor i64 %53, 2874463854
  %55 = mul nuw i64 %54, 3528531795
  %.masked965 = and i64 %55, 4294967295
  %56 = xor i64 %.masked965, %51
  %57 = xor i64 %56, 2935003537
  %58 = mul nuw i64 %57, 3449720151
  %59 = lshr i64 %58, 32
  %60 = lshr i64 %55, 32
  %.masked966 = and i64 %34, 4294967295
  %61 = xor i64 %.masked966, %60
  %62 = xor i64 %61, 4085836556
  %63 = mul nuw i64 %62, 3449720151
  %.masked967 = and i64 %63, 4294967295
  %64 = xor i64 %.masked967, %59
  %65 = xor i64 %64, 2247836569
  %66 = mul nuw i64 %65, 3528531795
  %67 = lshr i64 %66, 32
  %68 = lshr i64 %63, 32
  %.masked968 = and i64 %42, 4294967295
  %69 = xor i64 %.masked968, %68
  %70 = xor i64 %69, 3888368096
  %71 = mul nuw i64 %70, 3528531795
  %.masked969 = and i64 %71, 4294967295
  %72 = xor i64 %67, %.masked969
  %73 = xor i64 %72, 633337499
  %74 = mul nuw i64 %73, 3449720151
  %75 = lshr i64 %74, 32
  %76 = lshr i64 %71, 32
  %.masked970 = and i64 %50, 4294967295
  %77 = xor i64 %.masked970, %76
  %78 = xor i64 %77, 1784170518
  %79 = mul nuw i64 %78, 3449720151
  %.masked971 = and i64 %79, 4294967295
  %80 = xor i64 %.masked971, %75
  %81 = xor i64 %80, 3261740811
  %82 = mul nuw i64 %81, 3528531795
  %83 = lshr i64 %82, 32
  %84 = lshr i64 %79, 32
  %.masked972 = and i64 %58, 4294967295
  %85 = xor i64 %84, %.masked972
  %86 = xor i64 %85, 607305042
  %87 = mul nuw i64 %86, 3528531795
  %.masked973 = and i64 %87, 4294967295
  %88 = xor i64 %.masked973, %83
  %89 = xor i64 %88, 2626638757
  %90 = mul nuw i64 %89, 3449720151
  %91 = lshr i64 %90, 32
  %92 = trunc i64 %91 to i32
  %93 = lshr i64 %87, 32
  %94 = xor i64 %93, %66
  %95 = trunc i64 %94 to i32
  %96 = xor i32 %95, -517495520
  %97 = mul i32 %96, -845247145
  %98 = xor i32 %97, %92
  %99 = lshr i32 %98, 9
  %phi.bo = xor i32 %99, 8350869
  %phi.cast = uitofp i32 %phi.bo to float
  %phi.bo975 = fmul float %phi.cast, 0x3E80000000000000
  %phi.cmp = fcmp olt float %phi.bo975, 0x3FECCCCCC0000000
  %100 = zext i32 %5 to i64
  %101 = zext i32 %6 to i64
  %102 = getelementptr inbounds [256 x [16 x float]], [256 x [16 x float]] addrspace(1)* %1, i64 0, i64 %100, i64 %101
  %103 = bitcast float addrspace(1)* %102 to <4 x float> addrspace(1)*
  %104 = load <4 x float>, <4 x float> addrspace(1)* %103, align 16, !invariant.load !23
  %105 = extractelement <4 x float> %104, i32 0
  %106 = extractelement <4 x float> %104, i32 1
  %107 = extractelement <4 x float> %104, i32 2
  %108 = extractelement <4 x float> %104, i32 3
  %.op = fmul float %105, 0x3FF1C71C80000000
  %multiply.247 = select i1 %phi.cmp, float %.op, float 0.000000e+00
  %109 = getelementptr inbounds [256 x [16 x float]], [256 x [16 x float]] addrspace(1)* %3, i64 0, i64 %100, i64 %101
  %110 = xor i64 %84, %58
  %111 = xor i64 %110, 607305042
  %112 = mul i64 %111, 3528531795
  %113 = xor i64 %83, %112
  %114 = trunc i64 %113 to i32
  %115 = xor i32 %114, -1668328539
  %116 = mul i32 %115, -845247145
  %phi.bo976 = lshr i32 %116, 9
  %phi.cast977 = uitofp i32 %phi.bo976 to float
  %phi.bo978 = fmul float %phi.cast977, 0x3E80000000000000
  %phi.cmp979 = fcmp olt float %phi.bo978, 0x3FECCCCCC0000000
  %.op768 = fmul float %106, 0x3FF1C71C80000000
  %multiply.247346 = select i1 %phi.cmp979, float %.op768, float 0.000000e+00
  %.masked854 = and i64 %66, 4294967295
  %117 = xor i64 %.masked854, %93
  %118 = xor i64 %117, 3777471776
  %119 = mul nuw i64 %118, 3449720151
  %120 = lshr i64 %119, 32
  %.masked856 = and i64 %74, 4294967295
  %121 = xor i64 %.masked856, %120
  %122 = xor i64 %121, 1621209284
  %123 = mul nuw i64 %122, 3528531795
  %124 = lshr i64 %123, 32
  %125 = trunc i64 %124 to i32
  %126 = xor i64 %75, %79
  %127 = trunc i64 %126 to i32
  %128 = xor i32 %127, -1033226485
  %129 = mul i32 %128, -766435501
  %130 = xor i32 %129, %125
  %131 = lshr i32 %130, 9
  %phi.bo980 = xor i32 %131, 2882433
  %phi.cast981 = uitofp i32 %phi.bo980 to float
  %phi.bo982 = fmul float %phi.cast981, 0x3E80000000000000
  %phi.cmp983 = fcmp olt float %phi.bo982, 0x3FECCCCCC0000000
  %.op783 = fmul float %107, 0x3FF1C71C80000000
  %multiply.247540 = select i1 %phi.cmp983, float %.op783, float 0.000000e+00
  %132 = xor i64 %67, %71
  %133 = xor i64 %132, 633337499
  %134 = mul i64 %133, 3449720151
  %135 = xor i64 %120, %134
  %136 = trunc i64 %135 to i32
  %137 = xor i32 %136, 1621209284
  %138 = mul i32 %137, -766435501
  %phi.bo984 = lshr i32 %138, 9
  %phi.cast985 = uitofp i32 %phi.bo984 to float
  %phi.bo986 = fmul float %phi.cast985, 0x3E80000000000000
  %phi.cmp987 = fcmp olt float %phi.bo986, 0x3FECCCCCC0000000
  %.op798 = fmul float %108, 0x3FF1C71C80000000
  %multiply.247734 = select i1 %phi.cmp987, float %.op798, float 0.000000e+00
  %139 = insertelement <4 x float> poison, float %multiply.247, i32 0
  %140 = insertelement <4 x float> %139, float %multiply.247346, i32 1
  %141 = insertelement <4 x float> %140, float %multiply.247540, i32 2
  %142 = insertelement <4 x float> %141, float %multiply.247734, i32 3
  %143 = bitcast float addrspace(1)* %109 to <4 x float> addrspace(1)*
  store <4 x float> %142, <4 x float> addrspace(1)* %143, align 16
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define void @concatenate_8(i8* noalias nocapture align 128 dereferenceable(50320) %temp_buf) local_unnamed_addr #3 {
entry:
  %temp_buf29 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf29, i64 16384
  %1 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf29, i64 49152
  %2 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !24
  %linear_index_base = shl nuw nsw i32 %2, 2
  %linear_index1 = or i32 %linear_index_base, 1
  %linear_index2 = or i32 %linear_index_base, 2
  %linear_index3 = or i32 %linear_index_base, 3
  %3 = icmp ult i32 %2, 64
  br i1 %3, label %concatenate.pivot.0., label %concatenate.pivot.256.1

concatenate.pivot.0.:                             ; preds = %entry
  %4 = bitcast i8 addrspace(1)* %0 to [256 x float] addrspace(1)*
  %5 = zext i32 %linear_index_base to i64
  %6 = getelementptr inbounds [256 x float], [256 x float] addrspace(1)* %4, i64 0, i64 %5
  br label %concatenate.3.merge

concatenate.pivot.256.1:                          ; preds = %entry
  %7 = bitcast i8 addrspace(1)* %1 to [256 x float] addrspace(1)*
  %8 = sext i32 %linear_index_base to i64
  %9 = getelementptr [256 x float], [256 x float] addrspace(1)* %7, i64 0, i64 %8
  %10 = getelementptr inbounds float, float addrspace(1)* %9, i64 -256
  %.pre = zext i32 %linear_index_base to i64
  br label %concatenate.3.merge

concatenate.3.merge:                              ; preds = %concatenate.pivot.256.1, %concatenate.pivot.0.
  %.pre-phi = phi i64 [ %.pre, %concatenate.pivot.256.1 ], [ %5, %concatenate.pivot.0. ]
  %.in = phi float addrspace(1)* [ %10, %concatenate.pivot.256.1 ], [ %6, %concatenate.pivot.0. ]
  %11 = load float, float addrspace(1)* %.in, align 4, !invariant.load !23
  %12 = bitcast i8 addrspace(1)* %temp_buf29 to float addrspace(1)*
  %13 = getelementptr inbounds float, float addrspace(1)* %12, i64 %.pre-phi
  store float %11, float addrspace(1)* %13, align 16
  %14 = icmp ult i32 %linear_index1, 256
  br i1 %14, label %concatenate.pivot.0.6, label %concatenate.pivot.256.7

concatenate.pivot.0.6:                            ; preds = %concatenate.3.merge
  %15 = bitcast i8 addrspace(1)* %0 to [256 x float] addrspace(1)*
  %16 = zext i32 %linear_index1 to i64
  %17 = zext i32 %linear_index_base to i64
  %18 = getelementptr [256 x float], [256 x float] addrspace(1)* %15, i64 0, i64 %17
  %19 = getelementptr inbounds float, float addrspace(1)* %18, i64 1
  br label %concatenate.3.merge2

concatenate.pivot.256.7:                          ; preds = %concatenate.3.merge
  %20 = bitcast i8 addrspace(1)* %1 to [256 x float] addrspace(1)*
  %21 = sext i32 %linear_index_base to i64
  %22 = getelementptr [256 x float], [256 x float] addrspace(1)* %20, i64 0, i64 %21
  %23 = getelementptr inbounds float, float addrspace(1)* %22, i64 -255
  %.pre23 = zext i32 %linear_index1 to i64
  br label %concatenate.3.merge2

concatenate.3.merge2:                             ; preds = %concatenate.pivot.256.7, %concatenate.pivot.0.6
  %.pre-phi24 = phi i64 [ %.pre23, %concatenate.pivot.256.7 ], [ %16, %concatenate.pivot.0.6 ]
  %.in20 = phi float addrspace(1)* [ %23, %concatenate.pivot.256.7 ], [ %19, %concatenate.pivot.0.6 ]
  %24 = bitcast i8 addrspace(1)* %temp_buf29 to float addrspace(1)*
  %25 = load float, float addrspace(1)* %.in20, align 4, !invariant.load !23
  %26 = getelementptr inbounds float, float addrspace(1)* %24, i64 %.pre-phi24
  store float %25, float addrspace(1)* %26, align 4
  %27 = icmp ult i32 %linear_index2, 256
  br i1 %27, label %concatenate.pivot.0.12, label %concatenate.pivot.256.13

concatenate.pivot.0.12:                           ; preds = %concatenate.3.merge2
  %28 = bitcast i8 addrspace(1)* %0 to [256 x float] addrspace(1)*
  %29 = zext i32 %linear_index2 to i64
  %30 = zext i32 %linear_index_base to i64
  %31 = getelementptr [256 x float], [256 x float] addrspace(1)* %28, i64 0, i64 %30
  %32 = getelementptr inbounds float, float addrspace(1)* %31, i64 2
  br label %concatenate.3.merge8

concatenate.pivot.256.13:                         ; preds = %concatenate.3.merge2
  %33 = bitcast i8 addrspace(1)* %1 to [256 x float] addrspace(1)*
  %34 = sext i32 %linear_index_base to i64
  %35 = getelementptr [256 x float], [256 x float] addrspace(1)* %33, i64 0, i64 %34
  %36 = getelementptr inbounds float, float addrspace(1)* %35, i64 -254
  %.pre25 = zext i32 %linear_index2 to i64
  br label %concatenate.3.merge8

concatenate.3.merge8:                             ; preds = %concatenate.pivot.256.13, %concatenate.pivot.0.12
  %.pre-phi26 = phi i64 [ %.pre25, %concatenate.pivot.256.13 ], [ %29, %concatenate.pivot.0.12 ]
  %.in21 = phi float addrspace(1)* [ %36, %concatenate.pivot.256.13 ], [ %32, %concatenate.pivot.0.12 ]
  %37 = bitcast i8 addrspace(1)* %temp_buf29 to float addrspace(1)*
  %38 = load float, float addrspace(1)* %.in21, align 4, !invariant.load !23
  %39 = getelementptr inbounds float, float addrspace(1)* %37, i64 %.pre-phi26
  store float %38, float addrspace(1)* %39, align 8
  %40 = icmp ult i32 %linear_index3, 256
  br i1 %40, label %concatenate.pivot.0.18, label %concatenate.pivot.256.19

concatenate.pivot.0.18:                           ; preds = %concatenate.3.merge8
  %41 = bitcast i8 addrspace(1)* %0 to [256 x float] addrspace(1)*
  %42 = zext i32 %linear_index3 to i64
  %43 = zext i32 %linear_index_base to i64
  %44 = getelementptr [256 x float], [256 x float] addrspace(1)* %41, i64 0, i64 %43
  %45 = getelementptr inbounds float, float addrspace(1)* %44, i64 3
  br label %concatenate.3.merge14

concatenate.pivot.256.19:                         ; preds = %concatenate.3.merge8
  %46 = bitcast i8 addrspace(1)* %1 to [256 x float] addrspace(1)*
  %47 = sext i32 %linear_index_base to i64
  %48 = getelementptr [256 x float], [256 x float] addrspace(1)* %46, i64 0, i64 %47
  %49 = getelementptr inbounds float, float addrspace(1)* %48, i64 -253
  %.pre27 = zext i32 %linear_index3 to i64
  br label %concatenate.3.merge14

concatenate.3.merge14:                            ; preds = %concatenate.pivot.256.19, %concatenate.pivot.0.18
  %.pre-phi28 = phi i64 [ %.pre27, %concatenate.pivot.256.19 ], [ %42, %concatenate.pivot.0.18 ]
  %.in22 = phi float addrspace(1)* [ %49, %concatenate.pivot.256.19 ], [ %45, %concatenate.pivot.0.18 ]
  %50 = bitcast i8 addrspace(1)* %temp_buf29 to float addrspace(1)*
  %51 = load float, float addrspace(1)* %.in22, align 4, !invariant.load !23
  %52 = getelementptr inbounds float, float addrspace(1)* %50, i64 %.pre-phi28
  store float %51, float addrspace(1)* %52, align 4
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
define void @slice_17(i8* noalias nocapture align 128 dereferenceable(50320) %temp_buf) local_unnamed_addr #1 {
entry:
  %temp_buf1 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !25
  %linear_index_base = shl nuw nsw i32 %0, 2
  %1 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf1, i64 2048
  %2 = bitcast i8 addrspace(1)* %temp_buf1 to [512 x float] addrspace(1)*
  %3 = zext i32 %linear_index_base to i64
  %4 = getelementptr inbounds [512 x float], [512 x float] addrspace(1)* %2, i64 0, i64 %3
  %5 = bitcast float addrspace(1)* %4 to <4 x float> addrspace(1)*
  %6 = load <4 x float>, <4 x float> addrspace(1)* %5, align 16, !invariant.load !23
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
define void @slice_18(i8* noalias nocapture align 128 dereferenceable(50320) %temp_buf) local_unnamed_addr #1 {
entry:
  %temp_buf1 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !25
  %linear_index_base = shl nuw nsw i32 %0, 2
  %1 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf1, i64 3072
  %2 = bitcast i8 addrspace(1)* %temp_buf1 to [512 x float] addrspace(1)*
  %3 = zext i32 %linear_index_base to i64
  %4 = getelementptr [512 x float], [512 x float] addrspace(1)* %2, i64 0, i64 %3
  %5 = getelementptr inbounds float, float addrspace(1)* %4, i64 256
  %6 = bitcast float addrspace(1)* %5 to <4 x float> addrspace(1)*
  %7 = load <4 x float>, <4 x float> addrspace(1)* %6, align 16, !invariant.load !23
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
define void @fusion_7(i8* noalias nocapture align 16 dereferenceable(1024) %alloc1, i8* noalias nocapture align 16 dereferenceable(1024) %alloc2, i8* noalias nocapture readonly align 128 dereferenceable(50320) %temp_buf) local_unnamed_addr #1 {
entry:
  %temp_buf9 = addrspacecast i8* %temp_buf to i8 addrspace(1)*
  %alloc27 = addrspacecast i8* %alloc2 to i8 addrspace(1)*
  %alloc15 = addrspacecast i8* %alloc1 to i8 addrspace(1)*
  %0 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !range !26
  %1 = icmp ult i32 %0, 256
  br i1 %1, label %concatenate.pivot.0., label %concatenate.pivot.256.2

fusion_7.in_bounds-after:                         ; preds = %slice0-after, %slice1-true
  ret void

concatenate.pivot.0.:                             ; preds = %entry
  %2 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf9, i64 2048
  %3 = bitcast i8 addrspace(1)* %2 to [16 x [16 x float]] addrspace(1)*
  %4 = bitcast i8 addrspace(1)* %alloc15 to [16 x [16 x float]] addrspace(1)*
  %5 = and i32 %0, 15
  %6 = lshr i32 %0, 4
  %7 = zext i32 %6 to i64
  %8 = zext i32 %5 to i64
  %9 = getelementptr inbounds [16 x [16 x float]], [16 x [16 x float]] addrspace(1)* %4, i64 0, i64 %7, i64 %8
  %10 = getelementptr inbounds [16 x [16 x float]], [16 x [16 x float]] addrspace(1)* %3, i64 0, i64 %7, i64 %8
  br label %concatenate.13.merge

concatenate.pivot.256.2:                          ; preds = %entry
  %11 = getelementptr inbounds i8, i8 addrspace(1)* %temp_buf9, i64 3072
  %12 = bitcast i8 addrspace(1)* %11 to [16 x [16 x float]] addrspace(1)*
  %13 = bitcast i8 addrspace(1)* %alloc27 to [16 x [16 x float]] addrspace(1)*
  %14 = add nsw i32 %0, -256
  %15 = and i32 %0, 15
  %16 = lshr i32 %14, 4
  %17 = zext i32 %16 to i64
  %18 = zext i32 %15 to i64
  %19 = getelementptr inbounds [16 x [16 x float]], [16 x [16 x float]] addrspace(1)* %13, i64 0, i64 %17, i64 %18
  %20 = getelementptr inbounds [16 x [16 x float]], [16 x [16 x float]] addrspace(1)* %12, i64 0, i64 %17, i64 %18
  br label %concatenate.13.merge

concatenate.13.merge:                             ; preds = %concatenate.pivot.256.2, %concatenate.pivot.0.
  %.sink4 = phi float addrspace(1)* [ %20, %concatenate.pivot.256.2 ], [ %10, %concatenate.pivot.0. ]
  %.sink.in = phi float addrspace(1)* [ %19, %concatenate.pivot.256.2 ], [ %9, %concatenate.pivot.0. ]
  %21 = icmp ult i32 %0, 256
  %22 = bitcast i8 addrspace(1)* %alloc15 to [256 x float] addrspace(1)*
  %.sink = load float, float addrspace(1)* %.sink.in, align 4
  %23 = load float, float addrspace(1)* %.sink4, align 4, !invariant.load !23
  %multiply.10 = fmul float %23, 0x3F847AE140000000
  %subtract.11 = fsub float %.sink, %multiply.10
  %24 = zext i32 %0 to i64
  %25 = getelementptr inbounds [256 x float], [256 x float] addrspace(1)* %22, i64 0, i64 %24
  br i1 %21, label %slice0-true, label %slice0-after

slice0-after:                                     ; preds = %slice0-true, %concatenate.13.merge
  %26 = bitcast i8 addrspace(1)* %alloc27 to [256 x float] addrspace(1)*
  %27 = icmp ugt i32 %0, 255
  %28 = add nsw i32 %0, -256
  %29 = zext i32 %28 to i64
  %30 = getelementptr inbounds [256 x float], [256 x float] addrspace(1)* %26, i64 0, i64 %29
  br i1 %27, label %slice1-true, label %fusion_7.in_bounds-after

slice0-true:                                      ; preds = %concatenate.13.merge
  store float %subtract.11, float addrspace(1)* %25, align 4
  br label %slice0-after

slice1-true:                                      ; preds = %slice0-after
  store float %subtract.11, float addrspace(1)* %30, align 4
  br label %fusion_7.in_bounds-after
}

; Function Attrs: argmemonly mustprogress nofree norecurse nosync nounwind willreturn
define void @add_2(i8* noalias nocapture align 16 dereferenceable(4) %alloc0, i8* noalias nocapture readnone align 128 dereferenceable(50320) %temp_buf) local_unnamed_addr #4 {
entry:
  %alloc01 = addrspacecast i8* %alloc0 to i8 addrspace(1)*
  %0 = bitcast i8 addrspace(1)* %alloc01 to i32 addrspace(1)*
  %1 = load i32, i32 addrspace(1)* %0, align 16
  %2 = add i32 %1, 1
  store i32 %2, i32 addrspace(1)* %0, align 16
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.uadd.with.overflow.i64(i64, i64) #5

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn }
attributes #1 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #2 = { nofree nosync nounwind readnone speculatable }
attributes #3 = { mustprogress nofree nosync nounwind willreturn }
attributes #4 = { argmemonly mustprogress nofree norecurse nosync nounwind willreturn }
attributes #5 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!nvvm.annotations = !{!0, !1, !2, !3, !4, !5, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19}
!llvm.module.flags = !{!20}

!0 = !{void (i8*)* @rng_get_and_update_state, !"kernel", i32 1}
!1 = !{void (i8*)* @rng_get_and_update_state, !"reqntidx", i32 1}
!2 = !{void (i8*)* @fusion_5, !"kernel", i32 1}
!3 = !{void (i8*)* @fusion_5, !"reqntidx", i32 256}
!4 = !{void (i8*, i8*)* @fusion_4, !"kernel", i32 1}
!5 = !{void (i8*, i8*)* @fusion_4, !"reqntidx", i32 256}
!6 = !{void (i8*)* @fusion_1, !"kernel", i32 1}
!7 = !{void (i8*)* @fusion_1, !"reqntidx", i32 256}
!8 = !{void (i8*)* @fusion_3, !"kernel", i32 1}
!9 = !{void (i8*)* @fusion_3, !"reqntidx", i32 256}
!10 = !{void (i8*)* @concatenate_8, !"kernel", i32 1}
!11 = !{void (i8*)* @concatenate_8, !"reqntidx", i32 128}
!12 = !{void (i8*)* @slice_17, !"kernel", i32 1}
!13 = !{void (i8*)* @slice_17, !"reqntidx", i32 64}
!14 = !{void (i8*)* @slice_18, !"kernel", i32 1}
!15 = !{void (i8*)* @slice_18, !"reqntidx", i32 64}
!16 = !{void (i8*, i8*, i8*)* @fusion_7, !"kernel", i32 1}
!17 = !{void (i8*, i8*, i8*)* @fusion_7, !"reqntidx", i32 512}
!18 = !{void (i8*, i8*)* @add_2, !"kernel", i32 1}
!19 = !{void (i8*, i8*)* @add_2, !"reqntidx", i32 1}
!20 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!21 = !{i32 0, i32 4}
!22 = !{i32 0, i32 256}
!23 = !{}
!24 = !{i32 0, i32 128}
!25 = !{i32 0, i32 64}
!26 = !{i32 0, i32 512}
