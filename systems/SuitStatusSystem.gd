class_name SuitStatusSystem
extends RefCounted

## Mock suit/oxygen status system.

var oxygen_percent: float = 84.0
var pressure_stable: bool = true
var minutes_remaining: float = 31.0

func get_oxygen_report() -> String:
	return "\n".join([
		"Suit Status",
		"Oxygen........%d%%" % int(oxygen_percent),
		"",
		"Estimated Time Remaining",
		"%d minutes" % int(minutes_remaining),
		"",
		"Pressure %s" % ("Stable" if pressure_stable else "UNSTABLE"),
	])

func get_full_report() -> String:
	return "\n".join([
		get_oxygen_report(),
		"",
		"Vitals nominal.",
	])
