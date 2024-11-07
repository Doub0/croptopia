extends Resource

class_name Inv

signal update
signal test

var disable_build = false
signal disable_building_mode

signal slot_1
signal slot_2
signal slot_3
signal slot_4
signal slot_5
signal slot_6
signal slot_7
signal slot_8

@export var slots: Array[InvSlot]

var has_decreased

var selected_slot_1 = false
var selected_slot_2 = false
var selected_slot_3 = false
var selected_slot_4 = false
var selected_slot_5 = false
var selected_slot_6 = false
var selected_slot_7 = false
var selected_slot_8 = false

var slot_1_h_rb = false
var slot_1_h_ch = false
var slot_1_h_iax = false

var slot_2_h_rb = false
var slot_2_h_ch = false

var slot_3_h_rb = false
var slot_3_h_ch = false

var slot_4_h_rb = false
var slot_4_h_ch = false

var slot_5_h_rb = false
var slot_5_h_ch = false

var slot_6_h_rb = false
var slot_6_h_ch = false

var slot_7_h_rb = false
var slot_7_h_ch = false

var slot_8_h_rb = false
var slot_8_h_ch = false

var redbane_bought = false
var chive_bought = false

var redbane_amount
var chive_amount

@export var item: InvItem

func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
		has_decreased = false
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
#			if item.name == "redbaneberry":
#				emit_signal("test")
	update.emit()
	
func decrease(item: InvItem):
	var itemslots = slots
	if selected_slot_1 == true:
		itemslots[0].amount -= 1
	elif selected_slot_2 == true:
		itemslots[1].amount -= 1
	elif selected_slot_3 == true:
		itemslots[2].amount -= 1
	elif selected_slot_4 == true:
		itemslots[3].amount -= 1
	elif selected_slot_5 == true:
		itemslots[4].amount -= 1
	elif selected_slot_6 == true:
		itemslots[5].amount -= 1
	elif selected_slot_7 == true:
		itemslots[6].amount -= 1
	elif selected_slot_8 == true:
		itemslots[7].amount -= 1
	has_decreased = true
	if has_decreased == true:
		if itemslots[0].amount < 1:
			if selected_slot_1 == true:
				print("Itemslot 1 is 0!")
				disable_build = true
				itemslots[0].item = null
				slot_1_h_rb = false
				slot_1_h_ch = false
				slot_1_h_iax = false
		elif itemslots[1].amount < 1:
			if selected_slot_2 == true:
				disable_build = true
				itemslots[1].item = null
				slot_2_h_rb = false
				slot_2_h_ch = false
		elif itemslots[2].amount < 1:
			if selected_slot_3 == true:
				disable_build = true
				itemslots[2].item = null
				slot_3_h_rb = false
				slot_3_h_ch = false
		elif itemslots[3].amount < 1:
			if selected_slot_4 == true:
				disable_build = true
				itemslots[3].item = null
				slot_4_h_rb = false
				slot_4_h_ch = false
		elif itemslots[4].amount < 1:
			if selected_slot_5 == true:
				disable_build = true
				itemslots[4].item = null
				slot_5_h_rb = false
				slot_5_h_ch = false
		elif itemslots[5].amount < 1:
			if selected_slot_6 == true:
				disable_build = true
				itemslots[5].item = null
				slot_6_h_rb = false
				slot_6_h_ch = false
		elif itemslots[6].amount < 1:
			if selected_slot_7 == true:
				disable_build = true
				itemslots[6].item = null
				slot_7_h_rb = false
				slot_7_h_ch = false
		elif itemslots[7].amount < 1:
			if selected_slot_8 == true:
				disable_build = true
				itemslots[7].item = null
				slot_8_h_rb = false
				slot_8_h_ch = false
#	if has_decreased == false:
#		var emptyslots = slots.filter(func(slot): return slot.item == null)
#		emptyslots[0].item = null
#		itemslots[0].amount = 0
	update.emit()
