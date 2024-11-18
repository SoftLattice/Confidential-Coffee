class_name CafePath extends Node3D

signal path_opened();
signal stop_walking();
signal start_walking();
signal change_paths(new_path: CafePath);

@export var motion_path: Path3D;
@export var next_path: CafePath;

func _on_join_path(_customer: Customer) -> void:
    printerr("Method '_on_join_path' not implemented");

func is_path_open() -> bool:
    return false;