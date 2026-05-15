class_name LosePopupController
extends Node

@export var quit_button: TextureButton
@export var retry_button: TextureButton
@export var close_button: TextureButton
@export var home_button: TextureButton

func _ready():
	quit_button.pressed.connect(on_close_pressed)
	retry_button.pressed.connect(on_retry_pressed)
	close_button.pressed.connect(on_close_pressed)
	home_button.pressed.connect(on_home_pressed)

func on_home_pressed():
	UIManager.instance.onHomeBtnClicked()
	# UIManager.instance.disable_popup()
	# UIManager.instance.enable_panel(UIManager.PanelType.START)	

func on_retry_pressed():
	UIManager.instance.disable_popup()
	UIManager.instance.restart_game()

func on_close_pressed():
	UIManager.instance.disable_popup()
	
