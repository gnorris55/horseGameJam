extends Node2D

var speed = 100;#determined by wheels and fans that will be added

#var parent_pos = get_parent().position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		get_parent().position.x -=delta*speed
	elif Input.is_action_pressed("right"):
		get_parent().position.x +=delta*speed
	elif Input.is_action_pressed("up"):
		get_parent().position.y -=delta*speed
	elif Input.is_action_pressed("down"):
		get_parent().position.y +=delta*speed
