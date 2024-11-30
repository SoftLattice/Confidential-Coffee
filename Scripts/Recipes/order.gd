class_name Order extends ReceiptResource

@export var product: Product;
@export var modifiers: Array[ProductModifier];

var held_recipe: HeldRecipe;

func clear_status() -> void:
    product.clear_status();
    for modifier in modifiers:
        modifier.clear_status();

func set_held_recipe(held_item: HeldRecipe) -> void:
    held_recipe = held_item;

func _update(_delta: float) -> void:
    pass;

func print_to_label(label: RichTextLabel) -> int:
    var lines_out = 0;
    lines_out += product.print_to_label(label);
    for modifier in modifiers:
        label.append_text("\n");
        lines_out += modifier.print_to_label(label);
    return lines_out;

# Assign a new product
func set_product(recipe: Recipe = null) -> void:
    if product != null:
        product._exit_resource.call_deferred(self);
    product = recipe.product;
    product._enter_resource.call_deferred(self, recipe);

func add_modifier(modifier: ProductModifier) -> bool:
    if can_modify_product(modifier):
        if modifiers.has(modifier):
            return false;
        modifiers.append(modifier);
        modifier._enter_resource.call_deferred(self)
        return true;
    return false;

func can_mix_product(addition: Product) -> Recipe:
    if product == null:
        return NullRecipe.new(addition);

    return RecipeManager.mix_recipes(product, addition);

func can_modify_product(addition: ProductModifier) -> bool:
    if product == null:
        return false;
    return addition in product.allowed_modifiers;

const SAME_ORDER: int = 0;
const DIFFERENT_MODIFIERS: int = 1;
const DIFFERENT_ORDER: int = -1;

func compare_order(other: Order) -> int:
    if other.product == product:
        if modifiers.all(func(m: ProductModifier) -> bool: return other.modifiers.has(m)):
            if other.modifiers.all(func(m: ProductModifier) -> bool: return modifiers.has(m)):
                return SAME_ORDER;
        return DIFFERENT_MODIFIERS;
    return DIFFERENT_ORDER;
