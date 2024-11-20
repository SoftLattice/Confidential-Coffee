class_name AnimatedProduct extends Product

@export var animations: Array[AnimationResource];

func _enter_resource(order: Order, recipe: Recipe = null) -> void:
    if order.held_recipe != null:
        _play_animation(order.held_recipe, recipe);

func _play_animation(held_item: HeldRecipe, recipe: Recipe) -> void:
    for animation in animations:
        animation.play_animation(held_item);

    for animation in recipe.animations:
        animation.play_animation(held_item);