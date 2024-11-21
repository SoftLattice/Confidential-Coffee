extends MarginContainer

@export var clock_hand: Node2D;
@export var day_length: float = 10;
@export var timer: Timer;
var day_length_factor: float = TAU / day_length;

func _start_clock() -> void:
    pass;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    #if timer.time_left
    clock_hand.rotate(day_length_factor * delta);

func _on_start_timer() -> void:
    print("Starting timer!");