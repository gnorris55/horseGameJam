extends Node2D
@onready var horse: Node2D = $Horse
@onready var enemy_mananager: Node2D = $enemyMananager

@onready var game_over_menu: Label = $CanvasLayer/Control/Control/gameOverText
@onready var restart_button: Button = $CanvasLayer/Control/Control/restartButton
@onready var control: Control = $CanvasLayer/Control

var game_state = 0
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	control.hide()
	game_over_menu.visible = false
	restart_button.visible = false
	$AudioStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func game_over():
	control.show()
	game_over_menu.visible = true
	restart_button.visible = true
	restart_button.z_index = 5
	#enemy_mananager.queue_free()
	horse.queue_free()


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
