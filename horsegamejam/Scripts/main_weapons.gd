extends Node2D


var attack_type = "laser"
@onready var horse_node = get_parent().get_parent()
var laser_scene = preload("res://Scenes/laser.tscn")
@onready var main_scene = horse_node.get_parent()

const LASER_ATTACK_TIME = 0.5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		
		if attack_type == "laser":
			var l = laser_scene.instantiate()
			main_scene.add_child(l)
			
			
			l.get_node("Line2D").points = [horse_node.position,horse_node.position]
			l.get_node("attack_timer").wait_time = LASER_ATTACK_TIME
			l.get_node("attack_timer").start()
			var vec = Vector2(get_global_mouse_position().x - horse_node.position.x,get_global_mouse_position().y - horse_node.position.y)
			l.vel = vec.limit_length(1)
			l.length = vec.length()
			print(l.get_node("attack_timer").wait_time)
