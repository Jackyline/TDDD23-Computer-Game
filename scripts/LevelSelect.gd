extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for level in global.data.levels:
		get_node(level).get_child(0).text = "Moves: " + global.data.levels[level][0]
		get_node(level).get_child(1).text = "Time: " + global.data.levels[level][1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
