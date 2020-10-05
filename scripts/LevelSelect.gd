extends Node2D

var starTexture = preload("res://textures/Star Filled.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	for level in global.data.levels:
		get_node(level).get_child(0).text = "Moves: " + global.data.levels[level][0]
		get_node(level).get_child(1).text = "Time: " + global.data.levels[level][1]
		for star in global.data.levels[level][2]:
			var scale = get_node(level).get_child(2 + star).scale
			var curstar = get_node(level).get_child(2 + star)
			curstar.texture = starTexture
			curstar.scale = scale
