extends Node2D

@onready var horse: Node2D = $"../.."
@onready var weapon: Node2D = $weapon
@onready var sprite_2d: Sprite2D = $weapon/Sprite2D
@onready var tail: Line2D = $tail


var radius = 200
var direction = 1
var t = PI / 2
var speed_scalar = 4

var center_point = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	t =  PI + horse.rotation
	tail.add_point(global_position)
	tail.add_point(weapon.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	center_point = global_position 
	var horse_orientation = horse.rotation
	
	
	t += direction*delta*speed_scalar
	
	#if (t <)
	print("horse orientation: " + str(horse_orientation))
	# limit1 is counter clockwise
	# limit2 
	var limit1 = -PI/4.0
	var limit2 = (PI + PI/4.0) 

	var weapon_orientation = t + horse_orientation
	
	var rot1 = fposmod(weapon_orientation, TAU)
	var rot2 = fposmod(weapon_orientation, -TAU)
	#limit1 = fposmod(limit1, TAU)
	#limit2 = fposmod(limit2, TAU)
	var negative_limit1 = fposmod(limit1, -TAU)
	var negative_limit2 = fposmod(limit2, -TAU)
	
	#print("rot 1: " + str(rad_to_deg(rot1)))
	#print("rot 2: " + str(rad_to_deg(rot2)))
	
	print("t: " + str(rad_to_deg(t)))
	
	print("limit 1: " + str(rad_to_deg(limit1)))
	print("limit 2: " + str(rad_to_deg(limit2)))
	
	#print("neg limit 1: " + str(rad_to_deg(negative_limit1)))
	#print("neg limit 2: " + str(rad_to_deg(negative_limit2)))
	
	'''
	if (rot1 < limit1 and rot1 > limit2):
		print("in limit")
		var dist_to_start = abs(rot1 - limit1)
		var dist_to_end = abs(rot1 - limit2)
		print("dist to limit1: " + str(dist_to_start))
		print("dist to limit2: " + str(dist_to_end))
		
		if dist_to_start < dist_to_end:
			print("closer to limit 1")
			#t = limit1
			#weapon_orientation = limit1  # Set the angle to the end of the forbidden region
			#direction = -1
			pass
		else:
			print("closer to limit 2")
			#weapon_orientation = limit2  # Set the angle to the start of the forbidden region
			#t = limit2
			#direction = 1
			pass
		#t = limit1
		#weapon_orientation = limit1 - 0.5
		#print("reached limit1")
		#direction = -1
	
	
	'''
	'''
	print("horse position: " + str(rad_to_deg(fposmod(horse_orientation, TAU))))
	print("weapon orientation: " + str(rad_to_deg(weapon_orientation)))
	
	
	
	if limit1 <= weapon_orientation and weapon_orientation <= limit2:
		# Adjust the angle to avoid the forbidden region
		var dist_to_start = abs(weapon_orientation - limit1)
		var dist_to_end = abs(weapon_orientation - limit2)
		
		if dist_to_start < dist_to_end:
			weapon_orientation = limit1  # Set the angle to the end of the forbidden region
			direction = -1
		else:
			weapon_orientation = limit2  # Set the angle to the start of the forbidden region
			direction = 1
	'''

	if (t < limit1):
		print("go forwards")
		t = limit1
		direction = 1
		
	if (t > limit2):
		t = limit2
		print("go backwards")
		direction = -1


	
	var x = center_point.x + radius * cos(horse_orientation + t)
	var y = center_point.y + radius * sin(horse_orientation + t) 
	
	weapon.global_position = Vector2(x, y)
	
	tail.points[0] = tail.to_local(global_position)
	tail.points[1] = tail.to_local(weapon.global_position)
	
	
	
	
	
