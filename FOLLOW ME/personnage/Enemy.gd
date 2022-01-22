extends KinematicBody2D


# Declare member variables here. Examples:
onready var _animated_sprite_idle = $Idle_enemy
onready var _animated_sprite_death = $Death_enemy
onready var _animated_sprite_attack = $Attack_enemy
const GRAVITY = 3000.0
var velocity = Vector2.ZERO
const UP = Vector2(0, -1)
enum {MOVE, ATTACK,DEATH,KILL}

var state=MOVE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	if state==DEATH:
		death_enemy()
	elif state==MOVE:
		idle_enemy()
	elif state==ATTACK:
		attack_enemy()
	elif state==KILL:
		enemy_kill()
	velocity=move_and_slide(velocity,UP)

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
	if _animated_sprite_death.frame==5: 
		queue_free()

func attack_enemy():
	_animated_sprite_idle.hide()
	_animated_sprite_death.hide()
	_animated_sprite_attack.show()
	_animated_sprite_attack.play()
	if _animated_sprite_attack.frame==4:
		state=KILL

func enemy_kill():
	_animated_sprite_attack.frame=0
	_animated_sprite_attack.stop()
	
func _death_enemy_area_entered(_area):
	state=DEATH
	
func _attack_enemy_area_entered(_area):
	state=ATTACK



	#pass
