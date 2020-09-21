extends Area2D		

var sprites = []



func _ready():
	var simplex = load("res://simplex.gd")
	#.new([1,1,1,1], [[1,1,0,0], [0,0,1,1]]) 
	#print(thing.get_val() , " is a value from simplex")
	
	for sprite in self.get_children():
			if sprite is Sprite:
				sprites.append(sprite)

	print(_get_constraints())
	
	print(simplex.new(_get_costs(), _get_constraints()).get_solution())
	
	

func _submit():
	print("calculating optimum")
	for sprite in sprites:
		if sprite.is_lifted:
			print(sprite.row, sprite.column)

func _get_costs():
	var res = []
	for i in sprites.size():
		res.append(sprites[i].cost)
	return res
	
func _get_constraints():
	var temp = {}
	var res = []
	
	for sprite in sprites:
		if temp.has(sprite.pipe_num):
			temp[sprite.pipe_num][sprite.order] = 1
		else:
			# init constraint array for this pipe
			temp[sprite.pipe_num] = []
			for i in sprites.size():
				temp[sprite.pipe_num].append(0)
			temp[sprite.pipe_num][sprite.order] = 1
	
	for k in temp:
		res.append(temp[k])
	
	return res
	
