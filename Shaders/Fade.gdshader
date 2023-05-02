shader_type canvas_item;

uniform float speed = 2.0;
uniform float min_value = 0.1;
uniform float max_value = 0.5;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	float min_alpha = original_color.a * min_value;
	float min_value_factor = 0.5 - (min_value * 0.5);
	float alpha_new = (sin(original_color.a * TIME * speed) + 1.0) * 0.5;
	float alpha = min_value + (max_value - min_value) * alpha_new;
	if (original_color.a == 0.0) {
		alpha = 0.0;
	}
	COLOR = vec4(original_color.r, original_color.g, original_color.b, alpha);
}
