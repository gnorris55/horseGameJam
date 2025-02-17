extends Node2D

@onready var horse: Node2D = $"../.."
@onready var weapon: Node2D = $weapon
@onready var sprite_2d: Sprite2D = $weapon/Sprite2D
@onready var tail: Line2D = $tail


var radius = 200
var direction = -1
var t = PI / 2
var speed_scalar = 2

var center_point = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tail.add_point(global_position)
	tail.add_point(weapon.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	center_point = global_position 
	
	t += direction*delta*speed_scalar
	
	if (t < -PI/4.0):
		direction = 1
		
	if (t > (PI + PI/4.0)):
		direction = -1
	
	
	var x = center_point.x + radius * cos(t)
	var y = center_point.y + radius * sin(t) 
	
	weapon.global_position = Vector2(x, y)
	
	tail.points[0] = tail.to_local(global_position)
	tail.points[1] = tail.to_local(weapon.global_position)
	
	
	
	
	
