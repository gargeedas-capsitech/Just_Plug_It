class_name PausePopupController
extends Node


@export var resume_button: TextureButton
@export var quit_button: TextureButton
@export var home_button: TextureButton
@export var restart_button: TextureButton
@export var close_button: TextureButton

func _ready():
	resume_button.pressed.connect(_on_resume_pressed)
	quit_button.pressed.connect(_on_close_pressed)
	home_button.pressed.connect(_on_home_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	close_button.pressed.connect(_on_close_pressed)


func _on_resume_pressed():
	UIManager.instance.disable_popup()

func _on_close_pressed():
	UIManager.instance.disable_popup()

func _on_home_pressed():
	UIManager.instance.disable_popup()
	UIManager.instance.enable_panel(UIManager.PanelType.START)

func _on_restart_pressed():
	UIManager.instance.disable_popup()
	UIManager.instance.restart_game()
	# Optional: Add logic to reset the game state if needed


