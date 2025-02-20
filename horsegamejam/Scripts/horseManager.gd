extends Node2D

@onready var health_bar: ProgressBar = $playerUI/healthBar
@onready var stamina_bar: ProgressBar = $playerUI/staminaBar
@onready var currency_label: Label = $playerUI/currency

@export var health = 50
@export var stamina = 50

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
	
	stamina_bar.max_value = stamina
	stamina_bar.value = stamina
	$horseSpriteAnimated.play()
	
	
func take_damage(damage):
	if (health > 0):
		health -= damage
	
	
	if (health <= 0):
		print("game over")
	
	print("health lvl: " + str(health))
	health_bar.value = health
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("carrot"):
		area.get_parent().queue_free()
		money += 20
		currency_label.text = "carrots: " + str(money)
	elif area.is_in_group("healthPotion"):
		area.get_parent().queue_free()
		health += 20
		health_bar.value = health
	elif area.is_in_group("enemyArea2D"):
		take_damage(20)
	elif area.is_in_group("enemyBullet"):
		take_damage(1)
		area.get_parent().queue_free()
	
