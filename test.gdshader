shader_type spatial;

uniform vec3 array[1];

void fragment() {
	ALBEDO = array[0];
}
