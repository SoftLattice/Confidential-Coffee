extends Node

@export var recipes: Array[Recipe];


func mix_recipes(base: Product, addition: Product) -> Recipe:
    for recipe in recipes:
        if recipe.base == base and recipe.addition == addition:
            return recipe;

    return null;