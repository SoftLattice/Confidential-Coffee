class_name OptionsMenu extends Node

@export var quit_button: Button;

func _ready() -> void:
    if get_tree().current_scene != self:
        quit_button.visible = true;

func _on_back_pressed() -> void:
    if get_tree().current_scene == self:
        SceneList.load_scene(SceneList.main_menu);
    else:
        get_tree().paused = false;
        queue_free();

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_cancel"):
        _on_back_pressed();

func _on_quit_pressed() -> void:
    SceneList.load_scene(SceneList.main_menu);
