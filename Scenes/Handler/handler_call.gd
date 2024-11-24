class_name HandlerCall extends Node

static var _active_handler: HandlerCall;
func _ready() -> void:
    _active_handler = self;

static func get_active_handler() -> HandlerCall:
    return _active_handler;

