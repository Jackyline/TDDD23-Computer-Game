extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for level in global.data.levels:
		get_node(level).get_child(0).text = "Moves: " + global.data.levels[level][0]
		get_node(level).get_child(1).text = "Time: " + global.data.levels[level][1]
