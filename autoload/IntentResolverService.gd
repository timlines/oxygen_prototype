extends Node

## Autoload singleton. Owns the ACTIVE intent resolution strategy.
##
## Swap `resolver` for an LLM-backed implementation later without touching
## CommandConsole, CommandDispatcher, or any gameplay system. This is the
## single line that will change when this project grows an AI companion.

var resolver: IntentResolverBase = KeywordIntentResolver.new()

func resolve(raw_text: String) -> Intent:
	return resolver.resolve(raw_text)

func set_resolver(new_resolver: IntentResolverBase) -> void:
	resolver = new_resolver
