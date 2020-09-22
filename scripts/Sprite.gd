extends Sprite
export var is_lifted : int
export var row: int
export var column : int  
export var pipes : Array
export var cost : int
export var order : int
var child : Sprite

func _ready():
	var children = self.get_children()
	if children != []:
		child = children[0]
		child.modulate.a = 0.5
	
	is_lifted = false
	modulate.a = 1

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)) and !is_lifted:
			child.modulate.a = 0
			is_lifted = !is_lifted
		elif get_rect().has_point(to_local(event.position)) and is_lifted:
			child.modulate.a = 0.5
			is_lifted = !is_lifted
