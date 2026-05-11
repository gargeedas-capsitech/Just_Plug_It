class_name GamePanelController
extends Control

@export var back_button: TextureButton
@export var setting_button: TextureButton
@export var pause_button: TextureButton
@export var restart_button: TextureButton

@export var level_text: Label
@export var score_text: Label

var current_level : int = 0

func _ready():
	back_button.pressed.connect(on_back_button_clicked)
	setting_button.pressed.connect(on_setting_button_clicked)
	pause_button.pressed.connect(on_pause_button_clicked)
	restart_button.pressed.connect(on_restart_button_clicked)	

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