func select(item: InvItem):
	var itemslots = slots
	if selected_slot_1 == true:
		selected_slot_2 = false
		selected_slot_3 = false
		selected_slot_4 = false
		selected_slot_5 = false
		selected_slot_6 = false
		selected_slot_7 = false
		selected_slot_8 = false
		print("selected slot 1!")
		if itemslots[0].item == null:
			print("NO ITEMS IN SLOT 1")
		elif itemslots[0].item.name == "redbaneberry":
			print("Slot 1 has Redbane!")
			slot_1_h_rb = true
			slot_1_h_ch = false
			slot_2_h_rb = false
			slot_2_h_ch = false
			disable_build = false
		elif itemslots[0].item.name == "Chives":
			print("Slot 1 has Chives!")
			slot_1_h_ch = true
			slot_1_h_rb = false
			slot_2_h_rb = false
			slot_2_h_ch = false
			disable_build = false
	if selected_slot_2 == true:
		selected_slot_1 = false
		selected_slot_3 = false
		selected_slot_4 = false
		selected_slot_5 = false
		selected_slot_6 = false
		selected_slot_7 = false
		selected_slot_8 = false
		print("selected slot 2!")
		if itemslots[1].item == null:
			print("NO ITEMS IN SLOT 2")
		elif itemslots[1].item.name == "redbaneberry":
			print("Slot 2 has Redbane!")
			slot_2_h_rb = true
			slot_1_h_ch = false
			slot_1_h_rb = false
			slot_2_h_ch = false
			disable_build = false
		elif itemslots[1].item.name == "Chives":
			print("Slot 1 has Chives!")
			slot_2_h_ch = true
			slot_1_h_ch = false
			slot_1_h_rb = false
			slot_2_h_rb = false
			disable_build = false
		elif itemslots[1].item.name == "Iron Axe":
			slot_1_h_iax = true
			slot_2_h_ch = true
			slot_1_h_ch = false
			slot_1_h_rb = false
			slot_2_h_rb = false
	if selected_slot_3 == true:
		selected_slot_1 = false
		selected_slot_2 = false
		selected_slot_4 = false
		selected_slot_5 = false
		selected_slot_6 = false
		selected_slot_7 = false
		selected_slot_8 = false
		print("selected slot 3!")
		if itemslots[2].item == null:
			print("NO ITEMS IN SLOT 3")
		elif itemslots[2].item.name == "redbaneberry":
			print("Slot 3 has Redbane!")
			slot_3_h_rb = true
		elif itemslots[2].item.name == "Chives":
			print("Slot 1 has Chives!")
			slot_3_h_ch = true
	if selected_slot_4 == true:
		selected_slot_1 = false
		selected_slot_2 = false
		selected_slot_3 = false
		selected_slot_5 = false
		selected_slot_6 = false
		selected_slot_7 = false
		selected_slot_8 = false
		print("selected slot 4!")
		if itemslots[3].item == null:
			print("NO ITEMS IN SLOT 4")
		elif itemslots[3].item.name == "redbaneberry":
			print("Slot 4 has Redbane!")
			slot_4_h_rb = true
		elif itemslots[3].item.name == "Chives":
			print("Slot 1 has Chives!")
			slot_4_h_ch = true
	if selected_slot_5 == true:
		selected_slot_1 = false
		selected_slot_2 = false
		selected_slot_3 = false
		selected_slot_4 = false
		selected_slot_6 = false
		selected_slot_7 = false
		selected_slot_8 = false
		print("selected slot 5!")
		if itemslots[4].item == null:
			print("NO ITEMS IN SLOT 5")
		elif itemslots[4].item.name == "redbaneberry":
			print("Slot 5 has Redbane!")
			slot_5_h_rb = true
		elif itemslots[4].item.name == "Chives":
			print("Slot 1 has Chives!")
			slot_5_h_ch = true
	if selected_slot_6 == true:
		selected_slot_1 = false
		selected_slot_2 = false
		selected_slot_3 = false
		selected_slot_4 = false
		selected_slot_5 = false
		selected_slot_7 = false
		selected_slot_8 = false
		print("selected slot 6!")
		if itemslots[5].item == null:
			print("NO ITEMS IN SLOT 6")
		elif itemslots[5].item.name == "redbaneberry":
			print("Slot 6 has Redbane!")
			slot_6_h_rb = true
		elif itemslots[5].item.name == "Chives":
			print("Slot 1 has Chives!")
			slot_6_h_ch = true
	if selected_slot_7 == true:
		selected_slot_1 = false
		selected_slot_2 = false
		selected_slot_3 = false
		selected_slot_4 = false
		selected_slot_5 = false
		selected_slot_6 = false
		selected_slot_8 = false
		print("selected slot 7!")
		if itemslots[6].item == null:
			print("NO ITEMS IN SLOT 7")
		elif itemslots[6].item.name == "redbaneberry":
			print("Slot 7 has Redbane!")
			slot_7_h_rb = true
		elif itemslots[6].item.name == "Chives":
			print("Slot 1 has Chives!")
			slot_7_h_ch = true
	if selected_slot_8 == true:
		selected_slot_1 = false
		selected_slot_2 = false
		selected_slot_3 = false
		selected_slot_4 = false
		selected_slot_5 = false
		selected_slot_6 = false
		selected_slot_7 = false
		print("selected slot 8!")
		if itemslots[7].item == null:
			print("NO ITEMS IN SLOT 8")
		elif itemslots[7].item.name == "redbaneberry":
			print("Slot 8 has Redbane!")
			slot_8_h_rb = true
		elif itemslots[7].item.name == "Chives":
			print("Slot 1 has Chives!")
			slot_8_h_ch = true
			
