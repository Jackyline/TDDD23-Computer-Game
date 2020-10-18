extends Area2D

var is_click_allowed : bool = false

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
