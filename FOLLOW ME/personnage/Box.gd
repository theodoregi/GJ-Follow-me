extends StaticBody2D


# Declare member variables here. Examples:
const GRAVITY = 3000.0
var velocity = Vector2.ZERO
const UP = Vector2(0, -1)
enum {MOVE,DEATH}
onready var _animated_sprite_destruct = $Destruct
var state=MOVE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(_delta):
	check_area()
	if state==DEATH:
		death_box()
		state=DEATH


func death_box(): 
	_animated_sprite_destruct.play()
	if _animated_sprite_destruct.frame==8: 
		queue_free()

func _death_box_area_entered(_area):
	state=DEATH

func check_area():
	if state==DEATH:
		$CollisionShape2D.set_deferred("disabled", true)
		$CollisionShape2D.set_deferred("disabled", true)
	else :
		$CollisionShape2D.set_deferred("disabled", false)
		$CollisionShape2D.set_deferred("disabled", false)


