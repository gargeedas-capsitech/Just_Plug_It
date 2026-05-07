extends CanvasLayer

var _button: TextureButton
var _rightbutton: TextureButton
var _leftbutton: TextureButton
var _upbutton: TextureButton
var isPressed =false
var isRemovePressed =false
var isRotateleftPressed  = false
var isRotaterightPressed = false
var delay = 0;
# Called when the node enters the scene tree for the first time.
@onready var main = get_parent()
func _ready():
	_button = get_node("TextureButton")
	_leftbutton = get_node("TextureButton3")
	_rightbutton = get_node("TextureButton2")
	_upbutton = get_node("TextureButton4")
	
	if main != null:
		if main.has_method("rotate_board"):
			#_rightbutton.pressed.connect(main.rotate_board)
			_rightbutton.button_down.connect(func(): isRotateleftPressed = true)
			_rightbutton.button_up.connect(func(): isRotateleftPressed = false)
		if main.has_method("rotate_board_right"):
			#_leftbutton.pressed.connect(main.rotate_board_right)
			_leftbutton.button_down.connect(func(): isRotaterightPressed = true)
			_leftbutton.button_up.connect(func(): isRotaterightPressed = false)	
		if main.has_method("add_segment"):
			#_button.pressed.connect(main.add_segment)
			_button.button_down.connect(func(): isPressed = true)
			_button.button_up.connect(func(): isPressed = false)
		if main.has_method("remove_segment"):
			#_upbutton.pressed.connect(main.remove_segment)
			_upbutton.button_down.connect(func():isRemovePressed=true)
			_upbutton.button_up.connect(func():isRemovePressed=false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delay -= delta
	if main == null:
		return
	if isPressed and main.has_method("add_segment") and delay<=0:
		main.add_segment()
		delay = float(0.1);
	if isRemovePressed and main.has_method("remove_segment"):
		main.remove_segment()
	if isRotateleftPressed and main.has_method("rotate_board"):
		main.rotate_board()
	if isRotaterightPressed and main.has_method("rotate_board_right"):
		main.rotate_board_right()
	
