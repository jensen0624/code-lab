shader_type canvas_item;

uniform float pixel_size: hint_range(1.0, 128.0, 1.0) = 1.0;

void fragment() {
	vec2 tex_size = 1.0 / TEXTURE_PIXEL_SIZE;
	vec2 grid_size = tex_size / pixel_size;
	vec2 uv = floor(UV * grid_size + 0.5) / grid_size;
	COLOR = texture(TEXTURE, uv);
	
	//效果不佳
	//float grid_size = pixel_size / 128.0;
	//vec2 uv = vec2(
		//grid_size * (floor(UV.x / grid_size) + 0.5),
		//grid_size * (floor(UV.y / grid_size) + 0.5)
	//);
	//COLOR = texture(TEXTURE, uv);
}
