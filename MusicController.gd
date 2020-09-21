extends Control

# Load the music player node
onready var _player = $AudioStreamPlayer

# Calling this function will load the given track, and play it
func play():
	var track = load("res://menu-game.ogg")
	_player.stream = track
	_player.play()

# Calling this function will stop the music
func stop():
	_player.stop()



func _on_AudioStreamPlayer_finished():
	play()
