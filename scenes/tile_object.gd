extends Area2D

export var is_lifted : int
export var row: int
export var column : int  
export var pipes : Array
export var cost : int
export var order : int
export var clickable : bool


onready var tempcost = cost

var moves_label : Label

func _ready():	
	$weight.modulate.a = 0.5
	is_lifted = false
	if clickable:
		$clicks.text = str(cost)
	else:
		$clicks.text = str(0)
	
	
	moves_label = get_node("/root/Level 1/MovesPanel/MovesText")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and clickable and tempcost > 0:
		if tempcost == 1:
			$weight.modulate.a = 0
			is_lifted = !is_lifted
		moves_label._increment_move_cnt()
		print(tempcost)
		tempcost += -1
		$clicks.text = str(tempcost)
	elif event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT and clickable and tempcost < cost:
		$weight.modulate.a = 0.5
		if tempcost == 0:
			is_lifted = !is_lifted 
		moves_label._decrement_move_cnt()
		tempcost += 1
		$clicks.text = str(tempcost)




#func _input_event(viewport, event, shape_idx):
#	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and clickable:
#		if  !is_lifted:
#			$weight.modulate.a = 0
#			is_lifted = !is_lifted
#			moves_label._increment_move_cnt()
#			print(tempcost)
#			tempcost += -1
#			$clicks.text = str(tempcost)
#		elif is_lifted:
#			$weight.modulate.a = 0.5
#			is_lifted = !is_lifted
#			moves_label._decrement_move_cnt()
#			tempcost += 1
#			$clicks.text = str(tempcost)
#		#moves_label.text = str("Moves: ", moves_cnt)
