class_name UIManager
extends CanvasLayer
static var instance: UIManager
# =========================
# ENUMS
# =========================
enum PanelType {
	START,
	LEVEL,
	GAME,
	LEADERBOARD
}

# =========================
# SIGNALS (like C# Actions)
# =========================
#signal level_selected(level_index)
#signal star_updated(star_count)

# =========================
# REFERENCES
# =========================
@export var start_panel: StartPanelController 
@export var level_panel: LevelPanelController 
@export var game_panel: GamePanelController 
@export var popup_panel: PopupPanelController 
@export var level_manager : LevelController
@export var ropeController : Rope
@onready var win_panel =  popup_panel.win_popup
@onready var gameover_panel = popup_panel.gameover_popup
@onready var setting_panel = popup_panel.setting_popup
@onready var pause_panel = popup_panel.pause_popup
@onready var profile_panel = popup_panel.profile_popup

#@export var leaderboard_panel #= $LeaderboardPanel

@export var upButton: TouchScreenButton
@export var downButton: TouchScreenButton
@export var leftButton: TouchScreenButton
@export var rightButton: TouchScreenButton

func _enter_tree():
	if instance == null:
		instance = self
	else:
		queue_free() 
# =========================
# PANEL MAP
# =========================
var panel_map = {}

var current_panel:PanelType
func _ready():
	panel_map = {
		PanelType.START: start_panel,
		PanelType.LEVEL: level_panel,
		PanelType.GAME: game_panel
		#PanelType.LEADERBOARD: leaderboard_panel
	}
	level_panel.set_on_level_selected(on_level_selected)

# =========================
# PANEL CONTROL
# =========================
func enable_panel(type: PanelType):
	current_panel = type
	for p in panel_map.values():
		p.hide()

	panel_map[type].show()

# =========================
# POPUP CONTROL
# =========================
func enable_popup(popup_type):
	popup_panel.show_popup(popup_type)

func disable_popup():
	popup_panel.hide_popup()

func seton_level_selected(callback: Callable):
	level_panel.set_on_level_selected(callback)
	#PlayerPrefs.setInt("current_level", 0)

# =========================
# LEVEL PANEL
# =========================
func enable_level_panel():
	level_panel.show()

func disable_level_panel():
	level_panel.hide()

func update_level_buttons(current_level: int, saved_level: int):
	level_panel.initial_level_update(current_level, saved_level)
	level_panel.apply_progressions()

func get_unlocked_level() -> int:
	return PlayerPrefs.get_int("unlocked_level")

func unlock_next_level(current_level: int):
	var unlocked = PlayerPrefs.get_int("unlocked_level", 1)

	if current_level >= unlocked:
		PlayerPrefs.set_int("unlocked_level", current_level + 1)
		PlayerPrefs.save()
# =========================
# WIN / GAME OVER
# =========================
func update_win_stars(stars: int):
	win_panel.update_star_display(stars)

func update_win_segments(segments: int):
	win_panel.update_segments(segments)

func update_gameover_segments(segments: int):
	gameover_panel.update_segments(segments)

func restart_game():
	disable_popup()
	enable_panel(PanelType.GAME)
	level_manager.load_level(game_panel.current_level)
	on_level_selected(game_panel.current_level)
func onHomeBtnClicked():
	level_manager.clear_level()
	disable_popup()
	enable_panel(PanelType.START)

func start_next_level():
	level_manager.clear_level()
	disable_popup();
	enable_panel(PanelType.GAME)
	game_panel.current_level+=1
	level_manager.load_level(game_panel.current_level)
	on_level_selected(game_panel.current_level)

func start_selected_level(level_index: int):
	level_manager.clear_level()
	disable_popup();
	enable_panel(PanelType.GAME)
	level_manager.load_level(level_index)
	on_level_selected(level_index)

# =========================
# GAME PANEL
# =========================
func opacity_change(enable: bool):
	game_panel.enable_black_overlay(enable)

func on_game_start(count: int):
	game_panel.update_segments(count)

func on_stop(stop: bool):
	game_panel.on_stop(stop)

func on_level_selected(level_index:int):
	print("UIManager Received Level: ", level_index)
	enable_panel(PanelType.GAME)
	game_panel.start_game(level_index)
	PlayerPrefs.set_int("current_level", level_index)
	PlayerPrefs.save()

# =========================
# PROFILE / LEADERBOARD
# =========================
#func enable_login_btn(done: bool):
#	profile_panel.enable_login_button(done)

#func enable_leaderboard():
	#leaderboard_panel.show()

# =========================
# RESET
# =========================
func reset_all_ui():
	start_panel.reset_panel()
	#profile_panel.reset_panel()
	#leaderboard_panel.reset_panel()

func open_settings():
	if current_panel == PanelType.START:
		setting_panel.set_home_button_enabled(false)
	else:
		setting_panel.set_home_button_enabled(true)

func InActivePlay():
	game_panel.isPressed = false
	game_panel.isRemovePressed = false
	game_panel.isRotateleftPressed = false
	game_panel.isRotaterightPressed = false
	upButton.set_process_input(false)
	downButton.set_process_input(false)
	leftButton.set_process_input(false)
	rightButton.set_process_input(false)
func ActivePlay():
	upButton.set_process_input(true)
	downButton.set_process_input(true)
	leftButton.set_process_input(true)
	rightButton.set_process_input(true)