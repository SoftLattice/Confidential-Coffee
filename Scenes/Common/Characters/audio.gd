extends Node

@export var barks: Array[AudioStreamPlayer];

func bark() -> void:
    var _bark: AudioStreamPlayer = barks.pick_random();
    _bark.play();