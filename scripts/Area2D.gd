extends Area2D		

var sprites = []
var players_solution = []

func _ready():
	var simplex = load("res://scripts/simplex.gd")
	#.new([1,1,1,1], [[1,1,0,0], [0,0,1,1]]) 
	#print(thing.get_val() , " is a value from simplex")
	
	for sprite in self.get_children():
		if sprite is Sprite:
			sprites.append(sprite)

	print("constraints: ", _get_constraints())
	print("solution: ", simplex.new(_get_costs(), _get_constraints()).get_solution())

func _submit():
	print("calculating optimum")
	players_solution.clear()
	print("Players moves: ", self._get_player_moves())
	print(self._get_player_tiles())
	for sprite in sprites:
		players_solution.append(sprite.is_lifted)
		
	# KOLLA HIT DAWID!
	# Added for saving the progress of the level
	# Du får fixa så om det blir success (klarar banan) så görs detta.
	# EY OH! LET'S GO! :D :D
	var minutes = int(self._get_player_timer() / 60)
	var seconds = int(self._get_player_timer() % 60)
	var timespend = ("%02d" % minutes) + (":%02d" % seconds)
	# Maybe switch scene name? Almost get_parent()get_parent()...
	var levelNr = get_tree().get_current_scene().get_name()[get_tree().get_current_scene().get_name().length() - 1]
	global.data["levels"][levelNr] = [str(self._get_player_moves()), timespend]
	global.save(global.data)
	
func _get_costs():
	var res = []
	for i in sprites.size():
		res.append(sprites[i].cost)
	return res
	
func _get_constraints():
	var temp = {}
	var res = []
	
	for sprite in sprites:
		if !sprite.pipes.empty():
			for pipe in sprite.pipes:
				if temp.has(pipe):
					temp[pipe][sprite.order] = 1
				else:
					# init constraint array for this pipe
					temp[pipe] = []
					for i in sprites.size():
						temp[pipe].append(0)
					temp[pipe][sprite.order] = 1
	
	for k in temp:
		res.append(temp[k])
	
	return res

func _get_player_moves():
	return get_node("/root/Level 1/MovesPanel/MovesText").moves_cnt
	
func _get_player_timer():
	return get_node("/root/Level 1/TimerPanel/Timer").time
	
func _get_player_tiles():
	var res = []
	for sprite in sprites:
		if sprite.is_lifted:
			res.append(1)
		else:
			res.append(0)
			
	return res
