class_name GameManager
extends Node
static var instance: GameManager

# =========================
# FILE PATH
# =========================
var file_name := "gamedata.dat"
var file_path := ""

# =========================
# GAME DATA
# =========================
var game_data := {}

# =========================
# INIT
# =========================

func _enter_tree():
	if instance == null:
		instance = self
	else:
		queue_free()

func _ready():
	create_path()
	load_data()

func create_path():
	file_path = "user://" + file_name
	var absolute_path = ProjectSettings.globalize_path(file_path)
	print(absolute_path)
	PlayerPrefs.set_int("mrinal", 1)

# =========================
# SAVE (Binary .dat)
# =========================
func save_data():
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		file.store_var(game_data)  # Binary serialization
		file.close()
		print("Saved successfully (DAT)")
	else:
		push_error("Save failed")


# =========================
# LOAD (Binary .dat)
# =========================
func load_data():
	if not FileAccess.file_exists(file_path):
		initialize_default_data()
		save_data()
		return

	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var result = file.get_var()  # Read binary data

		if result != null:
			game_data = result
			print("Loaded successfully (DAT)")
		else:
			print("Corrupted data, resetting...")
			initialize_default_data()
			save_data()

		file.close()

# =========================
# DEFAULT DATA
# =========================
func initialize_default_data():
	game_data = {
		"player_data": {
			"name": "",
			"uid": "",
			"user_rank": 0,
			"total_coin": 0,
			"total_score": 0,
			"game_won_counter": 0,
			"max_unlocked_level_index": 0,
			"level_progressions": _create_level_list(50)
		},

		"powerups_data": {
			"undo": 1,
			"reveal": 1,
			"freeze": 1,
			"auto_place": 1
		},

		"settings_data": {
			"is_music_on": true,
			"is_sound_on": true,
			"is_theme_on": true,
			"sfx_volume": 1.0,
			"music_volume": 1.0,
			"is_first_time_playing": false,
			"language": "en",
			"is_login_mode_guest": true,
			"is_zyro_mode": true
		}
	}

	print("Default data initialized")

func _create_level_list(count:int) -> Array:
	var arr := []
	for i in count:
		arr.append(0)
	return arr

# =========================
# GETTERS
# =========================
func is_music_on() -> bool:
	return game_data["settings_data"]["is_music_on"]

func is_sound_on() -> bool:
	return game_data["settings_data"]["is_sound_on"]

func is_zyro_mode() -> bool:
	return game_data["settings_data"]["is_zyro_mode"]

func get_language():
	return game_data["settings_data"]["language"]

func is_login_mode_guest() -> bool:
	return game_data["settings_data"]["is_login_mode_guest"]

func get_music_volume() -> float:
	return game_data["settings_data"]["music_volume"]

func get_sfx_volume() -> float:
	return game_data["settings_data"]["sfx_volume"]

# =========================
# SETTERS
# =========================
func set_music_toggle():
	game_data["settings_data"]["is_music_on"] = !game_data["settings_data"]["is_music_on"]
	save_data()

func set_sound_toggle():
	game_data["settings_data"]["is_sound_on"] = !game_data["settings_data"]["is_sound_on"]
	save_data()

func set_zyro_mode_toggle():
	game_data["settings_data"]["is_zyro_mode"] = !game_data["settings_data"]["is_zyro_mode"]
	save_data()

func set_language(lang:String):
	game_data["settings_data"]["language"] = lang
	save_data()

func set_login_mode(is_guest:bool):
	game_data["settings_data"]["is_login_mode_guest"] = is_guest
	save_data()
