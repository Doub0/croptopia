extends Node2D

signal already_happened

@onready var transition = $Transition
signal left_her_house
signal memory_of_zea

#ne tree for the first time.

func _on_unknown_dialogue_dialogue_finished():
	transition.play("fade_out")
	$unknown_dialogue.visible = false
	$man.visible = false
	GlobalCache.null_it_out()
func _on_area_2d_body_entered(body):
	get_tree().change_scene_to_file("res://shelburne.tscn")


func _on_enter_house_body_entered(body):
	pass # Replace with function body.
