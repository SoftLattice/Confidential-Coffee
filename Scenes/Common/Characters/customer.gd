class_name Customer extends Node3D

@export var character_texture: Texture2D;
@export var visual_node: Node3D;
@export var cafe_path: CafePath;
@export var state_machine: CustomerStateMachine;

signal changed_paths();
signal start_walking();
signal stop_walking();

func change_paths(new_path: CafePath) -> void:
    cafe_path  = new_path;
    new_path._on_join_path(self);
    changed_paths.emit();

const STATE_WALKING: String = "walking";

func current_state() -> String:
    return state_machine.current_state.name.to_lower();