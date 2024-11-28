extends Node

@export_file("*.tscn") var main_menu: String;
@export_file("*.tscn") var cafe_scene: String;
@export_file("*.tscn") var handler_call: String;
@export_file("*.tscn") var market: String;
@export_file("*.tscn") var options_menu: String;
@export_file("*.tscn") var about_menu: String;

func load_scene(scene_location: String) -> void:
    get_tree().change_scene_to_file(scene_location);