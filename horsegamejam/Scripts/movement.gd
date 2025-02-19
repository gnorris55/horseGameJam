extends Node2D

var speed = 300; #determined by wheels and fans that will be added

var vel = Vector2(0,0)
#var parent_pos = get_parent().position

const BOUNDINGBOX = [-2251,-1500,2251,1500]

@onready var parent = get_parent();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left") and parent.position.x > BOUNDINGBOX[0]:
		vel.x = -1
	elif Input.is_action_pressed("right") and parent.position.x < BOUNDINGBOX[2]:
		vel.x =1
	else:
		vel.x = 0
	if Input.is_action_pressed("up") and parent.position.y > BOUNDINGBOX[1]:
		vel.y = -1
	elif Input.is_action_pressed("down") and parent.position.y < BOUNDINGBOX[3]:
		vel.y = 1
	else:
		vel.y = 0
		
	vel.limit_length(1)
	parent.position += vel*speed*delta
	
	var vec = Vector2(get_global_mouse_position().x - get_parent().position.x,get_global_mouse_position().y - get_parent().position.y)
	parent.rotation = vec.angle()+ PI/2
	#get_node("/root/Horse//horseSprite").rotation = vec.angle()
