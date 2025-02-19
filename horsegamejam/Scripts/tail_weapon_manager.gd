extends Node2D

@onready var horse: Node2D = $"../.."
@onready var weapon: Node2D = $weapon
@onready var tail: Line2D = $tail
@onready var sprite_2d: Sprite2D = $weapon/Sprite2D


var radius = 100
var direction = -1
var t = PI / 2
var speed_scalar = 3

var center_point = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tail.add_point(global_position)
	tail.add_point(weapon.global_position)

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
	weapon.global_rotation = Vector2(horse_orientation + x,horse_orientation + y).normalized().angle()
	
	weapon.global_position = Vector2(x, y)
	#sprites.global_position = Vector2(x, y)
	
	tail.points[0] = tail.to_local(global_position)
	tail.points[1] = tail.to_local(weapon.global_position)

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("body entered")
	if area.is_in_group("enemyArea2D"):
		area.get_parent().take_damage(20, true)	
	
