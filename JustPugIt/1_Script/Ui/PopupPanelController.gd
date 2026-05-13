class_name PopupPanelController
extends Control

# =========================
# ENUM
# =========================
enum PopupType {
	NONE = 0,
	PAUSE = 1,
	WIN = 2,
	GAME_OVER = 3,
	SETTING = 4,
	SHOP = 5,
	NO_ADS = 6,
	NETWORK = 7,
	LEADERBOARD = 8,
	RESTART = 9,
	PROFILE = 10
}

# =========================
# REFERENCES
# =========================
@export var pause_popup : PausePopupController 
@export var win_popup : WinPopupController
@export var gameover_popup : LosePopupController
@export var setting_popup : SettingPopupController
@export var shop_popup : ShopPopupController
@export var noads_popup : NoAdsPopupController
@export var network_popup : NetworkPopupController
@export var leaderboard_popup : LeaderboardPopupController
@export var restart_popup : RestartPopupController
@export var profile_popup : ProfilePopupController

# =========================
# MAP
# =========================
var popup_map = {}

func _ready():
	popup_map = {
		PopupType.PAUSE: pause_popup,
		PopupType.WIN: win_popup,
		PopupType.GAME_OVER: gameover_popup,
		PopupType.SETTING: setting_popup,
		PopupType.SHOP: shop_popup,
		PopupType.NO_ADS: noads_popup,
		PopupType.NETWORK: network_popup,
		PopupType.LEADERBOARD: leaderboard_popup,
		PopupType.RESTART: restart_popup,
		PopupType.PROFILE: profile_popup
	}
	hide_popup()

# =========================
# SHOW POPUP
# =========================
func show_popup(type: PopupType):
	for popup in popup_map.values():
		popup.visible = false

	var pop = popup_map.get(type, null)
	if pop:
		_toggle_popup(pop, true)

# =========================
# HIDE ALL
# =========================
func hide_popup():
	for popup in popup_map.values():
		_toggle_popup(popup, false)

# =========================
# ANIMATION (Tween)
# =========================
func _toggle_popup(popup: Control, is_show: bool, delay: float = 0.0):
	popup.pivot_offset = popup.size * 0.5
	var tween = create_tween()

	if is_show:
		popup.visible = true
		popup.scale = Vector2.ZERO

		tween.tween_property(popup, "scale", Vector2.ONE, 0.35)\
			.set_delay(delay)\
			.set_trans(Tween.TRANS_BACK)\
			.set_ease(Tween.EASE_OUT)

	else:
		tween.tween_property(popup, "scale", Vector2.ZERO, 0.25)\
			.set_delay(delay)\
			.set_trans(Tween.TRANS_BACK)\
			.set_ease(Tween.EASE_IN)

		tween.tween_callback(func():
			popup.visible = false
		)	   
