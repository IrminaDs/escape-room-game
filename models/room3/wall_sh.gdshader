shader_type spatial;
render_mode cull_disabled;

uniform sampler2D mask_tex;
uniform bool flip_mask_y = false;
uniform bool flip_mask_z = false;

uniform sampler2D albedo_a : source_color;
uniform sampler2D normal_a;
uniform sampler2D specular_a;
uniform sampler2D displacement_a;
uniform sampler2D diffuse_a;

uniform sampler2D albedo_b : source_color;
uniform sampler2D normal_b;
uniform sampler2D specular_b;
uniform sampler2D displacement_b;
uniform sampler2D diffuse_b;

uniform float displacement_scale = 0.1;
uniform vec2 uv_scale = vec2(1.0, 1.0);

void vertex() {
    vec2 uv = UV * uv_scale;
    vec2 mask_uv = uv;

    if (flip_mask_y) mask_uv.x = 1.0 - mask_uv.x;
    if (flip_mask_z) mask_uv.y = 1.0 - mask_uv.y;

    float m = texture(mask_tex, mask_uv).r;

    float dispA = texture(displacement_a, uv).r;
    float dispB = texture(displacement_b, uv).r;
    float disp = mix(dispB, dispA, m);
	
    disp = clamp(disp, 0.0, 1.0);
    VERTEX.z += disp * displacement_scale;
}


void fragment() {
    vec2 uv = UV * uv_scale;
    vec2 mask_uv = uv;

    if (flip_mask_y) {
        mask_uv.x = 1.0 - mask_uv.x;
    }
    if (flip_mask_z) {
        mask_uv.y = 1.0 - mask_uv.y;
    }

    float m = texture(mask_tex, mask_uv).r;

    vec3 albedoA = texture(albedo_a, uv).rgb * texture(diffuse_a, uv).rgb;
    vec3 albedoB = texture(albedo_b, uv).rgb * texture(diffuse_b, uv).rgb;
    ALBEDO = mix(albedoB, albedoA, m);

    vec3 nA = texture(normal_a, uv).rgb * 2.0 - 1.0;
    vec3 nB = texture(normal_b, uv).rgb * 2.0 - 1.0;
    vec3 n = normalize(mix(nB, nA, m));

    NORMAL = normalize(
        TANGENT * n.x +
        BINORMAL * n.y +
        NORMAL * n.z
    );

    float specA = texture(specular_a, uv).r;
    float specB = texture(specular_b, uv).r;
    SPECULAR = mix(specB, specA, m);

    ROUGHNESS = 0.5;
    METALLIC = 0.0;
}
