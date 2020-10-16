extends TextureButton

func _on_mouse_entered():
	self.modulate = Color(1,1,1,0.5)


func _on_mouse_exited():
	self.modulate = Color(1,1,1,1)
