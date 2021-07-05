extends Area2D

var velocity = Vector2(0, 0)
var wind
var g

func _process(delta):
	velocity.y += g * delta
	velocity.x += wind * delta
	position += velocity * delta
	rotation = velocity.angle()

