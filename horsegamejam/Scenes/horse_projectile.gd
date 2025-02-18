extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_type(name):
	$AnimatedSprite2D.play(name)
	if name == "bullet":
		$Area2D.bullet = true
	
	
func _on_attack_timer_timeout() -> void:
	queue_free()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	print("body entered by LASER")
	if area.is_in_group("enemyArea2D"):
		print("attacking enemy")
		#area.get_parent().take_damage(damage)	
