shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform int resX = 128;
uniform int resY = 128;

// 0.100392156862 is the cube root of 255
uniform vec3 rgb255 = vec3(0.100392156862, 0.100392156862, 0.100392156862);

void fragment() {
	float uvX = UV.x - mod(UV.x * float(resX), 1) / float(resX);
	float uvY = UV.y - mod(UV.y * float(resY), 1) / float(resY);
	vec2 grid_uv = vec2(uvX, uvY);
	
	vec4 col = texture(SCREEN_TEXTURE, grid_uv);
	
	if(col.r < 1.0 && col.g < 1.0 && col.b < 1.0) {
		vec3 remainder = mod(col.rgb, rgb255);
		col.rgb = col.rgb - remainder;
	}
	
	COLOR = col;
}