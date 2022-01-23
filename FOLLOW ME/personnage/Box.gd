extends StaticBody2D


# Declare member variables here. Examples:
const GRAVITY = 3000.0
var velocity = Vector2.ZERO
const UP = Vector2(0, -1)
enum {MOVE, ATTACK,DEATH}

var state=MOVE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	if state==DEATH:
		death_box()
		state=DEATH


func death_box(): 
	queue_free()

func _death_box_area_entered(area):
	state=DEATH
