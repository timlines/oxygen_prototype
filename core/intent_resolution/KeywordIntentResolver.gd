class_name KeywordIntentResolver
extends IntentResolverBase

## MVP intent resolver. Matches normalized text against keyword sets.
##
## This is intentionally "dumb" -- the point of the architecture is that
## this entire class can be deleted and replaced by an LLM call without
## touching CommandDispatcher or any gameplay system. Everything downstream
## only ever sees an Intent.

## Actions that take no argument. Matched if the input contains ANY
## keyword in the list.
const SIMPLE_KEYWORDS := {
	"help": ["help", "commands", "?"],
	"show_inventory": ["inventory", "items", "bag"],
	"show_oxygen": ["oxygen", "o2", "air", "breathing", "suit oxygen"],
	"show_status": ["status", "how am i", "health"],
	"show_location": ["where am i", "location", "position"],
	"show_objectives": ["objectives", "quests", "tasks", "goals"],
	"show_friends": ["friends", "friend list", "social"],
	"lower_music": ["lower music", "quieter music", "turn down music"],
	"raise_music": ["raise music", "louder music", "turn up music"],
	"open_settings": ["settings", "options", "preferences"],
	"quit_game": ["quit", "exit game", "close game"],
}

## Actions that take the remainder of the input as a single "target" arg.
## Checked before SIMPLE_KEYWORDS since they are more specific matches.
const ARG_KEYWORDS := {
	"craft_item": ["craft", "make", "build"],
	"equip_item": ["equip", "wear", "wield"],
	"invite_friend": ["invite"],
}

func resolve(raw_text: String) -> Intent:
	var normalized := CommandParser.normalize(raw_text)

	if normalized.is_empty():
		return Intent.new("empty", {}, 1.0, raw_text)

	for action: String in ARG_KEYWORDS.keys():
		for keyword: String in ARG_KEYWORDS[action]:
			if normalized.begins_with(keyword + " ") or normalized == keyword:
				var remainder := normalized.substr(keyword.length()).strip_edges()
				return Intent.new(action, {"target": remainder}, 1.0, raw_text)

	for action: String in SIMPLE_KEYWORDS.keys():
		for keyword: String in SIMPLE_KEYWORDS[action]:
			if normalized.find(keyword) != -1:
				return Intent.new(action, {}, 1.0, raw_text)

	return Intent.new("unknown", {}, 0.0, raw_text)
