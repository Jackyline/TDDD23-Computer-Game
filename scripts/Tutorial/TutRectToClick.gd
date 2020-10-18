extends Area2D

var is_click_allowed : bool = false
var is_left : bool = false
var is_right : bool = false

func _ready():	
	pass

func _input_event(viewport, event, shape_idx):
	pass

func _on_mouse_entered():
	self.is_click_allowed = true

func _on_mouse_exited():
	self.is_click_allowed = false

func is_click_allowed():
	return self.is_click_allowed

func set_left(state):
	self.is_left = state

func set_right(state):
	self.is_right = state

func is_left():
	if self.is_left:
		return true
	return false

func is_right():
	if self.is_right:
		return true
	return false
