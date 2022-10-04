extends Area2D



var direction = Vector2.UP
var speed = 5000
var damage = 50

func _ready():
	pass
	
func _process(delta):
	
	translate(direction.normalized()* speed *delta)
	
	
func kill():
	queue_free()


func _on_enemy_bullet_area_entered(area):
	if area.is_in_group("hitbox"):
		Global.emit_signal("damage", damage)
