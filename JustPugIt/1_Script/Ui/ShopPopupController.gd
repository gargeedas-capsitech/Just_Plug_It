class_name ShopPopupController
extends Node


@export var close_button1: TextureButton 
@export var close_button2: TextureButton 

func _ready():
	close_button1.pressed.connect(_on_close_pressed)
	close_button2.pressed.connect(_on_close_pressed)

func _on_close_pressed():
	UIManager.instance.disable_popup()
	
