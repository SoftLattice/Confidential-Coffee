class_name Customer extends Node3D

signal start_walking();
signal stop_walking();
signal at_queue_front();
signal approach_counter();
signal place_order(order: CustomerOrder);
signal order_completed(canceled: bool);
signal immediate_exit();

@export var visual_node: Node3D;
@export var person_sprite: Sprite3D;
@export var flag: Sprite3D;
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
@export var utter_timer: Timer;
@export var utter_interval: float = 3.;

@export_group("Queuing Properties")
@export var queue_state_machine: CustomerStateMachine;
@export var next_up: CustomerState;

@export var velocity: float = 1.0;
@export var radius: float = 0.5;

func set_flag_index(index: int) -> void:
    flag.frame = index % 8;

func is_customer_idle() -> bool:
    return animation_state_machine.current_state == idle_state;

func is_customer_walking() -> bool:
    return animation_state_machine.current_state == walking_state;

func get_customer_path() -> CustomerPath:
    return CustomerPath.get_active_path();

func is_customer_ready() -> bool:
    return queue_state_machine.current_state == next_up;

var _active_bubble: SpeechBubble;
func speak(render_function: Callable, duration: float = 2.) -> void:
    if is_instance_valid(_active_bubble):
        _active_bubble.queue_free();

    var bubble: SpeechBubble = speech_bubble_scene.instantiate();
    bubble.z_index = roundi(-10 * counter_distance);
    add_child(bubble);
    bubble.prepare_display(render_function, duration);
    bubble.track_position = speech_location;
    _active_bubble = bubble;

var phrase_seed: Array[int] = [];
func set_phrase(index: Array[int]) -> void:
    phrase_seed = index;

var _has_uttered: bool = false;
func _utter_phrase() -> void:
    if !is_instance_valid(utter_timer):
        return;
        
    utter_timer.start(utter_interval + randf_range(-0.5,2.));
    if phrase_seed:
        if counter_distance < 0.1:
            var phrase: Array[Texture] = CustomerManager.get_phrase_icons(phrase_seed);
            speak.call_deferred(render_phrase.bind(phrase));
            _has_uttered = true;
    else:
        utter_timer.queue_free();


func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("debug"):
        _utter_phrase();

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

func render_phrase(label: RichTextLabel, icons: Array[Texture]) -> void:
    label.text = "";
    label.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER );
    var icon_size: Vector2 = Vector2(16,16).lerp(Vector2(4,4),counter_distance);
    for icon in icons:
        label.add_image(icon, roundi(icon_size.x), roundi(icon_size.y));
        label.append_text(" ");
    label.pop();

var counter_distance: float = 1.0;
func _on_counter_distance_change(dist:float) -> void:
    counter_distance = dist;
    var person_shader: ShaderMaterial = person_sprite.material_override;
    person_shader.set_shader_parameter("modulate_strength", counter_distance);
    var flag_overlay: StandardMaterial3D = flag.material_overlay;
    flag_overlay.albedo_color = Color(0.5,0.5,0.5,dist);


func _on_start_exit() -> void:
    if is_instance_valid(utter_timer):
        utter_timer.queue_free();
