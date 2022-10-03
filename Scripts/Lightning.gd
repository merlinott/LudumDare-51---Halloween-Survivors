extends Node2D


onready var lightning_scene = preload("res://Scenes/lightning.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	shoot()


func _physics_process(delta):
	$Timer.wait_time = Global.lightning_cooldown

func shoot():
	
	for i in range(25):
		randomize()
		var lightning = lightning_scene.instance()
		lightning.position = get_parent().position + Vector2(rand_range(-2000,2000),rand_range(-2000,2000))
		get_tree().root.add_child(lightning)
		$shoottimer.wait_time = rand_range(0.01, 0.15)
		$shoottimer.start()
		yield($shoottimer, "timeout")


func _on_Timer_timeout():
		shoot()
