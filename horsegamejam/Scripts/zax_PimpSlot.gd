extends Button

signal close_all_except(pimpSlot: Node)

var pimps
var unlocked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)
	get_node("Pimps").visible = false
	pimps = get_node("Pimps").get_children()
	var i = 0
	for pimp in pimps:
		pimp.pressed.connect(_pimp_pressed.bind(pimp.name))
		i += 1

func _button_pressed() -> void:
	get_node("Pimps").visible = not get_node("Pimps").visible
	emit_signal("close_all_except", self)

func _pimp_pressed(name: String) -> void:
	global_pimpbus.change_pimp(self.name, name)
	
