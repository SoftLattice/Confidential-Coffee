shader_type spatial;

uniform vec4 liquid_color : source_color;
uniform float liquid_height = 2.18;

void vertex() {
	VERTEX.y = min(VERTEX.y, liquid_height);
}

void fragment() {
	ALBEDO = liquid_color.rgb;
    METALLIC = 0.7;
}

