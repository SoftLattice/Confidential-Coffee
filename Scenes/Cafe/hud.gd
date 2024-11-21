class_name CafeHUD extends Control

@export var sell_key: RegisterKey;
@export var cancel_key: RegisterKey;

signal start_timer();

func _on_start_day():
    start_timer.emit.call_deferred();