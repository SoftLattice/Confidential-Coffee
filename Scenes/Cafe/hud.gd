class_name CafeHUD extends Control

@export var sell_key: RegisterKey;
@export var cancel_key: RegisterKey;
@export var cafe_clock: CafeClock;

signal start_timer();

func _on_start_day() -> void:
    start_timer.emit.call_deferred();

func get_time() -> String:
    return cafe_clock.get_time();
