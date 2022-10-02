extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("anim")

func _process(delta):
	$AnimationPlayer.playback_speed = Global.blade_speed
