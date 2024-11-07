extends Control

@onready var inv: Inv = preload("res://inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

@onready var indicator_container = $GridContainer
@onready var slot_1 = $GridContainer/select_1_indicator
@onready var slot_2 = $GridContainer/select_2_indicator
@onready var slot_3 = $GridContainer/select_3_indicator
@onready var slot_4 = $GridContainer/select_4_indicator
@onready var slot_5 = $GridContainer/select_5_indicator
@onready var slot_6 = $GridContainer/select_6_indicator
@onready var slot_7 = $GridContainer/select_7_indicator
@onready var slot_8 = $GridContainer/select_8_indicator
signal first_slot

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	slot_1.visible = true
	slot_2.visible = false
	slot_3.visible = false
	slot_4.visible = false
	slot_5.visible = false
	slot_6.visible = false
	slot_7.visible = false
	slot_8.visible = false
	
#func _process(delta):
#	if Input.is_action_just_pressed("1"):
#		if slots.
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])


func _on_player_baneberry_held():
	if Input.is_action_just_pressed("1"): # Replace with function body.
		emit_signal("test")


func _on_player_slot_1_selected():
	slot_1.visible = true
	slot_2.visible = false
	slot_3.visible = false
	slot_4.visible = false
	slot_5.visible = false
	slot_6.visible = false
	slot_7.visible = false
	slot_8.visible = false


func _on_player_slot_3_selected():
	slot_1.visible = false
	slot_2.visible = false
	slot_3.visible = true
	slot_4.visible = false
	slot_5.visible = false
	slot_6.visible = false
	slot_7.visible = false
	slot_8.visible = false


func _on_player_slot_2_selected():
	slot_1.visible = false
	slot_2.visible = true
	slot_3.visible = false
	slot_4.visible = false
	slot_5.visible = false
	slot_6.visible = false
	slot_7.visible = false
	slot_8.visible = false


func _on_player_slot_4_selected():
	slot_1.visible = false
	slot_2.visible = false
	slot_3.visible = false
	slot_4.visible = true
	slot_5.visible = false
	slot_6.visible = false
	slot_7.visible = false
	slot_8.visible = false


func _on_player_slot_5_selected():
	slot_1.visible = false
	slot_2.visible = false
	slot_3.visible = false
	slot_4.visible = false
	slot_5.visible = true
	slot_6.visible = false
	slot_7.visible = false
	slot_8.visible = false


func _on_player_slot_6_selected():
	slot_1.visible = false
	slot_2.visible = false
	slot_3.visible = false
	slot_4.visible = false
	slot_5.visible = false
	slot_6.visible = true
	slot_7.visible = false
	slot_8.visible = false


func _on_player_slot_7_selected():
	slot_1.visible = false
	slot_2.visible = false
	slot_3.visible = false
	slot_4.visible = false
	slot_5.visible = false
	slot_6.visible = false
	slot_7.visible = true
	slot_8.visible = false


func _on_player_slot_8_selected():
	slot_1.visible = false
	slot_2.visible = false
	slot_3.visible = false
	slot_4.visible = false
	slot_5.visible = false
	slot_6.visible = false
	slot_7.visible = false
	slot_8.visible = true
