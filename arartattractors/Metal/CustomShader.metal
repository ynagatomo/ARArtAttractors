//
//  CustomShader.metal
//  arartattractors
//
//  Created by Yasuhito Nagatomo on 2022/05/18.
//

#include <metal_stdlib>
#include <RealityKit/RealityKit.h>

using namespace metal;

//    constexpr sampler samplerBilinear(coord::normalized,
//                                     address::repeat,
//                                     filter::linear,
//                                     mip_filter::nearest);

[[visible]]
void surfaceShader(realitykit::surface_parameters params)
{
    float time = params.uniforms().time();

    half3 color = (half3)params.material_constants().base_color_tint(); // for base color (tint)
    half3 color1 = color * ((sin(time) / 2 + 0.5) * 0.8 + 0.2); // Color(t): animate colors

    params.surface().set_emissive_color(color1); // emissive color for unlit materials
}
