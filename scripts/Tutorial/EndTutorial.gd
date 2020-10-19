extends Node2D

onready var test = get_node("/root/Level 11/Board/x0")

onready var hint = get_node("/root/Level 11/HintNode")
onready var click_rect : Area2D = get_node("/root/Level 11/ClickRect")
onready var dialog_cloud : Sprite = get_node("/root/Level 11/DialogCloud")
onready var dialog_label : RichTextLabel = get_node("/root/Level 11/DialogCloud/VBoxContainer/RichTextLabel")
onready var click_collider : CollisionShape2D = get_node("/root/Level 11/ClickRect/CollShape")
onready var cover_screen : Sprite = get_node("/root/Level 11/Cover")
onready var plumber : Node2D = get_node("/root/Level 11/Plumber")
onready var board : Area2D = get_node("/root/Level 11/Board")
onready var hint_btn : TextureButton = get_node("/root/Level 11/Hints")
onready var submit_btn : TextureButton = get_node("/root/Level 11/Submit")

var dialog_1 : String = "Hello adventurer! I see that you have figured out all the levels!"
var dialog_2 : String = "I want to thank you for fixing all the pipes."
var dialog_3 : String = "I don't know how I can thank you for all the help. It has warmed my heart to see that everything I taught you came in handy"
var dialog_4 : String = "Before I go, I have one more thing to tell you."
var dialog_5 : String = "If you want to become the master plumber among the engineers. Don't forget to get 3 stars on every level!"
var dialog_6 : String = "You can access all the levels on the main menu or through the game menu (press ESC when in game)!"
var dialog_7 : String = "Take care now young traveller, my our path cross again."

var step : int = 1
var step_in_progress = true
var cloud_pos = Vector2(327,410)
var cloud_size = Vector2(300,170)
var tile_pos = Vector2(896,436)
var tile_size = Vector2(64,64)
var hint_btn_pos = Vector2(1571,60)
var hint_btn_size = Vector2(100,38)
var submit_btn_pos = Vector2(960,930)
var submit_btn_size = Vector2(130,44)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Move plumber with cloud to the front
	_change_focus([self.plumber, self.dialog_cloud])
	
	_change_click_rect(cloud_pos, cloud_size)
	dialog_label.run_next_dialog(dialog_1)
	step += 1
	

func _process(delta):
	if Input.is_action_just_released("mouse_released"):
		if click_rect.is_click_allowed() or hint_btn.is_hint_clicked() or submit_btn.is_submit_clicked():
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
					dialog_label.run_next_dialog(dialog_5)
					step += 1
				6:
					dialog_label.run_next_dialog(dialog_6)
					step += 1
				7: 
					dialog_label.run_next_dialog(dialog_7)
					step += 1
				8:
					get_tree().change_scene("res://scenes/Menu.tscn")
						
func _change_click_rect(var pos, var size):
	click_rect.position = pos
	click_collider.shape.extents = size
	
func _display_hint(var pos):
	hint.visible = true
	hint.get_child(0).get_child(0).play("setup")
	hint.position = pos
	
func _destroy_hint():
	hint.visible = false
	hint.get_child(0).get_child(0).stop()

func _change_focus(var nodes):
	move_child(cover_screen, get_child_count()-2)
	for node in nodes:
		move_child(node, get_child_count()-2)
