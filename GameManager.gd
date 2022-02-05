extends Node
class_name GameManager

enum gameState {START_SCREEN, PLAYING, GAME_OVER}

onready var player = get_node("Player")
onready var gui = get_node("GUI")

func _ready() -> void:
	gui.connect("gui_start_game", self, "start_game")
	gui.is_wait_for_input = true
	player.visible = false

func start_game() -> void:
	player.visible = true
	player.call_deferred("set_alive", true)
