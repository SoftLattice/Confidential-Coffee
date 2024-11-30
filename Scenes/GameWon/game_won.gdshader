shader_type spatial;

uniform float height = 0.15;
uniform float amplitude = 0.25;
uniform vec4 color : source_color;

void vertex() {
	VERTEX.y += amplitude * sin(TIME) + height;
}

void fragment() {
	ALBEDO  = color.rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
