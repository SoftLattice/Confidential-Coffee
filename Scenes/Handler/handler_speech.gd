class_name HandlerSpeech extends Control

@export var speech_bubble_scene: PackedScene;
@export var receiver_position: Node3D;

var _active_bubble: SpeechBubble = null;
func speak(render_function: Callable, duration: float = 3.) -> SpeechBubble:
    if is_instance_valid(_active_bubble):
        _active_bubble.queue_free();
        
    var bubble: SpeechBubble = speech_bubble_scene.instantiate();
    add_child(bubble);
    bubble.track_position = receiver_position;
    bubble.prepare_display(render_function, duration);
    bubble.global_position = Vector2(-1000,-1000);
    _active_bubble = bubble;
    return bubble;

func quiet() -> void:
    if _active_bubble:
        _active_bubble.queue_free();
