class_name HandlerScene extends Node

static var _active_handler: HandlerScene;
func _ready() -> void:
    _active_handler = self;

static func get_active_handler() -> HandlerScene:
    return _active_handler;

@export var debug_order: CustomerOrder;
