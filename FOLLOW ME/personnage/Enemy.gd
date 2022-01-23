extends KinematicBody2D


# Declare member variables here. Examples:
onready var _animated_sprite_idle = $Idle_enemy
onready var _animated_sprite_death = $Death_enemy
onready var _animated_sprite_attack = $Attack_enemy
onready var _sound_=$AnimationPlayer
const GRAVITY = 3000.0
var velocity = Vector2.ZERO
const UP = Vector2(0, -1)
enum {MOVE, ATTACK,DEATH}

var state=MOVE
var death_value=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	if state==DEATH or death_value==1:
		death_value=1
		death_enemy()
		state=DEATH
	elif state==MOVE:
		idle_enemy()
	elif state==ATTACK:
		attack_enemy()
	print(state==DEATH)
	check_area()
	velocity=move_and_slide(velocity,UP)

func idle_enemy():
	_animated_sprite_idle.show()
	_animated_sprite_death.hide()
	_animated_sprite_attack.hide()
	_animated_sprite_idle.play()
	_sound_.play("idle_enemy_sound")

func death_enemy():
	_animated_sprite_idle.hide()
	_animated_sprite_death.show()
	_animated_sprite_death.play()
	_animated_sprite_attack.hide()
	_sound_.play("death_enemy_sound")
	if _animated_sprite_death.frame==5: 
		queue_free()

func attack_enemy():
	_animated_sprite_idle.hide()
	_animated_sprite_death.hide()
	_animated_sprite_attack.show()
	_animated_sprite_attack.play()
	_sound_.play("attack_enemy_sound")
	if _animated_sprite_attack.frame==5:
		_animated_sprite_attack.stop()
		_sound_.stop()
		_sound_.play("idle_enemy_sound")


	
func _death_enemy_area_entered(_area):
	state=DEATH
	
func _attack_enemy_area_entered(_area):
	if !state==DEATH:
		state=ATTACK

func check_area():
	if state==DEATH:
		$attack_enemy.set_monitoring(false)
		$attack_enemy.set_monitorable(false)
		$death_enemy.set_monitoring(false)
		$death_enemy.set_monitorable(false)
	else :
		$attack_enemy.set_monitoring(true)
		$attack_enemy.set_monitorable(true)
		$death_enemy.set_monitoring(true)
		$death_enemy.set_monitorable(true)
