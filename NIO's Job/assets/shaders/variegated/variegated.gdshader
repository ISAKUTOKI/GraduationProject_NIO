shader_type canvas_item;


uniform float amount = 0.1;      // 杂色强度
uniform float speed = 0.5;       // 动态噪声速度
uniform float scale = 5.0;       // 噪声纹理缩放
uniform vec3 color_variation : source_color = vec3(1.0); // 颜色偏移

// 伪随机噪声函数（修正了括号匹配问题）
float rand(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    // 原始颜色
    vec4 color = texture(TEXTURE, UV);

    // 动态噪声UV
    vec2 noise_uv = UV * scale;
    if (speed > 0.0) {
        noise_uv += TIME * speed;
    }

    // 生成噪声值 (-1到1范围)
    float noise = rand(noise_uv) * 2.0 - 1.0;

    // 应用颜色偏移
    vec3 color_offset = noise * color_variation * amount;

    // 混合结果
    COLOR.rgb = color.rgb + color_offset;
    COLOR.a = color.a; // 保持原始Alpha
}