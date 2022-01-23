extends Area2D

const GRAVITY = 3000
const JUMP_HIGH = GRAVITY/3
var taken = 0

func _on_JumpItem_body_entered(body):
	body.velocity.y=-JUMP_HIGH
	taken = 1

func _physics_process(delta):
	if taken:
		queue_free()
