shader_type spatial;

uniform float liquid_fraction = 1.0;
uniform float minimum_width = 0.7;
uniform vec4 liquid_color : source_color;

void vertex() {
    mat4 tform = mat4(1.);
    tform[0].x = mix(minimum_width,1.,liquid_fraction);
    tform[1].y = liquid_fraction;
    tform[2].z = mix(minimum_width,1.,liquid_fraction);
    VERTEX = (tform * vec4(VERTEX,1.)).xyz;
}

void fragment() {
	ALBEDO = liquid_color.rgb;
	ALPHA = liquid_color.a;
}
