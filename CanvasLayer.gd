extends CanvasLayer

#func change_scene(target: String, type: String = 'dissolve') -> void:
	#if type == 'dissolve':
		#transition_dissolve(target)
	#else:
		#transition_clouds(target)

#func transition_dissolve(target: String) -> void:
	#$AnimationPlayer.play('dissolve')
	#await $AnimationPlayer.animation_finished
	#get_tree().change_scene_to_file('res://scenes/worldtest.tscn')
	#$AnimationPlayer.play_backwards('dissolve')
#
#func transition_clouds(target: String) -> void:
	#$AnimationPlayer.play('clouds_in')
	#await $AnimationPlayer.animation_finished
	#get_tree().change_scene_to_file('res://scenes/worldtest.tscn')
	#$AnimationPlayer.play('clouds_out')

signal loading_screen_has_ful_coverage



func _update_progress_bar(new_value: float) -> void:
	pass


func start_outro_animation() -> void:
	pass	
