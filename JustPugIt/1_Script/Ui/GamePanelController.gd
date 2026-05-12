class_name GamePanelController
extends Control

@export var back_button: TextureButton
@export var setting_button: TextureButton
@export var pause_button: TextureButton
@export var restart_button: TextureButton
@export var level_text: Label
@export var score_text: Label
@export var ropecontroller: Rope
@export var camera: Camera2D

var _button: TouchScreenButton
var _rightbutton: TouchScreenButton
var _leftbutton: TouchScreenButton
var _upbutton: TouchScreenButton
var isPressed =false
var isRemovePressed =false
var isRotateleftPressed  = false
var isRotaterightPressed = false
var delay = 0;


var current_level : int = 0
@onready var main = get_tree().root.get_node("Main")
func _ready():
	back_button.pressed.connect(on_back_button_clicked)
	setting_button.pressed.connect(on_setting_button_clicked)
	pause_button.pressed.connect(on_pause_button_clicked)
	restart_button.pressed.connect(on_restart_button_clicked)	
	_button = get_node("TouchScreenButton")
	_leftbutton = get_node("TouchScreenButton3")
	_rightbutton = get_node("TouchScreenButton2")
	_upbutton = get_node("TouchScreenButton4")
	

	_rightbutton.pressed.connect(func():
				isRotateleftPressed = true
				)
	_rightbutton.released.connect(func(): isRotateleftPressed = false)
			#_leftbutton.pressed.connect(main.rotate_board_right)
	_leftbutton.pressed.connect(func(): isRotaterightPressed = true)
	_leftbutton.released.connect(func(): isRotaterightPressed = false)	

			#_button.pressed.connect(main.add_segment)
	_button.pressed.connect(func(): isPressed = true)
	_button.released.connect(func(): isPressed = false)

			#_upbutton.pressed.connect(main.remove_segment)
	_upbutton.pressed.connect(func():isRemovePressed=true)
	_upbutton.released.connect(func():isRemovePressed=false)

func start_game(level_index:int):
	current_level = level_index

	generate_level()

	show()

func select_Level(level_index:int):
	current_level = level_index

func generate_level():
	level_text.text = "Level: " + str(current_level)	
	score_text.text = "   Rand No :" + str(randi() % 101) 
	
func on_back_button_clicked():
	UIManager.instance.enable_panel(UIManager.PanelType.LEVEL)
	hide()

func on_setting_button_clicked():
	UIManager.instance.enable_popup(PopupPanelController.PopupType.SETTING)

func on_pause_button_clicked():
	UIManager.instance.enable_popup(PopupPanelController.PopupType.PAUSE)

func on_restart_button_clicked():
	UIManager.instance.enable_popup(PopupPanelController.PopupType.RESTART)

func _process(delta):
	delay -= delta
	if main == null:
		print("null")
		return
		
	if isPressed  and delay<=0:
		ropecontroller.add_segment()
		delay = float(0.1)

	if isRemovePressed and delay<=0:
		ropecontroller.remove_last_segment()
		delay = float(0.1);
	if isRotateleftPressed :
		camera.rotate_board(delta)
	if isRotaterightPressed :
		camera.rotate_board_right(delta)
