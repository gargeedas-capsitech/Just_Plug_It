extends CanvasLayer

var level_manager: LevelManager
# Called when the node enters the scene tree for the first time.

@onready var main=get_parent()
func _ready():
	level_manager=get_tree().root.get_node("Main/Background") as LevelManager
	if level_manager == null:
		print("cannot find the node")
	else:
		print("successs")
func load_level(index: int):
	if(level_manager!= null):
		level_manager.load_level(index)
		PlayerPrefs.set_int("current_Index", index) 
		PlayerPrefs.save()
		if main != null:
			main.game_play_on()
