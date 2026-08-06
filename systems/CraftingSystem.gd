class_name CraftingSystem
extends RefCounted

## Mock crafting system. Depends only on InventorySystem, injected
## explicitly in the constructor rather than reached for globally, so the
## dependency graph stays visible and testable.

var _inventory: InventorySystem

const RECIPES := {
	"medkit": {"iron": 2, "water": 1},
	"oxygen filter": {"iron": 3},
}

func _init(inventory: InventorySystem) -> void:
	_inventory = inventory

func craft(item_name: String) -> String:
	if item_name.is_empty():
		return "Craft what? Try \"craft medkit\"."
	if not RECIPES.has(item_name):
		return "No known recipe for \"%s\"." % item_name

	var recipe: Dictionary = RECIPES[item_name]
	for ingredient: String in recipe.keys():
		if _inventory.items.get(ingredient, 0) < recipe[ingredient]:
			return "Not enough %s to craft %s." % [ingredient, item_name]

	for ingredient: String in recipe.keys():
		_inventory.remove_item(ingredient, recipe[ingredient])
	_inventory.add_item(item_name, 1)

	return "Crafted 1x %s." % item_name.capitalize()
