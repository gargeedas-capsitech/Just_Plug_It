class_name LevelPanelController
extends Control

# =========================
# NODES (Assign in Inspector)
# =========================
#@export var root_level_panel: Control
@export var level_content: Control
@export var level_button_prefab: PackedScene
@export var back_button: TextureButton
@export var setting_button: TextureButton
@export var grid_container: GridContainer
@export var horizontal_rows : int
@export var level_manager : LevelController
@export var prev_button:TextureButton
@export var next_button:TextureButton

# =========================
# PAGINATION SETTINGS
# =========================
const Rows := 3
const Columns := 6
const LEVELS_PER_PAGE := Rows * Columns

var current_page := 0

# =========================
# DATA
# =========================
var level_data = []   # Replace with GameManager data
var is_initialized := false
var on_level_selected: Callable = Callable()

# =========================
# READY (equivalent to Start)
# =========================
func _ready():
	# PlayerPrefs.delete_all()
	back_button.pressed.connect(on_back_button_clicked)
	setting_button.pressed.connect(on_setting_button_clicked)
	next_button.pressed.connect(on_next_pressed)
	prev_button.pressed.connect(on_prev_pressed)

	# Replace this with your actual GameManager call
	# level_data = GameManager.get_level_data()
	level_data = [] # Example data
	level_data.resize(100)
	# FIX GRID SIZE
	grid_container.columns = Columns
	# show_page()

	#print("Level data loaded: ", level_data)
	# generate_level_buttons()
	# grid_container.columns = max(
	# 		ceili(
	# 			float(level_content.get_child_count()) /
	# 			float(max(horizontal_rows, 1))
	# 		), 1)
	#level_manager=get_tree().root.get_node("Main/Environment") as levelManager
	if level_manager == null:
		print("cannot find the node")
	else:
		print("successs")

# =========================
# SHOW / HIDE
# =========================
#func show_panel(on_shown: Callable = Callable()):
#	root_level_panel.visible = true
#	if on_shown.is_valid():
#		on_shown.call()

#func hide_panel(on_hidden: Callable = Callable()):
#	root_level_panel.visible = false
#	if on_hidden.is_valid():
#		on_hidden.call()


# =========================
# PAGINATION LOGIC
# =========================
func show_page():
	# Clear old buttons
	for child in grid_container.get_children():
		child.queue_free()

	var start := current_page * LEVELS_PER_PAGE
	var end :int = min(start + LEVELS_PER_PAGE, level_data.size())

	for i in range(start, end):
		var level_index := i + 1

		var btn = level_button_prefab.instantiate() as LevelButton
		grid_container.add_child(btn)

		# btn.level_index = level_index
		# btn.get_node("LevelText").text = str(level_index)
		var unlocked_level = PlayerPrefs.get_int("unlocked_level", 1)
		btn.level_index = level_index

		if level_index <= unlocked_level:
			btn.is_locked = false
		else:
			btn.is_locked = true

		# btn.pressed.connect(on_level_button_pressed.bind(level_index))
		
		if level_index <= unlocked_level:
			btn.disabled = false
			btn.pressed.connect(on_level_button_pressed.bind(level_index))
		else:
			btn.disabled = true
			# btn.modulate = Color(0.5, 0.5, 0.5) # greyed out

	# Optional: disable buttons at edges
	prev_button.disabled = current_page == 0
	next_button.disabled = end >= level_data.size()

# =========================
# NEXT / PREVIOUS
# =========================
func on_next_pressed():
	if (current_page + 1) * LEVELS_PER_PAGE < level_data.size():
		current_page += 1
		show_page()

func on_prev_pressed():
	if current_page > 0:
		current_page -= 1
		show_page()

# =========================
# BUTTON CALLBACKS
# =========================
func on_back_button_clicked():
	UIManager.instance.enable_panel(UIManager.PanelType.START)

func on_setting_button_clicked():
	UIManager.instance.enable_popup(PopupPanelController.PopupType.SETTING)

# =========================
# SET CALLBACK
# =========================
func set_on_level_selected(callback: Callable):
	on_level_selected = callback


# =========================
# GENERATE BUTTONS
# =========================
func generate_level_buttons():
	for i in range(level_data.size()):
		var level_index := i + 1

		var btn = level_button_prefab.instantiate() as LevelButton
		level_content.add_child(btn)
		btn.level_index = level_index

		btn.pressed.connect(on_level_button_pressed.bind(level_index))


func on_level_button_pressed(level_index:int):
	#print("Level %d selected" % level_index)
	if on_level_selected.is_valid():
		load_level(level_index)
		PlayerPrefs.set_int("current_Index", level_index);
		
		on_level_selected.call(level_index)
		
func load_level(index: int):
	if(level_manager!= null):
		print(index)
		level_manager.load_level(index)
		PlayerPrefs.set_int("current_Index", index) 
		PlayerPrefs.save()
