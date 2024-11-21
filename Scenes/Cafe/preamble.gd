extends Control

@export var timer: Timer;
@export var display_duration: float = 5.;

signal finished();

func _ready() -> void:
    timer.wait_time = display_duration;
    timer.start.call_deferred();

func _on_timer_timeout() -> void:
    finished.emit.call_deferred();
    queue_free();