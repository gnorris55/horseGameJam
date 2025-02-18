extends Node2D

var speed = 300;#determined by wheels and fans that will be added

#var parent_pos = get_parent().position

@onready var parent = get_parent();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		parent.position.x -=delta*speed
	elif Input.is_action_pressed("right"):
		parent.position.x +=delta*speed
	elif Input.is_action_pressed("up"):
		parent.position.y -=delta*speed
	elif Input.is_action_pressed("down"):
		parent.position.y +=delta*speed
	
	var vec = Vector2(get_global_mouse_position().x - get_parent().position.x,get_global_mouse_position().y - get_parent().position.y)
	parent.rotation = vec.angle()
	#get_node("/root/Horse//horseSprite").rotation = vec.angle()
