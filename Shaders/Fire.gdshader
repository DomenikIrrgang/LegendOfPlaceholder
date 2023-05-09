shader_type canvas_item;

uniform sampler2D noise_tex : repeat_enable;
uniform sampler2D gradient_tex;

uniform vec4 brighter_color : source_color = vec4(1.0, 0.28, 0.0, 1.0);
uniform vec4 middle_color : source_color  = vec4(1.0, 0.56, 0.0, 1.0);
uniform vec4 darker_color : source_color  = vec4(0.64, 0.22, 0.05, 1.0);

uniform float spread : hint_range(0.0, 1.0) = 0.45;


void fragment()
{
	
	float noise_value = texture(noise_tex, UV + vec2(0, TIME)).x;
	// The .yx swizzle is when using the built in horizontal gradient texture. If you have a vertical gradient texture remove .yx
	float gradient_value = texture(gradient_tex, UV.yx).x;
	
	gradient_value -= smoothstep(spread, spread + 0.5, length(UV + vec2(-0.5, -0.5)) / spread);
	
	float step1 = step(noise_value, gradient_value);
	float step2 = step(noise_value, gradient_value - 0.1);
	float step3 = step(noise_value, gradient_value - 0.44);
	
	vec3 bd_color = mix(brighter_color.rgb, darker_color.rgb, step1 - step2);
	
	vec4 color = vec4(bd_color, step1);
	color.rgb = mix(color.rgb, middle_color.rgb, step2 - step3);
	
	COLOR = color;
}