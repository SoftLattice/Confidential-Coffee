class_name SpawnAnimation extends AnimationResource

@export var spawn_scene: PackedScene;

func play_animation(held_item: HeldRecipe) -> void:
	var spawned_node: SpawnedNode = spawn_scene.instantiate();
	held_item.add_child(spawned_node);
	spawned_node._set_container.call_deferred(held_item);
