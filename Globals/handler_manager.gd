extends Node

@export var bad_intel_count: int = 0;
@export var warn_player: bool = false;

const BASE_INTEL_DEPOSIT: int = 50;
@export var intel_deposit = BASE_INTEL_DEPOSIT;

@export var flag_bonus: int = 25;
@export var verb_bouns: int = 25;

@export var phone_sound: AudioStreamPlayer;
@export var phone_pickup: AudioStreamPlayer;

func _ready() -> void:
    CustomerManager.spawn_parameters_changes.connect(recompute_bonus);

func recompute_bonus() -> void:
    intel_deposit = BASE_INTEL_DEPOSIT;
    intel_deposit += flag_bonus * CustomerManager.flags_used;
    intel_deposit += verb_bouns * CustomerManager.verbs_used;