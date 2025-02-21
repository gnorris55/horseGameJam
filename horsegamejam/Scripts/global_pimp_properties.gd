extends Node

signal pimp_changed(slot: String, pimp: String)
# Slot Names:
# HornSlot, BodySlot, MinifridgeSlot, TailSlot, HoovesSlot
# ~~~~~~~~~~~
# Pimp Names:
# lazer, shotgun, machinegun
# machete, chainsaw, sawblade
# regular, gold, platinum
# armor1, armor2, armor3, armor4, armor5
# wheels, sawblades, fans

func change_pimp(pimpSlot: String, pimp: String) -> void:
	emit_signal("pimp_changed", pimpSlot, pimp)
	
