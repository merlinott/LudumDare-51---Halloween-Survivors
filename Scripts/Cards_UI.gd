extends CanvasLayer


onready var card1 = $HUD/CardContainer/Card1
onready var card2 = $HUD/CardContainer/Card2
onready var card3 = $HUD/CardContainer/Card3

onready var clock_label = $HUD/UI/Time_Label
onready var hp_bar_tween = $HUD/UI/TextureProgress/Tween
onready var hp_bar = $HUD/UI/TextureProgress

onready var score_label = $HUD/HBoxContainer/Score
onready var highscore_label = $HUD/HBoxContainer/Highscore

onready var blade = preload("res://Assets/Upgrade Cards/blade.png")
onready var blade_speed = preload("res://Assets/Upgrade Cards/blade_speed.png")

onready var gun_cooldown = preload("res://Assets/Upgrade Cards/GunCooldown.png")
onready var gun_range = preload("res://Assets/Upgrade Cards/Range.png")


onready var bladestorm = preload("res://Assets/Upgrade Cards/bladestorm.png")
onready var bladestorm_speed = preload("res://Assets/Upgrade Cards/bladestorm_cd.png")

onready var lightning = preload("res://Assets/Upgrade Cards/lightning.png")
onready var lightning_recharge = preload("res://Assets/Upgrade Cards/lightning_recharge.png")

onready var max_health = preload("res://Assets/Upgrade Cards/health.png")
onready var base_damage = preload("res://Assets/Upgrade Cards/base_damage.png")
onready var movement_speed = preload("res://Assets/Upgrade Cards/MovementSpeed.png")

var upgrade_cards = []


var blade_equip = false
var bladestorm_equip = false
var lightning_equip = false

func _ready():
	Global.connect("card_reset", self, "update_cards")
	Global.connect("cards",self,"open_cards")
	Global.connect("update_health", self, "update_health_bar")
	Global.connect("hpbar_update", self, "reset_hp_bar")
	
	cards_init()
	
	
func cards_init():
	upgrade_cards.append(gun_cooldown)
	upgrade_cards.append(movement_speed)
	upgrade_cards.append(gun_range)
	upgrade_cards.append(base_damage)
	upgrade_cards.append(max_health)
	upgrade_cards.shuffle()
	add_cards()

func _process(delta):
	
	
	# Score will be printet on labels
	score_label.text = "SCORE: " + str(Global.score)
	highscore_label.text = "HIGHSCORE: " + str(Global.highscore)
	
	
	clock_label.text = str(Global.time)
	if Global.time == 3:
		clock_label.modulate = Color(255,0,0)
	elif Global.time == 2:
		clock_label.modulate = Color(255,0,0)
	elif Global.time == 1:
		clock_label.modulate = Color(255,0,0)
	elif Global.time == 0:
		clock_label.modulate = Color(255,0,0)
	
	else:
		clock_label.modulate = Color(255,255,255)
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
	
	if Global.level == 20:
		upgrade_cards.append(bladestorm)
	if bladestorm_equip == true:
		upgrade_cards.append(bladestorm_speed)
		bladestorm_equip = false
		
	if Global.level == 30:
		upgrade_cards.append(lightning)
	if lightning_equip == true:
		upgrade_cards.append(lightning_recharge)
		lightning_equip = false
		
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
		Global.blade_speed /= 1.125
		
	if  card1.texture_normal == bladestorm:
		Global.emit_signal("bladestorm_init")
		bladestorm_equip = true
		upgrade_cards.erase(bladestorm)
		
	if  card1.texture_normal == blade_speed:
		Global.bladestorm_speed /= 1.1
		
	if  card1.texture_normal == lightning:
		Global.emit_signal("lightning_init")
		lightning_equip = true
		upgrade_cards.erase(lightning)
		
	if  card1.texture_normal == lightning_recharge:
		Global.lightning_cooldown /= 1.1
		
	if  card1.texture_normal == base_damage:
		Global.base_damage *= 1.25
		
	if  card1.texture_normal == max_health:
		Global.playerhealth += 5
		hp_bar.max_value = Global.playerhealth
		print (hp_bar.max_value)
		
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
		
	if  card2.texture_normal == lightning:
		Global.emit_signal("lightning_init")
		lightning_equip = true
		upgrade_cards.erase(lightning)
		
	if  card2.texture_normal == lightning_recharge:
		Global.lightning_cooldown /= 1.1
	
	if  card2.texture_normal == base_damage:
		Global.base_damage *= 1.25
		
	if  card2.texture_normal == max_health:
		Global.playerhealth += 5
		hp_bar.max_value = Global.playerhealth
		print (hp_bar.max_value)
		
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
		Global.bladestorm_speed /= 1.1
		
	if  card3.texture_normal == lightning:
		Global.emit_signal("lightning_init")
		lightning_equip = true
		upgrade_cards.erase(lightning)
		
	if  card3.texture_normal == lightning_recharge:
		Global.lightning_cooldown /= 1.1
		
	if  card3.texture_normal == base_damage:
		Global.base_damage *= 1.25
		
	if  card3.texture_normal == max_health:
		Global.playerhealth += 5
		hp_bar.max_value = Global.playerhealth
		print (hp_bar.max_value)
		
func open_cards():
	add_cards()
	$HUD/CardContainer.visible = true
	print (upgrade_cards.size())
	
func update_cards():
	upgrade_cards.clear()
	cards_init()

func reset_hp_bar():
	hp_bar.max_value = Global.playerhealth

func update_health_bar(player_health):
	
	hp_bar_tween.interpolate_property(hp_bar, "value", hp_bar.value, player_health, 0.1, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	hp_bar_tween.start()
	if player_health >= 60:
		hp_bar.set_tint_progress("4eff15") # GREEN
	elif player_health >= 25:
		hp_bar.set_tint_progress("e1be32") # ORANGE
	else:
		hp_bar.set_tint_progress("e11e1e") # RED

