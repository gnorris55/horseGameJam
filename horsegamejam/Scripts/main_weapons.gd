extends Node2D


var attack_type = "machinegun"#laser,machine_gun
@onready var horse_node = get_parent().get_parent()
var laser_scene = preload("res://Scenes/laser.tscn")
var projectile_scene = preload("res://Scenes/horse_projectile.tscn")
var rng = RandomNumberGenerator.new()
@onready var main_scene = horse_node.get_parent()


var laser_sound = load("res://Assets/audio/laser.ogg")
var shoot_sound = load("res://Assets/audio/shot.ogg")

# offset needs to be half length bullet * scale of bullet animated sprite
#var attack_ind = 1
const attack_names = ["empty","lazer","machinegun","shotgun"]
const GUNS = {
	"lazer":{"spread":0,"bullets":1,"damage":50,"cooldown":0.5,"speed":2000,"bullet_duration":1,"bullet_type":"laser","offset":25,"stamina":30,"recoil":3},
	"machinegun":{"spread":10,"bullets":1,"damage":3,"cooldown":0.05,"speed":1000,"bullet_duration":1,"bullet_type":"bullet","offset":2,"stamina":1,"recoil":1},
	"shotgun":{"spread":10,"bullets":10,"damage":5,"cooldown":0.5,"speed":700,"bullet_duration":1,"bullet_type":"bullet","offset":2,"stamina":10,"recoil":10}
	}
var countdown_finished = true

var RECOIL = 0#suggested 0.05
#old laser system
#const LASER_ATTACK_TIME = 0.5
#const LASER_DAMAGE = 3

var weapon_sprite_a = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_pimpbus.pimp_changed.connect(change_weapon)
	$weaponSprites.play(attack_type)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#if Input.is_action_just_pressed("switch_attack"):
		#horse_node.main_weapon_state +=1
		#if horse_node.main_weapon_state >= attack_names.size():
			#horse_node.main_weapon_state = 0
	#attack_type = attack_names[horse_node.main_weapon_state]
	#print(attack_type)
	
	#if attack_type == "empty":#ugly, could be improved if we have a weapon change function
		#$weaponSprites.visible = false
	#else:
		#$weaponSprites.visible = true
		#$weaponSprites.play(attack_type)
	#if $weaponSprites.position.y > 0:
		#weapon_sprite_v -= 1
		#weaopon
		
	if attack_type!= "empty" and Input.is_action_pressed("attack") and horse_node.stamina >= GUNS[attack_type].stamina:
		if countdown_finished == true:
			if attack_type == "lazer":
				$AudioStreamPlayer2D.stream = laser_sound
				$AudioStreamPlayer2D.play()
			else:
				$AudioStreamPlayer2D.stream = shoot_sound
				$AudioStreamPlayer2D.play()
			horse_node.get_node("movement").move(-RECOIL*GUNS[attack_type].recoil)
			#var i = 0
			for i in GUNS[attack_type].bullets:
				var l = projectile_scene.instantiate()
				main_scene.add_child(l)
				l.damage = GUNS[attack_type].damage
				l.speed = GUNS[attack_type].speed
				l.get_node("attack_timer").wait_time = GUNS[attack_type].bullet_duration
				l.get_node("attack_timer").start()
				var vec = Vector2(get_global_mouse_position().x - horse_node.position.x,get_global_mouse_position().y - horse_node.position.y)
				vec = vec.rotated(rng.randf_range(-(PI/180 * GUNS[attack_type].spread),PI/180 * GUNS[attack_type].spread))
				l.vel = vec.limit_length(1)
				l.position = horse_node.position
				l.set_type(GUNS[attack_type].bullet_type,GUNS[attack_type].offset)
				
			horse_node.stamina -= GUNS[attack_type].stamina
			horse_node.stamina_bar.value = horse_node.stamina 
			
			
			#---old laser code ---
			#if attack_type == "laser":
				#var l = laser_scene.instantiate()
				#main_scene.add_child(l)
				#
				#l.damage = GUNS["laser"].damage
				#l.get_node("Line2D").points = [horse_node.position,horse_node.position]
				#l.get_node("attack_timer").wait_time = LASER_ATTACK_TIME
				#l.get_node("attack_timer").start()
				#var vec = Vector2(get_global_mouse_position().x - horse_node.position.x,get_global_mouse_position().y - horse_node.position.y)
				#l.vel = vec.limit_length(1)
				#l.length = vec.length()
			
			$attack_cooldown.wait_time = GUNS[attack_type]["cooldown"]
			$attack_cooldown.start()
			countdown_finished = false
func change_weapon(slot: String, type: String,unlocked: bool):#,unlocked: bool):
	#print(slot)
	#print(type)
	#print(unlocked)
	#print("thing equiped has been changed")
	if slot == "HornSlot" and unlocked:
		attack_type = type
		$weaponSprites.play(type)

func _on_attack_cooldown_timeout() -> void:
	countdown_finished = true
