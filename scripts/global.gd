extends Node

var data

func load_save() -> Dictionary:
	var f := File.new()
	f.open("res://save.json", File.READ)
	var result := JSON.parse(f.get_as_text())
	f.close()

	if result.error:
		save({
		"tutorialwatched" : false,
		"levels": {"1" : []}}
		)
		print("ERRIR")
		result.result = {"tutorialwatched" : false,"levels": {"1" : []}}
	print("SUCCESS LOAD")
	return result.result as Dictionary

func save(data: Dictionary):
	var f := File.new()
	f.open("res://save.json", File.WRITE)
	prints("Saving to", f.get_path_absolute())
	f.store_string(JSON.print(data))
	print("CREATED SAVE FILE")
	f.close()


# Called when the node enters the scene tree for the first time.
func _ready():
	data = load_save()
	print(data)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
