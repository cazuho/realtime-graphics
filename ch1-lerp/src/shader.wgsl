struct Uniforms {
    resolution: vec4<f32>,  // WebGPUに合わせるため(lib.rsで16バイトにする必要がある)vec4を使います
};

@group(0) @binding(0) var<uniform> u_resolution: Uniforms;

@vertex
fn vs_main(@builtin(vertex_index) vertex_index: u32) -> @builtin(position) vec4<f32> {
    var positions = array<vec2<f32>, 6>(
        vec2<f32>(-1.0, -1.0),  // 左下
        vec2<f32>( 1.0, -1.0),  // 右下
        vec2<f32>(-1.0,  1.0),  // 左上
        vec2<f32>(-1.0,  1.0),  // 左上
        vec2<f32>( 1.0, -1.0),  // 右下
        vec2<f32>( 1.0,  1.0)   // 右上
    );
    
    return vec4<f32>(positions[vertex_index], 0.0, 1.0);
}

@fragment
fn fs_main(@builtin(position) fragCoord: vec4<f32>) -> @location(0) vec4<f32> {
    let pos = fragCoord.xy / u_resolution.resolution.xy;
    // let pos = fragCoord.xy / vec2<f32>(800.0, 600.0); // 固定の解像度に変更
    let RED = vec3<f32>(1.0, 0.0, 0.0);
    let BLUE = vec3<f32>(0.0, 0.0, 1.0);
    let col = mix(RED, BLUE, pos.x);
    // 色を単色に変更
    //let col = vec3<f32>(1.0, 0.0, 0.0); // 赤色
    return vec4<f32>(col, 1.0);
}
