extends Node

signal cards
signal blade_init
signal bladestorm_init
signal range_update
signal update_health
signal damage
signal game_finished
signal health_reset
signal card_reset

var attack_range: float
var movement_speed: float
var bullet_cooldown: float

var bladestorm_speed: float

var blade_speed: float
var playerhealth: float
var level: int

var time: int

var spawn_lvl


func _ready():
	set_stats()
	
func set_stats():
	playerhealth = 100
	blade_speed = .3
	bladestorm_speed = 4
	attack_range = 1000
	movement_speed = 2000
	bullet_cooldown = 1
	level = 1 
	spawn_lvl = 1
	emit_signal("health_reset")
	
