extends Control

@export var speech_bubble_scene: PackedScene;
@export var receiver_position: Node3D;

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("debug"):
        _handler_speak();

func _handler_speak() -> void:
    speak(debug_render_message);

func speak(render_function: Callable, duration: float = 3.) -> void:
    var bubble: SpeechBubble = speech_bubble_scene.instantiate();
    add_child(bubble);
    bubble.track_position = receiver_position;
    bubble.prepare_display(render_function, duration);
    bubble.global_position = Vector2(-1000,-1000);

# This just pushes out a generic message for testing
func debug_render_message(label: RichTextLabel) -> void:
    label.text = "";
    label.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER );
    label.push_font_size(16);
    label.append_text("HELLO THERE!");
    #label.add_image(debug_texture, 16, 16);
    label.pop()
    label.pop();