extends TextureButton

var sound = preload("res://textures/sound.png")
var mute = preload("res://textures/mute.png")
var music_position = 0

onready var _player = get_tree().get_root().get_node("/root/MusicController").get_child(0)

func _ready():
	if _player.playing:
		$OnOff.bbcode_text = "[center] Music [/center]"
	elif !_player.playing:
		$OnOff.bbcode_text = "[center][s] Music [/s][/center]"

func _on_Sound_pressed():
	if _player.playing:
		music_position = _player.get_playback_position()
		_player.stop()
		$OnOff.bbcode_text = "[center][s] Music [/s][/center]"
	elif !_player.playing:
		_player.play(music_position)
		$OnOff.bbcode_text = "[center] Music [/center]"

func _on_mouse_entered():
	self.modulate = Color(1,1,1,0.5)


func _on_mouse_exited():
	self.modulate = Color(1,1,1,1)
