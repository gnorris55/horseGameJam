extends Node2D

const ENEMY_BULLET = preload("res://Scenes/enemy_bullet.tscn")

@onready var death_timer: Timer = $deathTimer
@onready var death_particles: CPUParticles2D = $deathParticles
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var health_bar: ProgressBar = $healthBar

@export var speed = 50
@export var health = 50

var direction = Vector2.ZERO
var target_position = Vector2.ZERO
var shooting_radius = [300, 800]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.max_value = health
	health_bar.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)
	
func movement(delta: float):
	# need to be able to get player position
	var horse = get_tree().get_nodes_in_group("horse")
	if (len(horse) > 0):
		target_position = horse[0].global_position
		direction = (target_position - global_position).normalized()
		sprite_2d.global_rotation = direction.angle() + PI/2.0
		global_position += speed*delta*direction

func take_damage(damage, hit_back = false):
	health -= damage
	health -= damage
	health_bar.value = health

	
	if (health <= 0):
		var enemy_manager = get_parent()
		enemy_manager.enemy_drop(global_position)
		death_timer.start()
		death_particles.emitting = true
		health_bar.visible = false
		sprite_2d.visible = false
		area_2d.queue_free()
		
	elif (hit_back):
		global_position = global_position - direction*200	

func shoot():
	# spawn a enemy bullet with current direction vector
	var curr_bullet = ENEMY_BULLET.instantiate()
	curr_bullet.global_position = global_position
	curr_bullet.direction = direction
	get_parent().add_child(curr_bullet)



func _on_death_timer_timeout() -> void:
	queue_free()


func _on_shoot_timer_timeout() -> void:
	# will shoot when this timer ends
	var distance_from_horse = abs((target_position - global_position).length())
	if distance_from_horse > shooting_radius[0] and distance_from_horse < shooting_radius[1]:
		shoot()
		print("should shoot")
		
	pass # Replace with function body.
	
