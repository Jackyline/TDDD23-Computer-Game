extends PopupDialog
var star = preload("res://textures/Star Filled.png")

var nextlevel = 2
var current = 1
var resultStars = 0
var newTime
var newMoves

# Called when the node enters the scene tree for the first time.
func _ready():
	show()

func _on_start(moves, time, stars, level): 
	_set_score(moves, time)
	_set_stars(stars)
	nextlevel = level + 1
	current = level

func _set_score(moves, time):
	$Time.text = time
	$Moves.text = moves
	newTime = time
	newMoves = moves

func _set_stars(stars):
	resultStars = stars
	var scale = get_node("Star1").scale
	for i in stars + 1:
		if i > 0:
			print(i)
			get_node("Star" + str(i)).texture = star
			get_node("Star" + str(i)).scale = scale

func _on_Next_pressed():
	if !global.data["levels"].has(str(nextlevel)):
		global.data["levels"][str(nextlevel)] = []
	#global.save(global.data)
	if global.data["levels"].has(str(current)):
		if (global.data["levels"][str(current)].size() != 0):
			var savedStars = global.data["levels"][str(current)][2]
			var savedTime = _calc_time(global.data["levels"][str(current)][1])
			var savedMoves = global.data["levels"][str(current)][0]
			#Check if we got better result than earlier runs
			if savedStars < resultStars:
				global.data["levels"][str(current)] = [newMoves, newTime, resultStars]
				global.save(global.data)
			elif savedStars == resultStars and savedMoves > newMoves or savedTime > _calc_time(newTime):
				global.data["levels"][str(current)] = [newMoves, newTime, resultStars]
				global.save(global.data)
		else:
			global.data["levels"][str(current)] = [newMoves, newTime, resultStars]
			global.save(global.data)
	print(global.data)
	get_tree().change_scene("res://scenes/Level"+str(nextlevel)+".tscn")

func _on_Retry_pressed():
	get_tree().change_scene("res://scenes/Level"+str(current)+".tscn")

func _calc_time(time):
	var totaltime = 0
	totaltime += int(int(time.left(2)) * 60)
	totaltime += int(time.right(2))
	return time
