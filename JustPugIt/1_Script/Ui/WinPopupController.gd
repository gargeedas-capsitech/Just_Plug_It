class_name WinPopupController
extends Node

@export var next_button: TextureButton
@export var home_button: TextureButton
@export var restart_button: TextureButton
#@export var close_button: TextureButton
@export var quit_button: TextureButton

func _ready():
	next_button.pressed.connect(on_next_pressed)
	home_button.pressed.connect(on_home_pressed)
	restart_button.pressed.connect(on_restart_pressed)
	#close_button.pressed.connect(on_close_pressed)
	#quit_button.pressed.connect(on_close_pressed)

func on_next_pressed():
	UIManager.instance.disable_popup()
	UIManager.instance.start_next_level()

func on_home_pressed():
	UIManager.instance.onHomeBtnClicked()
	# UIManager.instance.disable_popup()
	# UIManager.instance.enable_panel(UIManager.PanelType.START)

func on_close_pressed():
	UIManager.instance.disable_popup()

func on_restart_pressed():
	UIManager.instance.disable_popup()
	UIManager.instance.restart_game()
