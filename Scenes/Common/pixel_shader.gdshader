shader_type spatial;
// Prevent the quad from being affected by lighting and fog. This also improves performance.
render_mode unshaded, fog_disabled;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void vertex() {
  POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	vec3 pixel_color = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	ALBEDO = pixel_color;
	ALPHA = 0.;
}
