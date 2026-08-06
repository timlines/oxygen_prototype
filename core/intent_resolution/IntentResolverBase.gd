class_name IntentResolverBase
extends RefCounted

## Strategy interface for turning normalized text into an Intent.
##
## Implementations:
##   - KeywordIntentResolver  (MVP, this prototype)
##   - LLMIntentResolver      (future -- calls out to a language model)
##
## Anything implementing resolve() can be swapped into IntentResolverService
## with zero changes to CommandDispatcher or any gameplay system. This is
## the seam the whole architecture is built around.

func resolve(raw_text: String) -> Intent:
	push_error("IntentResolverBase.resolve() is abstract and must be overridden")
	return Intent.new("unknown", {}, 0.0, raw_text)
