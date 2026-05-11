class_name LevelButton
extends TextureButton

@export var level_text: Label
@export var locked_icon: TextureRect


# =====================================================
# VARIABLES
# =====================================================

var is_locked: bool = false:
	set(value):
		is_locked = value

		if locked_icon:
			locked_icon.visible = is_locked


var level_index: int = 0:
	set(value):
		level_index = value

		if level_text:
			level_text.text = str(level_index)


# =====================================================
# READY
# =====================================================
func _ready() -> void:

	# Refresh UI on startup
	locked_icon.visible = is_locked
	level_text.text = str(level_index)