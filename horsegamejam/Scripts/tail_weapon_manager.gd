extends Node2D

@onready var horse: Node2D = $"../.."
@onready var weapon: Node2D = $weapon
@onready var tail: Line2D = $tail
@onready var sprite_2d: Sprite2D = $weapon/Sprite2D
@onready var weapon_sprites: AnimatedSprite2D = $weapon/weaponSprites

@onready var weapons_area_2d: Area2D = $weapon/weaponsArea2D
@onready var weapons_area_2d_2: Area2D = $weapon/weaponsArea2D2


var radius = 100
var direction = -1
var t = PI / 2
var speed_scalar = 3
var weapon_damage = 20

var weapon_state = 0
var center_point = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	tail.add_point(global_position)
	tail.add_point(weapon.global_position)
	
	weapon_sprites.play("machete")
	weapons_area_2d.monitoring = false
	weapons_area_2d_2.monitoring = false
	weapon.visible = false
	tail.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	center_point = global_position 
	var horse_orientation = horse.rotation
	
	t += direction*delta*speed_scalar
	
	var limit1 = horse_orientation + -PI/3.0
	var limit2 = horse_orientation + (PI + PI/3.0)
	
	if (t < limit1):
		direction = 1
		
	if (t > limit2):
		direction = -1

	var x = center_point.x + radius * cos(t)
	var y = center_point.y + radius * sin(t) 
	
	#sprites.rotation = Vector2(x,y).normalized().angle()
	weapon.global_rotation = Vector2(x,y).normalized().angle()
	
	weapon.global_position = Vector2(x, y)
	#sprites.global_position = Vector2(x, y)
	
	tail.points[0] = tail.to_local(global_position)
	tail.points[1] = tail.to_local(weapon.global_position)

	inputs()

func inputs():
	if Input.is_action_just_pressed("changeMelee"):
		weapon_state = (weapon_state + 1) % 4
		print(weapon_state)
		
		if weapon_state == 0:
			tail.visible = false
			change_weapon_state(false, false, false, "machete", 20, 3)
		elif weapon_state == 1:
			tail.visible = true
			change_weapon_state(true, true, false, "machete", 20, 3)
		elif weapon_state == 2:
			tail.visible = true
			change_weapon_state(true, true, false, "chainsaw", 40, 2)
		elif weapon_state == 3:
			tail.visible = true
			change_weapon_state(true, false, true, "sawBlade", 30, 3.5)

func change_weapon_state(visible, monitoring1, monitoring2, animation, damage, speed):
	weapon.visible = visible
	weapons_area_2d.monitoring = monitoring1
	weapons_area_2d_2.monitoring = monitoring2
	weapon_sprites.play(animation)
	weapon_damage = damage
	speed_scalar = speed

func _on_weapons_area_2d_area_entered(area: Area2D) -> void:
	print("body entered")
	if area.is_in_group("enemyArea2D"):
		area.get_parent().take_damage(weapon_damage, true)	
		
	


func _on_weapons_area_2d_2_area_entered(area: Area2D) -> void:
	print("body entered")
	if area.is_in_group("enemyArea2D"):
		area.get_parent().take_damage(weapon_damage, true)	
