class_name InventorySystem
extends RefCounted

## Mock inventory system. Holds placeholder item counts.
## A real implementation would read/write persistent save data; the
## public interface (get_report, add_item, remove_item, equip) is
## what CommandDispatcher depends on, so that swap wouldn't ripple outward.

var items: Dictionary = {
	"medkit": 2,
	"water": 5,
	"iron": 12,
}

var equipped: String = "none"

const EQUIPPABLE := ["pistol", "rifle", "suit", "helmet"]

func get_report() -> String:
	var lines := ["Inventory"]
	for item_name: String in items.keys():
		lines.append("  %s x%d" % [item_name.capitalize(), items[item_name]])
	lines.append("Equipped: %s" % equipped.capitalize())
	return "\n".join(lines)

func add_item(item_name: String, amount: int = 1) -> void:
	items[item_name] = items.get(item_name, 0) + amount

func remove_item(item_name: String, amount: int = 1) -> bool:
	if items.get(item_name, 0) < amount:
		return false
	items[item_name] -= amount
	return true

func equip(item_name: String) -> String:
	if item_name.is_empty():
		return "Equip what? Try \"equip pistol\"."
	if item_name in EQUIPPABLE:
		equipped = item_name
		return "Equipped %s." % item_name.capitalize()
	return "\"%s\" can't be equipped." % item_name
