extends Control

@onready var inv: Inv = preload("res://inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

signal decrease

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	

#func _on_node_2d_baneberry_placed():
#	decrease.emit()
#	inv.update.connect(update_slots)
#	update_slots()
#	close()


func _on_crafting_menu_update_slot():
	update_slots()
