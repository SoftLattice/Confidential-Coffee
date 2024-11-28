class_name Carafe extends ClickableAsset

signal filled();

@export var max_cups: float = 8;
@export var cups: float = 0;
@export var fill_time: float = 5;
@export var cooldown_time: float = 0.75;
@export var produces: Product;

@export var liquid: MeshInstance3D;
@onready var liquid_shader: ShaderMaterial = liquid.mesh.surface_get_material(0);

@export var max_liquid_height: float = 2.18;

func _ready() -> void:
    set_liquid_height(cups / max_cups);

func set_liquid_height(f: float) -> void:
    liquid_shader.set_shader_parameter("liquid_height", max_liquid_height * f);

var _is_busy: bool = false;
func _on_click() -> void:
    if _is_busy:
        return;

    var player_hand: PlayerHand = PlayerHand.get_active_hand();
    if player_hand.held_item is LiquidContainer:
        var container: LiquidContainer = player_hand.held_item;
        if cups >= container.volume and container.add_pourable(produces):
            _is_busy = true;
            var drain_tween: Tween = create_tween();
            drain_tween.bind_node(self);
            var old_cups: float = cups;
            cups = move_toward(cups, 0, 1.);
            drain_tween.tween_method(set_liquid_height, old_cups/max_cups, cups/max_cups, cooldown_time);
            drain_tween.tween_property(self, "_is_busy", false, 0);
        else:
            # TODO: Indicate carafe is empty
            pass;

func begin_filling() -> void:
    _is_busy = true;
    var fill_tween: Tween = create_tween();
    fill_tween.bind_node(self).set_parallel(true);
    fill_tween.tween_property(self, "cups", max_cups, fill_time);
    fill_tween.tween_method(set_liquid_height, cups/max_cups, 1., fill_time);
    fill_tween.set_parallel(false);
    fill_tween.tween_callback(filled.emit);
    fill_tween.tween_property(self, "_is_busy", false, 0);
