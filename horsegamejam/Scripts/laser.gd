extends Node2D

#-----------OLD LASER CODE-----------
#lasers are horse projectiles now

var vel = Vector2(0,0)
var length = 0
var damage = 0




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if we want base of laser to move
	#position.x += delta*vel.x
	#position.y += delta*vel.y
	print($Line2D.points[1])
	$Line2D.points[0] = get_parent().get_node("Horse").position#stay centered on player position (remove if shooting laser)
	$Line2D.points[1] +=    length/$attack_timer.wait_time*vel*delta#laser reaches click by time up
	#print($Line2D)
	#$Area2D/CollisionShape2D.set_shape($Line2D)
	#print()#.points[1])
	$Area2D/CollisionShape2D.get_shape().a = $Line2D.points[0]
	$Area2D/CollisionShape2D.get_shape().b = $Line2D.points[1]
	print($Line2D.points[1])


func _on_attack_timer_timeout() -> void:
	queue_free()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	print("body entered by LASER")
	if area.is_in_group("enemyArea2D"):
		print("attacking enemy")
		area.get_parent().take_damage(damage)	
