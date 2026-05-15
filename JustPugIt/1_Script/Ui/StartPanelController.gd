class_name StartPanelController
extends Control

# =========================
# SIGNALS (C# Action → Godot)
# =========================
#signal start_button_pressed(level_index)

# =========================
# REFERENCES
# =========================
@onready var root_panel = $RootStartPanel
#@onready var bg = $BG

# Buttons
@export var setting_button : TextureButton #= $RootStartPanel/SettingButton
@export var shop_button : TextureButton #= $RootStartPanel/ShopButton
@export var play_button : TextureButton #= $RootStartPanel/PlayButton
@export var level_button : TextureButton #= $RootStartPanel/LevelButton
#@onready var leaderboard_button = $RootStartPanel/LeaderboardButton
#@onready var level_button = $RootStartPanel/LevelButton
#@onready var profile_button = $RootStartPanel/ProfileButton

# UI
#@onready var xp_text = $TopBar/XPText
#@onready var name_text = $TopBar/NameText
#@onready var profile_img = $TopBar/ProfileImage

#@export var default_texture: Texture2D
#@export var data_manager: Node # assign your DataManager

# =========================
# INIT
# =========================
func _ready():
	setting_button.pressed.connect(_on_setting_pressed)
	shop_button.pressed.connect(_on_shop_pressed)
	play_button.pressed.connect(_on_play_pressed)
	#leaderboard_button.pressed.connect(_on_leaderboard_pressed)
	level_button.pressed.connect(_on_level_panel_pressed)
	#profile_button.pressed.connect(_on_profile_pressed)

# =========================
# SHOW / HIDE (IUIPanel)
# =========================
func show_panel():
	#bg.show()
	root_panel.show()

	#_update_xp()

	# Enable level button if unlocked
	#var max_level = data_manager.game_data.player_data.max_unlocked_level_index
	#level_button.visible = max_level >= 1

func hide_panel():
	#bg.hide()
	root_panel.hide()

# =========================
# BUTTON EVENTS
# =========================
func _on_setting_pressed():
	print("Setting button pressed")
	UIManager.instance.enable_popup(PopupPanelController.PopupType.SETTING)
	UIManager.instance.open_settings()

func _on_shop_pressed():
	print("Shop button pressed")
	UIManager.instance.enable_popup(PopupPanelController.PopupType.SHOP)

func _on_level_panel_pressed():
	UIManager.instance.enable_panel(UIManager.PanelType.LEVEL)


func _on_play_pressed():
	print("Play button pressed")
	var current_level : int = PlayerPrefs.get_int("current_level")
	UIManager.instance.start_selected_level(current_level)

	#UIManager.instance.enable_panel(UIManager.PanelType.LEVEL)

	#var max_level = data_manager.game_data.player_data.max_unlocked_level_index
	#start_button_pressed.emit(max_level)





func _on_leaderboard_pressed():
	var cam = get_viewport().get_camera_2d()
	if cam:
		cam.set("is_mobile_rotate", false)

	UIManager.instance.enable_popup(PopupPanelController.PopupType.LEADERBOARD)





func _on_level_pressed():
	var cam = get_viewport().get_camera_2d()
	if cam:
		cam.set("is_mobile_rotate", true)

	UIManager.instance.enable_panel(UIManager.PanelType.LEVEL)

	#var current = data_manager.game_data.player_data.current_level_index
	#var max_level = data_manager.game_data.player_data.max_unlocked_level_index

	#UIManager.instance.update_level_buttons(current, max_level)




func _on_profile_pressed():
	UIManager.instance.enable_popup(PopupPanelController.PopupType.PROFILE)

# =========================
# DATA UPDATE
# =========================
#func _update_xp():
	#if data_manager:
		#var xp = data_manager.game_data.player_data.total_score
		#xp_text.text = str(xp)

#func update_xp(xp: int, rank: int):
	#xp_text.text = str(xp)

# =========================
# RESET
# =========================
#func reset_panel():
	#profile_img.texture = default_texture
	#name_text.text = ""
	#xp_text.text = "0"
