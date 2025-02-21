extends Node2D
@onready var game_over_menu: CanvasLayer = $gameOverMenu
@onready var horse: Node2D = $Horse
@onready var enemy_mananager: Node2D = $enemyMananager


var game_state = 0
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_menu.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func game_over():
	game_over_menu.visible = true
	#enemy_mananager.queue_free()
	horse.queue_free()


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
