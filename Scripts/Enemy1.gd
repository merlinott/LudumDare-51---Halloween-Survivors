extends KinematicBody2D

onready var pumpkin = preload("res://Assets/pumpkin.png")
onready var ghost = preload("res://Assets/ghost.png")
var type



onready var gem_scene = preload("res://Scenes/Gem.tscn")



var target = Vector2.ZERO
var velocity = Vector2.ZERO
var max_speed: float
var damage: float 
var gem_drop: int = 2
var avoid_force: int = 1000
var max_force = .5

func _ready():
	$AnimationPlayer.play("walk")
	var rand_type = randi() % Global.spawn_lvl
	type = rand_type
	
	
	
	
	if type == 0:
		$Sprite.texture = pumpkin
		max_speed = 50
		damage = 10
		
		

		
	if type == 1:
		$Sprite.texture = ghost
		max_speed = 100
		damage = 20
		
		
		
func _physics_process(delta):
	
	velocity = steer(target)
	move_and_slide(velocity * delta).normalized() 
	target = get_node("/root/SceneChanger/Room/Player").position


func steer(target):
	var desired_velocity = Vector2(target - position) * max_speed
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer*max_force)
	return (target_velocity)


func _on_HitBox_area_entered(area):
	if area.is_in_group("bullet"):
		area.queue_free()
		queue_free()
	if area.is_in_group("sword"):
		queue_free()
	
	if area.is_in_group("hitbox"):
		Global.emit_signal("damage", damage)
	
func drop():
	var gem = gem_scene.instance()
	randomize()
	var chance = randi() % gem_drop
	
	if chance == 1:
		gem.position = position
		get_parent().call_deferred("add_child", gem)
	
	yield(get_tree(),"idle_frame")
	die()

func die():
	queue_free()
