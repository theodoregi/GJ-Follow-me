extends Node2D

func _ready():
	$AnimationPlayer.play("sound")

func _physics_process(delta):
	position.x += 5
