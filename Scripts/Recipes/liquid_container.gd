class_name LiquidContainer extends HeldRecipe

@export var volume: float = 1.0;
@export var pour_time: float = 0.75;
@onready var liquid_material: ShaderMaterial = (%Liquid as MeshInstance3D).mesh.surface_get_material(0);

func set_liquid_level(f: float) -> void:
    liquid_material.set_shader_parameter("liquid_fraction", f);

func get_liquid_color() -> Color:
    return liquid_material.get_shader_parameter("liquid_color") as Color;

func set_liquid_color(color: Color) -> void:
    liquid_material.set_shader_parameter("liquid_color", color);

func fill_liquid(color: Color) -> void:
    set_liquid_color(color);
    var fill_tween: Tween = create_tween();
    fill_tween.bind_node(self).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD);
    fill_tween.tween_method(set_liquid_level, 0., 1., pour_time);

func modify_liquid(color: Color, f: float = 1.0) -> void:
    var color_tween: Tween = create_tween();
    color_tween.bind_node(self);
    var current_color: Color = get_liquid_color();
    var out_color: Color = current_color.lerp(color, f);
    color_tween.tween_method(set_liquid_color, current_color, out_color, pour_time);

func add_pourable(product: PouredProduct) -> bool:
    var result: Product = contents.can_mix_product(product);
    if result == null:
        return false;

    contents.product = result;
    contents.product.animate_addition(self);
    return true;


func add_sprinkles(_color: Color) -> void:
    printerr("Method not implemented");