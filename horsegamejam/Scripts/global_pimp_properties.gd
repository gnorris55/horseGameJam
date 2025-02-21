extends Node

signal pimp_changed(slot: String, pimp: String)

func change_pimp(pimpSlot: String, pimp: String) -> void:
	emit_signal("pimp_changed", pimpSlot, pimp)
