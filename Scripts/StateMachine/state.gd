class_name State extends Node

signal enter_state();
signal transitioned(new_state: String);

var _is_active_state: bool = false;
var machine: StateMachine;

func _initialize_state() -> void:
	pass;

func _enter_state() -> void:
	pass;

func _exit_state() -> void:
	pass;

func _update(_delta: float) -> void:
	pass;

func _physics_update(_delta: float) -> void:
	pass;