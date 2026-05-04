extends CanvasLayer

var _button: TextureButton
var _rightbutton: TextureButton
var _leftbutton: TextureButton
var _upbutton: TextureButton

# Called when the node enters the scene tree for the first time.
@onready var main = get_parent()
func _ready():
	_button = get_node("TextureButton")
	_leftbutton = get_node("TextureButton3")
	_rightbutton = get_node("TextureButton2")
	_upbutton = get_node("TextureButton4")
	
	if main != null:
		if main.has_method("rotate_board"):
			_rightbutton.pressed.connect(main.rotate_board)
		if main.has_method("rotate_board_right"):
			_leftbutton.pressed.connect(main.rotate_board_right)	
		if main.has_method("add_segment"):
			_button.pressed.connect(main.add_segment)
		if main.has_method("remove_segment"):
			_upbutton.pressed.connect(main.remove_segment)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
