extends CanvasLayer


onready var card1 = $HUD/CardContainer/Card1
onready var card2 = $HUD/CardContainer/Card2
onready var card3 = $HUD/CardContainer/Card3


onready var gun_cooldown = preload("res://Assets/Upgrade Cards/GunCooldown.png")
onready var movement_speed = preload("res://Assets/Upgrade Cards/MovementSpeed.png")
onready var gun_range = preload("res://Assets/Upgrade Cards/Range.png")
onready var blade = preload("res://Assets/Upgrade Cards/blade.png")
onready var blade_speed = preload("res://Assets/Upgrade Cards/blade_speed.png")

var upgrade_cards = []


var blade_equip = false


func _ready():
#	Global.emit_signal("blade_init")
	Global.connect("cards",self,"open_cards")
	
	upgrade_cards.append(gun_cooldown)
	upgrade_cards.append(gun_cooldown)
	upgrade_cards.append(gun_cooldown)
	
	upgrade_cards.append(movement_speed)
	upgrade_cards.append(movement_speed)
	upgrade_cards.append(movement_speed)
	
	upgrade_cards.append(gun_range)
	upgrade_cards.append(gun_range)
	upgrade_cards.append(gun_range)
	
	add_cards()

func _process(delta):
	pass

func add_cards():
	upgrade_cards.shuffle()
	$HUD/CardContainer/Card1.texture_normal = upgrade_cards.front()
	upgrade_cards.shuffle()
	$HUD/CardContainer/Card2.texture_normal = upgrade_cards.front()
	upgrade_cards.shuffle()
	$HUD/CardContainer/Card3.texture_normal = upgrade_cards.front()
	
	if Global.level == 10:
		upgrade_cards.append(blade)
	if blade_equip == true:
		upgrade_cards.append(blade_speed)
		
func _on_Card1_pressed():
	$HUD/CardContainer.visible = false
	if  card1.texture_normal == gun_cooldown:
		Global.bullet_cooldown /= 1.1
		
	if  card1.texture_normal == movement_speed:
		Global.movement_speed *= 1.05
		
	if  card1.texture_normal == gun_range:
		Global.emit_signal("range_update")
		Global.attack_range *= 1.1
		
		
	if  card1.texture_normal == blade:
		Global.emit_signal("blade_init")
		blade_equip = true
		upgrade_cards.erase(blade)
		
	if  card1.texture_normal == blade_speed:
		Global.blade_speed *= 1.125
		
	print ( "huh")
func _on_Card2_pressed():
	$HUD/CardContainer.visible = false
	if  card2.texture_normal == gun_cooldown:
		Global.bullet_cooldown /= 1.1
		
	if  card2.texture_normal == movement_speed:
		Global.movement_speed *= 1.05
		
	if  card2.texture_normal == gun_range:
		Global.emit_signal("range_update")
		Global.attack_range *= 1.1
		
		
	if  card2.texture_normal == blade:
		Global.emit_signal("blade_init")
		blade_equip = true
		upgrade_cards.erase(blade)
		
	if  card2.texture_normal == blade_speed:
		Global.blade_speed *= 1.125
		
func _on_Card3_pressed():
	$HUD/CardContainer.visible = false
	if  card3.texture_normal == gun_cooldown:
		Global.bullet_cooldown /= 1.1
		
	if  card3.texture_normal == movement_speed:
		Global.movement_speed *= 1.05
		
	if  card3.texture_normal == gun_range:
		Global.emit_signal("range_update")
		Global.attack_range *= 1.1
		
		
	if  card3.texture_normal == blade:
		Global.emit_signal("blade_init")
		blade_equip = true
		upgrade_cards.erase(blade)
		
	if  card3.texture_normal == blade_speed:
		Global.blade_speed *= 1.125
		
func open_cards():
	add_cards()
	$HUD/CardContainer.visible = true

