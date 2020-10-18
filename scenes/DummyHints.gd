extends TextureButton

var is_hint_clicked = false

func _on_Hints_button_up():
	if !self.disabled:
		print("lasfkdsjlkfjhdsklj")
		get_child(0).text = "HINTS: 0"
		self.is_hint_clicked = true
		self.modulate = Color(1,1,1,1)

func _on_mouse_entered():
	if !self.disabled:
		self.modulate = Color(1,1,1,0.5)

func _on_mouse_exited():
	if !self.disabled:
		self.modulate = Color(1,1,1,1)

func is_hint_clicked():
	return self.is_hint_clicked
	
func set_hint_clicked(is_clicked):
	self.is_hint_clicked = is_clicked
