extends Control

var pimpingIcon
var pimpSlots
var head
var body
var mini
var tail
var hooves
var pimps

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pimpingIcon = get_node("PimpingIcon")
	pimpSlots = get_node("PimpSlots")
	head = get_node("PimpSlots/HeadSlot")
	body = get_node("PimpSlots/BodySlot")
	#mini = get_node("PimpSlots/FridgeSlot")
	#tail = get_node("PimpSlots/TailSlot")
	#hooves = get_node("PimpSlots/HoovesSlot")
	pimps = [head, body] # Chenge to match nodes in _ready()
	_reset_pimping_menu()
	
	print(get_viewport().get_visible_rect().size.x * 0.32)
	print(get_viewport().get_visible_rect().size.x * 0.32 + get_viewport().get_visible_rect().size.x / 1057)
	print(get_viewport().get_visible_rect().size.x * 0.32 + 1057 / get_viewport().get_visible_rect().size.x)
	
	print(get_viewport().get_visible_rect().size.y * 0.32)
	print(get_viewport().get_visible_rect().size.y * 0.32 + get_viewport().get_visible_rect().size.y / 763)
	print(get_viewport().get_visible_rect().size.y * 0.32 + 763 / get_viewport().get_visible_rect().size.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _reset_pimping_menu() -> void:
	modulate = Color(1, 1, 1, 0.25)
	# Force shows PimpingIcon and hides PimpSlots + all PimpSlot/Pimps.
	pimpingIcon.visible = true
	pimpSlots.visible = false
	for pimp in pimps:
		pimp.get_node("Pimps").visible = false

func _input(event: InputEvent) -> void: # Reset back to normal.
	if event is InputEventKey and event.pressed and event.keycode == KEY_G:
		_reset_pimping_menu()
		
	
	
	# Mouse in viewport coordinates.
	if (event is InputEventMouseMotion) \
	and event.position.x > 0.31 * get_viewport().get_visible_rect().size.x \
	or event.position.y > 0.34 * get_viewport().get_visible_rect().size.y:
		_reset_pimping_menu()

func _signal_PimpingIcon_mouse_entered() -> void:
	modulate = Color(1, 1, 1, 0.75)
	pimpingIcon.visible = false
	pimpSlots.visible = true
	for pimp in pimps:
		pimp.get_node("Pimps").visible = false

func _signal_HeadSlot_pressed() -> void:
	pass # Replace with function body.
