extends Control
class_name CommandConsole

## Layer 0 (presentation) of the pipeline:
##   Player Input -> Command Parser -> Intent Resolver -> Dispatcher -> System
##
## This node owns ONLY presentation: opening/closing the console, echoing
## input, and displaying responses. All interpretation happens in
## IntentResolverService and CommandDispatcher -- this file never contains
## a single "if text contains X" check.

@onready var input_field: LineEdit = %CommandInput
@onready var output_label: RichTextLabel = %CommandOutput
@onready var panel: Control = %ConsolePanel

func _ready() -> void:
	panel.visible = false
	input_field.text_submitted.connect(_on_command_submitted)
	_print_line("Press TAB to open/close this console. Type \"help\" to see what I understand.")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_TAB:
			_toggle_console()
			get_viewport().set_input_as_handled()
		elif event.keycode == KEY_ESCAPE and panel.visible:
			_close_console()
			get_viewport().set_input_as_handled()

func _toggle_console() -> void:
	if panel.visible:
		_close_console()
	else:
		_open_console()

func _open_console() -> void:
	panel.visible = true
	input_field.grab_focus()

func _close_console() -> void:
	panel.visible = false
	input_field.release_focus()

func _on_command_submitted(text: String) -> void:
	if text.strip_edges().is_empty():
		input_field.clear()
		return

	_print_line("> " + text)

	var intent := IntentResolverService.resolve(text)
	var response := CommandDispatcher.dispatch(intent)

	if not response.is_empty():
		_print_line(response)

	input_field.clear()

func _print_line(text: String) -> void:
	output_label.append_text(text + "\n\n")
	output_label.scroll_to_line(output_label.get_line_count())
