extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	global.g = $"../OptionButton3".selected
	global.w = $"../OptionButton4".selected
	global.gInd = $"../OptionButton".selected
	global.wInd = $"../OptionButton2".selected
	global.score = $"../OptionButton5".selected
	get_tree().change_scene("res://Node2D.tscn")
