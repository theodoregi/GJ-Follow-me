extends KinematicBody2D


# Declare member variables here. Examples:
onready var _animated_sprite_idle = $Idle_enemy
onready var _animated_sprite_death = $Death_enemy
onready var _animated_sprite_attack = $Attack_enemy
const GRAVITY = 3000.0
var velocity = Vector2.ZERO
const UP = Vector2(0, -1)
enum {MOVE, ATTACK,DEATH}

var state=MOVE

# Called when the node enters the scene tree for the first time.
func _ready():
	if state==MOVE:
		idle_enemy()
	elif state==ATTACK:
		death_enemy()

func idle_enemy():
	_animated_sprite_idle.show()
	_animated_sprite_death.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_idle.play()

func death_enemy():
	_animated_sprite_idle.hide()
	_animated_sprite_death.show()
	_animated_sprite_death.play()
	_animated_sprite_attack.hide()
	if _animated_sprite_death.frame==10: 
		queue_free()


func _physics_process(delta):
	velocity.y += delta * GRAVITY
	velocity=move_and_slide(velocity,UP)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _attack_enemy_area_entered(area):
	state=ATTACK


func _death_enemy_area_entered(area):
	state=DEATH
