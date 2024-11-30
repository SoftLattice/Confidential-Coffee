extends Control

@export var timer: Timer;
@export var display_duration: float = 3.;

signal finished();
signal preamble_start();

func _ready() -> void:
    preamble_start.emit.call_deferred();

func _on_alarm_finish() -> void:
    finished.emit.call_deferred();
    queue_free();