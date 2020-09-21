extends Area2D		

var sprites = []



func _ready():
	var thing = load("res://simplex.gd").new([1,1,1,1], [[1,1,0,0], [0,0,1,1]]) 
	#print(thing.get_val() , " is a value from simplex")
	
	for sprite in self.get_children():
			if sprite is Sprite:
				sprites.append(sprite)

func _submit():
	print("calculating optimum")
	for sprite in sprites:
		if sprite.is_lifted:
			print(sprite.row, sprite.column)
