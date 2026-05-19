class_name LevelButton
extends TextureButton

@export var level_text: Label
@export var locked_icon: TextureRect
@export var stars:Control

# =====================================================
# VARIABLES
# =====================================================

var is_locked: bool = false:
	set(value):
		is_locked = value

		if locked_icon:
			locked_icon.visible = is_locked
		if level_text:
			level_text.visible = !is_locked
		if stars:
			stars.visible = !is_locked
	get:
		return is_locked
# var _is_locked: bool = false

# var is_locked: bool:
# 	set(value):
# 		_is_locked = value

# 		if locked_icon:
# 			locked_icon.visible = _is_locked

# 	get:
# 		return _is_locked


var level_index: int = 0:
	set(value):
		level_index = value

		if level_text:
			level_text.text = str(level_index)
		if stars:
			stars.visible = !is_locked
	get:
		return level_index
# var _level_index: int = 0

# var level_index: int:
# 	set(value):
# 		_level_index = value
# 		if level_text:
# 			level_text.text = str(_level_index)
# 	get:
# 		return _level_index


# =====================================================
# READY
# =====================================================
func _ready() -> void:

	# Refresh UI on startup
	locked_icon.visible = is_locked
	level_text.visible = !is_locked
	stars.visible = !is_locked
	level_text.text = str(level_index)
