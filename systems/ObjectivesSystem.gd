class_name ObjectivesSystem
extends RefCounted

## Mock objectives/navigation system.

var current_location: String = "Landing Site Alpha"

var objectives: Array[String] = [
	"Repair the oxygen generator",
	"Locate the missing supply crate",
	"Establish contact with base camp",
]

func get_report() -> String:
	if objectives.is_empty():
		return "No active objectives."
	var lines := ["Objectives"]
	for o: String in objectives:
		lines.append("  - " + o)
	return "\n".join(lines)

func get_location_report() -> String:
	return "You are at: %s" % current_location
