extends Node2D


var attack_type = "laser"
@onready var horse_node = get_parent().get_parent()
var laser_scene = preload("res://Scenes/laser.tscn")
@onready var main_scene = horse_node.get_parent()


const LASER_ATTACK_TIME = 0.5
const LASER_DAMAGE = 3
const GUNS = {"laser":{"spread":0,"bullets":1,"damage":3,"cooldown":0.5},"machine_gun":{"spread":30,"bullets":1,"damage":3,"cooldown":0.1}}

var countdown_finished = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("attack"):
		if countdown_finished == true:
			if attack_type == "laser":
				var l = laser_scene.instantiate()
				main_scene.add_child(l)
				
				#l.damage = GUNS["laser"].damage
				l.get_node("Line2D").points = [horse_node.position,horse_node.position]
				l.get_node("attack_timer").wait_time = LASER_ATTACK_TIME
				l.get_node("attack_timer").start()
				var vec = Vector2(get_global_mouse_position().x - horse_node.position.x,get_global_mouse_position().y - horse_node.position.y)
				l.vel = vec.limit_length(1)
				l.length = vec.length()
				print(l.get_node("attack_timer").wait_time)
			else:
				pass
			if attack_type == "machine gun":
				pass
		$attack_cooldown.wait_time = GUNS[attack_type]["cooldown"]
		$attack_cooldown.start()
		countdown_finished = false


func _on_attack_cooldown_timeout() -> void:
	countdown_finished = true
