extends Node2D

var pos_o = 0
var amplitude = 500
var speed = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pos_o= position.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#position.y = #sin(delta)#*delta
	position.y = pos_o+sin(speed * delta)*amplitude
