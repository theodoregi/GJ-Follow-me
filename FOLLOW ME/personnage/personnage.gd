extends KinematicBody2D


# Declare member variables here. Examples:
onready var _animated_sprite_jump = $Jump
onready var _animated_sprite_run = $Run
onready var _animated_sprite_death = $Death
onready var _animated_sprite_attack = $Attack
onready var _animated_sprite_idle = $Idle
onready var _timer = $Timer

enum {MOVE, ATTACK,DEATH}

const GRAVITY = 3000
const WALK_SPEED = 300
const WALK_ATTACK = WALK_SPEED/3
const JUMP_HIGH = GRAVITY/5
var state=MOVE
var velocity = Vector2.ZERO
const UP = Vector2(0,-1)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	velocity.x =WALK_SPEED
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y=-JUMP_HIGH
	if state==DEATH:
		velocity.x=0
		death_character(delta)
	elif !is_on_floor():
		jump_character(delta)
	elif state==ATTACK or (Input.is_action_just_pressed("attack") and is_on_floor()) :
		_attack(delta)
	else:
		move_character(delta)
	velocity=move_and_slide(velocity,UP)
	

func move_character(delta):
	_animated_sprite_run.show()
	_animated_sprite_run.play()
	_animated_sprite_jump.hide()
	_animated_sprite_death.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_idle.hide()
	
	

func jump_character(delta):
	_animated_sprite_run.hide()
	_animated_sprite_jump.show()
	_animated_sprite_jump.play()
	_animated_sprite_death.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_idle.hide()

func _death_area_entered(area):
	state=DEATH

func death_character(delta):
	_animated_sprite_run.hide()
	_animated_sprite_jump.hide()
	_animated_sprite_idle.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_death.show()
	_animated_sprite_death.play()
	if _animated_sprite_death.frame==10: 
		queue_free()

func _attack(delta):
	velocity.x =WALK_ATTACK
	_animated_sprite_run.hide()
	_animated_sprite_jump.hide()
	_animated_sprite_death.hide()
	_animated_sprite_attack.show()
	_animated_sprite_attack.play()
	_animated_sprite_idle.hide()
	state=ATTACK
	if !_timer.get_time_left()>0:
		_animated_sprite_attack.frame = 0
		_timer.start(0.5)

func place_object(node):
	node.global_position = get_global_mouse_position()
	print(1)

func _on_Timer_timeout():
	state=MOVE

func _attack_area_entered(area):
	pass # Replace with function body.
