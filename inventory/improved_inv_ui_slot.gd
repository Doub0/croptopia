extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label
signal disable_building

func update(slot: InvSlot):
	if !slot.item:
#		item_visual.visible = false
#		amount_text.visible = false
		print("NO MORE MATERIALS / DISABLE BUILDING!")
#			item_visual.visible = false
#			amount_text.visible = false
		emit_signal("disable_building")
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_text.visible = true
		amount_text.text = str(slot.amount)
		if slot.amount == 0:
			print("NO MORE MATERIALS / DISABLE BUILDING!")
#			item_visual.visible = false
#			amount_text.visible = false
			emit_signal("disable_building")
	if slot.resource_name == "redbaneberry":
		print("picked up redbane")
#		emit_signal("stick_collected")
		amount_text.text = str("Flag")
func disable_build():
	print("NO MORE MATERIALS!")
	item_visual.visible = false
	amount_text.visible = false
	emit_signal("disable_building")
	
func slot_1():
	print("slot 1 selected")
