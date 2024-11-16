class_name PlayerHand extends Marker3D

signal hold_item();
signal release_item();

@export_category("Holdable Models")
@export var paper_cup_scene: PackedScene;

var held_item: Node3D = null;

static var _active_hand: PlayerHand;
static func get_active_hand() -> PlayerHand:
    return _active_hand;

func _ready() -> void:
    _active_hand = self;

func _on_take_cup() -> void:
    if held_item == null:
        var paper_cup = paper_cup_scene.instantiate();
        add_child(paper_cup);
        held_item = paper_cup;
        hold_item.emit.call_deferred();

func take_item(held_recipe: HeldRecipe) -> bool:
    if held_item == null:
        held_recipe.reparent(self);
        held_recipe.position = Vector3.ZERO;
        held_item = held_recipe;
        return true;
    return false;

func _on_deliver_item() -> void:
    held_item = null;