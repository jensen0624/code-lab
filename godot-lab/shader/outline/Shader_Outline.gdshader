shader_type canvas_item;

uniform vec4 outline_color: source_color = vec4(1.0);
uniform float outline_width = 1.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec2 size = TEXTURE_PIXEL_SIZE * 0.5 * outline_width;
	
	float outline = color.a;
	outline += texture(TEXTURE, UV + vec2(size.x, 0.0)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, 0.0)).a;
	outline += texture(TEXTURE, UV + vec2(0.0, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(0.0, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
	outline = min(outline, 1.0);
	
	COLOR = mix(color, outline_color, outline - color.a);
}
