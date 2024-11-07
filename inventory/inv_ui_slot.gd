extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label
signal disable_the_building
func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_text.visible = true
		amount_text.text = str(slot.amount)
		print("nigguh")

func update_slot(slot: InvSlot):
	amount_text.text = str(slot.amount - 10)
	slot.amount = slot.amount - 10
func disable_building_mode():
	disable_the_building.emit()
func slot_1():
	print("slot 1 selected")
