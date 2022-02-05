extends CanvasLayer
class_name GUI

onready var control = get_node("Control")

var is_wait_for_input: bool

signal gui_start_game

func _input(event) -> void:
	if not is_wait_for_input:
		return
	if event is InputEventKey:
		control.visible = false
		emit_signal("gui_start_game")
