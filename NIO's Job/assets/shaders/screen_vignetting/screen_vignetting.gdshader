shader_type canvas_item;

uniform float radius = 0.75;   // 暗角半径 默认(0.0-2.0)
uniform float intensity = 2.0; // 暗角强度 默认(0.0-5.0)
uniform float smoothness = 0.5;// 边缘柔化程度 默认(0.0-1.0)
uniform vec4 vignette_color : source_color = vec4(0.0, 0.0, 0.0, 1.0); // 暗角颜色 默认纯黑

void fragment() {
    // 获取原始颜色
    vec4 original_color = texture(TEXTURE, UV);

    // 计算中心坐标
    vec2 center = vec2(0.5, 0.5);

    // 计算到中心的距离 (使用二次方增强效果)
    float dist = distance(UV, center) * 2.0;

    // 计算暗角衰减系数
    float vignette = 1.0 - smoothstep(
        radius - smoothness,
        radius + smoothness,
        dist * intensity
    );

    // 混合原始颜色和暗角颜色
    COLOR = mix(vignette_color, original_color, vignette);

    // 保持原始Alpha通道
    COLOR.a = original_color.a;
}