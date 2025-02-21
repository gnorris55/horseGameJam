extends Node2D

var vel = Vector2(0,0)
var length = 0
var damage = 0
var speed = 0
var rotation_offset = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += vel*speed*delta

func set_type(name,advance):
	$AnimatedSprite2D.play(name)
	if name == "bullet":
		$Area2D/bullet.disabled = false
		rotation_offset = PI/4
	elif name == "laser":
		$Area2D/laser.disabled = false
	print("bullet,angle",vel.angle())
	rotation = vel.angle() + rotation_offset
	position += vel*advance*$AnimatedSprite2D.scale.x
	
	
func _on_attack_timer_timeout() -> void:
	queue_free()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemyArea2D"):
		print("Enemy enterd by horse projectile")
		area.get_parent().take_damage(damage)	
		queue_free()
	elif area.is_in_group("enemyShieldArea"):
		queue_free()
