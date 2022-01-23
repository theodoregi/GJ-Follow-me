extends KinematicBody2D


# Declare member variables here. Examples:
onready var _animated_sprite_jump = $Jump
onready var _animated_sprite_run = $Run
onready var _animated_sprite_death = $Death
onready var _animated_sprite_attack = $Attack
onready var _animated_sprite_idle = $Idle
onready var _timer = $Timer
onready var _audio_ = $AnimationPlayer


enum {MOVE,ATTACK,DEATH,IDLE,JUMP}

const GRAVITY = 3000
const WALK_SPEED = 300
const WALK_ATTACK = WALK_SPEED/3
const JUMP_HIGH = GRAVITY/5
var state=0
var velocity = Vector2.ZERO
const UP = Vector2(0,-1)
const RIGHT=Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	velocity.x =WALK_SPEED
	check_attack_area()
	if state==DEATH:
		velocity.x=0
		death_character()
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y=-JUMP_HIGH
		state=JUMP
	elif !is_on_floor() :
		jump_character()
		state=JUMP
	elif state==ATTACK or (Input.is_action_just_pressed("attack") and is_on_floor()) :
		_attack()
		state=ATTACK
	elif is_on_wall() :
		state=IDLE
		idle_character()
	else:
		state=MOVE
		move_character()
	velocity=move_and_slide(velocity,UP)
	print(state==ATTACK)
	sound_effect(state)
	
func sound_effect(state1):
	if state1==MOVE :
		_audio_.play("run_music")
	elif state1==JUMP :
		_audio_.play("jump_sound")
	elif state1==IDLE :
		_audio_.play("idle_sound")
	elif state1==DEATH :
		_audio_.play("death_sound")


func move_character():
	_animated_sprite_run.show()
	_animated_sprite_run.play()
	_animated_sprite_jump.hide()
	_animated_sprite_death.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_idle.hide()

func idle_character():
	_animated_sprite_run.hide()
	_animated_sprite_jump.hide()
	_animated_sprite_death.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_idle.show()
	_animated_sprite_idle.play()
	

func jump_character():
	_animated_sprite_run.hide()
	_animated_sprite_jump.show()
	_animated_sprite_jump.play()
	_animated_sprite_death.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_idle.hide()

func _death_area_entered(_area):
	if !state==ATTACK:
		state=DEATH

func death_character():
	_animated_sprite_run.hide()
	_animated_sprite_jump.hide()
	_animated_sprite_idle.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_death.show()
	_animated_sprite_death.play()
	if _animated_sprite_death.frame==10: 
		queue_free()

func _attack():
	_audio_.play("attack_sound")
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
		_timer.start(1)


func check_attack_area():
	if state==ATTACK:
		$attack.set_monitoring(true)
		$attack.set_monitorable(true)
	else:
		$attack.set_monitoring(false)
		$attack.set_monitorable(false)

func place_object(node):
	node.global_position = get_global_mouse_position()
	print(1)

func _on_Timer_timeout():
	state=MOVE

func _attack_area_entered(_area):
	pass # Replace with function body.
