shader_type canvas_item;

uniform float width: hint_range(0.0, 1.0) = 0.5;
uniform float size: hint_range(0.0, 1.0) = 0.8;
uniform float blur: hint_range(0.0, 1.0) = 0.5;
uniform float fall_center = 0.5;

uniform sampler2D noise: repeat_enable;
uniform float speed = 0.2;

uniform vec3 color_out: source_color = vec3(0.969, 0.169, 0.027);
uniform vec3 color_mid: source_color = vec3(0.949, 0.357, 0.106);
uniform vec3 color_in: source_color = vec3(0.961, 0.867, 0.392);

void fragment() {
	vec2 uv = UV * 2.0 - 1.0;
	float ellipse = length(vec2(uv.x * (2.0 - width), uv.y));
	float gradient = smoothstep(-0.5, 0.5, uv.y);
	float shape = smoothstep(size, size - blur, ellipse) * gradient;
	
	vec2 noise_uv = vec2(UV.x, UV.y + TIME * speed);
	float noise_value = texture(noise, noise_uv).r;
	
	float fire_out = step(0.3, shape * 0.3 + noise_value * 0.3);
	float fire_mid = step(0.4, shape * 0.3 + noise_value * 0.4);
	float fire_in = step(0.5, shape * 0.3 + noise_value * 0.5);
	
	float mask_out = fire_out - fire_mid;
	float mask_mid = fire_mid - fire_in;
	
	COLOR.a = fire_out;
	COLOR.rgb = mask_out * color_out + mask_mid * color_mid + fire_in * color_in;
}
