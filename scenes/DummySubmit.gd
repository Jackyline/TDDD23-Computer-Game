extends TextureButton

var is_submit_clicked = false

func _on_Submit_button_up():
	if !self.disabled:
		self.is_submit_clicked = true
		print("SUBMIT")
		self.modulate = Color(1,1,1,1)

func _on_mouse_entered():
	if !self.disabled:
		self.modulate = Color(1,1,1,0.5)

func _on_mouse_exited():
	if !self.disabled:
		self.modulate = Color(1,1,1,1)

func is_submit_clicked():
	return self.is_submit_clicked
	
func set_hint_clicked(is_clicked):
	self.is_submit_clicked = is_clicked
