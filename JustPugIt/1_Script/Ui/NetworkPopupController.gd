class_name NetworkPopupController
extends Control

# =========================
# INSPECTOR REFERENCES
# =========================
@export var root_panel : Control
@export var open_setting_button : TextureButton

# =========================
# SETTINGS
# =========================
@export var check_interval : float = 3.0

var timer : Timer

# =========================
# READY
# =========================
func _ready():

	open_setting_button.pressed.connect(on_open_setting_pressed)

	# Create Timer
	timer = Timer.new()
	timer.wait_time = check_interval
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)

	timer.timeout.connect(_check_internet)

	# First check instantly
	_check_internet()

# =========================
# INTERNET CHECK
# =========================
func _check_internet() -> void:

	var has_internet := await _is_internet_available()

	if has_internet:
		root_panel.hide()
	else:
		root_panel.show()

# =========================
# REAL INTERNET CHECK
# =========================
func _is_internet_available() -> bool:

	var http := HTTPRequest.new()
	add_child(http)

	var error = http.request("https://clients3.google.com/generate_204")

	if error != OK:
		http.queue_free()
		return false

	var result = await http.request_completed

	http.queue_free()

	var response_code = result[1]

	return response_code == 204

# =========================
# OPEN MOBILE SETTINGS
# =========================
func on_open_setting_pressed():

	if OS.get_name() in ["Android", "iOS"]:
		OS.shell_open("app-settings:")
	else:
		print("Settings not supported on this platform")