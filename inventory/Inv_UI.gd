extends Control

@onready var inv: Inv = preload("res://inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

signal decrease

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()
	
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	
func _process(delta):
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()


func open():
	self.visible = true
	is_open = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func close():
	visible = false
	is_open = false


func _on_node_2d_baneberry_placed():
	decrease.emit()
#	inv.update.connect(update_slots)
#	update_slots()
#	close()
