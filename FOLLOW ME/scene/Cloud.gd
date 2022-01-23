extends StaticBody2D


func _physics_process(delta):
	if get_parent().name != "Object3" and get_parent().name != "Object1" and get_parent().name != "Object2":
		scale = Vector2(2,2)
