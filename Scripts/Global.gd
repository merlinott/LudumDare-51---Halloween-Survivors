extends Node

signal cards
signal lightning_init
signal blade_init
signal bladestorm_init
signal range_update
signal update_health
signal damage
signal game_finished
signal health_reset
signal card_reset
signal hpbar_update
var attack_range: float
var movement_speed: float
var bullet_cooldown: float

var base_damage: float
var bladestorm_speed: float
var lightning_cooldown: float
var blade_speed: float
var playerhealth: float
var level: int

var time: int

var spawn_lvl


func _ready():
	set_stats()
	
func set_stats():
	base_damage = 1
	playerhealth = 100
	blade_speed = .3
	bladestorm_speed = 18
	attack_range = 1000
	movement_speed = 2000
	bullet_cooldown = 1
	level = 1 
	spawn_lvl = 1
	lightning_cooldown = 32
	
	emit_signal("health_reset")
	emit_signal("hpbar_update")
