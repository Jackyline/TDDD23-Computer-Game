extends Label

var moves_cnt = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = str("Moves: ", moves_cnt)

func _increment_move_cnt():
	moves_cnt += 1
	self.text = str("Moves: ", moves_cnt)
	
func _decrement_move_cnt():
	moves_cnt -= 1
	self.text = str("Moves: ", moves_cnt)
