extends Node2D

var direction = Vector2.ZERO

var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scale = Vector2(2, 2)
	global_position += direction*delta*speed
	rotation = direction.angle()


func _on_bullet_life_timeout() -> void:
	queue_free()
