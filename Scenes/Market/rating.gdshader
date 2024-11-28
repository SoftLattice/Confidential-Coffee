shader_type canvas_item;

uniform float filled = 0.0;
uniform vec4 mask_color : source_color = vec4(1.,0.,1.,1.);
uniform vec4 gold_color : source_color = vec4(0.894,0.694,0.,1.);
uniform vec4 grey_color : source_color = vec4(0.3,0.3,0.3,1.);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    float out_select = step(UV.x,filled);

    vec4 color_out = (UV.x > filled) ? grey_color : gold_color;
    if (COLOR == mask_color) {
        COLOR = color_out;
    }
}
