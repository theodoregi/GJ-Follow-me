extends KinematicBody2D

var ACCELERATION = 500
var MAX_SPEED = 500
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction = Vector2(0,1)
var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if get_parent().name != "Object3" and get_parent().name != "Object1" and get_parent().name != "Object2":
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		velocity = move_and_slide(velocity)
