shader_type canvas_item;

uniform sampler2D tile_texture : filter_nearest;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    vec2 texture_size = vec2(textureSize(tile_texture,0));

    float screen_ratio = SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x; // W/H
    float tex_ratio = texture_size.y / texture_size.x;

    float z = ceil(screen_ratio * tex_ratio);

    COLOR = texture(tile_texture, vec2(mod(SCREEN_UV.x * z,1.),UV.y));
	// Called for every pixel the material is visible on.
}
