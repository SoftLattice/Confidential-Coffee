class_name SpeechBubble extends Node2D

@export var track_position: Node3D;
@export var tail_node: Node2D;
@export var bubble_container: Control;

@export var display_label: RichTextLabel;
@export var label_options: Array[RichTextLabel];

signal timeout();

func _process(_delta: float) -> void:
    if is_instance_valid(track_position):
        track_target();

func track_target() -> void:
    var cam: Camera3D = get_viewport().get_camera_3d();
    var target_position: Vector2 = to_local(cam.unproject_position(track_position.global_position));

    var viewport_bounds: Vector2 = get_viewport().get_visible_rect().size - bubble_container.size;
    var new_global_position: Vector2 = to_global(target_position - tail_node.position);

    global_position = new_global_position.clamp(Vector2.ZERO, viewport_bounds);


var all_labels: Array[RichTextLabel];
func prepare_display(render_function: Callable, duration: float = 3.) -> void:
    # Render all the options for labels...
    for label in label_options:
        render_function.call(label);

    render_function.call(display_label);

    # Figure out the smallest (vertical_ size)
    await RenderingServer.frame_post_draw;
    var label_sizes: Array[float] = [];
    for label in label_options:
        label_sizes.append(label.size.y);
    
    var best_label: int = 0;
    for i in range(label_sizes.size()):
        if label_sizes[i] < label_sizes[best_label]:
            best_label = i;

    display_label.custom_minimum_size = label_options[best_label].size;
    for label in label_options:
        label.queue_free();

    if duration > 0:
        await get_tree().create_timer(duration).timeout;
        timeout.emit();
        queue_free();


func _on_margin_container_resized() -> void:
    tail_node.position = Vector2(0, bubble_container.size.y);