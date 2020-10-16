extends Area2D

export var is_lifted : int
export var row: int
export var column : int  
export var pipes : Array
export var cost : int
export var order : int
export var clickable : bool
export var my_color : Color

onready var level_nr = get_tree().get_current_scene().get_name()[get_tree().get_current_scene().get_name().length() - 1]
onready var tempcost = cost
onready var hint = get_node("/root/Level " + str(level_nr) + "/Board/HintNode")

var moves_label : Label

func _ready():	
	$weight.modulate.a = 0.5
	is_lifted = false
	if clickable:
		$clicks.text = str(cost)
	else:
		$clicks.text = str(0)
	
	# Set color
	if $texture != null:
		$texture.modulate = my_color
		
	moves_label = get_node("/root/Level " + str(level_nr) + "/MovesPanel/MovesText")

func _input_event(viewport, event, shape_idx):
	if Input.is_action_just_released("mouse_released") and tempcost > 0 and clickable:
		$weight.modulate = Color(0,1,0,0.5)
		
	if event is InputEventMouseButton && event.is_action_released("click"):
		print("dkjsfhjkdsflködslkjfgdsz")
	
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and clickable and tempcost > 0:
		$weight.modulate = Color(0,1,0,0.8)
		if hint.visible == true:
			hint.get_child(0).get_child(0).stop()
			hint.visible = false
		
		if tempcost == 1:
			$weight.modulate.a = 0
			is_lifted = !is_lifted
		moves_label._increment_move_cnt()
		print(tempcost)
		tempcost += -1
		$clicks.text = str(tempcost)
	elif event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT and clickable and tempcost < cost:
		$weight.modulate = Color(0,1,0,0.8)
		if tempcost == 0:
			is_lifted = !is_lifted 
		moves_label._decrement_move_cnt()
		tempcost += 1
		$clicks.text = str(tempcost)

func _on_mouse_entered():
	if clickable and tempcost > 0:
		$weight.modulate = Color(0,1,0,0.5)
	
func _on_mouse_exited():
	if clickable and tempcost > 0:
		$weight.modulate = Color(1,1,1,0.5)
