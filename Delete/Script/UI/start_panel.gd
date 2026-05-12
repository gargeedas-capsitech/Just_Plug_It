extends CanvasLayer

var _playbutton:TextureButton
var _levelbutton:TextureButton

@onready var main=get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	_playbutton = get_node("Panel/Buttons/Play")
	_levelbutton = get_node("Panel/Buttons/Level")
	if main != null:
		if main.has_method("game_play_on"):
			_playbutton.pressed.connect(main.game_play_on)
		if main.has_method("on_level_panel_on"):
			_levelbutton.pressed.connect(main.on_level_panel_on)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