func disable_building():
	print(":3!")
	disable_building_mode.emit()

func shop(item: InvItem):
	var itemslots = slots
	if redbane_bought == true:
		if slot_1_h_rb == true:
			itemslots[0].amount -= 10
			if itemslots[0].amount < 1:
				disable_build = true
				itemslots[0].item = null
		if slot_2_h_rb == true:
			itemslots[1].amount -= 10
			if itemslots[1].amount < 1:
				disable_build = true
				itemslots[1].item = null
		if slot_3_h_rb == true:
			itemslots[2].amount -= 10
			if itemslots[2].amount < 1:
				disable_build = true
				itemslots[2].item = null
		if slot_4_h_rb == true:
			itemslots[3].amount -= 10
			if itemslots[3].amount < 1:
				disable_build = true
				itemslots[3].item = null
		if slot_5_h_rb == true:
			itemslots[4].amount -= 10
			if itemslots[4].amount < 1:
				disable_build = true
				itemslots[4].item = null
		if slot_6_h_rb == true:
			itemslots[5].amount -= 10
			if itemslots[5].amount < 1:
				disable_build = true
				itemslots[5].item = null
		if slot_7_h_rb == true:
			itemslots[6].amount -= 10
			if itemslots[6].amount < 1:
				disable_build = true
				itemslots[6].item = null
		if slot_8_h_rb == true:
			itemslots[7].amount -= 10
			if itemslots[7].amount < 1:
				disable_build = true
				itemslots[7].item = null
		redbane_bought = false
		update.emit()
	if chive_bought == true:
		var redbane_amount
		if slot_1_h_ch == true:
			chive_amount = itemslots[0].amount #Works to export the value
			itemslots[0].amount -= 10
			if itemslots[0].amount < 1:
				disable_build = true
				itemslots[0].item = null
		if slot_2_h_ch == true:
			itemslots[1].amount -= 10
			if itemslots[1].amount < 1:
				disable_build = true
				itemslots[1].item = null
		if slot_3_h_ch == true:
			itemslots[2].amount -= 10
			if itemslots[2].amount < 1:
				disable_build = true
				itemslots[2].item = null
		if slot_4_h_ch == true:
			itemslots[3].amount -= 10
			if itemslots[3].amount < 1:
				disable_build = true
				itemslots[3].item = null
		if slot_5_h_ch == true:
			itemslots[4].amount -= 10
			if itemslots[4].amount < 1:
				disable_build = true
				itemslots[4].item = null
		if slot_6_h_ch == true:
			itemslots[5].amount -= 10
			if itemslots[5].amount < 1:
				disable_build = true
				itemslots[5].item = null
		if slot_7_h_ch == true:
			itemslots[6].amount -= 10
			if itemslots[6].amount < 1:
				disable_build = true
				itemslots[6].item = null
		if slot_8_h_ch == true:
			itemslots[7].amount -= 10
			if itemslots[7].amount < 1:
				disable_build = true
				itemslots[7].item = null
			
		chive_bought = false
		update.emit()
