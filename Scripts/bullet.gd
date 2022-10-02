extends Area2D


var direction = Vector2.UP
var speed = 5000


func _ready():
	pass
	
func _process(delta):
	
	translate(direction.normalized()* speed *delta)
	
	
func kill():
	queue_free()
	
	
func _on_bullet_body_entered(body):
	if body.is_in_group("enemy") or "enemy1" in body.name:
		kill()


func _on_timeout_timeout():
	kill()
