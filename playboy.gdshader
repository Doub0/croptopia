shader_type canvas_item;
render_mode blend_mix;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float dot_size = 4.0;

uniform vec4 color0: source_color;
uniform vec4 color1: source_color;
uniform vec4 color2: source_color;
uniform vec4 color3: source_color;
uniform bool color_swap = true;
uniform bool color_correction = true;

uniform bool use_image_for_lcd = true;
uniform sampler2D lcd_back: source_color;

uniform float border_size = -600;
uniform bool enable_dot_matrix = true;

uniform float glare_amount = 0.002;
uniform float brightness : hint_range(0, 1) = 0.0;
uniform float pixel_shadow_amount : hint_range(0, 1) = 0.244;

uniform float lcd_dark_square_transparency : hint_range(0, 1) = 0.03;


void fragment() {
	// 1: Define the color list
	vec4 colors[] = {color0,color1,color2,color3};
	vec4 lcd_back_tex;
	if(use_image_for_lcd){
		lcd_back_tex = texture(lcd_back, SCREEN_UV) * color3;
		colors[0] = texture(lcd_back, SCREEN_UV) * color0;
		colors[1] = texture(lcd_back, SCREEN_UV) * color1;
		colors[2] = texture(lcd_back, SCREEN_UV) * color2;
		colors[3] = lcd_back_tex;
	}

	

// 2: Grab the junk off of the screen
	if(color_swap){
	vec3 scrn_uv = vec3(UV, 0.0);
	vec3 color_input;
	float alpa_input;
	{
		vec4 _tex_read = textureLod(TEXTURE, scrn_uv.xy, 0.0);
		color_input = _tex_read.rgb;
		alpa_input = _tex_read.a;
	}

// 3: Turn that junk into the superior "Grey"

	float grey_value;
	{
		vec3 c = color_input;
		float max1 = max(c.r, c.g);
		float max2 = max(max1, c.b);
		grey_value = max2;
	}

// 4: Multiply the superior "Grey" into the ultimate "Multiplied Grey"

	float multiplier = float(colors.length()-1);
	float multiplied_grey = grey_value * multiplier;

// 5: Round the ultimate "Multiplied Grey" to integer-like values; Achieve god-like "Rounded Multiplied Grey"

	float round_mult_grey = round(multiplied_grey);

// 6: Use the power of your new god to pick your output colors based on their color index.

	vec4 out_color = colors[int(round_mult_grey)];
	

// 7: Meet your new friends: the output colors.

	COLOR = out_color;
	COLOR.a = alpa_input;

// 8: Profit.
	}
	vec4 previous_pass = texture(TEXTURE, UV);
	vec3 glare = vec3((FRAGCOORD.x / (1.0 / TEXTURE_PIXEL_SIZE.x)) / 2.0 + (FRAGCOORD.y / (1.0 / TEXTURE_PIXEL_SIZE.y)) / 2.0);
	
	// SETUP LCD BACK
	

	int modulusX = int(mod(FRAGCOORD.x - (1.0 / TEXTURE_PIXEL_SIZE.x), dot_size));
	int modulusY = int(mod(FRAGCOORD.y - (1.0 / TEXTURE_PIXEL_SIZE.x), dot_size));
	
	// SETUP LCD SQUARES
	if(enable_dot_matrix){
		if(	FRAGCOORD.x < (1.0/TEXTURE_PIXEL_SIZE.x) - border_size
			&& FRAGCOORD.x > border_size
			&& FRAGCOORD.y > border_size
			&& FRAGCOORD.y < (1.0/TEXTURE_PIXEL_SIZE.y) - border_size){
			
			if((modulusX != 0 && modulusY != 0)){
				COLOR.xyz = mix(COLOR.xyz, vec3(0.0,0.0,0.0), lcd_dark_square_transparency);
			}
		}
	}

	// SETUP COLORED PIXELS
	float pixel_whiteness = previous_pass.x;
	vec4 colored_frame = vec4(COLOR.r, COLOR.b, COLOR.g, 1.0 - brightness * (1.0 - previous_pass.x) * 0.5 * previous_pass.a);
	
	if(abs(pixel_whiteness - 248.0/255.0) < 0.01 || COLOR.a == 0.0){

	}else{
		if(enable_dot_matrix){
			if((modulusX != 0 && modulusY != 0)){
				COLOR = mix(color3, COLOR, colored_frame.a);
			}else{
				//PRIMITIVE SHADOW
				if(colored_frame.a > 0.0){
					COLOR = mix(color3, COLOR, 1.0 - pixel_shadow_amount * 1.0 * (1.0 - pixel_whiteness * 0.2));
				}
			}
		}else{
			COLOR = mix(colored_frame, COLOR, colored_frame.a);
		}
	}
	if(color_correction){
	COLOR.rgb *= 255.0;
	
	int r = int(COLOR.r);
	int g = int(COLOR.g);
	int b = int(COLOR.b);
	
	int R = (r * 13 + g * 2 + b) >> 4;
	int G = (g *  3 + b) >> 2;
	int B = (r *  3 + g * 2 + b * 11) >> 4;
	
	COLOR.rgb = vec3(float(R), float(G), float(B));
	COLOR.rgb /= 255.0;
	}
	COLOR.xyz += glare * glare_amount;
	
	
}
