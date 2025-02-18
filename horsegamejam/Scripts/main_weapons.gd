extends Node2D


var attack_type = "laser"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		print("attacks")
		if attack_type == "laser":
			
			#$line2D.visible = true
			var vec = Vector2(get_global_mouse_position().x - get_parent().position.x,get_global_mouse_position().y - get_parent().position.y)
			$Line2D.rotation = -get_node("/root/Horse").rotation 
			$Line2D.points = [get_parent().position,get_global_mouse_position()]
