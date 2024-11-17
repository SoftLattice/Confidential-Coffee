class_name SprinkledModifier extends ProductModifier

@export var color: Color;

func animate_addition(held_recipe: HeldRecipe) -> void:
    if held_recipe.has_method("add_sprinkles"):
        held_recipe.add_sprinkles(color);
