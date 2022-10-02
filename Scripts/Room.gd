extends Node2D

var wave = 1

onready var Mob = preload("res://Scenes/Enemy1.tscn")
onready var timer = $Timer


var player_pos = Vector2.ZERO
var safe_range = 30000

func _ready():
	_spawn_enemies(wave)

func _process(delta):
	player_pos = get_node("Player").position
	Global.time = int(timer.time_left)
	

func _spawn_enemies(spawn: int) -> void:
	for i in range(spawn):
		var new_mob = Mob.instance()
		new_mob.global_position = _get_random_spawn_position()
		add_child(new_mob)

func _get_random_spawn_position() -> Vector2:
	randomize()
	var spawn_pos = Vector2(rand_range(-50000,50000), rand_range(-500000,500000))
	if (spawn_pos - player_pos).length() < safe_range: 
		spawn_pos = _get_random_spawn_position() 
	return spawn_pos
	
	
func _on_Timer_timeout():
	wave += 1
	_spawn_enemies(wave)
	Global.emit_signal("cards")
	Global.level += 1
	if Global.level == 3:
		Global.spawn_lvl += 1
	



