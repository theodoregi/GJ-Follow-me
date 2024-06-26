extends KinematicBody2D


# Declare member variables here. Examples:
onready var _animated_sprite_jump = $Jump
onready var _animated_sprite_run = $Run
onready var _animated_sprite_death = $Death
onready var _animated_sprite_attack = $Attack
onready var _animated_sprite_idle = $Idle
onready var _timer = $Timer
onready var _audio_ = $AnimationPlayer
onready var dead = false


enum {MOVE,ATTACK,DEATH,IDLE,JUMP}

const GRAVITY = 3000
var WALK_SPEED = 300
var WALK_ATTACK = WALK_SPEED/3
const JUMP_HIGH = GRAVITY/5
var state=MOVE
var velocity = Vector2.ZERO
const UP = Vector2(0,-1)
const RIGHT=Vector2(1,0)
var have_falling = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Collision.disabled=false

func _physics_process(delta):
	
	if dead:
		death_character()
	
	else:
		if (!have_falling) and state!=DEATH:
			sound_effect(state)
			
		if state==DEATH:
			velocity.x=0
			death_character()
			dead = true
			print("DEAD")
			
		else:
			velocity.y += delta * GRAVITY
			velocity.x =WALK_SPEED
			check_attack_area()
			cloud_protection()
			
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y=-JUMP_HIGH
				state=JUMP
			elif !is_on_floor():
				jump_character()
				state=JUMP
			elif have_falling:
				recovery_character()
			elif state==ATTACK or (Input.is_action_just_pressed("attack") and is_on_floor()) :
				_attack()
				state=ATTACK
			elif is_on_wall():
				state=IDLE
				idle_character()
			else:
				state=MOVE
				move_character()
				
			velocity=move_and_slide(velocity,UP)
	
	
func sound_effect(state1):
	if state1==MOVE :
		_audio_.play("run_music")
	elif state1==JUMP :
		_audio_.play("jump_sound")
	elif state1==IDLE :
		_audio_.play("idle_sound")
	#elif state1==DEATH:
	#	_audio_.play("death_sound")


func move_character():
	_animated_sprite_run.show()
	_animated_sprite_run.play()
	_animated_sprite_jump.hide()
	_animated_sprite_death.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_idle.hide()
	$Timer.stop()


func idle_character():
	_animated_sprite_run.hide()
	_animated_sprite_jump.hide()
	_animated_sprite_death.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_idle.show()
	_animated_sprite_idle.play()


func jump_character():
	if ($Timer.time_left == 0):
		$Timer.start(0.7)
		_audio_.stop()
	if ($Timer.time_left < 0.1):
		have_falling = true
	_animated_sprite_run.hide()
	_animated_sprite_jump.show()
	_animated_sprite_jump.play()
	_animated_sprite_death.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_idle.hide()

func _death_area_entered(area):
	if !state==ATTACK:
		state=DEATH
		if (area.name=="TornadoArea"):
			_audio_.play("Fly")

func death_character():
	_animated_sprite_run.hide()
	_animated_sprite_jump.hide()
	_animated_sprite_idle.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_death.show()
	_animated_sprite_death.play()
	if _animated_sprite_death.frame>9:
		retrylevel()

func recovery_character():
	_animated_sprite_run.hide()
	_animated_sprite_jump.hide()
	_animated_sprite_death.show()
	_animated_sprite_attack.hide()
	_animated_sprite_idle.hide()
	velocity = Vector2.ZERO
	_audio_.play("revovery")


func end_recovery():
	have_falling = false

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
		_timer.start(0.5)
		
func cloud_protection():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider && collision.collider.name == "Cloud":
			have_falling=false


func check_attack_area():
	if state==ATTACK:
		$attack/attack_shape.disabled=false
	else:
		$attack/attack_shape.disabled=true

func place_object(node):
	node.global_position = get_global_mouse_position()

func _on_Timer_timeout():
	state=MOVE

func retrylevel():
	get_tree().change_scene("res://scene/Levels/Level"+str(int(get_tree().current_scene.name))+".tscn")
	
func nextlevel():
	get_tree().change_scene("res://scene/Levels/Level"+str(int(get_tree().current_scene.name) + 1)+".tscn")
