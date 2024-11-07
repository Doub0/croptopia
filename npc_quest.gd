extends CanvasLayer

signal quest_menu_closed
signal quest_finished

var quest1_active = false
var quest1_completed = false

var stick = 0
#
var pinecone = 0
var elderberry = 0
var chive = 0
var sorrel = 0
var redbane = 0
#20 pinecones, 50 sticks, 5 sorrel, 10 red baneberries, 10 bundles of chives, 10 clumps of elderberries
func _process(delta):
	if quest1_active:
		if stick >= 10:
			if pinecone >= 20:
				if elderberry >= 10:
					if chive >= 10:
						if sorrel >= 5:
							if redbane >= 10:
								print("You finished the quest!")
								quest1_active = false
								quest1_completed = true
								play_finish_quest_anim()
								emit_signal("quest_finished")
			
func quest1_chat():
	$quest1_ui.visible = true
		
func next_quest():
	if !quest1_completed:
		quest1_chat()
	else:
		$no_quest.visible = true
		await get_tree().create_timer(3).timeout
		$no_quest.visible = false
		
func _on_yes_button_1_pressed():
	$quest1_ui.visible = false
	quest1_active = true
	stick = 0
	pinecone = 0
	elderberry = 0
	chive = 0
	sorrel = 0
	redbane = 0
	emit_signal("quest_menu_closed")
#
func _on_no_button_1_pressed():
	$quest1_ui.visible = false
	quest1_active = false
	emit_signal("quest_menu_closed")
	
func play_finish_quest_anim():
	$finished_quest.visible = true
	await get_tree().create_timer(3).timeout
	$finished_quest.visible = false 

func stick_collected():
	stick += 1
	print("sticks collected")
	
#
func pinecone_collected():
	pinecone += 1
	print("pinecone collected")
	
func elderberry_collected():
	elderberry += 1
	print("elderberry collected")
	
func redbane_collected():
	redbane += 1
	print("red baneberry collected")
	
func sorrel_collected():
	sorrel += 1
	print("sorrel collected")
	
func chive_collected():
	chive += 1
	print("chives collected")
#if pinecone == 20:
				#if sticks == 50:
					#if elderberry == 10:
						#if chive == 10:
							#if sorrel == 5:



