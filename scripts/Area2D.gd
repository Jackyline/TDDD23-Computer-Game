extends Area2D		
var np = preload("res://scripts/m_numpy.gd") 
var simplex = load("res://scripts/simplex.gd")
var simplex_inst

var tiles = []
var player_solution = []
var hints_number = 0
var hint_button = null
var moves_label : Label
var animation_node : Node2D

export var level_nr = 0
export var hints:Array
onready var dialog = preload("res://scenes/LevelFinished.tscn").instance()
#onready var level_nr = get_tree().get_current_scene().get_name()[get_tree().get_current_scene().get_name().length() - 1]

func _ready():
	# get hint button reference
	self.hint_button = get_node("/root/Level " + str(level_nr) + "/Hints/Text")
	moves_label = get_node("/root/Level " + str(level_nr) + "/MovesPanel/MovesText")
	animation_node = get_node("/root/Level " + str(level_nr) + "/Board/HintNode")
	
	for tile in self.get_children():
		if tile is Area2D:
			tiles.append(tile)
	
	simplex_inst = simplex.new(_get_costs(), _get_constraints())
	#print("constraints: ", _get_constraints())
	for c in _get_constraints():
		print("CVCC")
		print(c)
	print("Solution: ", simplex_inst.get_solution())
	
	self.hints_number = hints.size()
	print(hints_number)
	print("hints", hints.size())
	self.hint_button.text = "HINTS: " + str(self.hints_number)

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

	
	# if correct show some points...
	# for now change level
	if simplex_inst.is_correct(_get_player_tiles()):
		add_child(dialog)
		dialog.get_node("PopupDialog")._on_start(str(_get_player_moves()), 
			str(timespend), _calculate_reward(simplex_inst.get_opt_cost(), 
			_get_player_moves()), int(level_nr))
		get_node("/root/Level "+ str(level_nr) + "/TimerPanel/Timer").timer.paused = true
		
		_disable_tiles()
		
func _disable_tiles():
	for tile in tiles:
		tile.clickable = false
		
func _get_costs():
	var res = []
	for i in tiles.size():
		res.append(tiles[i].cost)
	return res
	
func _get_constraints():
	var temp = {}
	var res = []
	print(tiles)
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
	return get_node("/root/Level "+ str(level_nr)+ "/MovesPanel/MovesText").moves_cnt
	
func _get_player_timer():
	return get_node("/root/Level "+ str(level_nr)+ "/TimerPanel/Timer").time
	
func _get_player_tiles():
	var res = []
	for tile in tiles:
		if tile.is_lifted:
			res.append(1)
		else:
			res.append(0)
			
	return res

func _calculate_reward(var opt, var sol):
	var res = np.m_abs(opt - sol)
	if res <= 0:
		return 3
	elif res > 0 and res <= 0.25*sol:
		return 2
	elif res > sol*0.25:
		return 1
	else:
		return 0
		
func _get_hint_tile():
	if !hints.empty():
		var front = hints.pop_front()
		for tile in tiles:
			if tile.order == front:
				self.hints_number = hints.size()
				return tile
	print("Hint not avaliable!")


func _on_Hints_pressed():
	if !hints.empty():
		var tile = _get_hint_tile()
		animation_node.visible = true
		animation_node.get_child(0).get_child(0).play("setup")
		moves_label._increment_move_cnt()
		self.hint_button.text = "HINTS: " + str(self.hints_number)
	
