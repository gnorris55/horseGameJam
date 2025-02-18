extends Node2D

@export var speed = 100


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
		var direction = (target_postion - global_position).normalized()
		
		global_position += speed*delta*direction
