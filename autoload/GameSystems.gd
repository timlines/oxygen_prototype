extends Node

## Autoload singleton. Central registry of gameplay systems.
##
## CommandDispatcher talks to these. These never talk back to text parsing --
## that separation is what lets the parser/resolver be replaced independently
## of gameplay logic, and vice versa.

var inventory: InventorySystem
var suit_status: SuitStatusSystem
var crafting: CraftingSystem
var friends: FriendsSystem
var objectives: ObjectivesSystem
var settings: SettingsSystem

func _ready() -> void:
	inventory = InventorySystem.new()
	suit_status = SuitStatusSystem.new()
	crafting = CraftingSystem.new(inventory)
	friends = FriendsSystem.new()
	objectives = ObjectivesSystem.new()
	settings = SettingsSystem.new()
