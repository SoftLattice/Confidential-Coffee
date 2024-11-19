class_name LiquidModifyAnimation extends AnimationResource

@export var color: Color;
@export var pour_time: float = 0.7;
@export var intensity: float = 0.25;
@export var delay: float = 0.3;

func play_animation(held_item: HeldRecipe) -> void:
    if !(held_item is LiquidContainer):
        return;
    
    var container: LiquidContainer = held_item as LiquidContainer;
    held_item.get_tree().create_timer(delay).timeout.connect(
            container.modify_liquid.bind(color, pour_time, intensity)
        );