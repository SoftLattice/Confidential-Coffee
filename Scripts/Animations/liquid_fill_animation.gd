class_name LiquidFillAnimation extends AnimationResource

@export var color: Color;
@export var pour_time: float = 0.7;
@export var amount: float = 1.0;

func play_animation(held_item: HeldRecipe) -> void:
    if !(held_item is LiquidContainer):
        return;
    
    var container: LiquidContainer = held_item as LiquidContainer;
    container.fill_liquid(color, pour_time, amount);