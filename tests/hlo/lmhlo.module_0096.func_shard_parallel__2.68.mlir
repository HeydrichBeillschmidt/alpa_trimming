module attributes {hlo.unique_id = 96 : i32, mhlo.unique_id = 96 : i64} {
  memref.global "private" constant @buffer_for_constant_5 : memref<i32> = dense<1> {lmhlo.alloc = 7 : index}
  memref.global "private" constant @buffer_for_constant_3 : memref<ui64> = dense<32> {lmhlo.alloc = 6 : index}
  func @func_shard_parallel__2.68_spmd(%arg0: memref<4xi8> {lmhlo.output_index = dense<0> : tensor<1xi64>, lmhlo.params = 0 : index}, %arg1: memref<1024xi8> {lmhlo.output_index = dense<1> : tensor<1xi64>, lmhlo.params = 1 : index}, %arg2: memref<1024xi8> {lmhlo.output_index = dense<2> : tensor<1xi64>, lmhlo.params = 2 : index}, %arg3: memref<16384xi8> {lmhlo.params = 3 : index}, %arg4: memref<16384xi8> {lmhlo.params = 4 : index}, %arg5: memref<8xi8> {lmhlo.params = 5 : index}, %arg6: memref<8xi8> {lmhlo.constant_name = "buffer_for_constant_3"}, %arg7: memref<4xi8> {lmhlo.constant_name = "buffer_for_constant_5"}, %arg8: memref<50320xi8>) attributes {result_xla_shape = "(s32[], f32[16,16]{1,0}, f32[16,16]{1,0})"} {
    %c0 = arith.constant 0 : index
    %0 = memref.view %arg3[%c0][] : memref<16384xi8> to memref<256x16xf32>
    %c0_0 = arith.constant 0 : index
    %1 = memref.view %arg1[%c0_0][] : memref<1024xi8> to memref<16x16xf32>
    %c0_1 = arith.constant 0 : index
    %2 = memref.view %arg8[%c0_1][] : memref<50320xi8> to memref<256x16xf32>
    "lmhlo_gpu.gemm"(%0, %1, %2) {algorithm = 2 : i64, alpha_imag = 0.000000e+00 : f64, alpha_real = 1.1111111640930176 : f64, batch_size = 1 : i64, dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [1], rhs_contracting_dimensions = [0]>, lhs_stride = 4096 : i64, rhs_stride = 256 : i64} : (memref<256x16xf32>, memref<16x16xf32>, memref<256x16xf32>) -> ()
    %c50176 = arith.constant 50176 : index
    %3 = memref.view %arg8[%c50176][] : memref<50320xi8> to memref<2xui64>
    "lmhlo.rng_get_and_update_state"(%3) {delta = 4096 : i64} : (memref<2xui64>) -> ()
    %4 = memref.get_global @buffer_for_constant_3 : memref<ui64>
    %c16384 = arith.constant 16384 : index
    %5 = memref.view %arg8[%c16384][] : memref<50320xi8> to memref<256x16xf32>
    "lmhlo.fusion"() ({
      %31 = bufferization.to_tensor %2 : memref<256x16xf32>
      %32 = bufferization.to_tensor %4 : memref<ui64>
      %33 = bufferization.to_tensor %3 : memref<2xui64>
      %34 = "mhlo.slice"(%33) {limit_indices = dense<1> : tensor<1xi64>, start_indices = dense<0> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<2xui64>) -> tensor<1xui64>
      %35 = "mhlo.bitcast"(%34) {result_layout = dense<> : tensor<0xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1xui64>) -> tensor<ui64>
      %36 = "mhlo.convert"(%35) : (tensor<ui64>) -> tensor<ui32>
      %37 = "mhlo.convert"(%36) : (tensor<ui32>) -> tensor<ui64>
      %38 = mhlo.shift_right_logical %35, %32 : tensor<ui64>
      %39 = "mhlo.convert"(%38) : (tensor<ui64>) -> tensor<ui32>
      %40 = "mhlo.convert"(%39) : (tensor<ui32>) -> tensor<ui64>
      %41 = mhlo.shift_left %40, %32 : tensor<ui64>
      %42 = mhlo.or %37, %41 : tensor<ui64>
      %43 = "mhlo.broadcast_in_dim"(%42) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<1024xui64>
      %44 = "mhlo.iota"() {iota_dimension = 0 : i64} : () -> tensor<1024xui64>
      %45 = mhlo.add %43, %44 : tensor<1024xui64>
      %46 = "mhlo.convert"(%45) : (tensor<1024xui64>) -> tensor<1024xui32>
      %47 = "mhlo.convert"(%46) : (tensor<1024xui32>) -> tensor<1024xui64>
      %48 = mhlo.constant dense<3528531795> : tensor<ui64>
      %49 = "mhlo.broadcast_in_dim"(%48) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<1024xui64>
      %50 = mhlo.multiply %47, %49 : tensor<1024xui64>
      %51 = "mhlo.broadcast_in_dim"(%32) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<1024xui64>
      %52 = mhlo.shift_right_logical %50, %51 : tensor<1024xui64>
      %53 = "mhlo.convert"(%52) : (tensor<1024xui64>) -> tensor<1024xui32>
      %54 = "mhlo.compare"(%45, %43) {comparison_direction = #mhlo<"comparison_direction LT">} : (tensor<1024xui64>, tensor<1024xui64>) -> tensor<1024xi1>
      %55 = "mhlo.slice"(%33) {limit_indices = dense<2> : tensor<1xi64>, start_indices = dense<1> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<2xui64>) -> tensor<1xui64>
      %56 = "mhlo.bitcast"(%55) {result_layout = dense<> : tensor<0xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1xui64>) -> tensor<ui64>
      %57 = "mhlo.convert"(%56) : (tensor<ui64>) -> tensor<ui32>
      %58 = "mhlo.convert"(%57) : (tensor<ui32>) -> tensor<ui64>
      %59 = mhlo.shift_right_logical %56, %32 : tensor<ui64>
      %60 = "mhlo.convert"(%59) : (tensor<ui64>) -> tensor<ui32>
      %61 = "mhlo.convert"(%60) : (tensor<ui32>) -> tensor<ui64>
      %62 = mhlo.shift_left %61, %32 : tensor<ui64>
      %63 = mhlo.or %58, %62 : tensor<ui64>
      %64 = mhlo.constant dense<1> : tensor<ui64>
      %65 = mhlo.add %63, %64 : tensor<ui64>
      %66 = "mhlo.broadcast_in_dim"(%65) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<1024xui64>
      %67 = "mhlo.broadcast_in_dim"(%63) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<1024xui64>
      %68 = "mhlo.select"(%54, %66, %67) : (tensor<1024xi1>, tensor<1024xui64>, tensor<1024xui64>) -> tensor<1024xui64>
      %69 = mhlo.shift_right_logical %68, %51 : tensor<1024xui64>
      %70 = "mhlo.convert"(%69) : (tensor<1024xui64>) -> tensor<1024xui32>
      %71 = mhlo.xor %53, %70 : tensor<1024xui32>
      %72 = mhlo.constant dense<3243368317> : tensor<ui32>
      %73 = "mhlo.broadcast_in_dim"(%72) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %74 = mhlo.xor %71, %73 : tensor<1024xui32>
      %75 = "mhlo.convert"(%74) : (tensor<1024xui32>) -> tensor<1024xui64>
      %76 = mhlo.constant dense<3449720151> : tensor<ui64>
      %77 = "mhlo.broadcast_in_dim"(%76) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<1024xui64>
      %78 = mhlo.multiply %75, %77 : tensor<1024xui64>
      %79 = mhlo.shift_right_logical %78, %51 : tensor<1024xui64>
      %80 = "mhlo.convert"(%79) : (tensor<1024xui64>) -> tensor<1024xui32>
      %81 = "mhlo.convert"(%68) : (tensor<1024xui64>) -> tensor<1024xui32>
      %82 = "mhlo.convert"(%81) : (tensor<1024xui32>) -> tensor<1024xui64>
      %83 = mhlo.multiply %82, %77 : tensor<1024xui64>
      %84 = "mhlo.convert"(%83) : (tensor<1024xui64>) -> tensor<1024xui32>
      %85 = mhlo.xor %80, %84 : tensor<1024xui32>
      %86 = mhlo.constant dense<220028085> : tensor<ui32>
      %87 = "mhlo.broadcast_in_dim"(%86) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %88 = mhlo.xor %85, %87 : tensor<1024xui32>
      %89 = "mhlo.convert"(%88) : (tensor<1024xui32>) -> tensor<1024xui64>
      %90 = mhlo.multiply %89, %49 : tensor<1024xui64>
      %91 = mhlo.shift_right_logical %90, %51 : tensor<1024xui64>
      %92 = "mhlo.convert"(%91) : (tensor<1024xui64>) -> tensor<1024xui32>
      %93 = mhlo.shift_right_logical %83, %51 : tensor<1024xui64>
      %94 = "mhlo.convert"(%93) : (tensor<1024xui64>) -> tensor<1024xui32>
      %95 = mhlo.shift_right_logical %45, %51 : tensor<1024xui64>
      %96 = "mhlo.convert"(%95) : (tensor<1024xui64>) -> tensor<1024xui32>
      %97 = mhlo.xor %94, %96 : tensor<1024xui32>
      %98 = mhlo.constant dense<1860559612> : tensor<ui32>
      %99 = "mhlo.broadcast_in_dim"(%98) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %100 = mhlo.xor %97, %99 : tensor<1024xui32>
      %101 = "mhlo.convert"(%100) : (tensor<1024xui32>) -> tensor<1024xui64>
      %102 = mhlo.multiply %101, %49 : tensor<1024xui64>
      %103 = "mhlo.convert"(%102) : (tensor<1024xui64>) -> tensor<1024xui32>
      %104 = mhlo.xor %92, %103 : tensor<1024xui32>
      %105 = mhlo.constant dense<941702279> : tensor<ui32>
      %106 = "mhlo.broadcast_in_dim"(%105) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %107 = mhlo.xor %104, %106 : tensor<1024xui32>
      %108 = "mhlo.convert"(%107) : (tensor<1024xui32>) -> tensor<1024xui64>
      %109 = mhlo.multiply %108, %77 : tensor<1024xui64>
      %110 = mhlo.shift_right_logical %109, %51 : tensor<1024xui64>
      %111 = "mhlo.convert"(%110) : (tensor<1024xui64>) -> tensor<1024xui32>
      %112 = mhlo.shift_right_logical %102, %51 : tensor<1024xui64>
      %113 = "mhlo.convert"(%112) : (tensor<1024xui64>) -> tensor<1024xui32>
      %114 = "mhlo.convert"(%50) : (tensor<1024xui64>) -> tensor<1024xui32>
      %115 = mhlo.xor %113, %114 : tensor<1024xui32>
      %116 = mhlo.constant dense<2092535298> : tensor<ui32>
      %117 = "mhlo.broadcast_in_dim"(%116) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %118 = mhlo.xor %115, %117 : tensor<1024xui32>
      %119 = "mhlo.convert"(%118) : (tensor<1024xui32>) -> tensor<1024xui64>
      %120 = mhlo.multiply %119, %77 : tensor<1024xui64>
      %121 = "mhlo.convert"(%120) : (tensor<1024xui64>) -> tensor<1024xui32>
      %122 = mhlo.xor %111, %121 : tensor<1024xui32>
      %123 = mhlo.constant dense<1233932327> : tensor<ui32>
      %124 = "mhlo.broadcast_in_dim"(%123) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %125 = mhlo.xor %122, %124 : tensor<1024xui32>
      %126 = "mhlo.convert"(%125) : (tensor<1024xui32>) -> tensor<1024xui64>
      %127 = mhlo.multiply %126, %49 : tensor<1024xui64>
      %128 = mhlo.shift_right_logical %127, %51 : tensor<1024xui64>
      %129 = "mhlo.convert"(%128) : (tensor<1024xui64>) -> tensor<1024xui32>
      %130 = mhlo.shift_right_logical %120, %51 : tensor<1024xui64>
      %131 = "mhlo.convert"(%130) : (tensor<1024xui64>) -> tensor<1024xui32>
      %132 = "mhlo.convert"(%78) : (tensor<1024xui64>) -> tensor<1024xui32>
      %133 = mhlo.xor %131, %132 : tensor<1024xui32>
      %134 = mhlo.constant dense<2874463854> : tensor<ui32>
      %135 = "mhlo.broadcast_in_dim"(%134) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %136 = mhlo.xor %133, %135 : tensor<1024xui32>
      %137 = "mhlo.convert"(%136) : (tensor<1024xui32>) -> tensor<1024xui64>
      %138 = mhlo.multiply %137, %49 : tensor<1024xui64>
      %139 = "mhlo.convert"(%138) : (tensor<1024xui64>) -> tensor<1024xui32>
      %140 = mhlo.xor %129, %139 : tensor<1024xui32>
      %141 = mhlo.constant dense<2935003537> : tensor<ui32>
      %142 = "mhlo.broadcast_in_dim"(%141) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %143 = mhlo.xor %140, %142 : tensor<1024xui32>
      %144 = "mhlo.convert"(%143) : (tensor<1024xui32>) -> tensor<1024xui64>
      %145 = mhlo.multiply %144, %77 : tensor<1024xui64>
      %146 = mhlo.shift_right_logical %145, %51 : tensor<1024xui64>
      %147 = "mhlo.convert"(%146) : (tensor<1024xui64>) -> tensor<1024xui32>
      %148 = mhlo.shift_right_logical %138, %51 : tensor<1024xui64>
      %149 = "mhlo.convert"(%148) : (tensor<1024xui64>) -> tensor<1024xui32>
      %150 = "mhlo.convert"(%90) : (tensor<1024xui64>) -> tensor<1024xui32>
      %151 = mhlo.xor %149, %150 : tensor<1024xui32>
      %152 = mhlo.constant dense<4085836556> : tensor<ui32>
      %153 = "mhlo.broadcast_in_dim"(%152) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %154 = mhlo.xor %151, %153 : tensor<1024xui32>
      %155 = "mhlo.convert"(%154) : (tensor<1024xui32>) -> tensor<1024xui64>
      %156 = mhlo.multiply %155, %77 : tensor<1024xui64>
      %157 = "mhlo.convert"(%156) : (tensor<1024xui64>) -> tensor<1024xui32>
      %158 = mhlo.xor %147, %157 : tensor<1024xui32>
      %159 = mhlo.constant dense<2247836569> : tensor<ui32>
      %160 = "mhlo.broadcast_in_dim"(%159) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %161 = mhlo.xor %158, %160 : tensor<1024xui32>
      %162 = "mhlo.convert"(%161) : (tensor<1024xui32>) -> tensor<1024xui64>
      %163 = mhlo.multiply %162, %49 : tensor<1024xui64>
      %164 = mhlo.shift_right_logical %163, %51 : tensor<1024xui64>
      %165 = "mhlo.convert"(%164) : (tensor<1024xui64>) -> tensor<1024xui32>
      %166 = mhlo.shift_right_logical %156, %51 : tensor<1024xui64>
      %167 = "mhlo.convert"(%166) : (tensor<1024xui64>) -> tensor<1024xui32>
      %168 = "mhlo.convert"(%109) : (tensor<1024xui64>) -> tensor<1024xui32>
      %169 = mhlo.xor %167, %168 : tensor<1024xui32>
      %170 = mhlo.constant dense<3888368096> : tensor<ui32>
      %171 = "mhlo.broadcast_in_dim"(%170) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %172 = mhlo.xor %169, %171 : tensor<1024xui32>
      %173 = "mhlo.convert"(%172) : (tensor<1024xui32>) -> tensor<1024xui64>
      %174 = mhlo.multiply %173, %49 : tensor<1024xui64>
      %175 = "mhlo.convert"(%174) : (tensor<1024xui64>) -> tensor<1024xui32>
      %176 = mhlo.xor %165, %175 : tensor<1024xui32>
      %177 = mhlo.constant dense<633337499> : tensor<ui32>
      %178 = "mhlo.broadcast_in_dim"(%177) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %179 = mhlo.xor %176, %178 : tensor<1024xui32>
      %180 = "mhlo.convert"(%179) : (tensor<1024xui32>) -> tensor<1024xui64>
      %181 = mhlo.multiply %180, %77 : tensor<1024xui64>
      %182 = mhlo.shift_right_logical %181, %51 : tensor<1024xui64>
      %183 = "mhlo.convert"(%182) : (tensor<1024xui64>) -> tensor<1024xui32>
      %184 = mhlo.shift_right_logical %174, %51 : tensor<1024xui64>
      %185 = "mhlo.convert"(%184) : (tensor<1024xui64>) -> tensor<1024xui32>
      %186 = "mhlo.convert"(%127) : (tensor<1024xui64>) -> tensor<1024xui32>
      %187 = mhlo.xor %185, %186 : tensor<1024xui32>
      %188 = mhlo.constant dense<1784170518> : tensor<ui32>
      %189 = "mhlo.broadcast_in_dim"(%188) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %190 = mhlo.xor %187, %189 : tensor<1024xui32>
      %191 = "mhlo.convert"(%190) : (tensor<1024xui32>) -> tensor<1024xui64>
      %192 = mhlo.multiply %191, %77 : tensor<1024xui64>
      %193 = "mhlo.convert"(%192) : (tensor<1024xui64>) -> tensor<1024xui32>
      %194 = mhlo.xor %183, %193 : tensor<1024xui32>
      %195 = mhlo.constant dense<3261740811> : tensor<ui32>
      %196 = "mhlo.broadcast_in_dim"(%195) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %197 = mhlo.xor %194, %196 : tensor<1024xui32>
      %198 = "mhlo.convert"(%197) : (tensor<1024xui32>) -> tensor<1024xui64>
      %199 = mhlo.multiply %198, %49 : tensor<1024xui64>
      %200 = mhlo.shift_right_logical %199, %51 : tensor<1024xui64>
      %201 = "mhlo.convert"(%200) : (tensor<1024xui64>) -> tensor<1024xui32>
      %202 = mhlo.shift_right_logical %192, %51 : tensor<1024xui64>
      %203 = "mhlo.convert"(%202) : (tensor<1024xui64>) -> tensor<1024xui32>
      %204 = "mhlo.convert"(%145) : (tensor<1024xui64>) -> tensor<1024xui32>
      %205 = mhlo.xor %203, %204 : tensor<1024xui32>
      %206 = mhlo.constant dense<607305042> : tensor<ui32>
      %207 = "mhlo.broadcast_in_dim"(%206) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %208 = mhlo.xor %205, %207 : tensor<1024xui32>
      %209 = "mhlo.convert"(%208) : (tensor<1024xui32>) -> tensor<1024xui64>
      %210 = mhlo.multiply %209, %49 : tensor<1024xui64>
      %211 = "mhlo.convert"(%210) : (tensor<1024xui64>) -> tensor<1024xui32>
      %212 = mhlo.xor %201, %211 : tensor<1024xui32>
      %213 = mhlo.constant dense<2626638757> : tensor<ui32>
      %214 = "mhlo.broadcast_in_dim"(%213) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %215 = mhlo.xor %212, %214 : tensor<1024xui32>
      %216 = "mhlo.convert"(%215) : (tensor<1024xui32>) -> tensor<1024xui64>
      %217 = mhlo.multiply %216, %77 : tensor<1024xui64>
      %218 = mhlo.shift_right_logical %217, %51 : tensor<1024xui64>
      %219 = "mhlo.convert"(%218) : (tensor<1024xui64>) -> tensor<1024xui32>
      %220 = mhlo.shift_right_logical %210, %51 : tensor<1024xui64>
      %221 = "mhlo.convert"(%220) : (tensor<1024xui64>) -> tensor<1024xui32>
      %222 = "mhlo.convert"(%163) : (tensor<1024xui64>) -> tensor<1024xui32>
      %223 = mhlo.xor %221, %222 : tensor<1024xui32>
      %224 = mhlo.constant dense<3777471776> : tensor<ui32>
      %225 = "mhlo.broadcast_in_dim"(%224) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %226 = mhlo.xor %223, %225 : tensor<1024xui32>
      %227 = "mhlo.convert"(%226) : (tensor<1024xui32>) -> tensor<1024xui64>
      %228 = mhlo.multiply %227, %77 : tensor<1024xui64>
      %229 = "mhlo.convert"(%228) : (tensor<1024xui64>) -> tensor<1024xui32>
      %230 = mhlo.xor %219, %229 : tensor<1024xui32>
      %231 = mhlo.constant dense<4275645053> : tensor<ui32>
      %232 = "mhlo.broadcast_in_dim"(%231) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %233 = mhlo.xor %230, %232 : tensor<1024xui32>
      %234 = "mhlo.bitcast"(%233) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1024xui32>) -> tensor<1024x1xui32>
      %235 = "mhlo.convert"(%217) : (tensor<1024xui64>) -> tensor<1024xui32>
      %236 = "mhlo.bitcast"(%235) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1024xui32>) -> tensor<1024x1xui32>
      %237 = mhlo.shift_right_logical %228, %51 : tensor<1024xui64>
      %238 = "mhlo.convert"(%237) : (tensor<1024xui64>) -> tensor<1024xui32>
      %239 = "mhlo.convert"(%181) : (tensor<1024xui64>) -> tensor<1024xui32>
      %240 = mhlo.xor %238, %239 : tensor<1024xui32>
      %241 = mhlo.constant dense<1621209284> : tensor<ui32>
      %242 = "mhlo.broadcast_in_dim"(%241) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %243 = mhlo.xor %240, %242 : tensor<1024xui32>
      %244 = "mhlo.convert"(%243) : (tensor<1024xui32>) -> tensor<1024xui64>
      %245 = mhlo.multiply %244, %49 : tensor<1024xui64>
      %246 = mhlo.shift_right_logical %245, %51 : tensor<1024xui64>
      %247 = "mhlo.convert"(%246) : (tensor<1024xui64>) -> tensor<1024xui32>
      %248 = "mhlo.convert"(%199) : (tensor<1024xui64>) -> tensor<1024xui32>
      %249 = mhlo.xor %247, %248 : tensor<1024xui32>
      %250 = mhlo.constant dense<1475805738> : tensor<ui32>
      %251 = "mhlo.broadcast_in_dim"(%250) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %252 = mhlo.xor %249, %251 : tensor<1024xui32>
      %253 = "mhlo.bitcast"(%252) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1024xui32>) -> tensor<1024x1xui32>
      %254 = "mhlo.convert"(%245) : (tensor<1024xui64>) -> tensor<1024xui32>
      %255 = "mhlo.bitcast"(%254) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1024xui32>) -> tensor<1024x1xui32>
      %256 = "mhlo.concatenate"(%234, %236, %253, %255) {dimension = 1 : i64} : (tensor<1024x1xui32>, tensor<1024x1xui32>, tensor<1024x1xui32>, tensor<1024x1xui32>) -> tensor<1024x4xui32>
      %257 = mhlo.constant dense<9> : tensor<ui32>
      %258 = "mhlo.broadcast_in_dim"(%257) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024x4xui32>
      %259 = mhlo.shift_right_logical %256, %258 : tensor<1024x4xui32>
      %260 = "mhlo.convert"(%259) : (tensor<1024x4xui32>) -> tensor<1024x4xf32>
      %261 = mhlo.constant dense<1.1920929E-7> : tensor<f32>
      %262 = "mhlo.broadcast_in_dim"(%261) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<1024x4xf32>
      %263 = mhlo.multiply %260, %262 : tensor<1024x4xf32>
      %264 = mhlo.constant dense<0.899999976> : tensor<f32>
      %265 = "mhlo.broadcast_in_dim"(%264) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<1024x4xf32>
      %266 = "mhlo.compare"(%263, %265) {comparison_direction = #mhlo<"comparison_direction LT">} : (tensor<1024x4xf32>, tensor<1024x4xf32>) -> tensor<1024x4xi1>
      %267 = "mhlo.bitcast"(%266) {result_layout = dense<[2, 1, 0]> : tensor<3xindex>, source_layout = dense<[1, 0]> : tensor<2xindex>} : (tensor<1024x4xi1>) -> tensor<8x32x16xi1>
      %268 = "mhlo.bitcast"(%31) {result_layout = dense<[2, 1, 0]> : tensor<3xindex>, source_layout = dense<[1, 0]> : tensor<2xindex>} : (tensor<256x16xf32>) -> tensor<8x32x16xf32>
      %269 = mhlo.constant dense<0.000000e+00> : tensor<f32>
      %270 = "mhlo.broadcast_in_dim"(%269) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<8x32x16xf32>
      %271 = "mhlo.select"(%267, %268, %270) : (tensor<8x32x16xi1>, tensor<8x32x16xf32>, tensor<8x32x16xf32>) -> tensor<8x32x16xf32>
      %272 = "mhlo.bitcast"(%271) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<[2, 1, 0]> : tensor<3xindex>} : (tensor<8x32x16xf32>) -> tensor<256x16xf32>
      memref.tensor_store %272, %5 : memref<256x16xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c0_2 = arith.constant 0 : index
    %6 = memref.view %arg2[%c0_2][] : memref<1024xi8> to memref<16x16xf32>
    %c32768 = arith.constant 32768 : index
    %7 = memref.view %arg8[%c32768][] : memref<50320xi8> to memref<256x16xf32>
    "lmhlo_gpu.gemm"(%5, %6, %7) {algorithm = -1 : i64, alpha_imag = 0.000000e+00 : f64, alpha_real = 1.000000e+00 : f64, batch_size = 1 : i64, dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [1], rhs_contracting_dimensions = [0]>, lhs_stride = 4096 : i64, rhs_stride = 256 : i64} : (memref<256x16xf32>, memref<16x16xf32>, memref<256x16xf32>) -> ()
    %c0_3 = arith.constant 0 : index
    %8 = memref.view %arg4[%c0_3][] : memref<16384xi8> to memref<8x32x16xf32>
    %c0_4 = arith.constant 0 : index
    %9 = memref.view %arg8[%c0_4][] : memref<50320xi8> to memref<8x32x16xf32>
    "lmhlo.fusion"() ({
      %31 = bufferization.to_tensor %8 : memref<8x32x16xf32>
      %32 = bufferization.to_tensor %7 : memref<256x16xf32>
      %33 = "mhlo.bitcast"(%32) {result_layout = dense<[2, 1, 0]> : tensor<3xindex>, source_layout = dense<[1, 0]> : tensor<2xindex>} : (tensor<256x16xf32>) -> tensor<8x32x16xf32>
      %34 = mhlo.subtract %33, %31 : tensor<8x32x16xf32>
      %35 = mhlo.constant dense<1.22070313E-4> : tensor<f32>
      %36 = "mhlo.broadcast_in_dim"(%35) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<8x32x16xf32>
      %37 = mhlo.multiply %34, %36 : tensor<8x32x16xf32>
      memref.tensor_store %37, %9 : memref<8x32x16xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c32768_5 = arith.constant 32768 : index
    %10 = memref.view %arg8[%c32768_5][] : memref<50320xi8> to memref<256x16xf32>
    %11 = memref.reinterpret_cast %10 to offset: [0], sizes: [16, 256], strides: [1, 16] : memref<256x16xf32> to memref<16x256xf32, affine_map<(d0, d1) -> (d0 + d1 * 16)>>
    "lmhlo.fusion"() ({
      %31 = bufferization.to_tensor %9 : memref<8x32x16xf32>
      %32 = "mhlo.transpose"(%31) {permutation = dense<[2, 0, 1]> : tensor<3xi64>, xla_shape = "f32[16,8,32]{0,2,1}"} : (tensor<8x32x16xf32>) -> tensor<16x8x32xf32>
      %33 = "mhlo.bitcast"(%32) {result_layout = dense<[0, 1]> : tensor<2xindex>, source_layout = dense<[0, 2, 1]> : tensor<3xindex>, xla_shape = "f32[16,256]{0,1}"} : (tensor<16x8x32xf32>) -> tensor<16x256xf32>
      memref.tensor_store %33, %11 : memref<16x256xf32, affine_map<(d0, d1) -> (d0 + d1 * 16)>>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c49152 = arith.constant 49152 : index
    %12 = memref.view %arg8[%c49152][] : memref<50320xi8> to memref<16x16xf32>
    "lmhlo_gpu.gemm"(%5, %11, %12) {algorithm = -1 : i64, alpha_imag = 0.000000e+00 : f64, alpha_real = 1.000000e+00 : f64, batch_size = 1 : i64, dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [0], rhs_contracting_dimensions = [1]>, lhs_stride = 4096 : i64, rhs_stride = 4096 : i64} : (memref<256x16xf32>, memref<16x256xf32, affine_map<(d0, d1) -> (d0 + d1 * 16)>>, memref<16x16xf32>) -> ()
    %c0_6 = arith.constant 0 : index
    %13 = memref.view %arg8[%c0_6][] : memref<50320xi8> to memref<256x16xf32>
    %c16384_7 = arith.constant 16384 : index
    %14 = memref.view %arg8[%c16384_7][] : memref<50320xi8> to memref<256x16xf32>
    "lmhlo_gpu.gemm"(%13, %6, %14) {algorithm = -1 : i64, alpha_imag = 0.000000e+00 : f64, alpha_real = 1.000000e+00 : f64, batch_size = 1 : i64, dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [1], rhs_contracting_dimensions = [1]>, lhs_stride = 4096 : i64, rhs_stride = 256 : i64} : (memref<256x16xf32>, memref<16x16xf32>, memref<256x16xf32>) -> ()
    %c0_8 = arith.constant 0 : index
    %15 = memref.view %arg8[%c0_8][] : memref<50320xi8> to memref<256x16xf32>
    %16 = memref.reinterpret_cast %15 to offset: [0], sizes: [16, 256], strides: [1, 16] : memref<256x16xf32> to memref<16x256xf32, affine_map<(d0, d1) -> (d0 + d1 * 16)>>
    "lmhlo.fusion"() ({
      %31 = bufferization.to_tensor %14 : memref<256x16xf32>
      %32 = bufferization.to_tensor %4 : memref<ui64>
      %33 = bufferization.to_tensor %3 : memref<2xui64>
      %34 = "mhlo.slice"(%33) {limit_indices = dense<1> : tensor<1xi64>, start_indices = dense<0> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<2xui64>) -> tensor<1xui64>
      %35 = "mhlo.bitcast"(%34) {result_layout = dense<> : tensor<0xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1xui64>) -> tensor<ui64>
      %36 = "mhlo.convert"(%35) : (tensor<ui64>) -> tensor<ui32>
      %37 = "mhlo.convert"(%36) : (tensor<ui32>) -> tensor<ui64>
      %38 = mhlo.shift_right_logical %35, %32 : tensor<ui64>
      %39 = "mhlo.convert"(%38) : (tensor<ui64>) -> tensor<ui32>
      %40 = "mhlo.convert"(%39) : (tensor<ui32>) -> tensor<ui64>
      %41 = mhlo.shift_left %40, %32 : tensor<ui64>
      %42 = mhlo.or %37, %41 : tensor<ui64>
      %43 = "mhlo.broadcast_in_dim"(%42) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<1024xui64>
      %44 = "mhlo.iota"() {iota_dimension = 0 : i64} : () -> tensor<1024xui64>
      %45 = mhlo.add %43, %44 : tensor<1024xui64>
      %46 = "mhlo.convert"(%45) : (tensor<1024xui64>) -> tensor<1024xui32>
      %47 = "mhlo.convert"(%46) : (tensor<1024xui32>) -> tensor<1024xui64>
      %48 = mhlo.constant dense<3528531795> : tensor<ui64>
      %49 = "mhlo.broadcast_in_dim"(%48) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<1024xui64>
      %50 = mhlo.multiply %47, %49 : tensor<1024xui64>
      %51 = "mhlo.broadcast_in_dim"(%32) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<1024xui64>
      %52 = mhlo.shift_right_logical %50, %51 : tensor<1024xui64>
      %53 = "mhlo.convert"(%52) : (tensor<1024xui64>) -> tensor<1024xui32>
      %54 = "mhlo.compare"(%45, %43) {comparison_direction = #mhlo<"comparison_direction LT">} : (tensor<1024xui64>, tensor<1024xui64>) -> tensor<1024xi1>
      %55 = "mhlo.slice"(%33) {limit_indices = dense<2> : tensor<1xi64>, start_indices = dense<1> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<2xui64>) -> tensor<1xui64>
      %56 = "mhlo.bitcast"(%55) {result_layout = dense<> : tensor<0xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1xui64>) -> tensor<ui64>
      %57 = "mhlo.convert"(%56) : (tensor<ui64>) -> tensor<ui32>
      %58 = "mhlo.convert"(%57) : (tensor<ui32>) -> tensor<ui64>
      %59 = mhlo.shift_right_logical %56, %32 : tensor<ui64>
      %60 = "mhlo.convert"(%59) : (tensor<ui64>) -> tensor<ui32>
      %61 = "mhlo.convert"(%60) : (tensor<ui32>) -> tensor<ui64>
      %62 = mhlo.shift_left %61, %32 : tensor<ui64>
      %63 = mhlo.or %58, %62 : tensor<ui64>
      %64 = mhlo.constant dense<1> : tensor<ui64>
      %65 = mhlo.add %63, %64 : tensor<ui64>
      %66 = "mhlo.broadcast_in_dim"(%65) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<1024xui64>
      %67 = "mhlo.broadcast_in_dim"(%63) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<1024xui64>
      %68 = "mhlo.select"(%54, %66, %67) : (tensor<1024xi1>, tensor<1024xui64>, tensor<1024xui64>) -> tensor<1024xui64>
      %69 = mhlo.shift_right_logical %68, %51 : tensor<1024xui64>
      %70 = "mhlo.convert"(%69) : (tensor<1024xui64>) -> tensor<1024xui32>
      %71 = mhlo.xor %53, %70 : tensor<1024xui32>
      %72 = mhlo.constant dense<3243368317> : tensor<ui32>
      %73 = "mhlo.broadcast_in_dim"(%72) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %74 = mhlo.xor %71, %73 : tensor<1024xui32>
      %75 = "mhlo.convert"(%74) : (tensor<1024xui32>) -> tensor<1024xui64>
      %76 = mhlo.constant dense<3449720151> : tensor<ui64>
      %77 = "mhlo.broadcast_in_dim"(%76) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui64>) -> tensor<1024xui64>
      %78 = mhlo.multiply %75, %77 : tensor<1024xui64>
      %79 = mhlo.shift_right_logical %78, %51 : tensor<1024xui64>
      %80 = "mhlo.convert"(%79) : (tensor<1024xui64>) -> tensor<1024xui32>
      %81 = "mhlo.convert"(%68) : (tensor<1024xui64>) -> tensor<1024xui32>
      %82 = "mhlo.convert"(%81) : (tensor<1024xui32>) -> tensor<1024xui64>
      %83 = mhlo.multiply %82, %77 : tensor<1024xui64>
      %84 = "mhlo.convert"(%83) : (tensor<1024xui64>) -> tensor<1024xui32>
      %85 = mhlo.xor %80, %84 : tensor<1024xui32>
      %86 = mhlo.constant dense<220028085> : tensor<ui32>
      %87 = "mhlo.broadcast_in_dim"(%86) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %88 = mhlo.xor %85, %87 : tensor<1024xui32>
      %89 = "mhlo.convert"(%88) : (tensor<1024xui32>) -> tensor<1024xui64>
      %90 = mhlo.multiply %89, %49 : tensor<1024xui64>
      %91 = mhlo.shift_right_logical %90, %51 : tensor<1024xui64>
      %92 = "mhlo.convert"(%91) : (tensor<1024xui64>) -> tensor<1024xui32>
      %93 = mhlo.shift_right_logical %83, %51 : tensor<1024xui64>
      %94 = "mhlo.convert"(%93) : (tensor<1024xui64>) -> tensor<1024xui32>
      %95 = mhlo.shift_right_logical %45, %51 : tensor<1024xui64>
      %96 = "mhlo.convert"(%95) : (tensor<1024xui64>) -> tensor<1024xui32>
      %97 = mhlo.xor %94, %96 : tensor<1024xui32>
      %98 = mhlo.constant dense<1860559612> : tensor<ui32>
      %99 = "mhlo.broadcast_in_dim"(%98) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %100 = mhlo.xor %97, %99 : tensor<1024xui32>
      %101 = "mhlo.convert"(%100) : (tensor<1024xui32>) -> tensor<1024xui64>
      %102 = mhlo.multiply %101, %49 : tensor<1024xui64>
      %103 = "mhlo.convert"(%102) : (tensor<1024xui64>) -> tensor<1024xui32>
      %104 = mhlo.xor %92, %103 : tensor<1024xui32>
      %105 = mhlo.constant dense<941702279> : tensor<ui32>
      %106 = "mhlo.broadcast_in_dim"(%105) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %107 = mhlo.xor %104, %106 : tensor<1024xui32>
      %108 = "mhlo.convert"(%107) : (tensor<1024xui32>) -> tensor<1024xui64>
      %109 = mhlo.multiply %108, %77 : tensor<1024xui64>
      %110 = mhlo.shift_right_logical %109, %51 : tensor<1024xui64>
      %111 = "mhlo.convert"(%110) : (tensor<1024xui64>) -> tensor<1024xui32>
      %112 = mhlo.shift_right_logical %102, %51 : tensor<1024xui64>
      %113 = "mhlo.convert"(%112) : (tensor<1024xui64>) -> tensor<1024xui32>
      %114 = "mhlo.convert"(%50) : (tensor<1024xui64>) -> tensor<1024xui32>
      %115 = mhlo.xor %113, %114 : tensor<1024xui32>
      %116 = mhlo.constant dense<2092535298> : tensor<ui32>
      %117 = "mhlo.broadcast_in_dim"(%116) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %118 = mhlo.xor %115, %117 : tensor<1024xui32>
      %119 = "mhlo.convert"(%118) : (tensor<1024xui32>) -> tensor<1024xui64>
      %120 = mhlo.multiply %119, %77 : tensor<1024xui64>
      %121 = "mhlo.convert"(%120) : (tensor<1024xui64>) -> tensor<1024xui32>
      %122 = mhlo.xor %111, %121 : tensor<1024xui32>
      %123 = mhlo.constant dense<1233932327> : tensor<ui32>
      %124 = "mhlo.broadcast_in_dim"(%123) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %125 = mhlo.xor %122, %124 : tensor<1024xui32>
      %126 = "mhlo.convert"(%125) : (tensor<1024xui32>) -> tensor<1024xui64>
      %127 = mhlo.multiply %126, %49 : tensor<1024xui64>
      %128 = mhlo.shift_right_logical %127, %51 : tensor<1024xui64>
      %129 = "mhlo.convert"(%128) : (tensor<1024xui64>) -> tensor<1024xui32>
      %130 = mhlo.shift_right_logical %120, %51 : tensor<1024xui64>
      %131 = "mhlo.convert"(%130) : (tensor<1024xui64>) -> tensor<1024xui32>
      %132 = "mhlo.convert"(%78) : (tensor<1024xui64>) -> tensor<1024xui32>
      %133 = mhlo.xor %131, %132 : tensor<1024xui32>
      %134 = mhlo.constant dense<2874463854> : tensor<ui32>
      %135 = "mhlo.broadcast_in_dim"(%134) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %136 = mhlo.xor %133, %135 : tensor<1024xui32>
      %137 = "mhlo.convert"(%136) : (tensor<1024xui32>) -> tensor<1024xui64>
      %138 = mhlo.multiply %137, %49 : tensor<1024xui64>
      %139 = "mhlo.convert"(%138) : (tensor<1024xui64>) -> tensor<1024xui32>
      %140 = mhlo.xor %129, %139 : tensor<1024xui32>
      %141 = mhlo.constant dense<2935003537> : tensor<ui32>
      %142 = "mhlo.broadcast_in_dim"(%141) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %143 = mhlo.xor %140, %142 : tensor<1024xui32>
      %144 = "mhlo.convert"(%143) : (tensor<1024xui32>) -> tensor<1024xui64>
      %145 = mhlo.multiply %144, %77 : tensor<1024xui64>
      %146 = mhlo.shift_right_logical %145, %51 : tensor<1024xui64>
      %147 = "mhlo.convert"(%146) : (tensor<1024xui64>) -> tensor<1024xui32>
      %148 = mhlo.shift_right_logical %138, %51 : tensor<1024xui64>
      %149 = "mhlo.convert"(%148) : (tensor<1024xui64>) -> tensor<1024xui32>
      %150 = "mhlo.convert"(%90) : (tensor<1024xui64>) -> tensor<1024xui32>
      %151 = mhlo.xor %149, %150 : tensor<1024xui32>
      %152 = mhlo.constant dense<4085836556> : tensor<ui32>
      %153 = "mhlo.broadcast_in_dim"(%152) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %154 = mhlo.xor %151, %153 : tensor<1024xui32>
      %155 = "mhlo.convert"(%154) : (tensor<1024xui32>) -> tensor<1024xui64>
      %156 = mhlo.multiply %155, %77 : tensor<1024xui64>
      %157 = "mhlo.convert"(%156) : (tensor<1024xui64>) -> tensor<1024xui32>
      %158 = mhlo.xor %147, %157 : tensor<1024xui32>
      %159 = mhlo.constant dense<2247836569> : tensor<ui32>
      %160 = "mhlo.broadcast_in_dim"(%159) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %161 = mhlo.xor %158, %160 : tensor<1024xui32>
      %162 = "mhlo.convert"(%161) : (tensor<1024xui32>) -> tensor<1024xui64>
      %163 = mhlo.multiply %162, %49 : tensor<1024xui64>
      %164 = mhlo.shift_right_logical %163, %51 : tensor<1024xui64>
      %165 = "mhlo.convert"(%164) : (tensor<1024xui64>) -> tensor<1024xui32>
      %166 = mhlo.shift_right_logical %156, %51 : tensor<1024xui64>
      %167 = "mhlo.convert"(%166) : (tensor<1024xui64>) -> tensor<1024xui32>
      %168 = "mhlo.convert"(%109) : (tensor<1024xui64>) -> tensor<1024xui32>
      %169 = mhlo.xor %167, %168 : tensor<1024xui32>
      %170 = mhlo.constant dense<3888368096> : tensor<ui32>
      %171 = "mhlo.broadcast_in_dim"(%170) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %172 = mhlo.xor %169, %171 : tensor<1024xui32>
      %173 = "mhlo.convert"(%172) : (tensor<1024xui32>) -> tensor<1024xui64>
      %174 = mhlo.multiply %173, %49 : tensor<1024xui64>
      %175 = "mhlo.convert"(%174) : (tensor<1024xui64>) -> tensor<1024xui32>
      %176 = mhlo.xor %165, %175 : tensor<1024xui32>
      %177 = mhlo.constant dense<633337499> : tensor<ui32>
      %178 = "mhlo.broadcast_in_dim"(%177) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %179 = mhlo.xor %176, %178 : tensor<1024xui32>
      %180 = "mhlo.convert"(%179) : (tensor<1024xui32>) -> tensor<1024xui64>
      %181 = mhlo.multiply %180, %77 : tensor<1024xui64>
      %182 = mhlo.shift_right_logical %181, %51 : tensor<1024xui64>
      %183 = "mhlo.convert"(%182) : (tensor<1024xui64>) -> tensor<1024xui32>
      %184 = mhlo.shift_right_logical %174, %51 : tensor<1024xui64>
      %185 = "mhlo.convert"(%184) : (tensor<1024xui64>) -> tensor<1024xui32>
      %186 = "mhlo.convert"(%127) : (tensor<1024xui64>) -> tensor<1024xui32>
      %187 = mhlo.xor %185, %186 : tensor<1024xui32>
      %188 = mhlo.constant dense<1784170518> : tensor<ui32>
      %189 = "mhlo.broadcast_in_dim"(%188) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %190 = mhlo.xor %187, %189 : tensor<1024xui32>
      %191 = "mhlo.convert"(%190) : (tensor<1024xui32>) -> tensor<1024xui64>
      %192 = mhlo.multiply %191, %77 : tensor<1024xui64>
      %193 = "mhlo.convert"(%192) : (tensor<1024xui64>) -> tensor<1024xui32>
      %194 = mhlo.xor %183, %193 : tensor<1024xui32>
      %195 = mhlo.constant dense<3261740811> : tensor<ui32>
      %196 = "mhlo.broadcast_in_dim"(%195) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %197 = mhlo.xor %194, %196 : tensor<1024xui32>
      %198 = "mhlo.convert"(%197) : (tensor<1024xui32>) -> tensor<1024xui64>
      %199 = mhlo.multiply %198, %49 : tensor<1024xui64>
      %200 = mhlo.shift_right_logical %199, %51 : tensor<1024xui64>
      %201 = "mhlo.convert"(%200) : (tensor<1024xui64>) -> tensor<1024xui32>
      %202 = mhlo.shift_right_logical %192, %51 : tensor<1024xui64>
      %203 = "mhlo.convert"(%202) : (tensor<1024xui64>) -> tensor<1024xui32>
      %204 = "mhlo.convert"(%145) : (tensor<1024xui64>) -> tensor<1024xui32>
      %205 = mhlo.xor %203, %204 : tensor<1024xui32>
      %206 = mhlo.constant dense<607305042> : tensor<ui32>
      %207 = "mhlo.broadcast_in_dim"(%206) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %208 = mhlo.xor %205, %207 : tensor<1024xui32>
      %209 = "mhlo.convert"(%208) : (tensor<1024xui32>) -> tensor<1024xui64>
      %210 = mhlo.multiply %209, %49 : tensor<1024xui64>
      %211 = "mhlo.convert"(%210) : (tensor<1024xui64>) -> tensor<1024xui32>
      %212 = mhlo.xor %201, %211 : tensor<1024xui32>
      %213 = mhlo.constant dense<2626638757> : tensor<ui32>
      %214 = "mhlo.broadcast_in_dim"(%213) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %215 = mhlo.xor %212, %214 : tensor<1024xui32>
      %216 = "mhlo.convert"(%215) : (tensor<1024xui32>) -> tensor<1024xui64>
      %217 = mhlo.multiply %216, %77 : tensor<1024xui64>
      %218 = mhlo.shift_right_logical %217, %51 : tensor<1024xui64>
      %219 = "mhlo.convert"(%218) : (tensor<1024xui64>) -> tensor<1024xui32>
      %220 = mhlo.shift_right_logical %210, %51 : tensor<1024xui64>
      %221 = "mhlo.convert"(%220) : (tensor<1024xui64>) -> tensor<1024xui32>
      %222 = "mhlo.convert"(%163) : (tensor<1024xui64>) -> tensor<1024xui32>
      %223 = mhlo.xor %221, %222 : tensor<1024xui32>
      %224 = mhlo.constant dense<3777471776> : tensor<ui32>
      %225 = "mhlo.broadcast_in_dim"(%224) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %226 = mhlo.xor %223, %225 : tensor<1024xui32>
      %227 = "mhlo.convert"(%226) : (tensor<1024xui32>) -> tensor<1024xui64>
      %228 = mhlo.multiply %227, %77 : tensor<1024xui64>
      %229 = "mhlo.convert"(%228) : (tensor<1024xui64>) -> tensor<1024xui32>
      %230 = mhlo.xor %219, %229 : tensor<1024xui32>
      %231 = mhlo.constant dense<4275645053> : tensor<ui32>
      %232 = "mhlo.broadcast_in_dim"(%231) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %233 = mhlo.xor %230, %232 : tensor<1024xui32>
      %234 = "mhlo.bitcast"(%233) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1024xui32>) -> tensor<1024x1xui32>
      %235 = "mhlo.convert"(%217) : (tensor<1024xui64>) -> tensor<1024xui32>
      %236 = "mhlo.bitcast"(%235) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1024xui32>) -> tensor<1024x1xui32>
      %237 = mhlo.shift_right_logical %228, %51 : tensor<1024xui64>
      %238 = "mhlo.convert"(%237) : (tensor<1024xui64>) -> tensor<1024xui32>
      %239 = "mhlo.convert"(%181) : (tensor<1024xui64>) -> tensor<1024xui32>
      %240 = mhlo.xor %238, %239 : tensor<1024xui32>
      %241 = mhlo.constant dense<1621209284> : tensor<ui32>
      %242 = "mhlo.broadcast_in_dim"(%241) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %243 = mhlo.xor %240, %242 : tensor<1024xui32>
      %244 = "mhlo.convert"(%243) : (tensor<1024xui32>) -> tensor<1024xui64>
      %245 = mhlo.multiply %244, %49 : tensor<1024xui64>
      %246 = mhlo.shift_right_logical %245, %51 : tensor<1024xui64>
      %247 = "mhlo.convert"(%246) : (tensor<1024xui64>) -> tensor<1024xui32>
      %248 = "mhlo.convert"(%199) : (tensor<1024xui64>) -> tensor<1024xui32>
      %249 = mhlo.xor %247, %248 : tensor<1024xui32>
      %250 = mhlo.constant dense<1475805738> : tensor<ui32>
      %251 = "mhlo.broadcast_in_dim"(%250) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024xui32>
      %252 = mhlo.xor %249, %251 : tensor<1024xui32>
      %253 = "mhlo.bitcast"(%252) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1024xui32>) -> tensor<1024x1xui32>
      %254 = "mhlo.convert"(%245) : (tensor<1024xui64>) -> tensor<1024xui32>
      %255 = "mhlo.bitcast"(%254) {result_layout = dense<[1, 0]> : tensor<2xindex>, source_layout = dense<0> : tensor<1xindex>} : (tensor<1024xui32>) -> tensor<1024x1xui32>
      %256 = "mhlo.concatenate"(%234, %236, %253, %255) {dimension = 1 : i64} : (tensor<1024x1xui32>, tensor<1024x1xui32>, tensor<1024x1xui32>, tensor<1024x1xui32>) -> tensor<1024x4xui32>
      %257 = mhlo.constant dense<9> : tensor<ui32>
      %258 = "mhlo.broadcast_in_dim"(%257) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<ui32>) -> tensor<1024x4xui32>
      %259 = mhlo.shift_right_logical %256, %258 : tensor<1024x4xui32>
      %260 = "mhlo.convert"(%259) : (tensor<1024x4xui32>) -> tensor<1024x4xf32>
      %261 = mhlo.constant dense<1.1920929E-7> : tensor<f32>
      %262 = "mhlo.broadcast_in_dim"(%261) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<1024x4xf32>
      %263 = mhlo.multiply %260, %262 : tensor<1024x4xf32>
      %264 = mhlo.constant dense<0.899999976> : tensor<f32>
      %265 = "mhlo.broadcast_in_dim"(%264) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<1024x4xf32>
      %266 = "mhlo.compare"(%263, %265) {comparison_direction = #mhlo<"comparison_direction LT">} : (tensor<1024x4xf32>, tensor<1024x4xf32>) -> tensor<1024x4xi1>
      %267 = "mhlo.bitcast"(%266) {result_layout = dense<[2, 1, 0]> : tensor<3xindex>, source_layout = dense<[1, 0]> : tensor<2xindex>} : (tensor<1024x4xi1>) -> tensor<8x32x16xi1>
      %268 = mhlo.constant dense<true> : tensor<i1>
      %269 = "mhlo.broadcast_in_dim"(%268) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<i1>) -> tensor<8x32x16xi1>
      %270 = "mhlo.compare"(%267, %269) {comparison_direction = #mhlo<"comparison_direction EQ">} : (tensor<8x32x16xi1>, tensor<8x32x16xi1>) -> tensor<8x32x16xi1>
      %271 = "mhlo.bitcast"(%31) {result_layout = dense<[2, 1, 0]> : tensor<3xindex>, source_layout = dense<[1, 0]> : tensor<2xindex>} : (tensor<256x16xf32>) -> tensor<8x32x16xf32>
      %272 = mhlo.constant dense<0.000000e+00> : tensor<f32>
      %273 = "mhlo.broadcast_in_dim"(%272) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<8x32x16xf32>
      %274 = "mhlo.select"(%270, %271, %273) : (tensor<8x32x16xi1>, tensor<8x32x16xf32>, tensor<8x32x16xf32>) -> tensor<8x32x16xf32>
      %275 = mhlo.constant dense<1.11111116> : tensor<f32>
      %276 = "mhlo.broadcast_in_dim"(%275) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<8x32x16xf32>
      %277 = mhlo.multiply %274, %276 : tensor<8x32x16xf32>
      %278 = "mhlo.transpose"(%277) {permutation = dense<[2, 0, 1]> : tensor<3xi64>, xla_shape = "f32[16,8,32]{0,2,1}"} : (tensor<8x32x16xf32>) -> tensor<16x8x32xf32>
      %279 = "mhlo.bitcast"(%278) {result_layout = dense<[0, 1]> : tensor<2xindex>, source_layout = dense<[0, 2, 1]> : tensor<3xindex>, xla_shape = "f32[16,256]{0,1}"} : (tensor<16x8x32xf32>) -> tensor<16x256xf32>
      memref.tensor_store %279, %16 : memref<16x256xf32, affine_map<(d0, d1) -> (d0 + d1 * 16)>>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c16384_9 = arith.constant 16384 : index
    %17 = memref.view %arg8[%c16384_9][] : memref<50320xi8> to memref<16x16xf32>
    "lmhlo_gpu.gemm"(%0, %16, %17) {algorithm = -1 : i64, alpha_imag = 0.000000e+00 : f64, alpha_real = 1.000000e+00 : f64, batch_size = 1 : i64, dot_dimension_numbers = #mhlo.dot<lhs_contracting_dimensions = [0], rhs_contracting_dimensions = [1]>, lhs_stride = 4096 : i64, rhs_stride = 4096 : i64} : (memref<256x16xf32>, memref<16x256xf32, affine_map<(d0, d1) -> (d0 + d1 * 16)>>, memref<16x16xf32>) -> ()
    %c16384_10 = arith.constant 16384 : index
    %18 = memref.view %arg8[%c16384_10][] : memref<50320xi8> to memref<256xf32>
    %c49152_11 = arith.constant 49152 : index
    %19 = memref.view %arg8[%c49152_11][] : memref<50320xi8> to memref<256xf32>
    %c0_12 = arith.constant 0 : index
    %20 = memref.view %arg8[%c0_12][] : memref<50320xi8> to memref<512xf32>
    "lmhlo.fusion"() ({
      %31 = bufferization.to_tensor %18 : memref<256xf32>
      %32 = bufferization.to_tensor %19 : memref<256xf32>
      %33 = "mhlo.concatenate"(%31, %32) {dimension = 0 : i64} : (tensor<256xf32>, tensor<256xf32>) -> tensor<512xf32>
      memref.tensor_store %33, %20 : memref<512xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c0_13 = arith.constant 0 : index
    %21 = memref.view %arg8[%c0_13][] : memref<50320xi8> to memref<512xf32>
    "lmhlo.all_reduce"(%20, %21) ({
    ^bb0(%arg9: tensor<f32>, %arg10: tensor<f32>):
      %31 = mhlo.add %arg9, %arg10 : tensor<f32>
      "mhlo.return"(%31) : (tensor<f32>) -> ()
    }) {channel_id = {handle = 1 : i64, type = 0 : i64}, constrain_layout = false, replica_groups = dense<0> : tensor<1x1xi64>, use_global_device_ids = false} : (memref<512xf32>, memref<512xf32>) -> ()
    %c2048 = arith.constant 2048 : index
    %22 = memref.view %arg8[%c2048][] : memref<50320xi8> to memref<256xf32>
    "lmhlo.fusion"() ({
      %31 = bufferization.to_tensor %21 : memref<512xf32>
      %32 = "mhlo.slice"(%31) {limit_indices = dense<256> : tensor<1xi64>, start_indices = dense<0> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<512xf32>) -> tensor<256xf32>
      memref.tensor_store %32, %22 : memref<256xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c3072 = arith.constant 3072 : index
    %23 = memref.view %arg8[%c3072][] : memref<50320xi8> to memref<256xf32>
    "lmhlo.fusion"() ({
      %31 = bufferization.to_tensor %21 : memref<512xf32>
      %32 = "mhlo.slice"(%31) {limit_indices = dense<512> : tensor<1xi64>, start_indices = dense<256> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<512xf32>) -> tensor<256xf32>
      memref.tensor_store %32, %23 : memref<256xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %c2048_14 = arith.constant 2048 : index
    %24 = memref.view %arg8[%c2048_14][] : memref<50320xi8> to memref<16x16xf32>
    %c3072_15 = arith.constant 3072 : index
    %25 = memref.view %arg8[%c3072_15][] : memref<50320xi8> to memref<16x16xf32>
    %c0_16 = arith.constant 0 : index
    %26 = memref.view %arg1[%c0_16][] : memref<1024xi8> to memref<256xf32>
    %c0_17 = arith.constant 0 : index
    %27 = memref.view %arg2[%c0_17][] : memref<1024xi8> to memref<256xf32>
    "lmhlo.fusion"() ({
      %31 = bufferization.to_tensor %1 : memref<16x16xf32>
      %32 = bufferization.to_tensor %24 : memref<16x16xf32>
      %33 = bufferization.to_tensor %6 : memref<16x16xf32>
      %34 = bufferization.to_tensor %25 : memref<16x16xf32>
      %35 = mhlo.constant dense<0.00999999977> : tensor<f32>
      %36 = "mhlo.broadcast_in_dim"(%35) {broadcast_dimensions = dense<> : tensor<0xi64>} : (tensor<f32>) -> tensor<16x16xf32>
      %37 = mhlo.multiply %32, %36 : tensor<16x16xf32>
      %38 = mhlo.subtract %31, %37 : tensor<16x16xf32>
      %39 = "mhlo.reshape"(%38) : (tensor<16x16xf32>) -> tensor<256xf32>
      %40 = mhlo.multiply %34, %36 : tensor<16x16xf32>
      %41 = mhlo.subtract %33, %40 : tensor<16x16xf32>
      %42 = "mhlo.reshape"(%41) : (tensor<16x16xf32>) -> tensor<256xf32>
      %43 = "mhlo.concatenate"(%39, %42) {dimension = 0 : i64} : (tensor<256xf32>, tensor<256xf32>) -> tensor<512xf32>
      %44 = "mhlo.slice"(%43) {limit_indices = dense<256> : tensor<1xi64>, start_indices = dense<0> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<512xf32>) -> tensor<256xf32>
      %45 = "mhlo.slice"(%43) {limit_indices = dense<512> : tensor<1xi64>, start_indices = dense<256> : tensor<1xi64>, strides = dense<1> : tensor<1xi64>} : (tensor<512xf32>) -> tensor<256xf32>
      memref.tensor_store %44, %26 : memref<256xf32>
      memref.tensor_store %45, %27 : memref<256xf32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    %28 = memref.get_global @buffer_for_constant_5 : memref<i32>
    %c0_18 = arith.constant 0 : index
    %29 = memref.view %arg0[%c0_18][] : memref<4xi8> to memref<i32>
    %c0_19 = arith.constant 0 : index
    %30 = memref.view %arg0[%c0_19][] : memref<4xi8> to memref<i32>
    "lmhlo.fusion"() ({
      %31 = bufferization.to_tensor %29 : memref<i32>
      %32 = bufferization.to_tensor %28 : memref<i32>
      %33 = mhlo.add %31, %32 : tensor<i32>
      memref.tensor_store %33, %30 : memref<i32>
      "lmhlo.terminator"() : () -> ()
    }) : () -> ()
    "lmhlo.terminator"() : () -> ()
  }
}