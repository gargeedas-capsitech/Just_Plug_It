extends CanvasLayer

var _button: TouchScreenButton
var _rightbutton: TouchScreenButton
var _leftbutton: TouchScreenButton
var _upbutton: TouchScreenButton
var isPressed =false
var isRemovePressed =false
var isRotateleftPressed  = false
var isRotaterightPressed = false
var delay = 0;


# Called when the node enters the scene tree for the first time.
@onready var main = get_parent()
func _ready():
	_button = get_node("TouchScreenButton")
	_leftbutton = get_node("TouchScreenButton3")
	_rightbutton = get_node("TouchScreenButton2")
	_upbutton = get_node("TouchScreenButton4")
	
	if main != null:
		if main.has_method("rotate_board"):
			#_rightbutton.pressed.connect(main.rotate_board)
			_rightbutton.pressed.connect(func():
				if _rightbutton == null:
					print("hello")
				isRotateleftPressed = true
				)
		_rightbutton.released.connect(func(): isRotateleftPressed = false)
		if main.has_method("rotate_board_right"):
			#_leftbutton.pressed.connect(main.rotate_board_right)
			_leftbutton.pressed.connect(func(): isRotaterightPressed = true)
			_leftbutton.released.connect(func(): isRotaterightPressed = false)	
		if main.has_method("add_segment"):
			#_button.pressed.connect(main.add_segment)
			_button.pressed.connect(func(): isPressed = true)
			_button.released.connect(func(): isPressed = false)
		if main.has_method("remove_segment"):
			#_upbutton.pressed.connect(main.remove_segment)
			_upbutton.pressed.connect(func():isRemovePressed=true)
			_upbutton.released.connect(func():isRemovePressed=false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delay -= delta
	if main == null:
		return
	if isPressed and main.has_method("add_segment") and delay<=0:
		main.add_segment()
		delay = float(0.1)

	if isRemovePressed and main.has_method("remove_segment") and delay<=0:

		main.remove_segment()
		delay = float(0.1);
	if isRotateleftPressed and main.has_method("rotate_board"):

		main.rotate_board(delta)
	if isRotaterightPressed and main.has_method("rotate_board_right"):

		main.rotate_board_right(delta)
	
	
