extends Area2D

var is_click_allowed : bool = false

func _on_mouse_entered():
	print("rect enetered")
	self.is_click_allowed = true

func _on_mouse_exited():
	self.is_click_allowed = false

func is_click_allowed():
	return self.is_click_allowed
