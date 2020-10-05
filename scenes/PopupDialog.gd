extends PopupDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nextlevel = 2
var retry = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Next_pressed():
	get_tree().change_scene("res://scenes/Scene"+str(nextlevel)+".tscn")


func _on_Retry_pressed():
	get_tree().change_scene("res://scenes/Scene"+str(retry)+".tscn")
