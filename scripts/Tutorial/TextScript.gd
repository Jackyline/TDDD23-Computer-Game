extends RichTextLabel

var dialog_1 : String = "Hello adventurer, nice day for fishing, ain't it?"
var dialog_2 : String = "Bye bye LePapcain"
var current_dialog : String = ""
var run_dialog = false
var timer : Timer

func _ready():
	timer = get_node("/root/Tutorial/DialogCloud/Timer")
	
	#self.append_bbcode("[center]" + dialog_1 + "[/center]")
	#self.current_dialog = dialog_1
	self.visible_characters = 0
	self.run_dialog = false
	
func _process(delta):
	#if Input.is_action_just_released("mouse_released"):
	#	run_next_dialog()
	if self.run_dialog:
		self.run_dialog = false
		timer.start()
		self._on_Timer_timeout()

func _on_Timer_timeout():
	self.visible_characters += 1
	if self.visible_characters >= self.current_dialog.length():
		timer.stop()

func run_next_dialog(dialog):
	self.clear()
	self.visible_characters = 0
	self.append_bbcode("[center]" + dialog + "[/center]")
	self.current_dialog = dialog	
	self.run_dialog = true

