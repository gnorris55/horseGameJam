extends Node2D

@export var speed = 100
@export var health = 5

var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)
	
func movement(delta: float):
	# need to be able to get player position
	var horse = get_tree().get_nodes_in_group("horse")
	if (len(horse) > 0):
		var target_postion = horse[0].global_position
		direction = (target_postion - global_position).normalized()
		
		global_position += speed*delta*direction

func take_damage(damage):
	health -= damage
	print(health)
	#TODO: make the bounce back more realistic
	global_position = global_position - direction*200
	if (health <= 0):
		var enemy_manager = get_parent()
		enemy_manager.enemy_drop(global_position)
		queue_free()
