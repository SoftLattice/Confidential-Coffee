class_name CafeClock extends MarginContainer

signal day_finished();

@export var clock_hand: Node2D;
@export var day_length: float = 12;
@export var timer: Timer;

func _start_clock() -> void:
    pass;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    clock_hand.rotation = - TAU * timer.time_left / timer.wait_time;

func get_time() -> String:
    var time: float = day_length * (1. - (timer.time_left / timer.wait_time));
    var hour: int = floori(time);
    var minute: int = floori(60. * fposmod(time,1.));

    return "TIME: %02d:%02d" % [hour+6,minute];

func _on_start_timer() -> void:
    print("Starting timer!");

func _on_day_finished() -> void:
    print("DAY IS DONE!");
    day_finished.emit.call_deferred();