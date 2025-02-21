extends Control

signal pimp_change(slot: int, pimp: int)

var pimpingIcon
var pimpSlotsNode
var pimpSlots
var pimps

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pimpingIcon = get_node("PimpingIcon")
	pimpSlotsNode = get_node("PimpSlots")
	
	# Getting all pimp slots.
	pimpSlots = {
		"head": get_node("PimpSlots/HornSlot"),
		"body": get_node("PimpSlots/BodySlot"),
		"mini": get_node("PimpSlots/MinifridgeSlot"),
		"tail": get_node("PimpSlots/TailSlot"),
		"hooves": get_node("PimpSlots/HoovesSlot")
	}
	for pimpSlot in pimpSlots.keys():
		pimpSlots[pimpSlot].close_all_except.connect(_close_all_except)
	
	# Getting all pimps within each pimp slot.
	pimps = {
		"head": pimpSlots["head"].get_children(),
		"body": pimpSlots["body"].get_children(),
		"mini": pimpSlots["mini"].get_children(),
		"tail": pimpSlots["tail"].get_children(),
		"hooves": pimpSlots["hooves"].get_children()
	}
	
	_reset_pimping_menu()
	global_pimpbus.pimp_changed.connect(AAA)

func _reset_pimping_menu() -> void:
	modulate = Color(1, 1, 1, 0.20)
	# Force shows PimpingIcon and hides PimpSlots + all PimpSlot/Pimps.
	pimpingIcon.visible = true
	pimpSlotsNode.visible = false
	for pimpSlot in pimpSlots.keys():
		pimpSlots[pimpSlot].get_node("Pimps").visible = false

func _input(event: InputEvent) -> void: 
	# Press G to reset back to normal.
	if (event is InputEventKey) and event.pressed and event.keycode == KEY_G:
		_reset_pimping_menu()
		
	# Mouse in viewport coordinates.
	#if (event is InputEventMouseMotion) \
	#and event.position.x > 0.31 * get_viewport().get_visible_rect().size.x \
	#or event.position.y > 0.34 * get_viewport().get_visible_rect().size.y:
		## _reset_pimping_menu()
		#pass

func _signal_PimpingIcon_mouse_entered() -> void:
	modulate = Color(1, 1, 1, 0.69)
	pimpingIcon.visible = false
	pimpSlotsNode.visible = true

func _close_all_except(except: Node) -> void:
	for pimpSlot in pimpSlots.keys():
		#print(pimpSlot)
		#print(except)
		if pimpSlots[pimpSlot] != except:
			pimpSlots[pimpSlot].get_node("Pimps").visible = false

func AAA(a: String, b: String):
	print(a, b)
