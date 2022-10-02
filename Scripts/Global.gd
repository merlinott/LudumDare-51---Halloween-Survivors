extends Node

signal cards
signal blade_init
signal range_update


var attack_range: float
var movement_speed: float
var bullet_cooldown: float
var blade_speed: float

var level: int

var spawn_lvl


func _ready():
	blade_speed = .3
	attack_range = 1000
	movement_speed = 2000
	bullet_cooldown = 1
	level = 1 
	spawn_lvl = 1
	
