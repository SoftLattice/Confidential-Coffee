extends Control


@export var timer: Timer;

func _on_timer_timeout() -> void:
    SceneList.load_scene(SceneList.handler_call);

# TODO: Juice up the transition to screen
func _start_postamble() -> void:
    timer.start();
    visible = true;