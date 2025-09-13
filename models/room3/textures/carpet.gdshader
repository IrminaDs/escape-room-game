shader_type spatial;

uniform sampler2D albedo_tex;
uniform sampler2D ao_tex;
uniform sampler2D normal_tex;
uniform sampler2D roughness_tex;
uniform sampler2D metallic_tex;
uniform float hue_shift : hint_range(0.0, 1.0) = 0.0;
uniform float saturation_boost : hint_range(1.0, 3.0) = 1.5;
uniform float value_boost : hint_range(1.0, 3.0) = 1.2;

vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0/3.0, 2.0/3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1e-10;
    return vec3(abs((q.w - q.y)/(6.0*d + e) + q.z), d/(q.x+e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec3 p = abs(fract(c.xxx + vec3(0.0, 1.0/3.0, 2.0/3.0))*6.0 - 3.0);
    return c.z * mix(vec3(1.0), clamp(p-1.0, 0.0, 1.0), c.y);
}

void fragment() {
    vec2 uv = UV;

    vec4 albedo = texture(albedo_tex, uv);
    float ao = texture(ao_tex, uv).r;
    vec3 normal_map = texture(normal_tex, uv).rgb * 2.0 - 1.0;
    float roughness = texture(roughness_tex, uv).r;
    float metallic = texture(metallic_tex, uv).r;

    vec3 hsv = rgb2hsv(albedo.rgb);
    hsv.x = fract(hsv.x + hue_shift);
    hsv.y = clamp(hsv.y * saturation_boost, 0.0, 1.0);
    hsv.z = clamp(hsv.z * value_boost, 0.0, 1.0);

    ALBEDO = hsv2rgb(hsv);
    AO = ao;
    NORMAL = normal_map;
    ROUGHNESS = roughness;
    METALLIC = metallic;
}
