extends Node2D
class_name Main
@export var game_over_scene: PackedScene
@export var game_win_scene: PackedScene
@export var obstracle_scene: PackedScene
var camera: Camera2D
@export var gravity_strength := 980.0

var _rope: Rope
var board: StaticBody2D
@export var isRotateleftPressed:bool=false
@export var isRotaterightPressed:bool=false


var is_dragging_add_button: bool = false
@onready var gravity_area = $GravityArea
#@onready var camera = 
# Called when the node enters the scene tree for the first time.
func _ready():
	#_rope = get_node("Background/Rope")
	board = get_node("Background")
	camera=get_node("Camera2D")
func game_play_on():
	get_node("StartPanel").visible = false
	get_node("GamePlayUI").visible = true
	get_node("Background").visible = true
	get_node("Level_panel").visible =false


func on_level_panel_on():
	get_node("Level_panel").visible = true
	get_node("StartPanel").visible = false
	get_node("GamePlayUI").visible = false
	
func on_Home_Panel_on():
	get_node("GamePlayUI").visible = false
	get_node("Level_panel").visible=false
	board.visible=false

	
func game_over():
	print("gameover")
	await get_tree().create_timer(1.0).timeout
	var scene= game_over_scene.instantiate()
	add_child(scene)
func game_win():
	print("You Wonnnn")
	await get_tree().create_timer(1.0).timeout

	var scene = game_win_scene.instantiate()
	add_child(scene)
	
func on_add_segment_input(event):
	if event is InputEventMouseButton:
		var mouse = event
		if mouse.button_index == MOUSE_BUTTON_LEFT:
			if mouse.pressed:
				is_dragging_add_button = true
			else:
				if is_dragging_add_button:
					_rope.add_segment()
				is_dragging_add_button = false
func add_obstacle_to_board():
	var min_distance := 40.0
	var placed_positions: Array = []

	for i in range(5):
		var random_pos := Vector2.ZERO
		var position_found := false
		var attempts := 0

		while not position_found and attempts < 20:
			var random_x = randf_range(-100, 100)
			var random_y = randf_range(-100, 100)
			random_pos = Vector2(random_x, random_y)

			position_found = true

			for pos in placed_positions:
				if random_pos.distance_to(pos) < min_distance:
					position_found = false
					break

			attempts += 1

		if position_found:
			var obstacle = obstracle_scene.instantiate()
			board.add_child(obstacle)
			obstacle.position = random_pos
			placed_positions.append(random_pos)

func rotate_board(delta):
	camera.rotation -= 0.5 * delta


func rotate_board_right(delta):
	camera.rotation += 0.5 * delta
		
func add_segment():
	_rope.add_segment()
func  remove_segment():
	_rope.remove_last_segment()

func _process(delta: float):
	var gravity_direction = Vector2.DOWN.rotated(camera.rotation)
	if _rope != null:
		_rope.update_gravity(gravity_direction)

	
	

	
