class_name BasicPoured extends PouredProduct

@export var color: Color;

func animate_addition(held_recipe: HeldRecipe) -> void:
    if held_recipe is LiquidContainer:
        (held_recipe as LiquidContainer).fill_liquid(color);