extends Node2D

@onready var health_bar: ProgressBar = $playerUI/Control/Control/healthBar
@onready var stamina_bar: ProgressBar = $playerUI/Control/Control/staminaBar
@onready var currency_label: Label = $playerUI/Control/currency2/currency

@onready var immune_timer: Timer = $immuneTimer
@onready var movement: Node2D = $movement
@onready var movement_sprite: AnimatedSprite2D = $movementSprite

var MAX_STAMINA = 50
@export var health = 100
@export var stamina = MAX_STAMINA
var movement_state = 0

var main_weapon_state = 0
var tail_weapon_state = 0
var armour_type_state = 0
var beer_fridge_state = 0

var money = 1000

var stamina_factors = [5,10,20,50]
var armor_factors = [1,0.8,0.6,0.5,0.2,0.1]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	currency_label.text = str(money)
	health_bar.max_value = health
	health_bar.value = health
	movement_sprite.visible = false
	
	stamina_bar.max_value = stamina
	stamina_bar.value = stamina
	$horseSpriteAnimated.play()
	change_fridge("empty")
	change_armor("empty")
	
	global_pimpbus.pimp_changed.connect(pimp_changed)

func change_armor(type: String):
	
	if type == "armor1":
		armour_type_state = 1
	elif type == "armor2":
		armour_type_state = 2
	elif type == "armor3":
		armour_type_state = 3
	elif type == "armor4":
		armour_type_state = 4
	elif type == "armor5":
		armour_type_state = 5
	if type == "empty":
		armour_type_state = 0
		$armorSprite.visible = false
	else:
		$armorSprite.visible = true
		$armorSprite.play(str(armour_type_state))
	
	#beer_fridge_state = 1
func change_fridge(type: String):
	if type == "normal":
		beer_fridge_state = 1
	elif type == "gold":
		beer_fridge_state = 2
	elif type == "platinum":
		beer_fridge_state = 3
	if type == "empty":
		beer_fridge_state = 0
		$fridgeSprite.visible = false
	else:
		$fridgeSprite.visible = true
		$fridgeSprite.play(str(beer_fridge_state))

func change_movement(type: String):
	#if (slot == "HoovesSlot"):
	if type == "wheels":
		movement_sprite.play("wheels")
		movement_sprite.z_index = 0
		movement_sprite.visible = true
		movement.speed = 400
	elif type == "fans":
		movement_sprite.play("fans")
		movement_sprite.z_index = 1
		movement_sprite.visible = true
		movement.speed = 600
	elif type == "sawblades":
		movement_sprite.play("saws")
		movement_sprite.z_index = 0
		movement_sprite.visible = true
		movement.speed = 500
	
func take_damage(damage, direction):
	if (health > 0):
		health -= damage*armor_factors[armour_type_state]
		global_position += direction*20
	
	
	if (health <= 0):
		get_parent().game_over()

	health_bar.value = health
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	currency_label.text = str(money)
	if stamina < MAX_STAMINA:
		stamina += delta*stamina_factors[beer_fridge_state]
		if stamina > MAX_STAMINA:
			stamina = MAX_STAMINA
		stamina_bar.value = stamina
		
	if Input.is_action_just_pressed("changeMovement"):
		movement_state = (movement_state + 1) % 4
		
		if movement_state == 0:
			movement_sprite.play()
			movement_sprite.visible = false
		elif movement_state == 1:
			movement_sprite.play("wheels")
			movement_sprite.z_index = 0
			movement_sprite.visible = true
			movement.speed = 400
		elif movement_state == 2:
			movement_sprite.play("fans")
			movement_sprite.z_index = 1
			movement_sprite.visible = true
			movement.speed = 600
		elif movement_state == 3:
			movement_sprite.play("saws")
			movement_sprite.z_index = 0
			movement_sprite.visible = true
			movement.speed = 500
			
		
var immune = false
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("carrot"):
		area.get_parent().queue_free()
		money += 5
		currency_label.text = str(money)
	elif area.is_in_group("healthPotion"):
		area.get_parent().queue_free()
		health += 20
		health_bar.value = health
	elif area.is_in_group("enemyArea2D") and !immune:
		take_damage(20, area.get_parent().direction)
		immune_timer.start()
		immune = true
		
	elif area.is_in_group("enemyBullet"):
		take_damage(10, area.get_parent().direction)
		area.get_parent().queue_free()
	


func _on_immune_timer_timeout() -> void:
	immune = false

func pimp_changed(slot: String, type: String, unlocked: bool):#,unlocked: bool):
	
	#print(slot,type,unlocked)
	if unlocked:
		if slot == "HoovesSlot":
			change_movement(type)
		elif slot == "MinifridgeSlot":
			change_fridge(type)
		elif slot == "BodySlot":
				change_armor(type)
