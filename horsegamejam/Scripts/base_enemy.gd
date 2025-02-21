extends Node2D

@onready var death_timer: Timer = $deathTimer
@onready var death_particles: CPUParticles2D = $deathParticles
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var health_bar: ProgressBar = $healthBar

@export var speed = 100
@export var health = 50

var direction = Vector2.ZERO

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
		var target_postion = horse[0].global_position
		direction = (target_postion - global_position).normalized()
		sprite_2d.global_rotation = direction.angle() + PI/2.0
		global_position += speed*delta*direction

func take_damage(damage, hit_back = false):
	health -= damage
	health_bar.value = health
	print(health)
	#TODO: make the bounce back more realistic
	
	if (health <= 0 and health_bar.visible):
		var enemy_manager = get_parent()
		enemy_manager.enemy_drop(global_position)
		death_timer.start()
		death_particles.emitting = true
		sprite_2d.visible = false
		area_2d.queue_free()
		health_bar.visible = false
		
	elif (hit_back):
		global_position = global_position - direction*20	


func _on_death_timer_timeout() -> void:
	queue_free()
