class_name FriendsSystem
extends RefCounted

## Mock friends/social system. No real networking, per the project's
## non-goals -- invites just move a name into a pending list.

var friends_list: Array[String] = ["Kaylee", "Simon", "River"]
var pending_invites: Array[String] = []

func get_report() -> String:
	if friends_list.is_empty():
		return "No friends added yet."
	var lines := ["Friends"]
	for f: String in friends_list:
		lines.append("  " + f)
	return "\n".join(lines)

func invite(name_query: String) -> String:
	if name_query.is_empty():
		return "Invite who? Try \"invite Kaylee\"."

	var match_name := ""
	for f: String in friends_list:
		if f.to_lower() == name_query.to_lower():
			match_name = f
			break

	if match_name.is_empty():
		return "\"%s\" is not on your friends list." % name_query

	pending_invites.append(match_name)
	return "Invite sent to %s." % match_name
