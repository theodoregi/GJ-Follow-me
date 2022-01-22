extends RichTextLabel

func _process(delta):
	set_text(str(get_tree().current_scene.name)+" Complete")
	pass
