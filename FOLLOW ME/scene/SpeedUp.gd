extends Node2D




func _on_SpeedUpZone_body_entered(body):
	if body.name == "personnage" :
		body.WALK_SPEED *=1.5
		
		queue_free()
