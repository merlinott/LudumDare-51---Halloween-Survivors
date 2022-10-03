extends Control


func _process(delta):
	$VB/HIGHSCORE.text = "\n\nHighscore: " + str(Global.highscore)
