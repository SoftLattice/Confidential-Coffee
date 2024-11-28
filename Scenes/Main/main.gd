extends Node

func _on_start_button_pressed() -> void:
    print("Going to start the game!");
    SceneList.load_scene(SceneList.cafe_scene);


func _on_options_button_pressed() -> void:
    SceneList.load_scene(SceneList.options_menu);


func _on_about_button_pressed() -> void:
    SceneList.load_scene(SceneList.about_menu);
