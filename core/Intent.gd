class_name Intent
extends RefCounted

## Represents a resolved player intent, decoupled from the raw text that
## produced it. This is the contract between the parsing layer and the
## dispatch layer. Any future resolver -- keyword-based or LLM-based --
## only needs to produce Intent objects to be a drop-in replacement.

var action: String        # e.g. "show_oxygen", "craft_item", "invite_friend"
var args: Dictionary       # e.g. {"target": "medkit"}
var confidence: float      # 1.0 for exact keyword match; LLM resolvers can report < 1.0
var raw_text: String       # original input, kept for logging/debugging/fallback messages

func _init(p_action: String = "unknown", p_args: Dictionary = {}, p_confidence: float = 1.0, p_raw_text: String = "") -> void:
	action = p_action
	args = p_args
	confidence = p_confidence
	raw_text = p_raw_text
