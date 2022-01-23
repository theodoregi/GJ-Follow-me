extends Node2D


func _physics_process(delta):
	if get_parent().name != "Object3" and get_parent().name != "Object1" and get_parent().name != "Object2":
		if $Timer.time_left == 0:
			$Timer.start(0.2)


func _on_Timer_timeout():
	queue_free()
