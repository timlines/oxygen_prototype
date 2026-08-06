extends Node

## Autoload singleton. Layer 3 of the pipeline:
##   Command Parser -> Intent Resolver -> [Command Dispatcher] -> Game System
##
## Single responsibility: map an Intent's action to exactly one game-system
## call and return a terminal-formatted string. No text parsing happens
## here, and no gameplay system ever parses player text directly.

signal command_executed(intent: Intent, response: String)

func dispatch(intent: Intent) -> String:
	var response := _route(intent)
	command_executed.emit(intent, response)
	return response

func _route(intent: Intent) -> String:
	match intent.action:
		"help":
			return _help_text()
		"show_inventory":
			return GameSystems.inventory.get_report()
		"show_oxygen":
			return GameSystems.suit_status.get_oxygen_report()
		"show_status":
			return GameSystems.suit_status.get_full_report()
		"show_location":
			return GameSystems.objectives.get_location_report()
		"show_objectives":
			return GameSystems.objectives.get_report()
		"show_friends":
			return GameSystems.friends.get_report()
		"craft_item":
			return GameSystems.crafting.craft(intent.args.get("target", ""))
		"equip_item":
			return GameSystems.inventory.equip(intent.args.get("target", ""))
		"invite_friend":
			return GameSystems.friends.invite(intent.args.get("target", ""))
		"lower_music":
			return GameSystems.settings.adjust_music(-10)
		"raise_music":
			return GameSystems.settings.adjust_music(10)
		"open_settings":
			return GameSystems.settings.get_report()
		"quit_game":
			get_tree().quit()
			return "Shutting down..."
		"empty":
			return ""
		_:
			return "Unrecognized command: \"%s\"\nType \"help\" for a list of what I understand." % intent.raw_text

func _help_text() -> String:
	return "\n".join([
		"Available commands",
		"-------------------",
		"help                  Show this list",
		"inventory             Show carried items",
		"oxygen                Show suit oxygen status",
		"status                Show full suit status",
		"where am i            Show current location",
		"objectives            Show active objectives",
		"friends               Show friends list",
		"craft <item>          Craft an item (try: craft medkit)",
		"equip <item>          Equip an item (try: equip pistol)",
		"invite <name>         Invite a friend (try: invite Kaylee)",
		"lower music           Decrease music volume",
		"raise music           Increase music volume",
		"settings              Open settings",
		"quit                  Quit the game",
	])
