shader_type canvas_item;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	float speed = 2.0;
	float min_value = 0.1;
	COLOR = vec4(original_color.r, original_color.g, original_color.b, original_color.a * min_value + (sin(original_color.a * TIME * speed) + original_color.a * 1.0) * (0.5 - (min_value * 0.5)));
}
