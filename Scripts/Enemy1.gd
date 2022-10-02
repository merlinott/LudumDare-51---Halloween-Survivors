extends KinematicBody2D

onready var pumpkin = preload("res://Assets/pumpkin.png")
onready var ghost = preload("res://Assets/ghost.png")

var type


var target = Vector2.ZERO
var velocity = Vector2.ZERO
var max_speed: float
var max_force = .5
var avoid_force: int = 1000


func _ready():
	$AnimationPlayer.play("walk")
	var rand_type = randi() % Global.spawn_lvl
	type = rand_type
	print (rand_type)
	
	if type == 0:
		$Sprite.texture = pumpkin
		max_speed = 50
	if type == 1:
		$Sprite.texture = ghost
		max_speed = 100
		
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
	if "bullet" in area.name:
		queue_free()
	if "sword" in area.name:
		queue_free()
