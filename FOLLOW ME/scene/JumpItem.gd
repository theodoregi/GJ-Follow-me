extends Area2D

const GRAVITY = 3000
const JUMP_HIGH = GRAVITY/5

func _on_JumpItem_body_entered(body):
	body.velocity.y=-JUMP_HIGH
