class_name HandlerSpeech extends Control

@export var speech_bubble_scene: PackedScene;
@export var receiver_position: Node3D;

func speak(render_function: Callable, duration: float = 3.) -> SpeechBubble:
    var bubble: SpeechBubble = speech_bubble_scene.instantiate();
    add_child(bubble);
    bubble.track_position = receiver_position;
    bubble.prepare_display(render_function, duration);
    bubble.global_position = Vector2(-1000,-1000);
    return bubble;
