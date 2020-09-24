extends Label

var time = 0
onready var timer = Timer.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",self,"_on_Timer_timeout") 
	add_child(timer)
	timer.start()

func _process(delta):
	var minutes = int(time / 60)
	var seconds = int(time % 60)
	var timespend = ("%02d" % minutes) + (":%02d" % seconds)
	self.text = str(timespend)


func _on_Timer_timeout():
	time += 1

