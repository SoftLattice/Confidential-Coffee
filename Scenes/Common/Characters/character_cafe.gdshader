shader_type spatial;
render_mode unshaded;

uniform vec4 modulate_color : source_color = vec4(0.5,0.5,0.5,1.);
uniform float modulate_strength = 0.0;
varying float test;
uniform sampler2D albedo_texture : source_color, filter_nearest;

void fragment() {
	ALBEDO = mix(texture(albedo_texture, UV).rgb,modulate_color.rgb, modulate_strength);
	ALPHA = texture(albedo_texture, UV).a;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
