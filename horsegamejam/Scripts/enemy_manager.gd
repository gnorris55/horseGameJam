extends Node


const carrot = preload("res://Scenes/carrot.tscn")
const healt_potion = preload("res://Scenes/health_potion.tscn")

const tractor_enemy = preload("res://Scenes/tractor_enemy.tscn")#preload("res://Scenes/base_enemy.tscn")
const gun_enemy = preload("res://Scenes/gun_enemy.tscn")
const enemy = preload("res://Scenes/base_enemy.tscn")
const ROUND_STATE = 0
const TRANSITION_STATE = 1
const BREAK_STATE = 2


@onready var round_num_label: Label = $CanvasLayer/roundNum
@onready var time_left_round: Label = $CanvasLayer/timeLeftRound
@onready var time_left_break: Label = $CanvasLayer/timeLeftBreak
@onready var num_enemies_label: Label = $CanvasLayer/numEnemiesLabel

@onready var round_timer: Timer = $roundTimer
@onready var break_timer: Timer = $breakTimer

var enemies = [enemy]

var drop_probs = [0.75, 0.85]

var total_time = 0.0
var accumulated_time = 0.0
var spawn_rate = 3.0
var spawn_radius = 2500

var current_round = 1
var spawning_active = true

var round_state = 0

var num_enemies = 0

# Called when the node enters the scene tree for the first time.

func initialize_enemy(enemy_instance, starting_position: Vector2 = Vector2(0, 0), target_position: Vector2 = Vector2(10, 0) ):
	enemy_instance.position = starting_position
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
	
	num_enemies_label.text = "enemies: " + str(num_enemies)
	
	if round_state == TRANSITION_STATE and num_enemies <= 0:
		break_timer.start()
		round_state = BREAK_STATE
		spawning_active = false
		break_timer.start()
	
	if (round_state == ROUND_STATE and spawning_active):
	
		if (accumulated_time >= spawn_rate):
		
			var spawn_number = floor(log(0.1*total_time + 1)) + 2 + floor(0.1*total_time/3)
			num_enemies += spawn_number
			#print(spawn_number)
			
			#print("number to spawn: " + str(spawn_number))
			
			for i in range(spawn_number):
				#print("enemy array size: " + str(enemies.size()))
				var random_value = randf()
				var enemy_spawn_index = get_enemy_type()
				var new_instance = enemies[enemy_spawn_index].instantiate()
				#var new_instance = enemy_arr[3].instantiate()
				initialize_enemy(new_instance, fibonacci_sphere(spawn_radius, random_value), Vector2(0, 0))
		
			if (total_time > 10 and enemies.size() < 2):
				enemies.append(gun_enemy)
				spawn_rareness += 4
				#print("adding slow enemy")
				#print(enemies)
				
			if (total_time > 25 and enemies.size() < 3):
				spawn_rareness += 4
				enemies.append(tractor_enemy)
			'''	
			if (total_time > 20 and enemies.size() < 4):
				spawn_rareness += 3
				enemies.append(teleport_enemy)
			'''
			accumulated_time -= spawn_rate
			
		time_left_round.text = "round time left: " + str(snapped(round_timer.time_left, 0.1)) 
		
			
		total_time += delta
		accumulated_time += delta	
		
	elif (round_state == BREAK_STATE):
		#if (break_timer.time_left != null):
		time_left_break.text = "break time left: " + str(snapped(break_timer.time_left, 0.1)) 
	
	
	
func enemy_drop(position: Vector2):
	
	num_enemies -= 1
	
	randomize()
	var drop = randf()
	if (drop < drop_probs[0]):	
		var curr_carrot = carrot.instantiate()
		curr_carrot.position = position
		#enemy_instance.target_position = target_position
		add_child(curr_carrot)
	elif (drop < drop_probs[1]):
		var curr_health = healt_potion.instantiate()
		curr_health.position = position
		#enemy_instance.target_position = target_position
		add_child(curr_health)


func _on_round_timer_timeout() -> void:
	spawning_active = false
	round_state = TRANSITION_STATE


func _on_break_timer_timeout() -> void:
	round_state = ROUND_STATE
	spawning_active = true
	
	round_timer.wait_time = round_timer.wait_time + 1
	round_timer.start()
	current_round += 1
	round_num_label.text = "current round: " + str(current_round)
	
	
