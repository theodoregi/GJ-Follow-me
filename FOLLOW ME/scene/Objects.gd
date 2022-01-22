extends Area2D

var is_object = 0
	

func creation_object(list):
	print(list)
	list.shuffle()
	var object = [0,0]
	while (object != null && object[1]==0):
		object = list.pop_back()
	if object != null:
		is_object = 1
		object[1] -=1;
		var scene = object[0].instance()
		add_child(scene)
		scene.global_position = global_position
		if object[1]>0 :
			list.append(object)
	
	
