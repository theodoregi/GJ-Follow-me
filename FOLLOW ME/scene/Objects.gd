extends Area2D
signal place_node(value)
var is_object = false
	
var have_object = false
func _ready():
	var perso = get_parent().get_parent().get_node("personnage")
	self.connect("place_node",perso, "place_object")
func _physics_process(delta):
	if (have_object):
		get_child(1).global_position = get_viewport().get_mouse_position()
func creation_object(list):
	list.shuffle()
	var object = [0,0]
	while (object != null && object[1]==0):
		object = list.pop_back()
	if object != null:
		is_object = true
		object[1] -=1;
		var scene = object[0].instance()
		add_child(scene)
		scene.global_position = global_position
		if object[1]>0 :
			list.append(object)



func _on_Object1_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			$CollisionShape2D.disabled = true
			have_object = true
			get_child(1).modulate = Color(1,1,1,0.5)
			get_child(1).scale *= 0.25



func _on_Object2_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			have_object = true
			$CollisionShape2D.disabled = true
			get_child(1).scale *= 0.25
			get_child(1).modulate = Color(1,1,1,0.5)


func _on_Object3_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			have_object = true
			$CollisionShape2D.disabled = true
			get_child(1).scale *= 0.25
			get_child(1).modulate = Color(1,1,1,0.5)

func _on_Space_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if ! event.is_pressed() && have_object :
			have_object = false
			var node = get_child(1)
			node.modulate = Color(1,1,1,1)
			node.get_parent().remove_child(node)
			get_parent().get_parent().add_child(node)
			emit_signal("place_node", node)

			
