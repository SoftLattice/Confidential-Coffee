class_name HandlerCall extends Node

signal end_day();
signal disappointed();
signal satisfied();
signal receipt_picture(customer_result: CustomerResult);

signal request_picture()
signal stop_picture();

@export var items_area: ItemsArea;
@export var handler_speech: HandlerSpeech;
@export var fadeout_rect: ColorRect;

@export var debug_customer_results: Array[CustomerResult];

var customer_results: Array[CustomerResult];

static var _active_handler: HandlerCall;
static func get_active_handler() -> HandlerCall:
    return _active_handler;

func _ready() -> void:
    _active_handler = self;

    if debug_customer_results:
        customer_results.assign(debug_customer_results);
    else:
        customer_results.assign(CafeManager.customer_results);
        CafeManager.customer_results.clear();

    for customer_result in customer_results:
        _spawn_receipt(customer_result);

    if customer_results.size() < 1:
        disappointed.emit.call_deferred();
        return;

    # Shuffle the results
    customer_results.shuffle();
    satisfied.emit.call_deferred();

func _spawn_receipt(customer_result: CustomerResult) -> void:
    items_area.spawn_receipt.call_deferred(customer_result);

func _spawn_mugshot(customer_result: CustomerResult) -> void:
    items_area.spawn_customer_picture(customer_result);

var active_customer_result: CustomerResult = null;
func speak(render_bubble: Callable, duration: float) -> SpeechBubble:
    return handler_speech.speak(render_bubble, duration);

func _on_goto_bed() -> void:
    end_day.emit.call_deferred();
    fadeout_rect.visible = true;
    var sleep_tween: Tween = create_tween();
    sleep_tween.tween_property(fadeout_rect, "color:a", 1., 3.);
    await sleep_tween.finished;

    get_tree().change_scene_to_file(SceneList.cafe_scene);


func _on_receipt_picture(customer_result: CustomerResult) -> void:
    receipt_picture.emit.call_deferred(customer_result);
    print("RECEIVED A PICTURE!");