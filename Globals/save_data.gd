extends Node

var current_day: int = 1;

@export var _current_volume: float = 100;
@export var _current_sfx_volume: float = 100;

func _change_volume(value: float) -> void:
    var volume_index: int = AudioServer.get_bus_index("Master");
    _current_volume = value;
    AudioServer.set_bus_volume_db(volume_index, (value - 100.) * 0.5);

func _change_sfx(value: float) -> void:
    var sfx_index: int = AudioServer.get_bus_index("SoundEffects");
    _current_sfx_volume = value;
    AudioServer.set_bus_volume_db(sfx_index, (value - 100.) * 0.5);
