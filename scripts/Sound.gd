extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sound = preload("res://textures/sound.png")
var mute = preload("res://textures/mute.png")
var music_position = 0

onready var _player = get_tree().get_root().get_node("/root/MusicController").get_child(0)
# Called when the node enters the scene tree for the first time.
func _ready():
	if _player.playing:
		$Sprite.set_texture(sound)
	elif !_player.playing:
		$Sprite.set_texture(mute)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Sound_pressed():
	if _player.playing:
		music_position = _player.get_playback_position()
		_player.stop()
		$Sprite.set_texture(mute)
	elif !_player.playing:
		_player.play(music_position)
		$Sprite.set_texture(sound)
