extends CanvasLayer
@export var homeButton:TextureButton # adjust path if needed
@export var restartButton:TextureButton
@export var gameWinPanel:Panel
var level_manager: LevelManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_manager=get_tree().root.get_node("Main/Background") as LevelManager
	
	homeButton.pressed.connect(_on_home_pressed)
	restartButton.pressed.connect(_on_restart_pressed)
func _on_home_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main/Main.tscn")
	
	
func _on_restart_pressed():
	level_manager.clear_level()
	var currentLevel=PlayerPrefs.get_int("current_Index")
	level_manager.load_level(currentLevel)
	gameWinPanel.visible=false
	
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
