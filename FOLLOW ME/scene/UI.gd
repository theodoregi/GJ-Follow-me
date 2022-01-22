extends CanvasLayer

export var nb_planck = 1
export var nb_speed_up = 1
export var nb_speed_down = 1
export var nb_jump = 1
export var nb_random = 1
signal creation(list)
const Random = preload ("res://scene/RandomObject.tscn")
const Jump = preload ("res://scene/Jump.tscn")
const Planck = preload("res://scene/Planck.tscn")
const Speedup = preload("res://scene/SpeedUp.tscn")
const Speeddown = preload("res://scene/SpeedDown.tscn")

var list = null

func _ready():
	list = [[Planck, nb_planck], [Speedup,nb_speed_up], [Speeddown,nb_speed_down], [Random, nb_random], [Jump, nb_jump]]
	randomize()
	self.connect("creation", $Control/Item4/Object1,"creation_object" )
	self.connect("creation", $Control/Item4/Object2,"creation_object" )
	self.connect("creation", $Control/Item4/Object3,"creation_object" )
	emit_signal("creation", list)
