extends StaticBody2D



func _on_Area2D_body_entered(body):
	if body.name == "personnage":
		body.WALK_SPEED *= 0.5


func _on_Area2D_body_exited(body):
	if body.name == "personnage":
		body.WALK_SPEED *= 2


func _on_Area2D_area_entered(area):
	if area.name == "DigZone":
		queue_free()
