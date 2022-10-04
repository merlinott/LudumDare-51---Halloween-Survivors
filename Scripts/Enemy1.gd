extends KinematicBody2D

onready var pumpkin = preload("res://Assets/pumpkin.png")
onready var ghost = preload("res://Assets/ghost.png")
onready var wolf = preload("res://Assets/wolf.png")
onready var octopus = preload("res://Assets/octopus.png")


var type

export (int, "HUNT, SHOOT") var mode = 0

onready var gem_scene = preload("res://Scenes/Gem.tscn")

onready var bullet_scene = preload("res://Scenes/enemy_bullet.tscn")
var can_shoot = true
var player = null


var enemy_life: float
var target = Vector2.ZERO
var velocity = Vector2.ZERO
var max_speed: float
var damage: float 
var gem_drop: int = 2
var avoid_force: int = 1000
var max_force = .5

func _ready():
	
	var rand_type = randi() % Global.spawn_lvl
	type = rand_type
	
	
	if type == 0:
		$Sprite.texture = pumpkin
		max_speed = 50
		damage = 10
		enemy_life = 1
		$AnimationPlayer.play("pumpkin_walk")
		
	if type == 1:
		$Sprite.texture = ghost
		max_speed = 100
		damage = 20
		enemy_life = 4
		$AnimationPlayer.play("walk")
		
	if type == 2:
		$Sprite.texture = wolf
		max_speed = 120
		damage = 30
		enemy_life = 8
		$AnimationPlayer.play("wolf_walk")
		
	if type == 3:
		$Sprite.texture = octopus
		max_speed = 90
		damage = 50
		enemy_life = 8
		$AnimationPlayer.play("octo_walk")
		
func _physics_process(delta):
	if enemy_life <= 0:
		drop()
#	velocity = steer(target)

	if mode == 0:
		velocity = Vector2(target - position) 
		move_and_slide(velocity * delta * max_speed).normalized() 
		
		target = get_node("/root/SceneChanger/Room/Player").position
		
		
	if mode == 1:
		attack()





#func steer(target):
#	var desired_velocity = Vector2(target - position) * max_speed
#	var steer = desired_velocity - velocity
#	var target_velocity = velocity + (steer*max_force)
#	return (desired_velocity)


func _on_HitBox_area_entered(area):
	if area.is_in_group("bullet"):
		area.queue_free()
		enemy_life -= 1 * Global.base_damage
		
	if area.is_in_group("sword"):
		enemy_life -= 2 * Global.base_damage
	
	if area.is_in_group("lightning"):
		enemy_life -= 3 * Global.base_damage
	
	if area.is_in_group("hitbox"):
		Global.emit_signal("damage", damage)
	
	
func drop():
	var gem = gem_scene.instance()
	randomize()
	var chance = randi() % gem_drop + 1
	
	if chance == 1:
		gem.position = position
		get_parent().get_node("Gems").call_deferred("add_child", gem)
	
	yield(get_tree(),"idle_frame")
	die()

func die():
	Global.score +=1
	queue_free()


func _on_OctoShootRange_body_entered(body):
	if body.is_in_group("player") and type == 3:
		mode = 1
		print(mode)
		player = body
		
		
func _on_OctoShootRange_body_exited(body):
	if body.is_in_group("player") and type == 3:
		mode = 0
		print(mode)
		player = null
		
		
func attack():
	
	if can_shoot == true:
		can_shoot = false
		var bullet = bullet_scene.instance()
		bullet.direction = player.global_position - global_position
		bullet.position = global_position
		get_tree().get_root().add_child(bullet)
		$Timer.start(1)


func _on_Timer_timeout():
	can_shoot = true
