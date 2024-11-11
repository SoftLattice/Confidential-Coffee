class_name Customer extends Node3D

signal start_walking();
signal stop_walking();
signal at_queue_front();
signal approach_counter();
signal place_order(order: CustomerOrder);
signal order_completed(canceled: bool);

@export var character_texture: Texture2D;
@export var visual_node: Node3D;
@export var cafe_path: CafePath;

@export var order: CustomerOrder;

@export_group("Animation Properties")
@export var animation_state_machine: CustomerStateMachine;

@export var idle_state: CustomerState;
@export var walking_state: CustomerState;

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
    return get_parent().get_node("%CustomerPath");

func is_customer_ready() -> bool:
    return queue_state_machine.current_state == next_up;