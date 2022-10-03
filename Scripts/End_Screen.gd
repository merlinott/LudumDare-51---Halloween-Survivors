extends Control


func _ready():
	endscreen_text()
	
func endscreen_text():
	if Global.highscore == Global.score:
		$NinePatchRect/Label.text = "You Died! \n \n Congratulations, new Highscore! \n\n Highscore: " + str(Global.highscore) + "\n Score: " + str(Global.score) + "\n \n Click to continue! "
	else:
		$NinePatchRect/Label.text = "You Died! \n \n Highscore: " + str(Global.highscore) + "\n Score: " + str(Global.score) + "\n \n Click to continue! "


func _process(delta):
	if Input.is_action_just_pressed("LMB"):
		Global.emit_signal("back_to_menu")
