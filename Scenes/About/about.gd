extends Node

func _on_back_pressed() -> void:
    SceneList.load_scene(SceneList.main_menu);
