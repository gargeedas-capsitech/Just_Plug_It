extends Node

var config := ConfigFile.new()
var data_path := "user://playerprefs.cfg"
var section := "data"


func _ready():
	if FileAccess.file_exists(data_path):
		config.load(data_path)



# -------- SET --------
func set_int(key: String, value: int):
	config.set_value(section, key, value)

func set_float(key: String, value: float):
	config.set_value(section, key, value)

func set_string(key: String, value: String):
	config.set_value(section, key, value)



# -------- GET --------
func get_int(key: String,default_value: int = 1) -> int:
	return int(config.get_value(section, key, default_value))

func get_float(key: String,default_value: float = 0.0) -> float:
	return float(config.get_value(section, key, default_value))

func get_string(key: String, default_value: String = "") -> String:
	return str(config.get_value(section, key, default_value))



# -------- UTIL --------
func has_key(key: String) -> bool:
	return config.has_section_key(section, key)

func delete_key(key: String):
	if has_key(key):
		config.erase_section_key(section, key)

func delete_all():
	config.clear()

func save():
	config.save(data_path)
	
