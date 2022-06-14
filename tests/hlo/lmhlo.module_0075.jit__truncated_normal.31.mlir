module attributes {hlo.unique_id = 75 : i32, mhlo.unique_id = 75 : i64} {
  memref.global "private" constant @buffer_for_constant_185 : memref<ui64> = dense<32> {lmhlo.alloc = 3 : index}
  func @main.264(%arg0: memref<4xi8> {lmhlo.params = 0 : index}, %arg1: memref<4xi8> {lmhlo.params = 1 : index}, %arg2: memref<1024xi8> {lmhlo.output_index = dense<> : tensor<0xi64>}, %arg3: memref<8xi8> {lmhlo.constant_name = "buffer_for_constant_185"}, %arg4: memref<16xi8>) attributes {result_xla_shape = "f32[16,16]{1,0}"} {
    %0 = memref.get_global @buffer_for_constant_185 : memref<ui64>
    %c0 = arith.constant 0 : index
    %1 = memref.view %arg4[%c0][] : memref<16xi8> to memref<2xui64>
    "lmhlo.rng_get_and_update_state"(%1) {delta = 256 : i64} : (memref<2xui64>) -> ()
    %c0_0 = arith.constant 0 : index
    %2 = memref.view %arg0[%c0_0][] : memref<4xi8> to memref<i32>
    %c0_1 = arith.constant 0 : index
    %3 = memref.view %arg1[%c0_1][] : memref<4xi8> to memref<i32>
    %c0_2 = arith.constant 0 : index
    %4 = memref.view %arg2[%c0_2][] : memref<1024xi8> to memref<16x16xf32>
    "lmhlo.fusion"() ({
      %5 = bufferization.to_tensor %0 : memref<ui64>
      %6 = bufferization.to_tensor %1 : memref<2xui64>
      %7 = bufferization.to_tensor %2 : memref<i32>
      %8 = bufferization.to_tensor %3 : memref<i32>
      %9 = "mhlo.convert"(%8) : (tensor<i32>) -> tensor<f32>
      %10 = "mhlo.compare"(%9, %9) {comparison_direction = #mhlo<"comparison_direction NE">} : (tensor<f32>, tensor<f32>) -> tensor<i1>
      %11 = mhlo.constant dense<2143289344> : tensor<i32>
      %12 = mhlo.constant dense<0xFF800000> : tensor<f32>
      %13 = "mhlo.compare"(%9, %12) {comparison_direction = #mhlo<"comparison_direction EQ">} : (tensor<f32>, tensor<f32>) -> tensor<i1>
      %14 = mhlo.constant dense<-8388608> : tensor<i32>
      %15 = "mhlo.bitcast_convert"(%9) : (tensor<f32>) -> tensor<i32>
      %16 = mhlo.constant dense<2147483647> : tensor<i32>
      %17 = mhlo.and %15, %16 : tensor<i32>
      %18 = mhlo.constant dense<0> : tensor<i32>
      %19 = "mhlo.compare"(%17, %18) {comparison_direction = #mhlo<"comparison_direction EQ">} : (tensor<i32>, tensor<i32>) -> tensor<i1>
      %20 = mhlo.constant dense<-2147483647> : tensor<i32>
      %21 = mhlo.constant dense<2139095040> : tensor<i32>
      %22 = "mhlo.compare"(%17, %21) {comparison_direction = #mhlo<"comparison_direction GT">} : (tensor<i32>, tensor<i32>) -> tensor<i1>
      %23 = mhlo.constant dense<-2147483648> : tensor<i32>
      %24 = mhlo.and %15, %23 : tensor<i32>
      %25 = "mhlo.compare"(%24, %23) {comparison_direction = #mhlo<"comparison_direction NE">} : (tensor<i32>, tensor<i32>) -> tensor<i1>
      %26 = mhlo.or %22, %25 : tensor<i1>
      %27 = mhlo.constant dense<-1> : tensor<i32>
      %28 = mhlo.constant dense<1> : tensor<i32>
      %29 = "mhlo.select"(%26, %27, %28) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
      %30 = mhlo.add %15, %29 : tensor<i32>
      %31 = "mhlo.select"(%19, %20, %30) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
      %32 = "mhlo.select"(%13, %14, %31) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
      %33 = "mhlo.select"(%10, %11, %32) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
      %34 = "mhlo.bitcast_convert"(%33) : (tensor<i32>) -> tensor<f32>
      %35 = "mhlo.broadcast_in_dim"(%34) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %36 = "mhlo.convert"(%7) : (tensor<i32>) -> tensor<f32>
      %37 = "mhlo.compare"(%36, %36) {comparison_direction = #mhlo<"comparison_direction NE">} : (tensor<f32>, tensor<f32>) -> tensor<i1>
      %38 = mhlo.constant dense<0x7F800000> : tensor<f32>
      %39 = "mhlo.compare"(%36, %38) {comparison_direction = #mhlo<"comparison_direction EQ">} : (tensor<f32>, tensor<f32>) -> tensor<i1>
      %40 = "mhlo.bitcast_convert"(%36) : (tensor<f32>) -> tensor<i32>
      %41 = mhlo.and %40, %16 : tensor<i32>
      %42 = "mhlo.compare"(%41, %18) {comparison_direction = #mhlo<"comparison_direction EQ">} : (tensor<i32>, tensor<i32>) -> tensor<i1>
      %43 = "mhlo.compare"(%41, %21) {comparison_direction = #mhlo<"comparison_direction GT">} : (tensor<i32>, tensor<i32>) -> tensor<i1>
      %44 = mhlo.and %40, %23 : tensor<i32>
      %45 = "mhlo.compare"(%44, %18) {comparison_direction = #mhlo<"comparison_direction NE">} : (tensor<i32>, tensor<i32>) -> tensor<i1>
      %46 = mhlo.or %43, %45 : tensor<i1>
      %47 = "mhlo.select"(%46, %27, %28) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
      %48 = mhlo.add %40, %47 : tensor<i32>
      %49 = "mhlo.select"(%42, %28, %48) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
      %50 = "mhlo.select"(%39, %21, %49) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
      %51 = "mhlo.select"(%37, %11, %50) : (tensor<i1>, tensor<i32>, tensor<i32>) -> tensor<i32>
      %52 = "mhlo.bitcast_convert"(%51) : (tensor<i32>) -> tensor<f32>
      %53 = "mhlo.broadcast_in_dim"(%52) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %54 = "mhlo.slice"(%6) {limit_indices = dense<1> : tensor<1xi64>, start_indices = dense<0> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<2xui64>) -> tensor<1xui64>
      %55 = "mhlo.bitcast"(%54) {result_layout = dense<> : tensor<0xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1xui64>) -> tensor<ui64>
      %56 = "mhlo.convert"(%55) : (tensor<ui64>) -> tensor<ui32>
      %57 = "mhlo.convert"(%56) : (tensor<ui32>) -> tensor<ui64>
      %58 = mhlo.shift_right_logical %55, %5 : tensor<ui64>
      %59 = "mhlo.convert"(%58) : (tensor<ui64>) -> tensor<ui32>
      %60 = "mhlo.convert"(%59) : (tensor<ui32>) -> tensor<ui64>
      %61 = mhlo.shift_left %60, %5 : tensor<ui64>
      %62 = mhlo.or %57, %61 : tensor<ui64>
      %63 = "mhlo.broadcast_in_dim"(%62) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<64xui64>
      %64 = "mhlo.iota"() {iota_dimension = 0 : i64} : () -> tensor<64xui64>
      %65 = mhlo.add %63, %64 : tensor<64xui64>
      %66 = "mhlo.convert"(%65) : (tensor<64xui64>) -> tensor<64xui32>
      %67 = "mhlo.convert"(%66) : (tensor<64xui32>) -> tensor<64xui64>
      %68 = mhlo.constant dense<3528531795> : tensor<ui64>
      %69 = "mhlo.broadcast_in_dim"(%68) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<64xui64>
      %70 = mhlo.multiply %67, %69 : tensor<64xui64>
      %71 = "mhlo.broadcast_in_dim"(%5) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<64xui64>
      %72 = mhlo.shift_right_logical %70, %71 : tensor<64xui64>
      %73 = "mhlo.convert"(%72) : (tensor<64xui64>) -> tensor<64xui32>
      %74 = "mhlo.compare"(%65, %63) {comparison_direction = #mhlo<"comparison_direction LT">} : (tensor<64xui64>, tensor<64xui64>) -> tensor<64xi1>
      %75 = "mhlo.slice"(%6) {limit_indices = dense<2> : tensor<1xi64>, start_indices = dense<1> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<2xui64>) -> tensor<1xui64>
      %76 = "mhlo.bitcast"(%75) {result_layout = dense<> : tensor<0xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1xui64>) -> tensor<ui64>
      %77 = "mhlo.convert"(%76) : (tensor<ui64>) -> tensor<ui32>
      %78 = "mhlo.convert"(%77) : (tensor<ui32>) -> tensor<ui64>
      %79 = mhlo.shift_right_logical %76, %5 : tensor<ui64>
      %80 = "mhlo.convert"(%79) : (tensor<ui64>) -> tensor<ui32>
      %81 = "mhlo.convert"(%80) : (tensor<ui32>) -> tensor<ui64>
      %82 = mhlo.shift_left %81, %5 : tensor<ui64>
      %83 = mhlo.or %78, %82 : tensor<ui64>
      %84 = mhlo.constant dense<1> : tensor<ui64>
      %85 = mhlo.add %83, %84 : tensor<ui64>
      %86 = "mhlo.broadcast_in_dim"(%85) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<64xui64>
      %87 = "mhlo.broadcast_in_dim"(%83) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<64xui64>
      %88 = "mhlo.select"(%74, %86, %87) : (tensor<64xi1>, tensor<64xui64>, tensor<64xui64>) -> tensor<64xui64>
      %89 = mhlo.shift_right_logical %88, %71 : tensor<64xui64>
      %90 = "mhlo.convert"(%89) : (tensor<64xui64>) -> tensor<64xui32>
      %91 = mhlo.xor %73, %90 : tensor<64xui32>
      %92 = mhlo.constant dense<3243368317> : tensor<ui32>
      %93 = "mhlo.broadcast_in_dim"(%92) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %94 = mhlo.xor %91, %93 : tensor<64xui32>
      %95 = "mhlo.convert"(%94) : (tensor<64xui32>) -> tensor<64xui64>
      %96 = mhlo.constant dense<3449720151> : tensor<ui64>
      %97 = "mhlo.broadcast_in_dim"(%96) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<64xui64>
      %98 = mhlo.multiply %95, %97 : tensor<64xui64>
      %99 = mhlo.shift_right_logical %98, %71 : tensor<64xui64>
      %100 = "mhlo.convert"(%99) : (tensor<64xui64>) -> tensor<64xui32>
      %101 = "mhlo.convert"(%88) : (tensor<64xui64>) -> tensor<64xui32>
      %102 = "mhlo.convert"(%101) : (tensor<64xui32>) -> tensor<64xui64>
      %103 = mhlo.multiply %102, %97 : tensor<64xui64>
      %104 = "mhlo.convert"(%103) : (tensor<64xui64>) -> tensor<64xui32>
      %105 = mhlo.xor %100, %104 : tensor<64xui32>
      %106 = mhlo.constant dense<220028085> : tensor<ui32>
      %107 = "mhlo.broadcast_in_dim"(%106) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %108 = mhlo.xor %105, %107 : tensor<64xui32>
      %109 = "mhlo.convert"(%108) : (tensor<64xui32>) -> tensor<64xui64>
      %110 = mhlo.multiply %109, %69 : tensor<64xui64>
      %111 = mhlo.shift_right_logical %110, %71 : tensor<64xui64>
      %112 = "mhlo.convert"(%111) : (tensor<64xui64>) -> tensor<64xui32>
      %113 = mhlo.shift_right_logical %103, %71 : tensor<64xui64>
      %114 = "mhlo.convert"(%113) : (tensor<64xui64>) -> tensor<64xui32>
      %115 = mhlo.shift_right_logical %65, %71 : tensor<64xui64>
      %116 = "mhlo.convert"(%115) : (tensor<64xui64>) -> tensor<64xui32>
      %117 = mhlo.xor %114, %116 : tensor<64xui32>
      %118 = mhlo.constant dense<1860559612> : tensor<ui32>
      %119 = "mhlo.broadcast_in_dim"(%118) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %120 = mhlo.xor %117, %119 : tensor<64xui32>
      %121 = "mhlo.convert"(%120) : (tensor<64xui32>) -> tensor<64xui64>
      %122 = mhlo.multiply %121, %69 : tensor<64xui64>
      %123 = "mhlo.convert"(%122) : (tensor<64xui64>) -> tensor<64xui32>
      %124 = mhlo.xor %112, %123 : tensor<64xui32>
      %125 = mhlo.constant dense<941702279> : tensor<ui32>
      %126 = "mhlo.broadcast_in_dim"(%125) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %127 = mhlo.xor %124, %126 : tensor<64xui32>
      %128 = "mhlo.convert"(%127) : (tensor<64xui32>) -> tensor<64xui64>
      %129 = mhlo.multiply %128, %97 : tensor<64xui64>
      %130 = mhlo.shift_right_logical %129, %71 : tensor<64xui64>
      %131 = "mhlo.convert"(%130) : (tensor<64xui64>) -> tensor<64xui32>
      %132 = mhlo.shift_right_logical %122, %71 : tensor<64xui64>
      %133 = "mhlo.convert"(%132) : (tensor<64xui64>) -> tensor<64xui32>
      %134 = "mhlo.convert"(%70) : (tensor<64xui64>) -> tensor<64xui32>
      %135 = mhlo.xor %133, %134 : tensor<64xui32>
      %136 = mhlo.constant dense<2092535298> : tensor<ui32>
      %137 = "mhlo.broadcast_in_dim"(%136) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %138 = mhlo.xor %135, %137 : tensor<64xui32>
      %139 = "mhlo.convert"(%138) : (tensor<64xui32>) -> tensor<64xui64>
      %140 = mhlo.multiply %139, %97 : tensor<64xui64>
      %141 = "mhlo.convert"(%140) : (tensor<64xui64>) -> tensor<64xui32>
      %142 = mhlo.xor %131, %141 : tensor<64xui32>
      %143 = mhlo.constant dense<1233932327> : tensor<ui32>
      %144 = "mhlo.broadcast_in_dim"(%143) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %145 = mhlo.xor %142, %144 : tensor<64xui32>
      %146 = "mhlo.convert"(%145) : (tensor<64xui32>) -> tensor<64xui64>
      %147 = mhlo.multiply %146, %69 : tensor<64xui64>
      %148 = mhlo.shift_right_logical %147, %71 : tensor<64xui64>
      %149 = "mhlo.convert"(%148) : (tensor<64xui64>) -> tensor<64xui32>
      %150 = mhlo.shift_right_logical %140, %71 : tensor<64xui64>
      %151 = "mhlo.convert"(%150) : (tensor<64xui64>) -> tensor<64xui32>
      %152 = "mhlo.convert"(%98) : (tensor<64xui64>) -> tensor<64xui32>
      %153 = mhlo.xor %151, %152 : tensor<64xui32>
      %154 = mhlo.constant dense<2874463854> : tensor<ui32>
      %155 = "mhlo.broadcast_in_dim"(%154) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %156 = mhlo.xor %153, %155 : tensor<64xui32>
      %157 = "mhlo.convert"(%156) : (tensor<64xui32>) -> tensor<64xui64>
      %158 = mhlo.multiply %157, %69 : tensor<64xui64>
      %159 = "mhlo.convert"(%158) : (tensor<64xui64>) -> tensor<64xui32>
      %160 = mhlo.xor %149, %159 : tensor<64xui32>
      %161 = mhlo.constant dense<2935003537> : tensor<ui32>
      %162 = "mhlo.broadcast_in_dim"(%161) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %163 = mhlo.xor %160, %162 : tensor<64xui32>
      %164 = "mhlo.convert"(%163) : (tensor<64xui32>) -> tensor<64xui64>
      %165 = mhlo.multiply %164, %97 : tensor<64xui64>
      %166 = mhlo.shift_right_logical %165, %71 : tensor<64xui64>
      %167 = "mhlo.convert"(%166) : (tensor<64xui64>) -> tensor<64xui32>
      %168 = mhlo.shift_right_logical %158, %71 : tensor<64xui64>
      %169 = "mhlo.convert"(%168) : (tensor<64xui64>) -> tensor<64xui32>
      %170 = "mhlo.convert"(%110) : (tensor<64xui64>) -> tensor<64xui32>
      %171 = mhlo.xor %169, %170 : tensor<64xui32>
      %172 = mhlo.constant dense<4085836556> : tensor<ui32>
      %173 = "mhlo.broadcast_in_dim"(%172) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %174 = mhlo.xor %171, %173 : tensor<64xui32>
      %175 = "mhlo.convert"(%174) : (tensor<64xui32>) -> tensor<64xui64>
      %176 = mhlo.multiply %175, %97 : tensor<64xui64>
      %177 = "mhlo.convert"(%176) : (tensor<64xui64>) -> tensor<64xui32>
      %178 = mhlo.xor %167, %177 : tensor<64xui32>
      %179 = mhlo.constant dense<2247836569> : tensor<ui32>
      %180 = "mhlo.broadcast_in_dim"(%179) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %181 = mhlo.xor %178, %180 : tensor<64xui32>
      %182 = "mhlo.convert"(%181) : (tensor<64xui32>) -> tensor<64xui64>
      %183 = mhlo.multiply %182, %69 : tensor<64xui64>
      %184 = mhlo.shift_right_logical %183, %71 : tensor<64xui64>
      %185 = "mhlo.convert"(%184) : (tensor<64xui64>) -> tensor<64xui32>
      %186 = mhlo.shift_right_logical %176, %71 : tensor<64xui64>
      %187 = "mhlo.convert"(%186) : (tensor<64xui64>) -> tensor<64xui32>
      %188 = "mhlo.convert"(%129) : (tensor<64xui64>) -> tensor<64xui32>
      %189 = mhlo.xor %187, %188 : tensor<64xui32>
      %190 = mhlo.constant dense<3888368096> : tensor<ui32>
      %191 = "mhlo.broadcast_in_dim"(%190) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %192 = mhlo.xor %189, %191 : tensor<64xui32>
      %193 = "mhlo.convert"(%192) : (tensor<64xui32>) -> tensor<64xui64>
      %194 = mhlo.multiply %193, %69 : tensor<64xui64>
      %195 = "mhlo.convert"(%194) : (tensor<64xui64>) -> tensor<64xui32>
      %196 = mhlo.xor %185, %195 : tensor<64xui32>
      %197 = mhlo.constant dense<633337499> : tensor<ui32>
      %198 = "mhlo.broadcast_in_dim"(%197) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %199 = mhlo.xor %196, %198 : tensor<64xui32>
      %200 = "mhlo.convert"(%199) : (tensor<64xui32>) -> tensor<64xui64>
      %201 = mhlo.multiply %200, %97 : tensor<64xui64>
      %202 = mhlo.shift_right_logical %201, %71 : tensor<64xui64>
      %203 = "mhlo.convert"(%202) : (tensor<64xui64>) -> tensor<64xui32>
      %204 = mhlo.shift_right_logical %194, %71 : tensor<64xui64>
      %205 = "mhlo.convert"(%204) : (tensor<64xui64>) -> tensor<64xui32>
      %206 = "mhlo.convert"(%147) : (tensor<64xui64>) -> tensor<64xui32>
      %207 = mhlo.xor %205, %206 : tensor<64xui32>
      %208 = mhlo.constant dense<1784170518> : tensor<ui32>
      %209 = "mhlo.broadcast_in_dim"(%208) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %210 = mhlo.xor %207, %209 : tensor<64xui32>
      %211 = "mhlo.convert"(%210) : (tensor<64xui32>) -> tensor<64xui64>
      %212 = mhlo.multiply %211, %97 : tensor<64xui64>
      %213 = "mhlo.convert"(%212) : (tensor<64xui64>) -> tensor<64xui32>
      %214 = mhlo.xor %203, %213 : tensor<64xui32>
      %215 = mhlo.constant dense<3261740811> : tensor<ui32>
      %216 = "mhlo.broadcast_in_dim"(%215) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %217 = mhlo.xor %214, %216 : tensor<64xui32>
      %218 = "mhlo.convert"(%217) : (tensor<64xui32>) -> tensor<64xui64>
      %219 = mhlo.multiply %218, %69 : tensor<64xui64>
      %220 = mhlo.shift_right_logical %219, %71 : tensor<64xui64>
      %221 = "mhlo.convert"(%220) : (tensor<64xui64>) -> tensor<64xui32>
      %222 = mhlo.shift_right_logical %212, %71 : tensor<64xui64>
      %223 = "mhlo.convert"(%222) : (tensor<64xui64>) -> tensor<64xui32>
      %224 = "mhlo.convert"(%165) : (tensor<64xui64>) -> tensor<64xui32>
      %225 = mhlo.xor %223, %224 : tensor<64xui32>
      %226 = mhlo.constant dense<607305042> : tensor<ui32>
      %227 = "mhlo.broadcast_in_dim"(%226) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %228 = mhlo.xor %225, %227 : tensor<64xui32>
      %229 = "mhlo.convert"(%228) : (tensor<64xui32>) -> tensor<64xui64>
      %230 = mhlo.multiply %229, %69 : tensor<64xui64>
      %231 = "mhlo.convert"(%230) : (tensor<64xui64>) -> tensor<64xui32>
      %232 = mhlo.xor %221, %231 : tensor<64xui32>
      %233 = mhlo.constant dense<2626638757> : tensor<ui32>
      %234 = "mhlo.broadcast_in_dim"(%233) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %235 = mhlo.xor %232, %234 : tensor<64xui32>
      %236 = "mhlo.convert"(%235) : (tensor<64xui32>) -> tensor<64xui64>
      %237 = mhlo.multiply %236, %97 : tensor<64xui64>
      %238 = mhlo.shift_right_logical %237, %71 : tensor<64xui64>
      %239 = "mhlo.convert"(%238) : (tensor<64xui64>) -> tensor<64xui32>
      %240 = mhlo.shift_right_logical %230, %71 : tensor<64xui64>
      %241 = "mhlo.convert"(%240) : (tensor<64xui64>) -> tensor<64xui32>
      %242 = "mhlo.convert"(%183) : (tensor<64xui64>) -> tensor<64xui32>
      %243 = mhlo.xor %241, %242 : tensor<64xui32>
      %244 = mhlo.constant dense<3777471776> : tensor<ui32>
      %245 = "mhlo.broadcast_in_dim"(%244) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %246 = mhlo.xor %243, %245 : tensor<64xui32>
      %247 = "mhlo.convert"(%246) : (tensor<64xui32>) -> tensor<64xui64>
      %248 = mhlo.multiply %247, %97 : tensor<64xui64>
      %249 = "mhlo.convert"(%248) : (tensor<64xui64>) -> tensor<64xui32>
      %250 = mhlo.xor %239, %249 : tensor<64xui32>
      %251 = mhlo.constant dense<4275645053> : tensor<ui32>
      %252 = "mhlo.broadcast_in_dim"(%251) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %253 = mhlo.xor %250, %252 : tensor<64xui32>
      %254 = "mhlo.bitcast"(%253) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<64xui32>) -> tensor<64x1xui32>
      %255 = "mhlo.convert"(%237) : (tensor<64xui64>) -> tensor<64xui32>
      %256 = "mhlo.bitcast"(%255) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<64xui32>) -> tensor<64x1xui32>
      %257 = mhlo.shift_right_logical %248, %71 : tensor<64xui64>
      %258 = "mhlo.convert"(%257) : (tensor<64xui64>) -> tensor<64xui32>
      %259 = "mhlo.convert"(%201) : (tensor<64xui64>) -> tensor<64xui32>
      %260 = mhlo.xor %258, %259 : tensor<64xui32>
      %261 = mhlo.constant dense<1621209284> : tensor<ui32>
      %262 = "mhlo.broadcast_in_dim"(%261) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %263 = mhlo.xor %260, %262 : tensor<64xui32>
      %264 = "mhlo.convert"(%263) : (tensor<64xui32>) -> tensor<64xui64>
      %265 = mhlo.multiply %264, %69 : tensor<64xui64>
      %266 = mhlo.shift_right_logical %265, %71 : tensor<64xui64>
      %267 = "mhlo.convert"(%266) : (tensor<64xui64>) -> tensor<64xui32>
      %268 = "mhlo.convert"(%219) : (tensor<64xui64>) -> tensor<64xui32>
      %269 = mhlo.xor %267, %268 : tensor<64xui32>
      %270 = mhlo.constant dense<1475805738> : tensor<ui32>
      %271 = "mhlo.broadcast_in_dim"(%270) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64xui32>
      %272 = mhlo.xor %269, %271 : tensor<64xui32>
      %273 = "mhlo.bitcast"(%272) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<64xui32>) -> tensor<64x1xui32>
      %274 = "mhlo.convert"(%265) : (tensor<64xui64>) -> tensor<64xui32>
      %275 = "mhlo.bitcast"(%274) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<64xui32>) -> tensor<64x1xui32>
      %276 = "mhlo.concatenate"(%254, %256, %273, %275) {dimension = 1 : i64} : (tensor<64x1xui32>, tensor<64x1xui32>, tensor<64x1xui32>, tensor<64x1xui32>) -> tensor<64x4xui32>
      %277 = mhlo.constant dense<9> : tensor<ui32>
      %278 = "mhlo.broadcast_in_dim"(%277) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<64x4xui32>
      %279 = mhlo.shift_right_logical %276, %278 : tensor<64x4xui32>
      %280 = "mhlo.convert"(%279) : (tensor<64x4xui32>) -> tensor<64x4xf32>
      %281 = mhlo.constant dense<-4.000000e+00> : tensor<f32>
      %282 = mhlo.constant dense<0.707106769> : tensor<f32>
      %283 = mhlo.multiply %9, %282 : tensor<f32>
      %284 = mhlo.constant dense<4.000000e+00> : tensor<f32>
      %285 = "mhlo.clamp"(%281, %283, %284) : (tensor<f32>, tensor<f32>, tensor<f32>) -> tensor<f32>
      %286 = mhlo.multiply %285, %285 : tensor<f32>
      %287 = mhlo.constant dense<0.000000e+00> : tensor<f32>
      %288 = mhlo.multiply %286, %287 : tensor<f32>
      %289 = mhlo.constant dense<-2.72614237E-10> : tensor<f32>
      %290 = mhlo.add %288, %289 : tensor<f32>
      %291 = mhlo.multiply %290, %286 : tensor<f32>
      %292 = mhlo.constant dense<2.77068146E-8> : tensor<f32>
      %293 = mhlo.add %291, %292 : tensor<f32>
      %294 = mhlo.multiply %293, %286 : tensor<f32>
      %295 = mhlo.constant dense<-2.10102394E-6> : tensor<f32>
      %296 = mhlo.add %294, %295 : tensor<f32>
      %297 = mhlo.multiply %296, %286 : tensor<f32>
      %298 = mhlo.constant dense<-5.69250624E-5> : tensor<f32>
      %299 = mhlo.add %297, %298 : tensor<f32>
      %300 = mhlo.multiply %299, %286 : tensor<f32>
      %301 = mhlo.constant dense<-7.34990637E-4> : tensor<f32>
      %302 = mhlo.add %300, %301 : tensor<f32>
      %303 = mhlo.multiply %302, %286 : tensor<f32>
      %304 = mhlo.constant dense<-2.954600e-03> : tensor<f32>
      %305 = mhlo.add %303, %304 : tensor<f32>
      %306 = mhlo.multiply %305, %286 : tensor<f32>
      %307 = mhlo.constant dense<-0.0160960332> : tensor<f32>
      %308 = mhlo.add %306, %307 : tensor<f32>
      %309 = mhlo.multiply %285, %308 : tensor<f32>
      %310 = mhlo.constant dense<-1.45660715E-5> : tensor<f32>
      %311 = mhlo.add %288, %310 : tensor<f32>
      %312 = mhlo.multiply %311, %286 : tensor<f32>
      %313 = mhlo.constant dense<-2.13374049E-4> : tensor<f32>
      %314 = mhlo.add %312, %313 : tensor<f32>
      %315 = mhlo.multiply %314, %286 : tensor<f32>
      %316 = mhlo.constant dense<-0.00168282702> : tensor<f32>
      %317 = mhlo.add %315, %316 : tensor<f32>
      %318 = mhlo.multiply %317, %286 : tensor<f32>
      %319 = mhlo.constant dense<-0.00737332925> : tensor<f32>
      %320 = mhlo.add %318, %319 : tensor<f32>
      %321 = mhlo.multiply %320, %286 : tensor<f32>
      %322 = mhlo.constant dense<-0.0142647391> : tensor<f32>
      %323 = mhlo.add %321, %322 : tensor<f32>
      %324 = mhlo.divide %309, %323 : tensor<f32>
      %325 = mhlo.multiply %36, %282 : tensor<f32>
      %326 = "mhlo.clamp"(%281, %325, %284) : (tensor<f32>, tensor<f32>, tensor<f32>) -> tensor<f32>
      %327 = mhlo.multiply %326, %326 : tensor<f32>
      %328 = mhlo.multiply %327, %287 : tensor<f32>
      %329 = mhlo.add %328, %289 : tensor<f32>
      %330 = mhlo.multiply %329, %327 : tensor<f32>
      %331 = mhlo.add %330, %292 : tensor<f32>
      %332 = mhlo.multiply %331, %327 : tensor<f32>
      %333 = mhlo.add %332, %295 : tensor<f32>
      %334 = mhlo.multiply %333, %327 : tensor<f32>
      %335 = mhlo.add %334, %298 : tensor<f32>
      %336 = mhlo.multiply %335, %327 : tensor<f32>
      %337 = mhlo.add %336, %301 : tensor<f32>
      %338 = mhlo.multiply %337, %327 : tensor<f32>
      %339 = mhlo.add %338, %304 : tensor<f32>
      %340 = mhlo.multiply %339, %327 : tensor<f32>
      %341 = mhlo.add %340, %307 : tensor<f32>
      %342 = mhlo.multiply %326, %341 : tensor<f32>
      %343 = mhlo.add %328, %310 : tensor<f32>
      %344 = mhlo.multiply %343, %327 : tensor<f32>
      %345 = mhlo.add %344, %313 : tensor<f32>
      %346 = mhlo.multiply %345, %327 : tensor<f32>
      %347 = mhlo.add %346, %316 : tensor<f32>
      %348 = mhlo.multiply %347, %327 : tensor<f32>
      %349 = mhlo.add %348, %319 : tensor<f32>
      %350 = mhlo.multiply %349, %327 : tensor<f32>
      %351 = mhlo.add %350, %322 : tensor<f32>
      %352 = mhlo.divide %342, %351 : tensor<f32>
      %353 = mhlo.subtract %324, %352 : tensor<f32>
      %354 = mhlo.constant dense<1.1920929E-7> : tensor<f32>
      %355 = mhlo.multiply %353, %354 : tensor<f32>
      %356 = "mhlo.broadcast_in_dim"(%355) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<64x4xf32>
      %357 = mhlo.multiply %280, %356 : tensor<64x4xf32>
      %358 = "mhlo.broadcast_in_dim"(%352) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<64x4xf32>
      %359 = mhlo.add %357, %358 : tensor<64x4xf32>
      %360 = "mhlo.bitcast"(%359) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<[1, 0]> : tensor<2xindex>} : (tensor<64x4xf32>) -> tensor<16x16xf32>
      %361 = "mhlo.abs"(%360) : (tensor<16x16xf32>) -> tensor<16x16xf32>
      %362 = mhlo.constant dense<1.000000e+00> : tensor<f32>
      %363 = "mhlo.broadcast_in_dim"(%362) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %364 = "mhlo.compare"(%361, %363) {comparison_direction = #mhlo<"comparison_direction EQ">} : (tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xi1>
      %365 = "mhlo.broadcast_in_dim"(%38) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %366 = mhlo.multiply %360, %365 : tensor<16x16xf32>
      %367 = "mhlo.negate"(%360) : (tensor<16x16xf32>) -> tensor<16x16xf32>
      %368 = mhlo.multiply %367, %360 : tensor<16x16xf32>
      %369 = "mhlo.log_plus_one"(%368) : (tensor<16x16xf32>) -> tensor<16x16xf32>
      %370 = "mhlo.negate"(%369) : (tensor<16x16xf32>) -> tensor<16x16xf32>
      %371 = mhlo.constant dense<5.000000e+00> : tensor<f32>
      %372 = "mhlo.broadcast_in_dim"(%371) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %373 = "mhlo.compare"(%370, %372) {comparison_direction = #mhlo<"comparison_direction LT">} : (tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xi1>
      %374 = mhlo.constant dense<1.50140941> : tensor<f32>
      %375 = "mhlo.broadcast_in_dim"(%374) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %376 = mhlo.constant dense<2.83297682> : tensor<f32>
      %377 = "mhlo.broadcast_in_dim"(%376) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %378 = "mhlo.select"(%373, %375, %377) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %379 = mhlo.constant dense<0.246640727> : tensor<f32>
      %380 = "mhlo.broadcast_in_dim"(%379) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %381 = mhlo.constant dense<1.00167406> : tensor<f32>
      %382 = "mhlo.broadcast_in_dim"(%381) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %383 = "mhlo.select"(%373, %380, %382) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %384 = mhlo.constant dense<-0.00417768164> : tensor<f32>
      %385 = "mhlo.broadcast_in_dim"(%384) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %386 = mhlo.constant dense<0.00943887047> : tensor<f32>
      %387 = "mhlo.broadcast_in_dim"(%386) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %388 = "mhlo.select"(%373, %385, %387) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %389 = mhlo.constant dense<-0.00125372503> : tensor<f32>
      %390 = "mhlo.broadcast_in_dim"(%389) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %391 = mhlo.constant dense<-0.0076224613> : tensor<f32>
      %392 = "mhlo.broadcast_in_dim"(%391) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %393 = "mhlo.select"(%373, %390, %392) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %394 = mhlo.constant dense<2.1858087E-4> : tensor<f32>
      %395 = "mhlo.broadcast_in_dim"(%394) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %396 = mhlo.constant dense<0.00573950773> : tensor<f32>
      %397 = "mhlo.broadcast_in_dim"(%396) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %398 = "mhlo.select"(%373, %395, %397) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %399 = mhlo.constant dense<-4.39150654E-6> : tensor<f32>
      %400 = "mhlo.broadcast_in_dim"(%399) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %401 = mhlo.constant dense<-0.00367342844> : tensor<f32>
      %402 = "mhlo.broadcast_in_dim"(%401) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %403 = "mhlo.select"(%373, %400, %402) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %404 = mhlo.constant dense<-3.5233877E-6> : tensor<f32>
      %405 = "mhlo.broadcast_in_dim"(%404) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %406 = mhlo.constant dense<0.00134934322> : tensor<f32>
      %407 = "mhlo.broadcast_in_dim"(%406) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %408 = "mhlo.select"(%373, %405, %407) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %409 = mhlo.constant dense<3.43273939E-7> : tensor<f32>
      %410 = "mhlo.broadcast_in_dim"(%409) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %411 = mhlo.constant dense<1.00950558E-4> : tensor<f32>
      %412 = "mhlo.broadcast_in_dim"(%411) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %413 = "mhlo.select"(%373, %410, %412) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %414 = mhlo.constant dense<2.81022636E-8> : tensor<f32>
      %415 = "mhlo.broadcast_in_dim"(%414) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %416 = mhlo.constant dense<-2.00214257E-4> : tensor<f32>
      %417 = "mhlo.broadcast_in_dim"(%416) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %418 = "mhlo.select"(%373, %415, %417) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %419 = mhlo.constant dense<-2.500000e+00> : tensor<f32>
      %420 = "mhlo.broadcast_in_dim"(%419) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %421 = mhlo.add %370, %420 : tensor<16x16xf32>
      %422 = "mhlo.sqrt"(%370) : (tensor<16x16xf32>) -> tensor<16x16xf32>
      %423 = mhlo.constant dense<-3.000000e+00> : tensor<f32>
      %424 = "mhlo.broadcast_in_dim"(%423) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %425 = mhlo.add %422, %424 : tensor<16x16xf32>
      %426 = "mhlo.select"(%373, %421, %425) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %427 = mhlo.multiply %418, %426 : tensor<16x16xf32>
      %428 = mhlo.add %413, %427 : tensor<16x16xf32>
      %429 = mhlo.multiply %428, %426 : tensor<16x16xf32>
      %430 = mhlo.add %408, %429 : tensor<16x16xf32>
      %431 = mhlo.multiply %430, %426 : tensor<16x16xf32>
      %432 = mhlo.add %403, %431 : tensor<16x16xf32>
      %433 = mhlo.multiply %432, %426 : tensor<16x16xf32>
      %434 = mhlo.add %398, %433 : tensor<16x16xf32>
      %435 = mhlo.multiply %434, %426 : tensor<16x16xf32>
      %436 = mhlo.add %393, %435 : tensor<16x16xf32>
      %437 = mhlo.multiply %436, %426 : tensor<16x16xf32>
      %438 = mhlo.add %388, %437 : tensor<16x16xf32>
      %439 = mhlo.multiply %438, %426 : tensor<16x16xf32>
      %440 = mhlo.add %383, %439 : tensor<16x16xf32>
      %441 = mhlo.multiply %440, %426 : tensor<16x16xf32>
      %442 = mhlo.add %378, %441 : tensor<16x16xf32>
      %443 = mhlo.multiply %442, %360 : tensor<16x16xf32>
      %444 = "mhlo.select"(%364, %366, %443) : (tensor<16x16xi1>, tensor<16x16xf32>, tensor<16x16xf32>) -> tensor<16x16xf32>
      %445 = mhlo.constant dense<1.41421354> : tensor<f32>
      %446 = "mhlo.broadcast_in_dim"(%445) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %447 = mhlo.multiply %444, %446 : tensor<16x16xf32>
      %448 = mhlo.maximum %53, %447 : tensor<16x16xf32>
      %449 = mhlo.minimum %35, %448 : tensor<16x16xf32>
      memref.tensor_store %449, %4 : memref<16x16xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}