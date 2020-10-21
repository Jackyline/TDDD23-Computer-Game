extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_pressed():
	get_tree().change_scene("res://scenes/Level" + get_name() + ".tscn")

func _on_mouse_entered():
	if not disabled:
		$Sprite.modulate = Color(1,1,1,0.5)

func _on_mouse_exited():
	if not disabled:
		$Sprite.modulate = Color(1,1,1,1)
