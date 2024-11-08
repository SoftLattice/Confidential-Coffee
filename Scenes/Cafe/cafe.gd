extends Node

@export var day_intro: RichTextLabel;
@export var pcam_main: PhantomCamera3D;

func _ready() -> void:
	pcam_main = get_node("%PCamMainView");

@export var mark_primary: Node3D;
@export var mark_coffee: Node3D;

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		if pcam_main.look_at_target == mark_primary:
			pcam_main.look_at_target = mark_coffee;
		else:
			pcam_main.look_at_target = mark_primary;