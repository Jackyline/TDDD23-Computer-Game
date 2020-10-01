extends Area2D		
var simplex = load("res://scripts/simplex.gd")
var simplex_inst

var tiles = []
var player_solution = []


func _ready():
	#simplex_inst = simplex.new([1,1,1,1], [[1,1,0,0], [0,0,1,1]])
	#print(thing.get_val() , " is a value from simplex")
	
	for tile in self.get_children():
		tiles.append(tile)
	simplex_inst = simplex.new(_get_costs(), _get_constraints())
	print("constraints: ", _get_constraints())
	print("Solution: ", simplex_inst.get_solution())


func _submit():
	print("calculating optimum")
	player_solution.clear()
	print("Players moves: ", self._get_player_moves())
	print(self._get_player_tiles())
	for tile in tiles:
		player_solution.append(tile.is_lifted)
		
	# KOLLA HIT DAWID!
	# Added for saving the progress of the level
	# Du får fixa så om det blir success (klarar banan) så görs detta.
	# EY OH! LET'S GO! :D :D
	var minutes = int(self._get_player_timer() / 60)
	var seconds = int(self._get_player_timer() % 60)
	var timespend = ("%02d" % minutes) + (":%02d" % seconds)
	# Maybe switch scene name? Almost get_parent()get_parent()...
	var level_nr = get_tree().get_current_scene().get_name()[get_tree().get_current_scene().get_name().length() - 1]
	global.data["levels"][level_nr] = [str(self._get_player_moves()), timespend]
	global.save(global.data)
	
	# if correct show some points...
	# for now change level
	if simplex_inst.is_correct(_get_player_tiles()):
		var next_lvl = int(level_nr) + 1
		get_tree().change_scene("res://scenes/Scene"+str(next_lvl)+".tscn")
	
		# check if solution is optimal
		if simplex_inst.is_optimal(self._get_player_moves()):
			print("solution is optimal")
	
func _get_costs():
	var res = []
	for i in tiles.size():
		res.append(tiles[i].cost)
	return res
	
func _get_constraints():
	var temp = {}
	var res = []
	
	for tile in tiles:
		if !tile.pipes.empty():
			for pipe in tile.pipes:
				if temp.has(pipe):
					temp[pipe][tile.order] = 1
				else:
					# init constraint array for this pipe
					temp[pipe] = []
					for i in tiles.size():
						temp[pipe].append(0)
					temp[pipe][tile.order] = 1
	
	for k in temp:
		res.append(temp[k])
	
	return res

func _get_player_moves():
	return get_node("/root/Level 1/MovesPanel/MovesText").moves_cnt
	
func _get_player_timer():
	return get_node("/root/Level 1/TimerPanel/Timer").time
	
func _get_player_tiles():
	var res = []
	for tile in tiles:
		if tile.is_lifted:
			res.append(1)
		else:
			res.append(0)
			
	return res
