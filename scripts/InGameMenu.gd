extends Control

onready var _player = get_tree().get_root().get_node("/root/MusicController").get_child(0)
onready var slider = get_node("PopupDialog/HSlider") as HSlider
onready var check_button = get_node("PopupDialog/CheckButton") as CheckButton

func _ready():
	slider.value = db2linear(_player.get_volume_db())
	pass

func _on_Exit_pressed():
	get_tree().quit()


func _on_Levels_pressed():
	get_tree().change_scene("res://scenes/LevelSelect.tscn")


func _on_Menu_pressed():
	get_tree().change_scene("res://scenes/Menu.tscn")


func _on_Settings_pressed():
	get_node("PopupDialog").popup()


func _on_CheckButton_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen


func _on_HSlider_value_changed(value):
	_player.set_volume_db(linear2db(slider.value))
