extends Button

signal close_all_except(pimpSlot: Node)
signal sounding_upgrade(is_unlocked: bool)

var pimps: Array[Node]
var pricing = [43, 68, 117, 175, 224]
## Pricing is ordered, tier 1 – 5: 43, 68, 117, 175, 224

var horse_node: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)
	$Pimps.visible = false
	pimps = $Pimps.get_children()
	for pimp in pimps:
		var cost = pricing[pimps.find(pimp)] + randi_range(-10, 10)
		pimp.set_meta("Unlocked", false)
		pimp.set_meta("Carrots", cost)
		pimp.set_text(pimp.get_text().capitalize() +" | "+ str(cost))
		pimp.pressed.connect(_pimp_pressed.bind(pimp))
		set_button_icon(null)
	if pimps[0].name == "machinegun":
		pimps[0].set_meta("Unlocked", true)
		pimps[0].set_meta("Carrots", 0)
		pimps[0].set_text("Machinegun")
		set_button_icon(pimps[0].get_button_icon())
	global_pimpbus.pimp_changed.connect(_signal_pimpbus_pimp_changed)
	global_pimpbus.listen_to_signal("connect_menu", self, "asdf")

func _process(delta: float) -> void:
	for pimp in pimps:
		if pimp.get_meta("Unlocked") == true:
			pimp.modulate = Color(1, 1, 1)
		else:
			pimp.modulate = Color(1, 0, 0)

func _button_pressed() -> void:
	$Pimps.visible = not $Pimps.visible
	emit_signal("close_all_except", self)

func _pimp_pressed(pimp: Node) -> void:
	#print(horse_node.money)
	if pimp.get_meta("Unlocked"):
		set_button_icon(pimp.get_button_icon())
	elif horse_node.money >= pimp.get_meta("Carrots"):
		horse_node.money -= pimp.get_meta("Carrots")
		pimp.set_meta("Unlocked", true)
		emit_signal("sounding_upgrade", true)
	else:
		emit_signal("sounding_upgrade", false)
	global_pimpbus.change_pimp(self.name, pimp.name, pimp.get_meta("Unlocked"))

func _signal_pimpbus_pimp_changed(slot: String, pimp: String, unlocked:bool) -> void: pass

func asdf(node: Node):
	#print(node)
	pass

#################################################################################################
