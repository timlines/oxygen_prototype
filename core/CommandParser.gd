class_name CommandParser
extends RefCounted

## Layer 1 of the pipeline:
##   Player Input -> [Command Parser] -> Intent Resolver -> Dispatcher -> System
##
## Single responsibility: normalize raw text. This layer knows nothing about
## intents, actions, or game systems, so it never needs to change when new
## commands or systems are added.

static func normalize(raw_text: String) -> String:
	var normalized := raw_text.strip_edges().to_lower()
	while normalized.find("  ") != -1:
		normalized = normalized.replace("  ", " ")
	return normalized

static func tokenize(raw_text: String) -> PackedStringArray:
	return normalize(raw_text).split(" ", false)
