class_name AnimatedProductModifier extends ProductModifier

@export var animations: Array[AnimationResource];

func _enter_resource(order: Order) -> void:
    if order.held_recipe != null:
        _play_animation(order.held_recipe);

func _play_animation(held_item: HeldRecipe) -> void:
    for animation in animations:
        animation.play_animation(held_item);