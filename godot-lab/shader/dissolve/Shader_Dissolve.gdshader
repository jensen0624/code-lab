shader_type canvas_item;

uniform float progress: hint_range(0.0, 1.0) = 0.0;
uniform float progress_gradient: hint_range(0.0, 1.0) = 0.0;
uniform vec3 color_dissolve: source_color = vec3(0.949, 0.357, 0.106);

uniform sampler2D noise;

void fragment() {
	float noise_value = texture(noise, UV).r;
	COLOR.a = COLOR.a * (step(progress, noise_value) + smoothstep(noise_value, 0.0, progress_gradient));
	COLOR.rgb = step(progress, noise_value) < 1.0 ? color_dissolve : COLOR.rgb;
	
	//效果不佳
	//float shape = step(progress, noise_value);
	//float gradient = smoothstep(noise_value + (1.0 - progress), 0.0, progress);
	//COLOR.a = COLOR.a * (shape + gradient);
	//COLOR.rgb = COLOR.a < 1.0 ? color_dissolve : COLOR.rgb;
}
