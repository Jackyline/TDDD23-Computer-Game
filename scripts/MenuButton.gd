extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _player = get_tree().get_root().get_node("/root/MusicController").get_child(0)
var music_position = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Menu_pressed():
	music_position = _player.get_playback_position()
	get_tree().change_scene("res://scenes/Menu.tscn")
	_player.play(music_position)


func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/Scene1.tscn")


func _on_2_pressed():
	get_tree().change_scene("res://scenes/Scene2.tscn")
