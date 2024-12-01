extends Node

@export_file("*.tscn") var main_menu: String;
@export_file("*.tscn") var cafe_scene: String;
@export_file("*.tscn") var handler_call: String;
@export_file("*.tscn") var market: String;
@export_file("*.tscn") var options_menu: String;
@export_file("*.tscn") var about_menu: String;
@export_file("*.tscn") var game_over_bankruptcy: String;
@export_file("*.tscn") var game_over_arrest: String;
@export_file("*.tscn") var game_won: String;

@export var options_scene: PackedScene;

func load_scene(scene_location: String) -> void:
    get_tree().change_scene_to_file.call_deferred(scene_location);