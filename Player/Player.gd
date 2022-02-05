extends Spatial
class_name Player

enum State {IDLE, MOVING}
var curr_state : int
var curr_x_pos: int
var curr_y_pos: int
const MOVE_TIME := 0.1
const MOVE_DIST_X := 1.0
const MOVE_DIST_Y := 1.0
const MAX_X := 1
const MIN_X := -1
const MAX_Y := 1
const MIN_Y := 0 

var alive: bool

#var action_queue: String # TODO: let player queue 1 movement

onready var tween = get_node("Tween")
onready var birb = get_node("Birb")

func _ready() -> void:
	curr_state = State.IDLE
	curr_x_pos = 0
	curr_y_pos = 0
	alive = false

func _input(event) -> void:
	if not alive:
		return
	if event.is_action_pressed("left"):
		move_request("left")
	elif event.is_action_pressed("right"):
		move_request("right")
	elif event.is_action_pressed("up"):
		move_request("up")
	elif event.is_action_pressed("down"):
		move_request("down")

func move_request(dir: String) -> void:
	if curr_state == State.MOVING:
		return
	if dir == "left" and curr_x_pos > MIN_X:
		curr_x_pos -= 1
		start_move_tween(Vector2(-1.0 * MOVE_DIST_X, 0.0))
	elif dir == "right" and curr_x_pos < MAX_X:
		curr_x_pos += 1
		start_move_tween(Vector2(MOVE_DIST_X, 0.0))
	elif dir == "up" and curr_y_pos < MAX_Y:
		curr_y_pos += 1
		start_move_tween(Vector2(0.0, MOVE_DIST_Y))
	elif dir == "down" and curr_y_pos > MIN_Y:
		curr_y_pos -= 1
		start_move_tween(Vector2(0.0, -1 * MOVE_DIST_Y))

func start_move_tween(offset: Vector2) -> void:
	curr_state = State.MOVING
	var to_pos = birb.transform.origin + Vector3(offset.x, offset.y, 0.0) 
	tween.interpolate_property(birb, "transform:origin", birb.transform.origin, to_pos, MOVE_TIME, Tween.TRANS_CUBIC)
	tween.start()
	yield(tween, "tween_completed")
	curr_state = State.IDLE

func set_alive(value: bool) -> void:
	alive = value

