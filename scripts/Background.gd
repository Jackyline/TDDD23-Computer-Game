extends Sprite

const velocity: float = -0.3
var g_texture_width: float = 0
var image

func _ready():
	var hour = OS.get_time().hour
	if hour >= 18 && hour < 22:
		image = load("res://textures/fajrbackground.png") 
	elif hour >= 22 && hour < 24 || hour < 6:
		image = load("res://textures/nightbackgroundwithmoon.png") 
	elif hour >= 6 && hour < 12:
		image = load("res://textures/dawnbackground.png") 
	elif hour >= 12 && hour < 15:
		image = load("res://textures/noonbackground.png") 
	elif hour >= 15 && hour < 18:
		image = load("res://textures/sunsetbackground.png") 
	texture = image
	g_texture_width = texture.get_size().x * scale.x
	
func _process(delta):
	position.x += velocity
	_attempt_reposition()
	
func _attempt_reposition():
	if position.x < -g_texture_width:
		position.x += 2 * g_texture_width

