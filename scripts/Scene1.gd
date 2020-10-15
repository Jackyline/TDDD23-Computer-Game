extends Node2D

var menu = preload("res://scenes/InGameMenu.tscn").instance()


func _ready():
	print(OS.get_real_window_size())
	set_process(true)

func _process(delta):
	if Input.is_action_just_released("ui_cancel"):
		if menu.is_inside_tree():
			get_node("TimerPanel/Timer").timer.paused = false
			remove_child(menu)			
		else:
			add_child(menu)
			get_node("TimerPanel/Timer").timer.paused = true

