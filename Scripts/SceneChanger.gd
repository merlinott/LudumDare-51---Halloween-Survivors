extends Node2D


var gamescene1 = preload("res://Scenes/Room.tscn")
var main_menu = preload("res://Scenes/Main_Menu.tscn")
var end_scene = preload("res://Scenes/End_Screen.tscn")

func _ready():

	load_main_menu()
	
	
func load_main_menu():
	$"Cards UI".visible = false
	get_node("Main_Menu/VB/PLAY").connect("pressed", self, "on_new_game_pressed")
#	get_node("Main_Menu/VB/QUIT").connect("pressed", self, "on_quit_pressed")
	
	
func on_new_game_pressed():
	Global.emit_signal("card_reset")
	Global.set_stats()
	get_node("Main_Menu").queue_free()
	var game_scene = gamescene1.instance()
	
	Global.connect("game_finished", self, "ending_scene")
	Global.connect("back_to_menu", self, "unload_game")
	add_child(game_scene)
	$"Cards UI".visible = true
	
func on_quit_pressed():
	get_tree().quit()


func unload_game():
	get_node("End_Screen").queue_free()
	var menu = load("res://Scenes/Main_Menu.tscn").instance()
	add_child(menu)
	load_main_menu()
	
func ending_scene():
	$"Cards UI".visible = false
	get_node("Room").queue_free()
	var endscene = end_scene.instance()
	add_child(endscene)
	
