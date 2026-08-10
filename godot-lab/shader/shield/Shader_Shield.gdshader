shader_type canvas_item;

const vec2 center = vec2(0.5);
uniform float radius: hint_range(0.0, 1.0) = 0.5;
uniform float width: hint_range(0.0, 1.0) = 0.5;

uniform vec2 highlight_center = vec2(0.2, 0.2);
uniform float highlight_intensity: hint_range(0.0, 2.0) = 1.0;

uniform vec3 shape_color: source_color = vec3(0.149, 0.78, 0.902);
uniform vec3 highlight_color: source_color = vec3(0.772, 0.723, 0.35);
uniform float glow: hint_range(0.0, 1.0) = 0.5;

uniform sampler2D noise: repeat_enable;
uniform float speed: hint_range(0.0, 1.0) = 0.2;

uniform float scale = 1.0;
uniform float scale_speed = 1.0;

void vertex() {
	VERTEX += normalize(VERTEX) * sin(TIME * scale_speed) * scale;
}

void fragment() {
	float circle = step(distance(UV, center), radius);
	float inner = smoothstep(width * 0.5, 1.0, distance(UV, center));
	float shape = circle * inner;
	
	float highlight = pow(1.0 - distance(highlight_center, UV), 3.0) * highlight_intensity * shape;
	
	vec3 color = (shape_color * shape + highlight_color * highlight) * (1.0 + 5.0 * glow);
	
	float threshold = texture(noise, UV + vec2(TIME * speed, 0.0)).r * 3.0;
	
	COLOR.a = (shape + highlight) * threshold;
	COLOR.rgb = color;
}
