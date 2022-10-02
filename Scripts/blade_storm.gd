extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("attack")
	$Timer.start(Global.bladestorm_speed)


func _process(delta):
	$Timer.wait_time = Global.bladestorm_speed


func _on_Timer_timeout():
	$AnimationPlayer.play("attack")
