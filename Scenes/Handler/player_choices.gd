extends Control

@export var main_container: Control;

@export var verb_container: Control;
@export var flag_container: Control;

@export var verb_texture: TextureRect;
@export var flag_texture: TextureRect;

signal submit_phrase(phrase: Array[int]);

var verb_buttons: Array[Button];
var flag_buttons: Array[Button];

func _ready() -> void:
    verb_buttons.assign(
            verb_container.get_children().filter(
                func(n:Node) -> bool: return n is Button
            )
        );

    for i in range(verb_buttons.size()):
        if i >= CustomerManager.verbs_used:
            verb_buttons[i].queue_free();
    verb_buttons.resize(CustomerManager.verbs_used);

    flag_buttons.assign(
            flag_container.get_children().filter(
                func(n:Node) -> bool: return n is Button
            )
        );

    for i in range(flag_buttons.size()):
        if i >= CustomerManager.flags_used:
            flag_buttons[i].queue_free();
    flag_buttons.resize(CustomerManager.flags_used);

    for i in range(verb_buttons.size()):
        verb_buttons[i].pressed.connect(_on_verb_press.bind(i));

    for i in range(flag_buttons.size()):
        flag_buttons[i].pressed.connect(_on_flag_press.bind(i));

var _selected_verb: int = -1;
var _selected_flag: int = -1;

func _on_verb_press(index: int) -> void:
    verb_texture.texture = CustomerManager.verb_icons[index];
    _selected_verb = index;

func _on_flag_press(index: int) -> void:
    flag_texture.texture = CustomerManager.country_icons[index];
    _selected_flag = index;


var is_in: bool = false;
func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("debug"):
        if is_in:
            pop_out();
        else:
            pop_in();

func pop_in() -> void:
    is_in = true;
    _selected_verb = -1;
    _selected_flag = -1;
    verb_texture.texture = null;
    flag_texture.texture = null;
    var pop_tween: Tween = create_tween();
    pop_tween.bind_node(self).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE);
    var pop_height = get_viewport().get_visible_rect().size.y;
    pop_tween.tween_property(self, "global_position:y", pop_height, 1.25);

func pop_out() -> void:
    is_in = false;
    var pop_tween: Tween = create_tween();
    pop_tween.bind_node(self).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD);
    var pop_height = get_viewport().get_visible_rect().size.y + main_container.size.y;
    pop_tween.tween_property(self, "global_position:y", pop_height, 0.75);


func _on_send() -> void:
    var result: Array[int] = [_selected_verb,_selected_flag];
    submit_phrase.emit.call_deferred(result);
    pop_out();
