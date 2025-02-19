extends Node


const carrot = preload("res://Scenes/carrot.tscn")

const enemy = preload("res://Scenes/base_enemy.tscn")
const gun_enemy = preload("res://Scenes/gun_enemy.tscn")
var enemies = [gun_enemy]
var total_time = 0.0
var accumulated_time = 0.0
var spawn_rate = 3.0
var spawn_radius = 1500

# Called when the node enters the scene tree for the first time.

func initialize_enemy(enemy_instance, starting_position: Vector2 = Vector2(0, 0), target_position: Vector2 = Vector2(10, 0) ):
	enemy_instance.position = starting_position
	enemy_instance.scale = Vector2(0.25, 0.25)
	#enemy_instance.target_position = target_position
	add_child(enemy_instance)

func fibonacci_sphere(radius: float = 1.0, random_value: float = 0.0) -> Vector2:
	
	
	var angle = random_value * 2*PI  # Scale to the range of 0 to PI

	# Calculate the random point on the circle
	var random_point = Vector2(radius * cos(angle), radius * sin(angle))
	
	return random_point
	
	#return points

func _ready() -> void:
	#enemies.append(teleport_enemy)
	#load_multiple_enemies(5)
	pass # Replace with function body.

func determine_enemy_type():
	pass

var spawn_rareness = 10

func get_enemy_type() -> int:
	var enemy_spawn_index = randi_range(0, spawn_rareness)
	if (enemy_spawn_index <= 10):
		return 0
	elif(enemy_spawn_index <= 14):
		return 1
	elif(enemy_spawn_index <= 18):
		return 2
	else:
		return 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if (accumulated_time >= spawn_rate):
		#print("enemy should spawn")
		#print(random_value)
		
		var spawn_number = floor(log(0.1*total_time + 1)) + 1
		print(spawn_number)
		
		#print("number to spawn: " + str(spawn_number))
		
		for i in range(spawn_number):
			#print("enemy array size: " + str(enemies.size()))
			var random_value = randf()
			var enemy_spawn_index = get_enemy_type()
			var new_instance = enemies[enemy_spawn_index].instantiate()
			#var new_instance = enemy_arr[3].instantiate()
			initialize_enemy(new_instance, fibonacci_sphere(spawn_radius, random_value), Vector2(0, 0))
		'''
		if (total_time > 10 and enemies.size() < 2):
			enemies.append(gun_enemy)
			spawn_rareness += 4
			#print("adding slow enemy")
			#print(enemies)
	
		if (total_time > 15 and enemies.size() < 3):
			spawn_rareness += 4
			enemies.append(fast_enemy)
		
		if (total_time > 20 and enemies.size() < 4):
			spawn_rareness += 3
			enemies.append(teleport_enemy)
		'''
		accumulated_time -= spawn_rate
		
			
	total_time += delta
	accumulated_time += delta	
	
func enemy_drop(position: Vector2):
	var curr_carrot = carrot.instantiate()
	curr_carrot.position = position
	#enemy_instance.target_position = target_position
	add_child(curr_carrot)
		
	#print(accumulated_time)
