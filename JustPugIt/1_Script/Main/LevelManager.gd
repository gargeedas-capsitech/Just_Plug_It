extends Node2D
class_name LevelController

@export var leveldata:LevelData
@export var spawn_parent: Node2D
@export var current_level: int = 0
@export var ropeController:Rope

# Called when the node enters the scene tree for the first time.
func _ready():
	load_level_data()
	

func load_level_data():
	if leveldata == null:
		push_error("leveldata is not assigned in the Inspector!")
		return
	if PlayerPrefs.get_int("current_Index")!= null:
		print("save_level",PlayerPrefs.get_int("current_Index"))
	 #load_level(1)
	
func load_level(index: int):
	if index < 0 or index >= leveldata.Levels.size():
		push_error("Invalid level index!")
		return

	# clear_level()  # optional if you want reset

	var level = leveldata.Levels[index]

	spawn_obstacles(level)
	spawn_players(level)
	print("Level ", index, " Loaded")
	
func spawn_obstacles(level):
	for obs in level.ObstacleDatas:
		if obs.Obstracle == null:
			continue

		var obj = obs.Obstracle.instantiate()
		spawn_parent.add_child(obj)

		if obj is Node2D:
			obj.position = obs.Position


func spawn_players(level):
	for player in level.PlayerDatas:
		if player.player == null:
			continue

		var obj = player.player.instantiate()
		spawn_parent.add_child(obj)
		
		if obj is Node2D:
			obj.position = player.position
			obj.rotation = player.rotation
			if(player.player_type==0):
				ropeController.ropesegmentParent=obj
				ropeController.set_initial_segment()
			print(obj, " type = ", typeof(obj))

		#if obj is Rope:
			#_rope.set_switch_count(level.SwitchCount)
		else:
			print("RopeController not found!")

func clear_level():
	for child in spawn_parent.get_children():
		child.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
