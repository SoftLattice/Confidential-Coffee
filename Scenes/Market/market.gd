class_name Market extends Node

signal purchase(value: int);
signal funds_change(value: int);
signal daily_expenses(value: int);
signal deposit(value: int);

@export var rating_texture: TextureRect;
@export var rating_count_label: Label;

@export var store_item_list: Container;

@export var store_item_scene: PackedScene;

static var _active_market: Market;
static func get_market() -> Market:
    return _active_market;

func _ready() -> void:
    _active_market = self;
    (rating_texture.material as ShaderMaterial).set_shader_parameter("filled",CafeManager.rating);
    rating_count_label.text = "(%d)"%[CafeManager.rating_count];

    for item in CafeManager.available_store_purchases:
        var store_item: StoreItem = store_item_scene.instantiate();
        store_item.set_purchase(item);
        store_item_list.add_child(store_item);
        store_item.purchase_item.connect(_on_purchase.bind(store_item));
        funds_change.connect(store_item._on_funds_change);

    CafeManager.funds -= CafeManager.daily_expenses;
    daily_expenses.emit.call_deferred(CafeManager.daily_expenses);
    funds_change.emit(CafeManager.funds);
    CafeManager.daily_expenses = 0;

    await get_tree().create_timer(1.5).timeout;
    CafeManager.funds += CafeManager.deposits;
    funds_change.emit.call_deferred(CafeManager.funds);
    deposit.emit.call_deferred(CafeManager.deposits);
    CafeManager.deposits = 0;

func _on_purchase(store_item: StoreItem) -> void:
    CafeManager.funds -= store_item.purchase.price;
    purchase.emit.call_deferred(store_item.purchase.price);
    funds_change.emit.call_deferred(CafeManager.funds);
    store_item.queue_free();

    store_item.purchase.action_purchase.call_deferred()

func _on_continue_pressed() -> void:
    if CafeManager.funds < 0:
        SceneList.load_scene(SceneList.game_over_bankruptcy);
    else:
        SaveData.current_day += 1;
        CafeManager.daily_expenses += 2;
        SceneList.load_scene(SceneList.cafe_scene);