class_name RestartPopupController
extends Node

@export var quit_button: TextureButton
@export var yes_button: TextureButton
@export var no_button: TextureButton
@export var close_button: TextureButton

func _ready():
	quit_button.pressed.connect(on_close_pressed)
	yes_button.pressed.connect(on_yes_pressed)
	no_button.pressed.connect(on_no_pressed)
	close_button.pressed.connect(on_close_pressed)

func on_close_pressed():
	UIManager.instance.disable_popup()

func on_yes_pressed():
	UIManager.instance.disable_popup()
	UIManager.instance.restart_game()

func on_no_pressed():
	UIManager.instance.disable_popup()
	UIManager.instance.enable_panel(UIManager.PanelType.GAME)
