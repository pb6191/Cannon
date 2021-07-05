extends Sprite

const Area2D1 = preload("res://Area2D1.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var g1
var wind1
var rng = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()
var flipFlop
var dispText = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$"TextureProgress".value = muzzle_velocity
	$"TextureProgress".max_value = 10*muzzleK
	if global.g == 0:
		g1 = 100.0
	elif global.g == 1:
		rng.randomize()
		g1 = float(rng.randi_range(0, 200))
	elif global.g == 2:
		rng.randomize()
		g1 = float(rng.randi_range(-200, 0))
	else:
		rng.randomize()
		g1 = float(rng.randi_range(-200, 200))
	if global.w == 0:
		wind1 = 100.0
	elif global.w == 1:
		rng2.randomize()
		wind1 = float(rng.randi_range(0, 200))
	elif global.w == 2:
		rng2.randomize()
		wind1 = float(rng.randi_range(-200, 0))
	else:
		rng2.randomize()
		wind1 = float(rng.randi_range(-200, 200))
	if global.gInd == 0:
		dispText = dispText + "Gravity: "+str(g1)
	if global.wInd == 0:
		dispText = dispText + "    Wind: "+str(wind1)
	$"../RichTextLabel".text = dispText
	$"../Sprite3".material.set_shader_param("strengthScale", wind1)
	$"../Sprite3".material.set_shader_param("direction", wind1)
	$"../Sprite3".material.set_shader_param("speed", wind1/10)
	$"../Sprite4".material.set_shader_param("strengthScale", g1)
	$"../Sprite4".material.set_shader_param("direction", 1.0)
	$"../Sprite4".material.set_shader_param("speed", g1/10)
	if g1 > 0.0:
		$"../Sprite4".scale.y = 0.3
	else:
		$"../Sprite4".scale.y = -0.3
	if global.gInd == 1:
		$"../Sprite4".visible = false
	if global.wInd == 1:
		$"../Sprite3".visible = false
	

var muzzleK = 100.0 * 4
var muzzle_velocity = muzzleK
#export var gravity = 250.0


func shoot():
	var b = Area2D1.instance()
	owner.add_child(b)
	$Barrel.rotation = get_angle_to(get_global_mouse_position())
	b.transform = $Barrel.global_transform
	b.velocity = b.transform.x * muzzle_velocity
	b.g = g1
	b.wind = wind1

var mousePressDur = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("leftClk") and get_tree().current_scene == $"..":
		mousePressDur = mousePressDur + delta
		muzzle_velocity = min(10*muzzleK, mousePressDur*3*muzzleK+muzzleK)
		$"TextureProgress".value = muzzle_velocity
		flipFlop = "flip"
	if Input.is_action_just_released("leftClk") and get_tree().current_scene == $".." and flipFlop == "flip":
		shoot()
		muzzle_velocity = muzzleK
		mousePressDur = 0.0
		$"TextureProgress".value = muzzle_velocity
		flipFlop = "flop"
	$"TextureProgress".rect_rotation = rad2deg(get_angle_to(get_global_mouse_position()))


func _on_Area2D_area_entered(area):
	get_tree().reload_current_scene()
