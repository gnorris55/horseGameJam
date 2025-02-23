extends Node


### PIMP CHANGING SIGNAL ###
signal pimp_changed(slot: String, pimp: String, unlocked:bool)
# Slot Names <slot>:
# HornSlot, BodySlot, MinifridgeSlot, TailSlot, HoovesSlot
# ~~~~~~~~~~~
# Pimp Names <pimp>:
# machinegun, shotgun, lazer
# armor1, armor2, armor3, armor4, armor5
# regular, gold, platinum
# machete, chainsaw, sawblade
# wheels, sawblades, fans
# ~~~~~~~~~~~
# <unlocked>: whenther the node's meta data "Unlocked" is true or not.
# true -> is unlocked / has been purchased (default is false)

func change_pimp(pimpSlot: String, pimp: String, unlocked:bool) -> void:
	emit_signal("pimp_changed", pimpSlot, pimp, unlocked)


### GLOBAL SIGNAL SYSTEM ###
var signal_listeners = {}

func listen_to_signal(signal_name: String, target: Object, method: String):
	if not signal_listeners.has(signal_name):
		signal_listeners[signal_name] = []
	signal_listeners[signal_name].append(Callable(target, method))

func emit_global_signal(signal_name: String, args = []):
	if signal_listeners.has(signal_name):
		for callable in signal_listeners[signal_name]:
			callable.callv(args)

### USEFUL FUNCTIONS ###
func for_each(array: Array, callable: Callable):
	for item in array:
		callable.call(item)
