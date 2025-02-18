extends Node2D


var attack_type = "laser"
@onready var horse_node = get_parent().get_parent()


const LASER_ATTACK_TIME = 0.5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vec = Vector2(get_global_mouse_position().x -horse_node.position.x,get_global_mouse_position().y -horse_node.position.y)
	var angle = vec.angle()
	if Input.is_action_just_pressed("attack"):
		if attack_type == "laser":
			$attack_timer.wait_time = LASER_ATTACK_TIME
			#$line2D.visible = true
			
			#print(str(get_parent().position.length()) + "   "+ str(vec.length()))
			$Line2D.points = [Vector2(0,0),vec]
			
			
			$Line2D.visible = true
	$Line2D.rotation = -angle
			


func _on_attack_timer_timeout() -> void:
	$Line2D.visible = false
	#pass # Replace with function body.
