extends Node3D

@export var muffin_scene: PackedScene;

func _on_click() -> void:
    if PlayerHand.get_active_hand().held_item == null:
        var muffin: HeldRecipe = muffin_scene.instantiate();
        add_child(muffin);
        PlayerHand.get_active_hand().take_item.call_deferred(muffin);
