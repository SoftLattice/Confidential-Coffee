extends Node

@export_file("*.tscn") var cafe_scene: String;
@export_file("*.tscn") var handler_call: String;

func load_scene(scene_location: String) -> void:
    get_tree().change_scene_to_file(scene_location);