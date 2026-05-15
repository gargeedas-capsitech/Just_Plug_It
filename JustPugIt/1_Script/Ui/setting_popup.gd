class_name SettingPopupController
extends Control

@export var musicBtn : TextureRect
@export var hapBtn : TextureRect
@export var soundBtn : TextureRect
@export var closeBtn: TextureButton

@export var musicOn : Texture2D
@export var musicOff : Texture2D
@export var hapOn : Texture2D
@export var hapOff : Texture2D
@export var soundOn : Texture2D
@export var soundOff : Texture2D
@export var home_button:TextureButton
@export var deleteAcc_button:TextureButton

 
@export var music_on : bool = true
@export var hap_on : bool = true
@export var sound_on : bool = true
 
func _ready():
	musicBtn.texture = musicOn
	hapBtn.texture = hapOn
	soundBtn.texture = soundOn
	closeBtn.pressed.connect(_on_close_pressed)
	home_button.pressed.connect(_on_homeBtn_pressed)
func musicbtn():
	if music_on:
		musicOffFn()
	else:
		musicOnFn()
	music_on = !music_on
func hapbtn():
	if hap_on:
		hapOffFn()
	else:
		hapOnFn()
	hap_on = !hap_on
func soundbtn():
	if sound_on:
		soundOffFn()
	else:
		soundOnFn()
	sound_on = !sound_on

func set_home_button_enabled(enable: bool):
	# home_button.disabled = not enable
	home_button.visible = enable
	deleteAcc_button.visible =not enable

func _on_homeBtn_pressed():
	UIManager.instance.onHomeBtnClicked()

func _on_close_pressed():
	print("close pressed")
	UIManager.instance.disable_popup()

func musicOnFn():moveimage(musicBtn,25,musicOn)
func musicOffFn():moveimage(musicBtn,185,musicOff)
 
func hapOnFn():moveimage(hapBtn,25,hapOn)
func hapOffFn():moveimage(hapBtn,185,hapOff)
 
func soundOnFn():moveimage(soundBtn,25,soundOn)
func soundOffFn():moveimage(soundBtn,185,soundOff)
 
func moveimage(btnImage : TextureRect, targetx : float, image : Texture2D):
	var tween = create_tween()
	tween.tween_property(
		btnImage,
		"position:x",
		targetx,
		0.1
	)
	await tween.finished
	btnImage.texture = image
