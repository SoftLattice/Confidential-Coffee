extends Node

@export var barks: Array[AudioStreamPlayer];

func _bark() -> void:
    barks.pick_random().play();