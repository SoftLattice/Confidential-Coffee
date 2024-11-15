shader_type spatial;

uniform float liquid_fraction = 1.0;

uniform vec4 liquid_color : source_color;

void vertex() {
	mat4 transform = mat4(liquid_fraction);
	VERTEX = (transform * vec4(VERTEX,1.)).xyz;
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = liquid_color.rgb;
	ALPHA = liquid_color.a;
}
