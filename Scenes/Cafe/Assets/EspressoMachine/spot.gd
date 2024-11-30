extends Node3D

@export var placement_spot: Node3D;
@export var produces: Product;

@export var steam: GPUParticles3D;
@export var portafilter: Node3D;

signal start_steam();

var _active_item: LiquidContainer = null;
var _running: bool = false;

func _on_select() -> void:
    if _active_item == null:
        _receive_item();

func _receive_item() -> void:
    var new_item: HeldRecipe = PlayerHand.get_active_hand().held_item;
    if new_item == null:
        return;

    if new_item is LiquidContainer:
        var container: LiquidContainer = new_item;
        container.reparent(placement_spot);
        container.position = placement_spot.position;
        container.picked_up.connect(_on_item_removed.bind(container), CONNECT_ONE_SHOT);
        container.put_down.emit.call_deferred();
        PlayerHand.get_active_hand()._on_deliver_item();
        _active_item = container;
        
        if container.add_pourable(produces):
            container._can_take = false;
            _running = true;
            steam.emitting = true;
            var portafilter_tween: Tween = create_tween();
            portafilter_tween.bind_node(portafilter).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD);
            portafilter_tween.tween_property(portafilter, "rotation:y",-0.26, 0.25);
            portafilter_tween.tween_interval(steam.lifetime - 0.5);
            portafilter_tween.tween_property(portafilter, "rotation:y",0., 0.25);
            start_steam.emit.call_deferred();
            await portafilter_tween.finished;
            container._can_take = true;

func _on_item_removed(_container: LiquidContainer) -> void:
    _active_item = null;