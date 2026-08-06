class_name SettingsSystem
extends RefCounted

## Mock settings system.

var music_volume: int = 50   # 0-100
var sfx_volume: int = 70     # 0-100

func get_report() -> String:
	return "\n".join([
		"Settings",
		"  Music Volume: %d%%" % music_volume,
		"  SFX Volume:   %d%%" % sfx_volume,
	])

func adjust_music(delta: int) -> String:
	music_volume = clamp(music_volume + delta, 0, 100)
	return "Music volume set to %d%%." % music_volume
