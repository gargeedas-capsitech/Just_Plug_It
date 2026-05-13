# class_name SettingPopupController
extends Node

@export var close_button1: TextureButton 
@export var close_button2: TextureButton 
@export var music_button: TextureButton
@export var sfx_button: TextureButton

@export var music_on_texture: Texture2D
@export var music_off_texture: Texture2D
@export var sfx_on_texture: Texture2D
@export var sfx_off_texture: Texture2D

var music_on: bool
var sfx_on: bool 


func _ready():
	#music_on = GameManager.instance.is_music_on()
	#sfx_on = GameManager.instance.is_sfx_on()
	_update_music_button()
	_update_sfx_button()

	close_button1.pressed.connect(_on_close_pressed)
	close_button2.pressed.connect(_on_close_pressed)
	music_button.pressed.connect(_on_music_pressed)
	sfx_button.pressed.connect(_on_sfx_pressed)

func _on_close_pressed():
	UIManager.instance.disable_popup()
	pass

func _on_music_pressed():
	music_on = !music_on
	#GameManager.instance.set_music_on(music_on)
	_update_music_button()
	pass

func _on_sfx_pressed():
	sfx_on = !sfx_on
	#GameManager.instance.set_sfx_on(sfx_on)
	_update_sfx_button()
	pass

func _update_music_button():
	if music_on:
		music_button.texture_normal = music_on_texture
	else:
		music_button.texture_normal = music_off_texture

func _update_sfx_button():
	if sfx_on:
		sfx_button.texture_normal = sfx_on_texture
	else:		
		sfx_button.texture_normal = sfx_off_texture
