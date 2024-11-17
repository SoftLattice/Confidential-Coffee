class_name PaperCup extends LiquidContainer

@export var pour_stream: GPUParticles3D;
@export var sprinkle_stream: GPUParticles3D;

func fill_liquid(color: Color) -> void:
    super(color);
    var material: StandardMaterial3D = pour_stream.draw_pass_1.surface_get_material(0);
    pour_stream.lifetime = 0.9 * pour_time;
    material.albedo_color = color;
    pour_stream.emitting = true;

func add_sprinkles(color: Color) -> void:
    var material: StandardMaterial3D = sprinkle_stream.draw_pass_1.surface_get_material(0);
    sprinkle_stream.lifetime = pour_time;
    material.albedo_color = color;
    sprinkle_stream.emitting = true;
