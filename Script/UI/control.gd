extends Control

const ITEM_PER_PAGE=12

@export var level_panel_path: NodePath
@export var level_button:PackedScene

var grid:GridContainer
var left_button:TextureButton
var right_button:TextureButton
var level_panel
var max_level:=30
var current_page:=0

var all_buttons: Array=[]




# Called when the node enters the scene tree for the first time.
func _ready():
	grid = get_node("GridContainer")
	left_button = get_node("leftSlide")
	right_button = get_node("rightSlide")

	right_button.pressed.connect(_on_next_pressed)
	left_button.pressed.connect(_on_previous_pressed)

	level_panel = get_node(level_panel_path)
	if level_panel == null:
		print("cannot find levelpanel")
	

	generate_item()
	show_page()
func connected_all_button(parent: Node):
	for child in parent.get_children():
		if child is Button:
			child.pressed.connect(func(): _on_level_button_pressed(child))
		connected_all_button(child)


func _on_level_button_pressed(btn: Button):
	print("Pressed: ", btn.name)

	# Example:
	# var level_index = int(btn.name.replace("Level", ""))
	# print("Load Level: ", level_index)

	# var level_manager = get_node("/root/Main/Background")
	# level_manager.load_level(level_index)
func _on_next_pressed():
	if (current_page + 1) * ITEM_PER_PAGE < max_level:
		current_page += 1
		show_page()


func _on_previous_pressed():
	if current_page > 0:
		current_page -= 1
		show_page()


func generate_item():
	for i in range(1, max_level + 1):
		var btn : TextureButton = level_button.instantiate()
		btn.get_node("Label").text = str(i)
		all_buttons.append(btn)
		
func _on_level_selected(level_index: int):
	print("Selected Level: ", level_index)
	if level_panel:
		level_panel.load_level(level_index)

func show_page():
	# Clear old buttons
	for child in grid.get_children():
		child.queue_free()

	var start := current_page * ITEM_PER_PAGE
	var end :int = min(start + ITEM_PER_PAGE, max_level)

	for i in range(start, end):
		var btn : TextureButton = level_button.instantiate()
		btn.get_node("Label").text = str(i + 1)
		btn.pressed.connect(func(): _on_level_selected(i))
		grid.add_child(btn)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
