extends Control

## 	Accessable functions:
#	get_pimp(pimp: String) -> Node
#		pimp: a pimp's name in lowercase.
#		Return: the node of the relevant 
#			pimp.
#
#	getall_pimp_prices() -> Dictiionary[String, Int]
#		Returns: a dictionary of the names of each 
#			pimp as a key, and its corresponding carrot 
#			cost as an integer value.
#
#	get_pimp_price(pimp: String) -> int:
#		pimp: a pimp's name in lowercase.
#		Returns: the pimp's carrot cost 
#			as an interger value.
#
#	set_pimp_unlock(pimp_to_unlock: String, carrots:int = -1) -> bool:
#		pimp_to_unlock: a pimp's name in lowercase.
#		*carrots: the player's current amount of carrots, the default 
#			value of -1 is interpreted as infinite carrots. [Optional]
#		Returns: whether or not the pimp was unlocked.

signal pimp_change(slot: int, pimp: int)

@onready var pimpingIcon = $PimpingIcon
@onready var pimpSlotsNode = $PimpSlots
@onready var pimpSlots = [$PimpSlots/HornSlot, $PimpSlots/BodySlot, $PimpSlots/MinifridgeSlot, $PimpSlots/TailSlot, $PimpSlots/HoovesSlot]
var pimpsDict: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_reset_pimping_menu()
	for pimpSlot in pimpSlots:
		pimpSlot.close_all_except.connect(_close_all_except)
		for pimp in pimpSlot.get_node("Pimps").get_children():
			pimpsDict[pimp.name] = pimp
			#costs[pimp.name] = pimp.get_meta("Carrots")
	global_pimpbus.pimp_changed.connect(_pimp_changed)
	global_pimpbus.emit_global_signal("connect_menu", self)

func _reset_pimping_menu() -> void:
	modulate = Color(1, 1, 1, 0.20)
	# Force shows PimpingIcon and hides PimpSlots + all PimpSlot/Pimps.
	pimpingIcon.visible = true
	pimpSlotsNode.visible = false
	for pimpSlot in pimpSlots:
		pimpSlot.get_node("Pimps").visible = false

func _input(event: InputEvent) -> void: 
	# Test keys
	if (event is InputEventKey) and event.pressed and event.keycode == KEY_Y:
		_reset_pimping_menu()
	if (event is InputEventKey) and event.pressed and event.keycode == KEY_U:
		getall_pimp_prices()
	if (event is InputEventKey) and event.pressed and event.keycode == KEY_I:
		set_pimp_unlock("armor1", 169)
		set_pimp_unlock("armor2", 124)
		set_pimp_unlock("armor3", 117)
		set_pimp_unlock("armor4", 36)
		set_pimp_unlock("armor5", 10)
	if (event is InputEventKey) and event.pressed and event.keycode == KEY_O:
		print(getall_pimp_prices())
	
	 #Mouse in viewport coordinates.
	if (event is InputEventMouseMotion) \
	and (event.position.x > 0.63 * get_viewport().get_visible_rect().size.x \
	or event.position.y > 0.48 * get_viewport().get_visible_rect().size.y):
		_reset_pimping_menu()

func _signal_PimpingIcon_mouse_entered() -> void:
	modulate = Color(1, 1, 1, 0.69)
	pimpingIcon.visible = false
	pimpSlotsNode.visible = true

func _close_all_except(except: Node) -> void:
	for pimpSlot in pimpSlots:
		if pimpSlot == except: continue
		pimpSlot.get_node("Pimps").visible = false

func _pimp_changed(slot, pimp, unlocked):
	#print(slot, " ", pimp, " ", unlocked) # Test
	#set_pimp_unlock(pimp)
	_reset_pimping_menu()


#################################################################################################
func get_pimp(pimp: String) -> Node:
	for pimpSlot in pimpSlots:
		for p in pimpSlot.get_node("Pimps").get_children():
			if p.name == pimp:
				return p
	return null

func getall_pimp_prices() -> Dictionary:
	var costs = {}
	for pimpKeys in pimpsDict.keys():
		costs[pimpKeys] = pimpsDict[pimpKeys].get_meta("Carrots")
	return costs
	
func get_pimp_price(pimp: String) -> int:
	return pimpsDict[pimp.to_lower()].get_meta("Carrots")

func set_pimp_unlock(pimp_to_unlock: String, carrots:int = -1) -> bool:
	if carrots >= get_pimp(pimp_to_unlock).get_meta("Carrots") or carrots == -1:
		get_pimp(pimp_to_unlock).set_meta("Unlocked", true)
		return true
	return false
