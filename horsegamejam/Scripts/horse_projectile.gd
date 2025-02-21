extends Node2D

var vel = Vector2(0,0)
var length = 0
var damage = 0
var speed = 0
var rotation_offset = 0
var wname = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += vel*speed*delta

func set_type(tempname,advance):
	wname = tempname
	$AnimatedSprite2D.play(wname)
	#if name == "bullet":
	$Area2D/bullet.disabled = false
	rotation_offset = PI/4
	#elif name == "laser":
		#$Area2D/laser.disabled = false
	rotation = vel.angle() + rotation_offset
	position += vel*advance*$AnimatedSprite2D.scale.x
	
	
	
func _on_attack_timer_timeout() -> void:
	queue_free()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemyArea2D"):
		area.get_parent().take_damage(damage)	
		if wname != "laser":
			queue_free()
	elif area.is_in_group("enemyShieldArea"):
		queue_free()
