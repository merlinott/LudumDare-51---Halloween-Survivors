extends KinematicBody2D
class_name Player


var player_health

var max_speed : float
var acceleration : float = 20000
var velocity : Vector2 = Vector2.ZERO

var attack_range
var bullet_cooldown


onready var bullet_scene = preload("res://Scenes/bullet.tscn")
onready var blade_scene = preload("res://Scenes/sword.tscn")
onready var bladestorm_scene = preload("res://Scenes/blade_storm.tscn")

var can_shoot = true
	
	
var enemy_array = []

func _ready():
	
	set_health()
	
	Global.connect("damage", self, "on_base_damage")
	Global.connect("blade_init", self, "equip_blade")
	Global.connect("bladestorm_init", self, "equip_bladestorm")
	Global.connect("range_update", self, "range_visual")
	Global.connect("health_reset", self, "set_health")
	
func set_health():
	player_health = Global.playerhealth
	Global.emit_signal("update_health", player_health)
	
func _process(delta):
	max_speed = Global.movement_speed
	attack_range = Global.attack_range
	$Range/CollisionShape2D.shape.radius = attack_range
	$Range/Sprite.scale = Vector2((attack_range / 1000 * 2),(attack_range / 1000 * 2) )
	bullet_cooldown = Global.bullet_cooldown
	


	
	get_input_axis()

#MOVEMENT
	var axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(acceleration * delta)
	else:
		apply_movement(axis * acceleration * delta)

	velocity = move_and_slide(velocity)

	if select_enemy() != null:
		attack()
	
	player_animation(axis)
	
func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) 
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")) 
	return axis.normalized()

func apply_friction(ammount):
	if velocity.length() > ammount:
		velocity -= velocity.normalized() * ammount
	else:
		velocity = Vector2.ZERO

func apply_movement(ammount):
		velocity += ammount
		velocity = velocity.limit_length(max_speed)

func _on_Range_body_entered(body):
	if body.is_in_group("enemy"):
		enemy_array.append(body)

func _on_Range_body_exited(body):
	if body.is_in_group("enemy"):
		enemy_array.erase(body)
	

func select_enemy():
	var closest_position
	var closest_distance = INF

	for p in enemy_array:
		var distance = self.position.distance_to(p.position)
		if distance < closest_distance:
			closest_distance = distance
			closest_position = p
		
	return (closest_position)

func attack():
	
	if can_shoot == true:
		can_shoot = false
		var bullet = bullet_scene.instance()
		bullet.direction = select_enemy().global_position - global_position
		bullet.position = global_position
		get_tree().get_root().add_child(bullet)
		yield(get_tree().create_timer(bullet_cooldown), "timeout")
		can_shoot = true

func player_animation(axis):
	if axis.x < 0:
		$Sprite.scale.x = -1
	if axis.x >= 0:
		$Sprite.scale.x = 1
	
	if axis != Vector2.ZERO:
		$AnimationPlayer.play("walk")


func equip_blade():
	var blade = blade_scene.instance()
	add_child(blade)

func equip_bladestorm():
	var bladestorm = bladestorm_scene.instance()
	add_child(bladestorm)



func range_visual():
	$Range/Sprite.visible = true
	yield(get_tree().create_timer(.2), "timeout")
	$Range/Sprite.visible = false


func on_base_damage(damage):
	
	player_health -= damage
	if player_health <= 0:
		Global.emit_signal("game_finished", false)

	else:
		Global.emit_signal("update_health", player_health)
