extends Node2D

onready var test = get_node("/root/Tutorial/Board/x0")

onready var hint = get_node("/root/Tutorial/HintNode")
onready var click_rect : Area2D = get_node("/root/Tutorial/ClickRect")
onready var dialog_cloud : Sprite = get_node("/root/Tutorial/DialogCloud")
onready var dialog_label : RichTextLabel = get_node("/root/Tutorial/DialogCloud/VBoxContainer/RichTextLabel")
onready var click_collider : CollisionShape2D = get_node("/root/Tutorial/ClickRect/CollShape")
onready var cover_screen : Sprite = get_node("/root/Tutorial/Cover")
onready var plumber : Node2D = get_node("/root/Tutorial/Plumber")
onready var board : Area2D = get_node("/root/Tutorial/Board")

var dialog_1 : String = "Hello adventurer! I'm LePapcain, the plumber. We have some pipes to be uncovered."
var dialog_2 : String = "I need to get to those damn pipes but unfortunately every time we lift a tile laying over the pipe the poisonous gas is being released."
var dialog_3 : String = "So as you can guess our task is to get access to all the pipes by lifting as little of them as possible."
var dialog_4 : String = "Let's get to work."
var dialog_5 : String = "You can lift any tile by clicking on it with left mouse button."
var dialog_6 : String = "Perfect!"
var dialog_7 : String = "If you accidentally lifted wrong tile, DON'T worry. Use right mouse button to quickly put it back before harmful gas is released."
var dialog_8 : String = "To be continued..."

var step : int = 1
var step_in_progress = true
var cloud_pos = Vector2(327,410)
var cloud_size = Vector2(300,170)
var tile_pos = Vector2(896,436)
var tile_size = Vector2(64,64)

# Called when the node enters the scene tree for the first time.
func _ready():
	print(click_rect.position)
	print(click_collider.shape.extents)
	print("pos", test.get_global_position())
	
	# Move plumber with cloud to the front
	_change_focus([self.plumber, self.dialog_cloud])
	
	_change_click_rect(cloud_pos, cloud_size)
	dialog_label.run_next_dialog(dialog_1)
	step += 1
	

func _process(delta):
	if Input.is_action_just_released("mouse_released"):
		if click_rect.is_click_allowed():
			match step:
				2:
					_change_click_rect(cloud_pos, cloud_size)
					dialog_label.run_next_dialog(dialog_2)
					step += 1
				3:
					dialog_label.run_next_dialog(dialog_3)
					step += 1
				4:
					dialog_label.run_next_dialog(dialog_4)
					step += 1
				5: 
					#cover_screen.visible = false
					_change_click_rect(tile_pos, tile_size)
					_display_hint(tile_pos)
					dialog_label.run_next_dialog(dialog_5)
					_change_focus([self.plumber, self.dialog_cloud, self.board])
					step += 1	
				6:
					if Input.is_action_just_released("left_click"):
						_change_click_rect(cloud_pos, cloud_size)
						cover_screen.visible = true
						dialog_label.run_next_dialog(dialog_6)
						_change_focus([self.plumber, self.dialog_cloud])
						step += 1
				7: 
					_change_click_rect(tile_pos, tile_size)
					_display_hint(tile_pos)
					dialog_label.run_next_dialog(dialog_7)
					_change_focus([self.plumber, self.dialog_cloud, self.board])
					step += 1
				8:
					if Input.is_action_just_released("right_click"):
						cover_screen.visible = true
						_change_click_rect(cloud_pos, cloud_size)
						dialog_label.run_next_dialog(dialog_8)
						step += 1
					
func _change_click_rect(var pos, var size):
	click_rect.position = pos
	click_collider.shape.extents = size
	
func _display_hint(var pos):
	hint.visible = true
	hint.get_child(0).get_child(0).play("setup")
	hint.position = pos

func _change_focus(var nodes):
	move_child(cover_screen, get_child_count()-2)
	for node in nodes:
		print("muerte", node.name)
		move_child(node, get_child_count()-2)
