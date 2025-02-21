extends Node2D

@onready var health_bar: ProgressBar = $playerUI/healthBar
@onready var stamina_bar: ProgressBar = $playerUI/staminaBar
@onready var currency_label: Label = $playerUI/currency
@onready var immune_timer: Timer = $immuneTimer
@onready var movement: Node2D = $movement
@onready var movement_sprite: AnimatedSprite2D = $movementSprite

@export var health = 50
@export var stamina = 50
var movement_state = 0

var main_weapon_state = 0
var tail_weapon_state = 0
var armour_type_state = 0
var beer_fridge_state = 0

var money = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	currency_label.text = "carrots: " + str(money)
	health_bar.max_value = health
	health_bar.value = health
	movement_sprite.visible = false
	
	stamina_bar.max_value = stamina
	stamina_bar.value = stamina
	$horseSpriteAnimated.play()
	
func change_movement(slot: String, type: String):
	if (slot == "HoovesSlot"):
		if type == "wheels":
			movement_sprite.play("wheels")
			movement_sprite.z_index = 0
			movement_sprite.visible = true
			movement.speed = 400
		elif movement_state == "fans":
			movement_sprite.play("fans")
			movement_sprite.z_index = 1
			movement_sprite.visible = true
			movement.speed = 600
		elif movement_state == 3:
			movement_sprite.play("sawblades")
			movement_sprite.z_index = 0
			movement_sprite.visible = true
			movement.speed = 500
	
func take_damage(damage, direction):
	if (health > 0):
		health -= damage
		global_position += direction*20
	
	
	if (health <= 0):
		get_parent().game_over()

	health_bar.value = health
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("changeMovement"):
		movement_state = (movement_state + 1) % 4
		print(movement)
		
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
		money += 20
		currency_label.text = "carrots: " + str(money)
	elif area.is_in_group("healthPotion"):
		area.get_parent().queue_free()
		health += 20
		health_bar.value = health
	elif area.is_in_group("enemyArea2D") and !immune:
		take_damage(20, area.get_parent().direction)
		immune_timer.start()
		immune = true
		
	elif area.is_in_group("enemyBullet"):
		take_damage(1, area.get_parent().direction)
		area.get_parent().queue_free()
	


func _on_immune_timer_timeout() -> void:
	immune = false
