extends StaticBody2D
class_name LevelManager

@export var leveldata:LevelData
@export var spawn_parent: Node2D
@export var current_level: int = 0
@export var Rope: Rope


func _ready():
	load_level_data()

func load_level_data():
	if leveldata == null:
		push_error("leveldata is not assigned in the Inspector!")
		return
	load_level(0)


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

		if obj is Rope:
			obj.set_switch_count(level.SwitchCount)
		else:
			push_error("RopeController not found!")


func clear_level():
	for child in spawn_parent.get_children():
		child.queue_free()


func _process(delta):
	pass
