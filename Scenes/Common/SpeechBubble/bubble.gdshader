shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D viewport_texture;

void vertex() {
  POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	ALBEDO = texture(viewport_texture, UV).rgb;
	ALPHA = texture(viewport_texture, UV).a;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
