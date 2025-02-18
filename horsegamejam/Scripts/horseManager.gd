extends Node2D

@onready var health_bar: ProgressBar = $playerUI/healthBar
@onready var stamina_bar: ProgressBar = $playerUI/staminaBar

@export var health = 50
@export var stamina = 50

var money = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.max_value = health
	health_bar.value = health
	
	stamina_bar.max_value = stamina
	stamina_bar.value = stamina
	
	
func take_damage(damage):
	health -= damage
	health_bar.value = health
	
	if (health <= 0):
		print("game over")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("carrot"):
		area.get_parent().queue_free()
		money += 20
	if area.is_in_group("enemyArea2D"):
		take_damage(20)
	
