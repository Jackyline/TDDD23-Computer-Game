extends Control

# Load the music player node
onready var _player = AudioStreamPlayer.new()

func _ready():
	add_child(_player)
	_player.set_volume_db(30)
	play()

# Calling this function will load the given track, and play it
func play():
	var track = load("res://audio/menu-game-v2.ogg")
	_player.stream = track
	_player.play()

# Calling this function will stop the music
func stop():
	_player.stop()



func _on_AudioStreamPlayer_finished():
	play()
