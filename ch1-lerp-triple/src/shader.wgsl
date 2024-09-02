struct Uniforms {
    resolution: vec4<f32>,  // WebGPUに合わせるため(lib.rsで16バイトにする必要がある)vec4を使います
};

@group(0) @binding(0) var<uniform> u_resolution: Uniforms;

struct VertexInput {
    @location(0) pos: vec2<f32>,
};

struct VertexOutput {
    @builtin(position) pos: vec4<f32>,
};

@vertex
fn vs_main(in: VertexInput) -> VertexOutput {
    var out: VertexOutput;
    out.pos = vec4(in.pos, 0.0, 1.0);
    return out;
}

@fragment
fn fs_main(fragCoord: VertexOutput) -> @location(0) vec4<f32> {
    var pos = fragCoord.pos.xy / u_resolution.resolution.xy;

    var col3 = array<vec3<f32>, 3>(
        vec3<f32>(1.0, 0.0, 0.0),
        vec3<f32>(0.0, 0.0, 1.0),
        vec3<f32>(0.0, 1.0, 0.0)
    );

    pos.x *= 2.0;
    let ind = u32(pos.x);
    let col = mix(col3[ind], col3[ind + 1], fract(pos.x));

    return vec4<f32>(col, 1.0);
}
