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
	for sprite in sprites:
		players_solution.append(sprite.is_lifted)

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
	
