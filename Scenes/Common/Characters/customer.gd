class_name Customer extends Node3D

signal start_walking();
signal stop_walking();
signal at_queue_front();
signal approach_counter();
signal place_order(order: CustomerOrder);
signal order_completed(canceled: bool);
signal immediate_exit();

@export var visual_node: Node3D;
@export var cafe_path: CafePath;

@export var order: CustomerOrder;

@export var mugshot_viewport: SubViewport;
var mugshot: Texture;

@export_group("Animation Properties")
@export var animation_state_machine: CustomerStateMachine;

@export var idle_state: CustomerState;
@export var walking_state: CustomerState;

@export var speech_bubble_scene: PackedScene;
@export var speech_location: Node3D;

@export_group("Queuing Properties")
@export var queue_state_machine: CustomerStateMachine;
@export var next_up: CustomerState;

@export var velocity: float = 1.0;
@export var radius: float = 0.5;

func is_customer_idle() -> bool:
    return animation_state_machine.current_state == idle_state;

func is_customer_walking() -> bool:
    return animation_state_machine.current_state == walking_state;

func get_customer_path() -> CustomerPath:
    return CustomerPath.get_active_path();

func is_customer_ready() -> bool:
    return queue_state_machine.current_state == next_up;

func speak(render_function: Callable, duration: float = 3.) -> void:
    var bubble: SpeechBubble = speech_bubble_scene.instantiate();
    add_child(bubble);
    bubble.track_position = speech_location;
    bubble.prepare_display(render_function, duration);
    bubble.global_position = Vector2(-1000,-1000);

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("debug"):
        speak.call_deferred(debug_render_message);

func force_exit() -> void:
    immediate_exit.emit.call_deferred();

func _on_place_order(_order: CustomerOrder) -> void:
    _capture_image.call_deferred();

func _capture_image() -> void:
    await get_mugshot();

func get_mugshot() -> Texture:
    if mugshot:
        return mugshot;
    await RenderingServer.frame_post_draw;
    mugshot = ImageTexture.create_from_image(mugshot_viewport.get_texture().get_image());
    mugshot_viewport.queue_free();
    return mugshot;

# This just pushes out a generic message for testing
func debug_render_message(label: RichTextLabel) -> void:
    label.text = "";
    label.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER );
    label.push_font_size(16);
    label.append_text("HELLO THERE!");
    #label.add_image(debug_texture, 16, 16);
    label.pop()
    label.pop();
