class_name Market extends Node

signal purchase(value: int);
signal funds_change(value: int);
signal daily_expenses(value: int);
signal daily_income(value: int);
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
    CafeManager.funds += CafeManager.daily_income;

    daily_expenses.emit.call_deferred(CafeManager.daily_expenses);
    daily_income.emit.call_deferred(CafeManager.daily_income);

    funds_change.emit(CafeManager.funds);
    CafeManager.daily_income = 0;

    await get_tree().create_timer(1.5).timeout;
    CafeManager.funds += CafeManager.deposits;

    deposit.emit.call_deferred(CafeManager.deposits);
    CafeManager.deposits = 0;

    funds_change.emit.call_deferred(CafeManager.funds);
    
func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_cancel"):
        var options: Node = SceneList.options_scene.instantiate();
        add_child(options);
        options.tree_exiting.connect(func() -> void: get_tree().paused = false, CONNECT_ONE_SHOT);
        get_tree().paused = true;

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
        CafeManager.daily_expenses += 1;
        SceneList.load_scene(SceneList.cafe_scene);

func _on_flee_country() -> void:
    SceneList.load_scene(SceneList.game_won);

