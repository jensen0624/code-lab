shader_type canvas_item;

uniform sampler2D screen: hint_screen_texture, filter_linear_mipmap;
varying vec2 center;

uniform float zoom: hint_range(0.0, 1.0);
uniform float blur: hint_range(0.0, 1.0);

uniform float radius: hint_range(0.0, 1.0) = 0.5;

void vertex() {
	center = (CANVAS_MATRIX * MODEL_MATRIX * vec4(0.0, 0.0, 0.0, 1.0)).xy;
}

void fragment() {
	vec2 center_uv = center * SCREEN_PIXEL_SIZE;
	vec2 uv = SCREEN_UV + (center_uv - SCREEN_UV ) * zoom;
	vec4 tex = textureLod(screen, uv, blur);
	
	float shape = step(distance(UV, vec2(0.5)), radius);
	
	COLOR.rgb = tex.rgb;
	COLOR.a = shape;
}
