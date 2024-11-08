extends Node2D

@export var bubble_control: BubbleControl;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await bubble_control.prepare_display(bubble_control.render_message);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
