extends Control

@export var timer: Timer;
@export var display_duration: float = 3.;

signal finished();
signal preamble_start();

func _ready() -> void:
    timer.wait_time = display_duration;
    preamble_start.emit.call_deferred();
    timer.start.call_deferred();

func _on_timer_timeout() -> void:
    finished.emit.call_deferred();
    queue_free();