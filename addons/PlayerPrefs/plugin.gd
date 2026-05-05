@tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("PlayerPrefs", "res://addons/PlayerPrefs/player_prefs.gd")

func _exit_tree():
	remove_autoload_singleton("PlayerPrefs")
