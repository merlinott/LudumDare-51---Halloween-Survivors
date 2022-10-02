extends CanvasLayer


onready var card1 = $HUD/CardContainer/Card1
onready var card2 = $HUD/CardContainer/Card2
onready var card3 = $HUD/CardContainer/Card3

onready var clock_label = $HUD/UI/Label
onready var hp_bar_tween = $HUD/UI/TextureProgress/Tween
onready var hp_bar = $HUD/UI/TextureProgress


onready var gun_cooldown = preload("res://Assets/Upgrade Cards/GunCooldown.png")
onready var movement_speed = preload("res://Assets/Upgrade Cards/MovementSpeed.png")
onready var gun_range = preload("res://Assets/Upgrade Cards/Range.png")
onready var blade = preload("res://Assets/Upgrade Cards/blade.png")
onready var blade_speed = preload("res://Assets/Upgrade Cards/blade_speed.png")
onready var bladestorm = preload("res://Assets/Upgrade Cards/bladestorm.png")
onready var bladestorm_speed = preload("res://Assets/Upgrade Cards/bladestorm_cd.png")

var upgrade_cards = []


var blade_equip = false
var bladestorm_equip = false

func _ready():
	Global.connect("card_reset", self, "update_cards")
	Global.connect("cards",self,"open_cards")
	Global.connect("update_health", self, "update_health_bar")
	
	cards_init()
	
	
func cards_init():
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
	clock_label.text = str(Global.time)
	$HUD/DEBUGLABEL.text = "attack range: "+str(Global.attack_range) +", speed: "+ str(Global.movement_speed) +", bulletCD: "+ str(Global.bullet_cooldown) +", blade_speed: "+ str(Global.blade_speed) +", playerhealth: "+ str(Global.playerhealth) +", level: "+ str(Global.level) +", time: "+ str(Global.time) +", spawn_level: "+ str(Global.spawn_lvl)

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
		blade_equip = false
	
	if Global.level == 2:
		upgrade_cards.append(bladestorm)
	if bladestorm_equip == true:
		upgrade_cards.append(bladestorm_speed)
		bladestorm_equip = false
		
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
		
	if  card1.texture_normal == bladestorm:
		Global.emit_signal("bladestorm_init")
		bladestorm_equip = true
		upgrade_cards.erase(bladestorm)
		
	if  card1.texture_normal == blade_speed:
		Global.bladestorm_speed *= 1.125
		
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
		
	if  card2.texture_normal == bladestorm:
		Global.emit_signal("bladestorm_init")
		bladestorm_equip = true
		upgrade_cards.erase(bladestorm)
		
	if  card2.texture_normal == blade_speed:
		Global.bladestorm_speed *= 1.125
		
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
		
	if  card3.texture_normal == bladestorm:
		Global.emit_signal("bladestorm_init")
		bladestorm_equip = true
		upgrade_cards.erase(bladestorm)
		
	if  card3.texture_normal == blade_speed:
		Global.bladestorm_speed *= 1.125
		
func open_cards():
	add_cards()
	$HUD/CardContainer.visible = true
	print (upgrade_cards.size())
	
func update_cards():
	upgrade_cards.clear()
	cards_init()

func update_health_bar(player_health):
	
	hp_bar_tween.interpolate_property(hp_bar, "value", hp_bar.value, player_health, 0.1, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	hp_bar_tween.start()
	if player_health >= 60:
		hp_bar.set_tint_progress("4eff15") # GREEN
	elif player_health >= 25:
		hp_bar.set_tint_progress("e1be32") # ORANGE
	else:
		hp_bar.set_tint_progress("e11e1e") # RED

