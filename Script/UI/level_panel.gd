extends CanvasLayer

var level_manager: LevelManager
# Called when the node enters the scene tree for the first time.
func _ready():
	level_manager=get_tree().root.get_node("Main/Background") as LevelManager
	if level_manager == null:
		print("cannot find the node")
	else:
		print("success")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
